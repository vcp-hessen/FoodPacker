require 'bundler/capistrano'

set :application, "FoodPacker"
set :user, 'foodpack'

role :web, "#{user}.draco.uberspace.de"                          # Your HTTP server, Apache/etc
role :app, "#{user}.draco.uberspace.de"                          # This may be the same as your `Web` server
role :db,  "#{user}.draco.uberspace.de", :primary => true # This is where Rails migrations will run

set :deploy_to, "/home/#{user}/FoodPacker"
set :deploy_via, :remote_cache
set :scm, :git
set :repository,  "ssh://git@code.tonklon.com/tonklon/foodpack.git"
set :branch, 'development'
set :scm_verbose, true
set :use_sudo, false
set :rails_env, :production
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "foodpack_rsa")]

set :default_environment, {
  'PATH' => "/package/host/localhost/ruby-1.9.3/bin:$HOME/.gem/ruby/1.9.1/bin:$PATH:"
}

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "if [ -e #{shared_path}/pids/server.pid ]; then kill `cat #{shared_path}/pids/server.pid`; fi"
 end

end

before "deploy:setup", "db:configure"
after "deploy:update_code", "db:symlink"
after "deploy", "deploy:migrate"

set(:database_username, user)
set(:development_database) { application + "_development" }
set(:test_database) { application + "_test" }
set(:production_database) { user }

namespace :db do
  desc "Create database yaml in shared path"
  task :configure do
    set :database_password do
      Capistrano::CLI.password_prompt "Database Password: "
    end
    
    db_config = <<-EOF
base: &base
  adapter: mysql2
  encoding: utf8
  username: #{database_username}
  password: #{database_password}
  socket: /var/lib/mysql/mysql.sock

development:
  database: #{development_database}
  <<: *base

test:
  database: #{test_database}
  <<: *base

production:
  database: #{production_database}
  <<: *base
    EOF

    run "mkdir -p #{shared_path}/config"
    put db_config, "#{shared_path}/config/database.yml"
  end

  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end
end