class CreateSolicitudes < ActiveRecord::Migration
  def change
    create_table :solicitudes do |t|

      t.timestamps
    end
  end
end
