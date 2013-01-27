# -*- encoding : utf-8 -*-
class Ruta < ActiveRecord::Base
  set_primary_key :id_ruta
  validates :costo ,:destino ,:tiempo_prom_duracion,:capital,:presence =>true
  validates :tiempo_prom_duracion ,:numericality => { :only_integer => true }
  validates :costo,:numericality => true
  validates :destino ,:uniqueness => true

end
