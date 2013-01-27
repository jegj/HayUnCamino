# -*- encoding : utf-8 -*-
class Administrador < ActiveRecord::Base
  # attr_accessible :title, :body  

	validates :nombre, :apellido,:correo,:presence => true
	validates :correo, :uniqueness =>true
	validates :nombre, :apellido,:length =>{:in =>6..45 }
	validates :correo, :length =>{:in =>14..45}

	set_primary_key  :id_administrador
	
	def informacion
		"#{nombre} #{apellido} con correo: #{correo}"
	end	
end
