require 'rails_helper'

include Warden::Test::Helpers

RSpec.describe  Admin::BookingsController, type: :controller do
  render_views
  before(:each) do
    @admin_user =  FactoryBot.create(:admin_user)
    @address = FactoryBot.create(:address)
    @property = FactoryBot.create(:property)
    @bookings = FactoryBot.create(:booking, address_id: @address.id, property_id: @property.id )
    @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
    @admin.password = "password"
    @admin.save
    sign_in @admin
  end
  describe 'POST#new' do
    let!(:params) do {
      reserved_date: (20-10-2000),
      reserved_time:  ( Time.now ),
      address_id:(@address.id),
      property_id: (@property.id)
    }
    end
    it 'creates a plan' do
      post :new, params: params
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET#index' do
    it 'shows all data' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET#show' do
    it 'show company details' do
      get :show, params: { id: @address.id, property_id:@property.id }
      expect(response).to have_http_status(200)
    end
  end
end