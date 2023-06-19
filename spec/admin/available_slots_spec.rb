require 'rails_helper'

include Warden::Test::Helpers

RSpec.describe  Admin::AvailableSlotsController, type: :controller do
  render_views
  before(:each) do
    @admin_user =  FactoryBot.create(:admin_user)
    @property = FactoryBot.create(:property)
    @available_slots = FactoryBot.create(:available_slot, property_id: @property.id )
    @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
    @admin.password = "password"
    @admin.save
    sign_in @admin
  end
  describe 'POST#new' do
    let!(:params) do {
      time: (Time.now),
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
      get :show, params: { id: @property.id }
      expect(response).to have_http_status(200)
    end
  end
end