class RastreoController < ApplicationController
	layout :resolver_layaout

	def rastrear
		@titulo="Rastreo de Paquetes"
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
			ruta=@solicitud.ruta_id_actual
			pais="Venezuela"
			if @ciudad=Ruta.find(ruta)
				union_ubicacion="#{@ciudad.capital},#{pais}"
				comercio_id=UsuarioFacturaSolicitud.where(:solicitudes_id_solicitudes=>@paquete).first.usuario_id_usuario
				@comercio=Usuario.find(comercio_id)
				if busqueda_coordenadas=Geocoder.search(union_ubicacion)
					latitud=busqueda_coordenadas[0].latitude 
					longitud=busqueda_coordenadas[0].longitude
					@resultado="#{latitud},#{longitud}"
				end
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
