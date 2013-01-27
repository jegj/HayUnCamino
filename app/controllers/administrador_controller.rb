# -*- encoding : utf-8 -*-
class AdministradorController < ApplicationController
	layout "administrador"

	before_filter :verificar_autenticado_admin , :only=>[:listo_admin]
	
	def index
		if session[:usuario_admin]
			redirect_to :action=>"listo_admin"
			return
		end

		@titulo="Bienvenido Administrador"
	end

	def autenticar_admin
		session.delete :usuario_admin
		#Por si meten informacion en una peticion POST
		unless params[:correo] && params[:clave]
			bitacora "Faltan Parametros"
			flash[:error]="Falta Parametros"
			redirect_to :action=>"index"
			return		
		end
		correo=params[:correo] 		
		clave=params[:clave]
		#validacion si el campo esta vacio
		if correo.empty?
			bitacora "Error usuario Vacio"
			flash[:error]="Disculpe tiene que ingresar un usuario."
			redirect_to :action=>"index"
			return
		end

		if clave.empty?
			bitacora "Error Clave Usuario"
			flash[:error]="Disculpe tiene que ingresar la clave."
			redirect_to :action=>"index"
			return
		end
		if !correo.empty? and !clave.empty?
			clave_cifrada=Digest::MD5.hexdigest(clave)
			if usuar=Administrador.where(:correo => correo, :clave => clave_cifrada).first
				session[:usuario_admin]=usuar
				bitacora "Se logueo correctamente el usuario #{ session[:usuario_admin].nombre}"	
				redirect_to :action => "listo_admin"
				return
			else
				bitacora "Error Usuario o clave incorrectas"
				flash[:error]="Disculpe usuario o clave incorrecta."
				redirect_to :action=>"index"
				return
			end	
		end
	end

		def listo_admin
			@titulo="Bienvenido #{session[:usuario_admin].nombre}"
		end

		def cerrar_sesion_admin
			bitacora "Cerro la session #{ session[:usuario_admin].nombre}"
			session.delete :usuario_admin
			redirect_to :action=>"index"
			return
		end

		def cambiar_datos
			@titulo="Cambiar mis datos"
			@administrador=session[:usuario_admin]
		end

		def cambiando_datos
			unless params[:nombre]&&params[:apellido] && params[:correo]
				flash[:error]="Falta Parametros"
				bitacora "Intento de daño de la seguidad en cambiar_datos(administrador)"
				redirect_to :action=>"listo_admin"
				return		
			end

			nombre=params[:nombre]
			apellido=params[:apellido]
			correo=params[:correo]

			@administrador=Administrador.find(session[:usuario_admin].id_administrador)
			@administrador.nombre=nombre
			@administrador.apellido=apellido
			@administrador.correo=correo

			if @administrador.save
				session[:usuario_admin]=@administrador
				bitacora "Cambio correctamente sus datos el usuario  #{ session[:usuario_admin].informacion}"
				flash[:exito]="Cambio exitosamente sus datos"
				redirect_to :action=>"listo_admin"
				return
			else
				bitacora "Intento fallido de cambio de datos(administrador)"
				render "cambiar_datos" #ver errores
				return
			end
			
		end
	
	def ver_bitacora
		@titulo="Gestor de Bitacoras"
		@bitacoras=Bitacora.all
	end
	
end
