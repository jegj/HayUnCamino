class CreateUsuarioFacturaSolicitud < ActiveRecord::Migration
  def change
    create_table :usuario_factura_solicitud do |t|

      t.timestamps
    end
  end
end
