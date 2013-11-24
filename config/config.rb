
require "parseconfig"

if File.exists?("production")
  CONFIG = ParseConfig.new("config/production.cfg")
else
  CONFIG = ParseConfig.new("config/development.cfg")
end
