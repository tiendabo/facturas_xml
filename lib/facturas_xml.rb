require 'nokogiri'
require_relative 'facturas_xml/invoice_data'

class FacturasXML
  attr_accessor :invoice_data, :signature

  def self.compra_venta(invoice_data, signature)
    @invoice_data = InvoiceData.new(invoice_data).data
    @signature = signature

    template = Nokogiri::XML('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
    Nokogiri::XML::Builder.with(template) do |xml|
      xml.facturaElectronicaCompraVenta('xmlns:xsi': "http://www.w3.org/2001/XMLSchema-instance", 'xsi:noNamespaceSchemaLocation': "facturaElectronicaCompraVenta.xsd") {
        self.cabecera(xml)
        @invoice_data[:detalles].each do |data|
          self.detalle(xml, data)
        end
        self.signature(xml)
      }
    end
  end

  private
  def self.cabecera(xml)
    xml.cabecera {
      InvoiceData.allowed_cabecera_fields.each do |field_name|
        self.invoice_field(xml, @invoice_data[:cabecera], field_name)
      end
      xml.codigoDocumentoSector 1
    }
  end

  def self.detalle(xml, data)
    xml.detalle {
      InvoiceData.allowed_detalle_fields.each do |field_name|
        self.invoice_field(xml, data, field_name)
      end
    }
  end

  def self.invoice_field(xml, data, field_name)
    value = data[field_name.to_sym]
    attributes = value ? {} : {'xsi:nil': "true"}
    xml.send(field_name, value, attributes)
  end

  def self.signature(xml)
    xml.Signature('xmlns': "http://www.w3.org/2000/09/xmldsig#") {
      xml.SignedInfo {
        xml.CanonicalizationMethod('Algorithm': "http://www.w3.org/TR/2001/REC-xml-c14n-20010315")
        xml.SignatureMethod('Algorithm': "http://www.w3.org/2001/04/xmldsig-more#rsa-sha256")
        xml.Reference('URI': "") {
          xml.Transforms {
            xml.Transform('Algorithm': "http://www.w3.org/2000/09/xmldsig#enveloped-signature")
            xml.Transform('Algorithm': "http://www.w3.org/TR/2001/REC-xml-c14n-20010315#WithComments")
          }
          xml.DigestMethod('Algorithm': "http://www.w3.org/2001/04/xmlenc#sha256")
          xml.DigestValue(@signature[:DiggestValue])
        }
      }
      xml.SignatureValue(@signature[:SignatureValue])
      xml.KeyInfo {
        xml.X509Data {
          xml.X509Certificate(@signature[:X509Certificate])
        }
      }
    }
  end
end