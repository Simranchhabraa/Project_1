FactoryBot.define do
    factory :property do
      name { "Sample Property" }
      google_location_link { "https://maps.google.com/sample" }
      description { "Sample description" }
      amenity { "Sample amenity" }
      association :company
      property_type { "Huber" }
    end
  end
  