class InvoiceData
  attr_accessor :data

  ALLOWED_CABECERA_FIELDS = {
    nitEmisor: {mandatory: true},
    razonSocialEmisor: {mandatory: true},
    municipio: {mandatory: true},
    telefono: {mandatory: true},
    numeroFactura: {mandatory: false},
    cuf: {mandatory: true},
    cufd: {mandatory: true},
    codigoSucursal: {mandatory: true},
    direccion: {mandatory: true},
    codigoPuntoVenta: {mandatory: false},
    fechaEmision: {mandatory: true},
    nombreRazonSocial: {mandatory: false},
    codigoTipoDocumentoIdentidad: {mandatory: true},
    numeroDocumento: {mandatory: true},
    complemento: {mandatory: false},
    codigoCliente: {mandatory: true},
    codigoMetodoPago: {mandatory: true},
    numeroTarjeta: {mandatory: false},
    montoTotal: {mandatory: true},
    montoTotalSujetoIva: {mandatory: true},
    codigoMoneda: {mandatory: true},
    tipoCambio: {mandatory: true},
    montoTotalMoneda: {mandatory: true},
    montoGiftCard: {mandatory: false},
    descuentoAdicional: {mandatory: false},
    codigoExcepcion: {mandatory: false},
    cafc: {mandatory: false},
    leyenda: {mandatory: true},
    usuario: {mandatory: true}
  }

  ALLOWED_DETALLE_FIELDS = {
    actividadEconomica: {mandatory: true},
    codigoProductoSin: {mandatory: true},
    codigoProducto: {mandatory: true},
    descripcion: {mandatory: true},
    cantidad: {mandatory: true},
    unidadMedida: {mandatory: true},
    precioUnitario: {mandatory: true},
    montoDescuento: {mandatory: false},
    subTotal: {mandatory: true},
    numeroSerie: {mandatory: false},
    numeroImei: {mandatory: false}
  }

  def self.allowed_cabecera_fields
    ALLOWED_CABECERA_FIELDS.keys
  end

  def self.allowed_detalle_fields
    ALLOWED_DETALLE_FIELDS.keys
  end

  def initialize(data = {})
    @data = data

    validate_data
  end

  private
  def validate_data
    validate_cabecera
    validate_detalles
  end

  def validate_detalles
    unless @data['detalles']
      raise "invoice_data debe conteter el attributo detalles"
    end
  end

  def validate_cabecera
    unless @data['cabecera']
      raise "invoice_data debe conteter el attributo cabecera"
    end

    missing_fields = []

    InvoiceData.allowed_cabecera_fields.each do |field|
      if @data['cabecera'][field.to_s].nil? && ALLOWED_CABECERA_FIELDS[field.to_sym][:mandatory]
        missing_fields << field
      end
    end

    if missing_fields.any?
      raise "La cabecera no tiene los campos: #{missing_fields.join(', ')}"
    end
  end
end