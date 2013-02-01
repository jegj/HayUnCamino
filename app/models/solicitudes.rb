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



end
