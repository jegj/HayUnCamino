# -*- encoding : utf-8 -*-
class ConfiguracionUsuariosController < ApplicationController
	layout "administrador"
	before_filter :verificar_autenticado_admin
	
	def index
		@titulo="Se maneja los siguientes usuarios:"
		@usuarios=Usuario.all
	end

	def cambiar_datos_usuario

	end

	def eliminar_usuario
		unless params[:usuario_id]
			flash[:error]="Faltan Parametros"
			bitacora "Faltan Parametros"
			redirect_to :controller =>"externo",:action=>"index"
			return
		end

		usuario=Usuario.find(params[:usuario_id])
		usuario.delete
		bitacora "Se elimino correctamente el usuario #{usuario.nombre} por el administrador #{session[:usuario_admin].informacion}"
		flash[:exito]="Se elimino correctamente el usuario"
		redirect_to :action=>"index"
		return		
	end
	
end
