# require 'rails_helper'
# require 'spec_helper'

# include Warden::Test::Helpers

# RSpec.describe  Admin::CompaniesController, type: :controller do
#   render_views
#   before(:each) do
#     @admin_user =  FactoryBot.create(:admin_user)
#     @company = FactoryBot.create(:company)
#     @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
#     @admin.password = "password"
#     @admin.save
#     sign_in @admin
#   end

#   describe 'POST#new' do
#     let!(:params) do {
#       company_name: ('company 1'),
#       number_of_users:  ( 20 ),
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
#       get :show, params: { id: @company.id }
#       expect(response).to have_http_status(200)
#     end
#   end
# end
require 'rails_helper'
RSpec.describe Admin::CompaniesController, type: :controller do
    let(:admin_user) { FactoryBot.create(:admin_user) }
   before do
    sign_in admin_user
   end
  describe 'GET#index' do
      it 'renders the index page' do
        get :index
        expect(response).to have_http_status(200)
      end
      it 'assigns all the companies to @companies' do
        expect(assigns(:companies)).to eq(@companies)
      end
  end
  describe 'GET#show' do
    let(:company) { FactoryBot.create(:company) }
    it 'renders the show page' do
        get :show, params: { id: company.id }
        expect(response).to have_http_status(200)
    end
    it 'assigns the requested company to @company' do
      get :show, params: { id: company.id }
      expect(assigns(:companies)).to eq(@companies)
    end
  end
  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
    it 'assigns a new company to @company' do
      get :new
      expect(assigns(:company)).to be_a_new(Company)
    end
  end
  describe 'POST#create' do
    let(:valid_params) { { company: { company_name: 'Example company' } } }
    context 'with valid params' do
      it 'creates a new company' do
        expect{
          post :create, params: valid_params
        }.to change(Company, :count).by(0)
      end
      it 'redirects to the index path after successful creation' do
        post :create, params: valid_params
        expect(response).to have_http_status(200)
      end
    end
    context 'with invalid params' do
      let(:invalid_params) { { company: { company_name: '' } } }
      it 'does not create a new company' do
        expect{
          post :create, params: invalid_params
        }.not_to change(Company, :count)
      end
      it 'renders the new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end
  describe 'GET#edit' do
  let(:company) { FactoryBot.create(:company) }
      it 'renders the edit template' do
      get :edit, params: { id: company.id }
      expect(response).to render_template(:edit)
      end
      it 'assigns the requested company to @company' do
        get :edit, params: { id: company.id }
        expect(assigns(:companies)).to eq(@companies)
      end
    end
    describe 'PUT #update' do
        let(:company) { FactoryBot.create(:company) }
        it 'updates the company' do
          put :update, params: { id: company.id, company: { company_name: 'Updated company' } }
          company.reload
          expect(company.company_name).to eq('Updated company')
        end
        it 'redirects to the index page after successful update' do
          put :update, params: { id: company.id, company: { company_name: 'Updated company' } }
          expect(response).to redirect_to(admin_company_path)
      end
  end
  describe 'DELETE #destroy' do
        let!(:company) { FactoryBot.create(:company) }
        it 'destroys the company' do
          expect {
            delete :destroy, params: { id: company.id }
          }.to change(Company, :count).by(-1)
        end
        it 'redirects to the index page after successful deletion' do
          delete :destroy, params: { id: company.id }
          expect(response).to redirect_to(admin_companies_path)
        end
    end
end