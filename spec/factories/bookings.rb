FactoryBot.define do
    factory :booking do
    #   association :user
      association :address
      association :property
      reserved_date { Date.today }
      reserved_time { Time.now }
      created_at { DateTime.now }
      updated_at { DateTime.now }
    end
  end
  