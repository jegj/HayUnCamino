class GestionarSolicitudesController < ApplicationController
	layout "administrador"
	before_filter :verificar_autenticado_admin 

	def index
	end
	
end
