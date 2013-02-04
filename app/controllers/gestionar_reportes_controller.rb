class GestionarReportesController < ApplicationController
  layout "administrador"

  before_filter :verificar_autenticado_admin

  def index
    @titulo="Reportes"
  end

  def solicitudes_despachadas
    @titulo="Solicitudes Despachadas"
    @solicitudes=Solicitudes.where("estado=?","Despachado")
  end

  def solicitudes_pendientes
    @titulo="Solicitudes por Despachar"
    @solicitudes=Solicitudes.where("estado=?","Por Despachar")
  end

  def sol_realizadas_cliente
    @titulo="Clientes Ordenados por cantidad de Solicitudes"
    @aux= UsuarioFacturaSolicitud.group('usuario_id_usuario').count("solicitudes_id_solicitudes")
  end

  def destinos_orde_sol
    @titulo="Destinos ordenados por canitdad de solicitudes"    
    @aux=Solicitudes.group('ruta_id_ruta').count('id_solicitudes')
  end

  def facturas_ord_tcan
    @titulo="Facturas ordenadas por tiempo de Cancelacion "
    @facturas=Factura.order("fecha_cancelacion  desc")
  end

  def facturas_vig_ven_cobrar
    @titulo="Reporte de Facturas Vigentes/Vencidas por cobrar"
    @facturas=Factura.where("estado=?","Por Pagar")
  end
end
