# -*- encoding : utf-8 -*-
class ExternoController < ApplicationController
	layout "externo"
	
	def index
		if session[:usuario_sesion]
			redirect_to :controller =>"principal" ,:action =>"index"
			return
		end
		@titulo="Hay un Camino, el servicio que usted necesita!"

	end


	def autenticar_usuario
#clave_digest=Digest::MD5.hexdigest(clave)
		session.delete :usuario_sesion
		#Por si meten informacion en una peticion POST
		unless params[:usuario] && params[:clave]
			flash[:error]="Falta Parametros"
			bitacora "Faltan parametros"
			redirect_to :action=>"index"
			return		
		end

		usuario=params[:usuario] 		
		clave=params[:clave]
		#validacion si el campo esta vacio
		if usuario.empty?
			flash[:error]="Disculpe tiene que ingresar un usuario."
			bitacora "Intento de ingreso con usuario vacio"
			redirect_to :action=>"index"
			return
		end

		if clave.empty?
			flash[:error]="Disculpe tiene que ingresar la clave."
			bitacora "Intento de ingreso con clave vacia"
			redirect_to :action=>"index"
			return
		end
		if !usuario.empty? and !clave.empty?
			clave_md5=Digest::MD5.hexdigest(clave)
			if usr=(Usuario.where(:nombre => usuario, :clave => clave_md5).first)
				session[:usuario_sesion]=usr
				bitacora "Se logueo correctamente el usuario #{ session[:usuario_sesion].nombre}"	
				redirect_to :controller=>"principal" , :action => "index"
				return
			else
				bitacora "Error en algunos de los campos."
				flash[:error]="Disculpe usuario o clave incorrecta."
				redirect_to :action=>"index"
				return

			end	
		end
 	end

	def registrar_usuario
		@titulo = "Registro de Usuario"
	end

	def crear_usuario

		unless params[:usuario][:nombre]&&params[:usuario][:rif]&&params[:usuario][:direccion] &&params[:usuario][:correo] && params[:usuario][:clave]&& params[:usuario][:clave_confirmation]
			bitacora "Intento de acceso por medio de a URL"
			flash[:error]="Faltan Parametros"
			redirect_to :action=>"index"
			return
		end
		@titulo = "Registro de Usuario"

		@jeje="Usuario Registrado"


		@usuario=Usuario.new 	
		@usuario.nombre=params[:usuario][:nombre]
		@usuario.rif=params[:usuario][:rif]
		@usuario.direccion=params[:usuario][:direccion]
		@usuario.correo=params[:usuario][:correo]
		@usuario.clave=Digest::MD5.hexdigest(params[:usuario][:clave])
		@usuario.clave_confirmation=Digest::MD5.hexdigest(params[:usuario][:clave_confirmation])
		
		if @usuario.save
			flash[:exito]="Se registro con exito,Felicidades"
			bitacora "Se registro Correctamemente el usuario #{@usuario.nombre}"
			redirect_to :action=>"index" 
		else
			bitacora "Errores al registrar Usuario"
			render :registrar_usuario #llama a la vista sin asar por el controladro y tienes que poner en este todas lass que estan el el otro controlador con -------@	
		end
		
	end

	def recuperar_clave
		@titulo="Recuperación de Clave"
	end

	def recuperar

		unless params[:rif]
			flash[:error]="Falta Parametros"
			bitacora "Faltan parametros"
			redirect_to :action=>"recuperar_clave"
			return		
		end		

		rif=params[:rif]
		
		if rif.empty?
			flash[:error]="Disculpe tiene que ingresar su numero de rif."
			bitacora "Intento de ingreso con rif vacio"
			redirect_to :action=>"recuperar_clave"
			return
		end

		if !rif.empty?

			if usr=(Usuario.where(:rif => rif).first)
				flash[:exito]="Se ha enviado la nueva contraseña a su correo"

				bitacora "El usuario #{usr.nombre} recupero contraseña"
				RecuperarClave.recuperar_clave_usuario(usr).deliver
				redirect_to :controller=>"externo" , :action => "index"
				return
			else
				bitacora "Error en algunos de los campos."
				flash[:error]="Disculpe usuario o clave incorrecta."
				redirect_to :action=>"recuperar_clave"
				return
			end	

		end
	end

	def contactenos
		@titulo="Quienes somos ?"
	end

	def preguntas
		if session[:usuario_sesion]
			redirect_to :controller =>"principal",:action =>"preguntas"
			return
		end

		@titulo="Preguntas Frecuentes"
	end


	def tarifas
		if session[:usuario_sesion]
			redirect_to :controller =>"principal",:action =>"tarifas"
			return
		end
		@titulo="Tarifas"
		@rutas=Ruta.all
	end

	def ofertas
		@titulo="Ofertas"
		@ofertas=Ofertas.all
	end

	
end
