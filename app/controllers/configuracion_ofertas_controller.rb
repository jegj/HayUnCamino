class ConfiguracionOfertasController < ApplicationController
	layout "administrador"

	def index
		@titulo="Se manejan las siguientes ofertas:"
		@ofertas=Ofertas.all
	end

end
