require 'rails_helper'

include Warden::Test::Helpers

RSpec.describe  Admin::PropertiesController, type: :controller do
  render_views
  before(:each) do
    @admin_user =  FactoryBot.create(:admin_user)
    @company = FactoryBot.create(:company)
    @property = FactoryBot.create(:property, company_id: @company.id)
    @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
    @admin.password = "password"
    @admin.save
    sign_in @admin
  end

  describe 'POST#new' do
    let!(:params) do {
      name: ('prop 1'),
      description:  ('description of our property'),
      property_type: ( 0 ),
    #   country: ('uk'),
    #   latitude: (AccountBlock::Account::CORPORATE_ADMIN),
      company_id: (@company.id),
      address: ('somewhere'),
      google_location_link: ('google link'),
      amenities: ('xyzx amenities')
    } 
    end
    it 'creates a property' do
      post :new, params: params
      expect(response).to have_http_status(200)
    end 

  end

  describe 'GET#index' do
    it 'shows all properties' do
      get :index 
      expect(response).to have_http_status(200)
    end 
  end

  describe 'GET#show' do
    it 'show property details' do
      get :show, params: { id: @property.id }
      expect(response).to have_http_status(200)
    end 
  end
end