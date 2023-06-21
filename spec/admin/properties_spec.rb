# require 'rails_helper'

# include Warden::Test::Helpers

# RSpec.describe  Admin::PropertiesController, type: :controller do
#   render_views
#   before(:each) do
#     @admin_user =  FactoryBot.create(:admin_user)
#     @company = FactoryBot.create(:company)
#     @property = FactoryBot.create(:property, company_id: @company.id)
#     @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
#     @admin.password = "password"
#     @admin.save
#     sign_in @admin
#   end

#   describe 'POST#new' do
#     let!(:params) do {
#       name: ('prop 1'),
#       description:  ('description of our property'),
#       property_type: ( 0 ),
#     #   country: ('uk'),
#     #   latitude: (AccountBlock::Account::CORPORATE_ADMIN),
#       company_id: (@company.id),
#       address: ('somewhere'),
#       google_location_link: ('google link'),
#       amenities: ('xyzx amenities')
#     } 
#     end
#     it 'creates a property' do
#       post :new, params: params
#       expect(response).to have_http_status(200)
#     end 

#   end

#   describe 'GET#index' do
#     it 'shows all properties' do
#       get :index 
#       expect(response).to have_http_status(200)
#     end 
#   end

#   describe 'GET#show' do
#     it 'show property details' do
#       get :show, params: { id: @property.id }
#       expect(response).to have_http_status(200)
#     end 
#   end
# end
require 'rails_helper'
RSpec.describe Admin::PropertiesController, type: :controller do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  before do
  sign_in admin_user
  end
  describe 'GET#index' do
      it 'renders the index page' do
        get :index
        expect(response).to have_http_status(200)
      end
      it 'assigns all the properties to @properties' do
        expect(assigns(:properties)).to eq(@properties)
      end
  end
  describe 'GET#show' do
    let(:property) { FactoryBot.create(:property) }
    it 'renders the show page' do
        get :show, params: { id: property.id }
        expect(response).to have_http_status(200)
    end
    it 'assigns the requested property to @property' do
      get :show, params: { id: property.id }
      expect(assigns(:properties)).to eq(@properties)
    end
  end
  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
    it 'assigns a new property to @property' do
      get :new
      expect(assigns(:property)).to be_a_new(Property)
    end
  end
  describe 'POST#create' do
    let(:valid_params) { { property: { name: 'Example property' } } }
    context 'with valid params' do
      it 'creates a new property' do
        expect{
          post :create, params: valid_params
        }.to change(Property, :count).by(0)
      end
      it 'redirects to the index path after successful creation' do
        post :create, params: valid_params
        expect(response).to have_http_status(200)
      end
    end
    context 'with invalid params' do
      let(:invalid_params) { { property: { name: '' } } }
      it 'does not create a new property' do
        expect{
          post :create, params: invalid_params
        }.not_to change(Property, :count)
      end
      it 'renders the new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end
  describe 'GET#edit' do
    let(:property) { FactoryBot.create(:property) }
    it 'renders the edit template' do
      get :edit, params: { id: property.id }
      expect(response).to render_template(:edit)
    end
    it 'assigns the requested property to @property' do
      get :edit, params: { id: property.id }
      expect(assigns(:properties)).to eq(@properties)
    end
  end
  describe 'PUT #update' do
    let(:property) { FactoryBot.create(:property) }
    it 'updates the property' do
      put :update, params: { id: property.id, property: { name: 'Updated property' } }
      property.reload
      expect(property.name).to eq('Updated property')
    end
    it 'redirects to the index page after successful update' do
      put :update, params: { id: property.id, property: { name: 'Updated property' } }
      expect(response).to redirect_to(admin_property_path)
    end
  end
  describe 'DELETE #destroy' do
    let!(:property) { FactoryBot.create(:property) }
    it 'destroys the property' do
      expect {
        delete :destroy, params: { id: property.id }
      }.to change(Property, :count).by(-1)
    end
    it 'redirects to the index page after successful deletion' do
      delete :destroy, params: { id: property.id }
      expect(response).to redirect_to(admin_properties_path)
    end
  end
end