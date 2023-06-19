class CreateAvailableSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :available_slots do |t|
      t.string :time
      t.references :property, null: false, foreign_key: true
      t.timestamps
    end
  end
end
