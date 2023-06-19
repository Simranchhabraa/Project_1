FactoryBot.define do
    factory :seat do
      seat_name { "Example Seat" }
      available_seat { 10 }
      booked { false }
      association :property
    end
end 