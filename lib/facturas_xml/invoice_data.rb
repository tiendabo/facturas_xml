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
  end
end