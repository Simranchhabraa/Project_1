FactoryBot.define do
    factory :room do
      room_name { "Standard Room" }
      available_room { "Yes" }
      booked { false }
      association :property
      created_at { DateTime.now }
      updated_at { DateTime.now }
    end
end
  