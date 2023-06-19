class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :address_id
      t.integer :property_id
      t.date :reserved_date
      t.time :reserved_time

      t.timestamps
    end
  end
end
