class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :property_type
      t.string :google_location_link
      t.text :description
      t.text :amenity
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
