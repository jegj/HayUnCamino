# -*- encoding : utf-8 -*-
class CofiguracionRutasController < ApplicationController
	layout "administrador"

	before_filter :verificar_autenticado_admin
	
	def index
		@titulo="Se manejan las siguientes rutas:"
		@rutas=Ruta.all
	end

	def crear_ruta
		@titulo="Crear Ruta"
	end

	def guardar_ruta
		@titulo="Crear Ruta"

		unless params[:ruta] && params[:ruta][:destino] && params[:ruta][:costo] && params[:ruta][:tiempo_prom_duracion] && params[:ruta][:capital]
			flash[:error]="Faltan Parametros"
			redirect_to :action=>"index" 
			return
		end

		@ruta=Ruta.new
		@ruta.destino=params[:ruta][:destino]
		@ruta.costo= params[:ruta][:costo]
		@ruta.tiempo_prom_duracion=params[:ruta][:tiempo_prom_duracion]
		@ruta.capital=params[:ruta][:capital]

		if @ruta.save
			bitacora "Se creo una nueva ruta con destino: #{@ruta.destino} por el administrador #{session[:usuario_admin].nombre } #{session[:usuario_admin].apellido}  con correo : #{session[:usuario_admin].correo}"
			flash[:exito]="Ruta guardada con exito"
			redirect_to :action=>"index" 
			return
		end
		render :action=> "crear_ruta"
	end

	def eliminar_ruta
		unless params[:ruta_id]
			flash[:error]="Faltan Parametros"
			redirect_to :action=>"index"
			return
		end

		ruta_id=params[:ruta_id]
		ruta_eliminar=Ruta.find(ruta_id)
		bitacora "Se elimino correctamente la ruta #{ruta_eliminar.destino} por el administrador #{session[:usuario_admin].nombre } #{session[:usuario_admin].apellido}  con correo : #{session[:usuario_admin].correo}"
		ruta_eliminar.delete
		flash[:exito]="Se elimino correctamente la ruta"
		redirect_to :action=>"index"
		return
	end

	def modificar_ruta
		@titulo="Modificar Ruta"

		unless params[:ruta_id]
			flash[:error]="Faltan Parametros"
			redirect_to :action=>"index"
			return
		end
		ruta_id=params[:ruta_id]
		@ruta=Ruta.find(ruta_id)
	end

	def guardar_cambios_ruta
		@titulo="Modificar Ruta"

		unless params[:ruta] && params[:ruta][:destino] && params[:ruta][:costo] && params[:ruta][:tiempo_prom_duracion] && params[:ruta][:capital]
			flash[:error]="Faltan Parametros"
			redirect_to :action=>"index" 
			return
		end

		@ruta=Ruta.find(params[:ruta_id])
		@ruta.destino=params[:ruta][:destino]
		@ruta.costo=params[:ruta][:costo]
		@ruta.tiempo_prom_duracion=params[:ruta][:tiempo_prom_duracion]
		@ruta.capital=params[:ruta][:capital]

		if @ruta.save
			bitacora "Se modifico la ruta  con destino: #{@ruta.destino} por el administrador #{session[:usuario_admin].nombre } #{session[:usuario_admin].apellido}  con correo : #{session[:usuario_admin].correo}"
			flash[:exito]="Se modifico la ruta con exito"
			redirect_to :action=>"index"
			return
		end

		render :action=>"modificar_ruta"
	end

end
