class CreateFactura < ActiveRecord::Migration
  def change
    create_table :factura do |t|

      t.timestamps
    end
  end
end
