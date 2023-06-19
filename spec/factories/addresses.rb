# spec/factories/addresses.rb
FactoryBot.define do
    factory :address do
      street { '123 Example St' }
      city { 'Example City' }
      state { 'Example State' }
      zip_code { '12345' }
     association :property
    end
  end
  