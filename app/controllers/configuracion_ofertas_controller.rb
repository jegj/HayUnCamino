class ConfiguracionOfertasController < ApplicationController
	layout "administrador"

	#Crear una vista para que se vea por el usuario y otra por el adminsitrador
	def index
		@titulo="Se manejan las siguientes ofertas:"
		@ofertas=Ofertas.all
	end

	def crear_oferta
		@titulo="Crear Oferta"
	end

	def guardar_oferta
		@titulo="Crear Oferta"
#id_Ofertas | nombre_Ofertar | descuento | fecha_Inicio | fecha_Fin 
		unless params[:oferta] && params[:oferta][:nombre_Oferta] && params[:oferta][:descuento] && params[:oferta][:fecha_Inicio] && params[:oferta][:fecha_Fin] 
			flash[:error]="Faltan Parametros"
			redirect_to :action=>"crear_oferta" 
			return
		end

		@oferta=Ofertas.new
		@oferta.nombre_Ofertar=params[:oferta][:nombre_Oferta]
		@oferta.descuento= params[:oferta][:descuento]
		@oferta.fecha_Inicio=params[:oferta][:fecha_Inicio]
		@oferta.fecha_Fin=params[:oferta][:fecha_Fin]

		if @oferta.save
			bitacora "Se creo una nueva oferta con nombre: #{@oferta.nombre_Ofertar} por el administrador #{session[:usuario_admin].nombre } #{session[:usuario_admin].apellido}  con correo : #{session[:usuario_admin].correo}"
			flash[:exito]="Oferta guardada con exito"
			redirect_to :action=>"index" 
			return
		end
		render :action=> "crear_oferta"
	end

	def eliminar_oferta
		unless params[:oferta_id]
			flash[:error]="Faltan Parametros"
			redirect_to :action=>"index"
			return
		end

		oferta_id=params[:oferta_id]
		oferta_eliminar=Ofertas.find(oferta_id)
		bitacora "Se elimino correctamente la oferta #{oferta_eliminar.nombre_Ofertar} por el administrador #{session[:usuario_admin].nombre } #{session[:usuario_admin].apellido}  con correo : #{session[:usuario_admin].correo}"
		oferta_eliminar.delete
		flash[:exito]="Se elimino correctamente la oferta"
		redirect_to :action=>"index"
		return
	end

	def modificar_oferta
		@titulo="Modificar oferta"

		unless params[:oferta_id]
			flash[:error]="Faltan Parametros"
			redirect_to :action=>"index"
			return
		end
		oferta_id=params[:oferta_id]
		@oferta=Ofertas.find(oferta_id)
	end

	def guardar_cambios_oferta
		@titulo="Modificar Oferta"

		unless params[:oferta] && params[:oferta][:nombre_Ofertar] && params[:oferta][:descuento] && params[:oferta][:fecha_Inicio] && params[:oferta][:fecha_Fin] 
			flash[:error]="Faltan Parametros"
			redirect_to :action=>"modificar_oferta" 
			return
		end

		@oferta=Ofertas.find(params[:oferta_id])
		@oferta.nombre_Ofertar=params[:oferta][:nombre_Ofertar]
		@oferta.descuento= params[:oferta][:descuento]
		@oferta.fecha_Inicio=params[:oferta][:fecha_Inicio]
		@oferta.fecha_Fin=params[:oferta][:fecha_Fin]
		
		if @oferta.save
			bitacora "Se modifico la oferta con nombre: #{@oferta.nombre_Ofertar} por el administrador #{session[:usuario_admin].nombre } #{session[:usuario_admin].apellido}  con correo : #{session[:usuario_admin].correo}"
			flash[:exito]="Se modifico la ruta con exito"
			redirect_to :action=>"index"
			return
		end

		render :action=>"modificar_oferta"
	end

end