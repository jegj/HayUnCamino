# -*- encoding : utf-8 -*-
class CreateRuta < ActiveRecord::Migration
  def change
    create_table :ruta do |t|

      t.timestamps
    end
  end
end
