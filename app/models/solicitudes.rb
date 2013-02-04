class Solicitudes < ActiveRecord::Base
  # attr_accessible :title, :body
  set_primary_key  :id_solicitudes

  def self.buscar_solicitud(id)
  	Solicitudes.where(:id_solicitudes=>id).first
  end

  def obtener_destino
  	Ruta.where(:id_ruta=>ruta_id_ruta).first.destino	
  end

  def obtener_destino_actual
		Ruta.where(:id_ruta=>ruta_id_actual).first.destino	  	
  end

  def self.buscar_destino(id_solicitud,flag_actual)
    if flag_actual    
      id_ruta=Solicitudes.buscar_solicitud(id_solicitud).ruta_id_ruta
      Ruta.obtener_destino(id_ruta);
    else
      id_ruta=Solicitudes.buscar_solicitud(id_solicitud).ruta_id_actual
      Ruta.obtener_destino(id_ruta);
    end
  end

  



end
