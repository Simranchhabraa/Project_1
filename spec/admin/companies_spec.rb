require 'rails_helper'
require 'spec_helper'

include Warden::Test::Helpers

RSpec.describe  Admin::CompaniesController, type: :controller do
  render_views
  before(:each) do
    @admin_user =  FactoryBot.create(:admin_user)
    @company = FactoryBot.create(:company)
    @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
    @admin.password = "password"
    @admin.save
    sign_in @admin
  end

  describe 'POST#new' do
    let!(:params) do {
      company_name: ('company 1'),
      number_of_users:  ( 20 ),
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
      get :show, params: { id: @company.id }
      expect(response).to have_http_status(200)
    end
  end
end