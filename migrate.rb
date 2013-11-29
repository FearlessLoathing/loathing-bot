
require './config/config.rb'

if ARGV[0] == "undo"
  system "sequel -E -m migrations -M 0 #{CONFIG["db"]}"
else
  system "sequel -E -m migrations #{CONFIG["db"]}"
end
