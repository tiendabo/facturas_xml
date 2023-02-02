Gem::Specification.new do |spec|
  spec.name = 'facturas_xml'
  spec.version = "0.1.4"
  spec.summary = "Permite crear facturas en formato XML"
  spec.description = "Permite crear facturas en formato XML que puedes enviar al Servicio de Impuestos Nacionales de Bolivia"
  spec.authors = ["Jorge Arteaga Carvalho"]
  spec.email = "me@jorgelabs.com"
  spec.files = ["lib/facturas_xml.rb", "lib/facturas_xml/invoice_data.rb"]
  spec.homepage = "https://github.com/tiendabo/facturas_xml"
  spec.license = "MIT"

  spec.add_dependency 'nokogiri', '~> 1.14'

  spec.add_development_dependency 'codecov', '~> 0.1'
  spec.add_development_dependency 'dotenv', '~> 2.5'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.6'

  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'vcr', '~> 6.0'
end