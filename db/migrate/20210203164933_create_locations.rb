class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :zip_code
      t.integer :max_inches_of_snow

      t.timestamps
    end
  end
end
