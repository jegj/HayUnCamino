class GestionarSolicitudesController < ApplicationController
	layout "administrador"
	before_filter :verificar_autenticado_admin 

	def index
		@titulo="Gestion de Solicitudes"
		@solicitudes=Solicitudes.all		
	end

	def actualizar
		@titulo="Modificar Solicitud"

		unless params[:solicitud_id]
			flash[:error]="Faltan Parametros"
			redirect_to :action=>"index"
			return
		end

		solicitud_id=params[:solicitud_id]
		@estados=["Despachado","Por Despachar","No Procesado","Rechazado"]
		@solicitud=Solicitudes.find(solicitud_id)
		@rutas=Ruta.all
	end

	def guardar_cambios_solicitud
		#mejorar interfaz
		unless params[:solicitud] && params[:solicitud][:id_solicitudes] && params[:solicitud][:ruta_id_actual] && params[:solicitud][:estado]
			flash[:error]="Faltan Parametros"
			redirect_to :action=>"index"
			return
		end

	  solicitud_id=params[:solicitud][:id_solicitudes]
	  solicitud_estado=params[:solicitud][:estado]
		ruta_actual=params[:solicitud][:ruta_id_actual]

		solicitud=Solicitudes.find(solicitud_id)
		solicitud.estado=solicitud_estado
		solicitud.ruta_id_actual=ruta_actual
		if solicitud.save
			flash[:exito]="Se actulizo la solicitud correctamente"
			bitacora "Se actualizo la solicitud #{solicitud_id} por el administrador #{session[:usuario_admin].informacion}"
			redirect_to :action=>"index"
			return
		else
			flash[:error]="No se pudo actulizar la solicitud"
			bitacora "No se pudo actualizar la solicitud #{solicitud_id} por el administrador #{session[:usuario_admin].informacion}"
			redirect_to :action=>"index"
			return
		end
		
	end

	def eliminar_solicitud
		unless params[:solicitud_id]
			flash[:error]="Faltan Parametros"
			redirect_to :action=>"index"
			return
		end

		solicitud_id=params[:solicitud_id]
		solicitud_eliminar=Solicitudes.find(solicitud_id)
		bitacora "Se elimino correctamente la solicitud #{solicitud_eliminar.id_solicitudes} por el administrador #{session[:usuario_admin].nombre } #{session[:usuario_admin].apellido}  con correo : #{session[:usuario_admin].correo}"
		solicitud_eliminar.delete
		flash[:exito]="Se elimino correctamente la Solicitud"
		redirect_to :action=>"index"
		return
	end
	
end
