# -*- encoding : utf-8 -*-
class PrincipalController < ApplicationController
	layout "interno"
	
	before_filter :verificar_autenticado

	def index
		@titulo="Que desea realizar?"
	end

	def cerrar_sesion
		bitacora "Cerro sesion el usuario #{ session[:usuario_sesion].nombre}"
		session.delete :usuario_sesion
		redirect_to :controller	=>"externo", :action =>"index"
	end

	def contactenos
		@titulo="Quienes somos ?"
	end

	def cambiar_datos
		@titulo="Modificar Información"
		@usuario=session[:usuario_sesion]
	end

	def preguntas
		@titulo="Preguntas Frecuentes"
	end

	def cambiando_datos
		unless params[:Usuario] && params[:Direccion] && params[:Correo]
			flash[:error]="Falta Parametros"
			bitacora "Intento de daño de la seguidad en cambiar_datos"
			redirect_to :action=>"cambiar_datos"
			return		
		end
		usuario=params[:Usuario]
		direccion=params[:Direccion]
		correo=params[:Correo]

		@usuario=Usuario.find(session[:usuario_sesion].id_usuario)
		@usuario.nombre=usuario
		@usuario.direccion=direccion
		@usuario.correo=correo
		@usuario.clave=session[:usuario_sesion].clave
		@usuario.clave_confirmation=session[:usuario_sesion].clave

		if @usuario.save
			session[:usuario_sesion]=@usuario
			bitacora "Cambio correctamente sus datos el usuario  #{ session[:usuario_sesion].nombre}"
			flash[:exito]="Cambio exitosamente sus datos"
			redirect_to :action=>"index"
			return
		else
			bitacora "Intento fallido de cambio de datos"
			render "cambiar_datos" #ver errores
			return
		end
		
	end

	def cambiar_clave
		@titulo="Modificar Clave"
		@usuario=session[:usuario_sesion]
	end
	
	def cambiando_clave

		unless params[:usuario] && params[:usuario][:clave_vieja] && params[:usuario][:Clave] && params[:usuario][:Clave_confirmation]
			flash[:error]="Faltan parametros"
			bitacora "Intento de invadir seguridad por url cambiando_clave"
			redirect_to :action=>"cambiar_clave"
			return	
		end	

		clave_vieja=params[:usuario][:clave_vieja]
		clave_nueva=params[:usuario][:Clave]
		clave_confirmation=params[:usuario][:Clave_confirmation]


		if clave_vieja.empty?
			flash[:error]="Disculpe el campo de clave actual esta vacia."
			bitacora "Intento de cambiar clave fallido, porque clave actual esta vacia"
			redirect_to :action=>"cambiar_clave"
			return
		end

		if clave_nueva.empty?
			flash[:error]="Disculpe el campo de clave nueva esta vacia."
			bitacora "Intento de cambiar clave fallido, porque clave nueva esta vacia"
			redirect_to :action=>"cambiar_clave"
			return
		end

		if clave_confirmation.empty?
			flash[:error]="Disculpe el campo de clave de confirmacion esta vacia."
			bitacora "Intento de cambiar clave fallido, porque clave confirmacion esta vacia"
			redirect_to :action=>"cambiar_clave"
			return
		end

		@usuario=Usuario.find(session[:usuario_sesion].id_usuario)
	

		if clave_vieja==clave_nueva && clave_vieja==clave_confirmation
			flash[:error]="Las claves son identicas"
			bitacora "Intento de cambiar claves con el mismo valor"
			redirect_to :action=>"cambiar_clave"
			return	
		end

		if clave_vieja==@usuario.clave
			@usuario.nombre=session[:usuario_sesion].nombre
			@usuario.direccion=session[:usuario_sesion].direccion
			@usuario.correo=session[:usuario_sesion].correo
			@usuario.clave=clave_nueva
			@usuario.clave_confirmation=clave_confirmation
				if @usuario.save
					session[:usuario_sesion]=@usuario
					bitacora "Cambio correctamente su clave el usuario  #{ session[:usuario_sesion].nombre}"
					flash[:exito]="Cambio exitosamente su clave"
					redirect_to :action=>"index"
					return
				else
					bitacora "Intento fallido de cambio de clave"
					render "cambiar_clave" #ver errores
					return
				end	
			return		
		else
			bitacora "Intento fallido de cambio de clave por que clave vieja no coincide"		
			flash[:error]="la clave actual no coincide"
			redirect_to :action=>"cambiar_clave"
			return
		end
			
	end

	def tarifas
		@titulo="Tarifas"
		@rutas=Ruta.all
	end


end
