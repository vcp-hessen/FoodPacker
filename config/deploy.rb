require 'bundler/capistrano'

set :application, "FoodPacker"

task :uberspace do
  set :user, 'lala'

  role :web, "#{user}.ankaa.uberspace.de"                          # Your HTTP server, Apache/etc
  role :app, "#{user}.ankaa.uberspace.de"                          # This may be the same as your `Web` server
  role :db,  "#{user}.ankaa.uberspace.de", :primary => true # This is where Rails migrations will run

  set :deploy_to, "/var/www/virtual/#{user}/foodpacker"

  set :repository,  "ssh://git@code.tonklon.com/tonklon/foodpack.git"
end


set :deploy_via, :remote_cache
set :scm, :git
set :branch, 'development'
set :scm_verbose, true
set :use_sudo, false
set :rails_env, :production
set :default_shell, "/bin/bash"
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "lala_rsa")]



# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "kill -SIGUSR2 $(cat #{File.join(shared_path,'tmp/pids/puma.pid')})"
 end

 task :htaccess, roles: :web do
     htaccess = <<EOF
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule (.*) http://localhost:62915/$1 [P]
EOF
   put htaccess, "#{release_path}/public/.htaccess"
   run "chmod a+r #{File.join(release_path, 'public', '.htaccess ')}"
 end

 after 'deploy:update_code', 'deploy:htaccess'

 task :symlink do
   run "ln -nfs #{shared_path}/foodpacker.sqlite3 #{latest_release}/db/production.sqlite3"
 end

  after 'deploy:create_symlink', 'deploy:symlink'

end

after "deploy", "deploy:migrate"


  namespace :rails do
    desc "Open the rails console on one of the remote servers"
    task :console, :roles => :app do
      hostname = find_servers_for_task(current_task).first
      exec "ssh #{hostname} -t 'source ~/.bash_profile && #{current_path}/script/rails c #{rails_env}'"
    end
  end
