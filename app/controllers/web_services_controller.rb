class WebServicesController < ApplicationController
	respond_to :xml

	def index
		@prueba= "<?xml version='1.0' encoding='UTF-8'?>
    <respuesta>           
      <mensaje>El mensaje se recibio con exito!</mensaje>    
    </respuesta>"

		render :text=>@prueba,:status=>200
	end


	def prueba
		@prueba= "<?xml version='1.0' encoding='UTF-8'?><respuesta><mensaje>El mensaje se recibio con exito!</mensaje></respuesta>"

    respond_to do |format|     
      format.xml { render :xml=>@prueba }
    end
		#render :text=>@prueba,:status=>200
		#return
		
	end

	def create

		prodcuto=params[:banco_distribuidor]

		usr=Usuario.find(2)

		@respuesta="
    <?xml version='1.0' encoding='UTF-8'?>
    <respuesta>           
      <mensaje>Exitoso</mensaje>    
    </respuesta>"
     render :text=>@respuesta,:status=>201
		#trabajar el xml 
		#h=Restfulie.at("http://localhost:3000/items").get
	end

end
