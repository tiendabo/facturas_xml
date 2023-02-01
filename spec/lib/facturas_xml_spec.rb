require 'spec_helper'

describe FacturasXML do
  describe '.compra_venta' do
    let(:cabecera) do
      {
        nitEmisor: 1905208,
        razonSocialEmisor: 'Jorge Arteaga',
        municipio: 'Santa Cruz',
        telefono: 70055555,
        numeroFactura:1234567,
        cuf: '44AAEC00DBD34C819B4D7AFD5F91900D3A059E06A467A75AC82F24C74',
        cufd: 'BQUE+QytqQUDBKVUFOSVRPQkxVRFZNVFVJBMDAwMDAwM',
        codigoSucursal: 0,
        direccion: 'Calle Dr. Victor Pinto #123',
        fechaEmision: '2023-01-21T09:01:24.178',
        nombreRazonSocial: 'Juan Vargas',
        codigoTipoDocumentoIdentidad: 1,
        numeroDocumento: 1234567,
        codigoCliente: 123456,
        codigoMetodoPago: 1,
        montoTotal: 100,
        montoTotalSujetoIva: 100,
        codigoMoneda: 1,
        tipoCambio: 100,
        montoTotalMoneda: 100,
        leyenda: 'Ley N° 453: Tienes derecho a recibir información sobre las características y contenidos de los servicios que utilices.',
        usuario: 'JORGEARTEAGA',
      }
    end

    let(:detalles) do
      [
        {
          actividadEconomica: 46788,
          codigoProductoSin: 12345,
          codigoProducto: 'BLA-23',
          descripcion: 'Blusa Amarilla',
          cantidad: 1,
          unidadMedida: 1,
          precioUnitario: 60,
          montoDescuento: 0,
          subTotal: 60,
          numeroSerie: 124548,
          numeroImei: 545454
        },
        {
          actividadEconomica: 46789,
          codigoProductoSin: 12346,
          codigoProducto: 'BLR-24',
          descripcion: 'Blusa Roja',
          cantidad: 1,
          unidadMedida: 1,
          precioUnitario: 40,
          montoDescuento: 0,
          subTotal: 40,
          numeroSerie: 124549,
          numeroImei: 545455
        }
      ]
    end
    let(:invoice_data) do
      {
        cabecera: cabecera,
        detalles: detalles
      }
    end

    let(:signature) do
      {
        DiggestValue: 'jx+krcEI3qu5gWywEdlGerqVX4eCgU31F/10rFfLVgw=',
        SignatureValue:
        'VxbkrurXy1XNcbbpWFSmRQGq8ubQ4yU2Bwj475WtEfsOostfe+ZNeLc+u2fbuVHWCgeYFcZm+ieCBmf0gI6+3YzgbZ25nNk9heVGD1N8mUXtT+o5FgV6e2dj7rDF19EZImBj86r6W/h1GGlvuIYZK5U+RsXrbREXIJ2eunVDU/ahqQxyotufEBd2t0mdtVKcqapNsp//KckT9doeSV3tiZXqkv1oKlv/tokb8J9ZBqCtt+9q2R2gIeID2iGgOzJ/xLQR3QOSmtoTGFY1FtdEooj6ljK/fAnvQHcZy3rDj/pHGbuIj29qfb9M7kLlRm217cskLx5fGNTzUqk1w7NJjw==',
        X509Certificate: 
        '
          MIIGezCCBGOgAwIBAgIISqaLqTX+Op8wDQYJKoZIhvcNAQELBQAwVDEyMDAGA1UE
          AwwpRW50aWRhZCBDZXJ0aWZpY2Fkb3JhIEF1dG9yaXphZGEgRGlnaWNlcnQxETAP
          BgNVBAoMCERpZ2ljZXJ0MQswCQYDVQQGEwJCTzAeFw0yMjA3MTQxNzEyMDBaFw0y
          MzA3MTQxNzEyMDBaMIG1MQ8wDQYDVQQNDAZOT1JNQUwxCzAJBgNVBC4TAkNJMR0w
          GwYDVQQDDBRDRUNJTElBIE1JTExFUiBTSUxFUzESMBAGA1UEBRMJMzU4MjQ1MDI1
          MRwwGgYDVQQMDBNSRVBSRVNFTlRBTlRFIExFR0FMMSEwHwYDVQQKDBhQRURJRE9T
          WUEgU0VSVklDSU9TIFMuQS4xCzAJBgNVBAYTAkJPMRQwEgYHKwYBAQEBAAwHNDU1
          NzU2NDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKs57lcAur4cxwdo
          ZPsHVcaJhC4uqtr9QO8E4cz/ZgA0sbH2fMIrKS85EREv1S8/bOhvr2Z7pu5CYnhv
          6RolIh41RsrWQEdXVzVVYH3+/MfckbIoN0uMDcDEsortZLdf9Jxxf10lDFrNTNDg
          S6/BsTwKqjM7JBhk0dIuRdNiLDufxYQmap763/MuoQpQdQ4vYIWl0OPAMI0DWtro
          w9MbicjBuNLJzhUGhrKFcY/L/udQXWMnyhqEdGz+Wmvwg7S3rkBa4Y5oDYpAMHTP
          kqowsyyv14nC8z6G5FFksmTcVsURRfjcd3JKc9jufmRaclSPIqWowyxsW+gWa2ji
          CcCF6bkCAwEAAaOCAe0wggHpMAkGA1UdEwQCMAAwHwYDVR0jBBgwFoAUebY6dC/W
          MrheEFsTwBjHoNx5Lt0waQYIKwYBBQUHAQEEXTBbMC8GCCsGAQUFBzAChiNodHRw
          Oi8vd3d3LmRpZ2ljZXJ0LmJvL2RpZ2ljZXJ0LnBlbTAoBggrBgEFBQcwAYYcaHR0
          cDovL3d3dy5kaWdpY2VydC5iby9vY3NwLzAcBgNVHREEFTATgRF0YXhAcGVkaWRv
          c3lhLmNvbTBSBgNVHSAESzBJMEcGD2BEAAAAAQ4BAgACAgAAADA0MDIGCCsGAQUF
          BwIBFiZodHRwOi8vd3d3LmRpZ2ljZXJ0LmJvL2VjcGRpZ2ljZXJ0LnBkZjAnBgNV
          HSUEIDAeBggrBgEFBQcDAgYIKwYBBQUHAwMGCCsGAQUFBwMEMIGFBgNVHR8EfjB8
          MHqgHqAchhpodHRwOi8vd3d3LmRpZ2ljZXJ0LmJvL2NybKJYpFYwVDEyMDAGA1UE
          AwwpRW50aWRhZCBDZXJ0aWZpY2Fkb3JhIEF1dG9yaXphZGEgRGlnaWNlcnQxETAP
          BgNVBAoMCERpZ2ljZXJ0MQswCQYDVQQGEwJCTzAdBgNVHQ4EFgQUKFx4ri70I9bu
          oGZab80C1Jq9+dkwDgYDVR0PAQH/BAQDAgTwMA0GCSqGSIb3DQEBCwUAA4ICAQCg
          JjNv4BAL+6slF2CoWTwSwHsKe/mMAYxRhhdXY5TSiHBa8N8nIBek3zW0VZx9Jg72
          PAuHejT0QsyCHViuESVrjAjRpPosSAxHB7fyd/IgOZ+blzVem4it3UsC/7UTHl+B
          o2+0gwnd3UwgkRM2Gt0z6kIsO0za6Cx3Zy5bBEijPmrVdWLmGnLNFX95l4JO84FL
          AZC4HdyPJ5yC63YfefuS3sPA7XoQe5Ad/+zuw/5EwsDvk4dHWx9WNvyfODEIvJB6
          PO4n/i6N7ewRfk/qLV3rSqQZ+qRC/NnRdG5OeJrTfFP6q/wyuKHVMAaNx+0yYrav
          r652JAbhwtYtqGVtycja7jCGZ2DozSEJllDwCy/nO+oniUxH0Mlz6W8yhhujjXYu
          oAPip0k3u0hin8NnCAO+svdZbZ1MXwPcFUb5+u8TrkUjv8/Vypf0RuQ6Emm5eDCh
          FlvDSocoe4NLJAXJNnSEn43HRX8G25yLimyTdIolsLo8nYC2u6EN6Vzm6xkjJhCT
          VhUxSf07TY/jw+CpfMNawNp1ymTu0Y4RbaL9anIi5dbUDaOyTsfWwFxME/EqTgJF
          +zhJUelelK9SZlCMACs1Cs3Yi6dCbsag+PeqQC0TmWLaKIvImY8rX6JO0fJltHTu
          wGvFxcqxde0v0Vr/JuZ74jrn7EGebwCjY2TnVbFUjg==
        '
      }
    end

    it 'generates a "compra venta" invoice doc' do
      xml = described_class.compra_venta(invoice_data, signature).to_xml

      expected_xml_file_path =
        File.join(File.dirname(__FILE__), '../support/compra_venta_invoice.xml')
      expected_xml = File.read(expected_xml_file_path)

      expect(xml).to eq(expected_xml)
    end

    it 'passes validation against the XSD schema' do
      doc = Nokogiri::XML(described_class.compra_venta(invoice_data, signature).to_xml)
      schema_path =
        File.join(File.dirname(__FILE__), '../support/facturaElectronicaCompraVenta.xsd')
      xsd = Nokogiri::XML::Schema(File.read(schema_path))

      expect(xsd.valid?(doc)).to eq true
    end

    describe 'when mandatory cabecera fields are not provided' do
      let(:cabecera) do
        {
          telefono: 70055555,
          numeroFactura:1234567,
          cuf: '44AAEC00DBD34C819B4D7AFD5F91900D3A059E06A467A75AC82F24C74',
          cufd: 'BQUE+QytqQUDBKVUFOSVRPQkxVRFZNVFVJBMDAwMDAwM',
          codigoSucursal: 0,
          direccion: 'Calle Dr. Victor Pinto #123',
          fechaEmision: '2023-01-21T09:01:24.178',
          codigoTipoDocumentoIdentidad: 1,
          numeroDocumento: 1234567,
          codigoCliente: 123456,
          codigoMetodoPago: 1,
          montoTotal: 100,
          montoTotalSujetoIva: 100,
          codigoMoneda: 1,
          tipoCambio: 100,
          montoTotalMoneda: 100,
          leyenda: 'Ley N° 453: Tienes derecho a recibir información sobre las características y contenidos de los servicios que utilices.',
          usuario: 'JORGEARTEAGA',
        }
      end

      it 'raises the correct error' do
        expect{ described_class.compra_venta(invoice_data, signature) }.to raise_error('La cabecera no tiene los campos: nitEmisor, razonSocialEmisor, municipio')
      end
    end

    describe 'when invoice_data does not include a cabecera attribute' do
      let(:cabecera) { nil }

      it 'raises the correct error' do
        expect{ described_class.compra_venta(invoice_data, signature) }.to raise_error('invoice_data debe conteter el attributo cabecera')
      end
    end

    describe 'when invoice_data does not include a detalles attribute' do
      let(:detalles) { nil }

      it 'raises the correct error' do
        expect{ described_class.compra_venta(invoice_data, signature) }.to raise_error('invoice_data debe conteter el attributo detalles')
      end
    end
  end
end