# -*- encoding : utf-8 -*-
class Usuario < ActiveRecord:: Base #< Herencia ActiveRecord Es la clase que implementa orm (Mape las clases deruby con las tablas de la bd)
	set_primary_key  :id_usuario
	validates :clave, :confirmation => true	
	validates :nombre, :rif, :direccion, :correo, :clave_confirmation, :presence => true
	validates :correo, :uniqueness =>true
	validates :nombre, :clave, :clave_confirmation, :length =>{:in =>6..45 }
	validates :correo,  :length =>{:in =>14..45}
	validates :direccion, :length =>{:in =>15..45 }
	validates :rif, :numericality => {:only_integer => true}

end
