# Changes the script_name ENV Variable to fix routing on uberspace.de fcgi deployments
# Author: Tobias Klonk, 2012
# License: WTFPL

module Rack
  class FixFcgiScriptName
    def initialize(app, strip_path)
      @app = app
      @strip_path = strip_path
    end

    def call(env)
      env['SCRIPT_NAME'].gsub!(@strip_path, '') unless env['SCRIPT_NAME'].nil?
      env['PATH_TRANSLATED'].gsub!(@strip_path, '') unless env['PATH_TRANSLATED'].nil?
      @app.call(env)
    end
  end
end