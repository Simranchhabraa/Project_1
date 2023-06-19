FactoryBot.define do
    factory :available_slot do
      time { "09:00 AM" }
      association :property
      created_at { DateTime.now }
      updated_at { DateTime.now }
    end
end
  