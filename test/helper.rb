$: << File.join(File.dirname(__FILE__), "..", "lib")
require 'test/unit'
require 'supportconfig'

if ENV["DEBUG"]
  Supportconfig::Logging.logger = Logger.new(STDERR)
  Supportconfig::Logging.logger.level = Logger::DEBUG
end

