class Factura < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.buscar_factura(id)
  	Factura.find(id)
  end
end
