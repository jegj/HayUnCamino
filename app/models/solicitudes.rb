class Solicitudes < ActiveRecord::Base
  # attr_accessible :title, :body
  set_primary_key  :id_solicitudes

  def self.buscar_solicitud(id)
  	Solicitudes.where(:id_solicitudes=>id).first
  end
end
