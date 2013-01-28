class GestionarSolicitudesController < ApplicationController
	layout "administrador"
	before_filter :verificar_autenticado_admin 

	def index
		@titulo="Gestion de Solicitudes"
		@solicitudes=Solicitudes.all		
	end
	
end
