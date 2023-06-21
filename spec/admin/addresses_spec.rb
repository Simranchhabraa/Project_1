# require 'rails_helper'
# include Warden::Test::Helpers
# RSpec.describe  Admin::AddressesController, type: :controller do
#   render_views
#   before(:each) do
#     @admin_user =  FactoryBot.create(:admin_user)
#     @property = FactoryBot.create(:property)
#     @address = FactoryBot.create(:address, property_id: @property.id )
#     @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
#     @admin.password = "password"
#     @admin.save
#     sign_in @admin
#   end
#   describe 'POST#new' do
#     let!(:params) do {
#       street: ('street 1'),
#       city:  ( 'city' ),
#       state:  ( 'state 1' ),
#       zip_code:  ( 'zip_code 1' ),
#       property_id:  ( @property.id ),
#     }
#     end
#     it 'creates a plan' do
#       post :new, params: params
#       expect(response).to have_http_status(200)
#     end
#   end
#   describe 'GET#index' do
#     it 'shows all data' do
#       get :index
#       expect(response).to have_http_status(200)
#     end
#   end
#   describe 'GET#show' do
#     it 'show company details' do
#       get :show, params: { id: @property.id }
#       expect(response).to have_http_status(200)
#     end
#   end
# end

require 'rails_helper'
RSpec.describe  Admin::AddressesController, type: :controller do
    let(:admin_user) { FactoryBot.create(:admin_user) }
  before do
    sign_in admin_user
  end
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
    it 'assigns addresses to @addresses' do
      address = FactoryBot.create(:address)
      get :index
      expect(assigns(:addresses)).to eq([address])
    end
  end
  describe 'GET#show' do
    let(:address) { FactoryBot.create(:address) }
    it 'renders the show page' do
        get :show, params: { id: address.id }
        expect(response).to have_http_status(200)
    end
    it 'assigns the requested address to @address' do
      get :show, params: { id: address.id }
      expect(assigns(:addresses)).to eq(@addresses)
    end
  end
  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end
  describe 'POST #create' do
    let(:address) { create(:address, street: 'Example address', city: 'Example City') }
    it 'creates a new address' do
      expect {
        post :create, params: { address: address }
      }.to change(Address, :count).by(1)
    end
    it 'redirects to the index page after successful creation' do
      post :create, params: { address: address }
      expect(response).to have_http_status(200)
    end
  end
  describe 'GET #edit' do
    let(:address) { FactoryBot.create(:address) }
    it 'renders the edit template' do
      get :edit, params: { id: address.id }
      expect(response).to render_template(:edit)
    end
  end
  describe 'PUT #update' do
    let(:address) { FactoryBot.create(:address) }
    it 'updates the address' do
      put :update, params: { id: address.id, address: { city: 'Updated address' } }
      address.reload
      expect(address.city).to eq('Updated address')
    end
    it 'redirects to the index page after successful update' do
      put :update, params: { id: address.id, address: { city: 'Updated address' } }
      expect(response).to redirect_to(admin_address_path)
    end
  end
  describe 'DELETE #destroy' do
    let!(:address) { FactoryBot.create(:address) }
    it 'destroys the address' do
      expect {
        delete :destroy, params: { id: address.id }
      }.to change(Address, :count).by(-1)
    end
    it 'redirects to the index page after successful deletion' do
      delete :destroy, params: { id: address.id }
      expect(response).to redirect_to(admin_addresses_path)
    end
  end
end
