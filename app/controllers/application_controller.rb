# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  def bitacora (descripcion)
  	bita=Bitacora.new
  	bita.descripcion=descripcion
    if session[:usuario_sesion]
  	 bita.nombre_usuario=session[:usuario_sesion].nombre 
    end
    if session[:usuario_admin]
      bita.nombre_usuario="#{session[:usuario_admin].nombre } #{session[:usuario_admin].apellido }"
    end
		bita.fecha=Time.now
		bita.direccion_ip=request.remote_ip
		bita.save  
  end

   def verificar_autenticado
    unless session[:usuario_sesion] #else if,tiene quer ser falso
      bitacora "Intento de accceso sin autenticacion"
      flash[:error]="Debe autenticarse"
      redirect_to :action => "index" , :controller => "externo"
      return false
    end
  end

  #prevenir ataque de seguridad
  def verificar_autenticado_admin
     unless session[:usuario_admin] #else if,tiene quer ser falso
      bitacora "Intento de accceso sin autenticacion a la zona del admin"
      flash[:error]="Debe autenticarse como Administrador"
      redirect_to :action => "index" , :controller => "externo"
      return false
    end
  end

end
