class RastreoController < ApplicationController
	layout :resolver_layaout

	def rastrear
		@titulo="Siga de cerca su paquete con el servicio de rastreo de proporcionado por Hay Un Camino!"
		unless params[:id_paquete]
			flash[:error]="Faltan Parametros"
			bitacora "Faltan Parametros"

			if session[:usuario_sesion]
				redirect_to :controller=>"principal", :action=>"index"
				return
			else
				redirect_to :controller=>"externo", :action=>"index"
				return
			end
		end

		@paquete=params[:id_paquete]
		@solicitud=Solicitudes.buscar_solicitud(@paquete)
		if(@solicitud)
			ruta=@solicitud.ruta_id_ruta
			pais="Venezuela"
			if @ciudad=Ruta.find(ruta)
				union_ubicacion="#{@ciudad.capital},#{pais}"
				busqueda_coordenadas=Geocoder.search(union_ubicacion)
				latitud=busqueda_coordenadas[0].latitude 
				longitud=busqueda_coordenadas[0].longitude
				@resultado="#{latitud},#{longitud}"
			end
		end
	end


	def resolver_layaout
		if session[:usuario_sesion]
			"interno"
		else 
			"externo"
		end
	end

end