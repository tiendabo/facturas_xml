require 'simplecov'
require 'facturas_xml'
require 'dotenv/load'

SimpleCov.start do
  add_filter 'spec/'
  add_filter '.github/'

  add_group "Lib", "lib"
end
if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f } # <============= 4