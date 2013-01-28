class GestionarSolicitudesController < ApplicationController
	layout "administrador"
	before_filter :verificar_autenticado_admin 

	def index
		@titulo="Gestion de Solicitudes"
		@solicitudes=Solicitudes.all		
	end

	def modificar
		@titulo="Modificar Solicitud"

		unless params[:solicitud_id]
			flash[:error]="Faltan Parametros"
			redirect_to :action=>"index"
			return
		end

		solicitud_id=params[:solicitud_id]
		@solicitud=Solicitudes.find(solicitud_id)
	end
	
end
