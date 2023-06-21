# require 'rails_helper'

# include Warden::Test::Helpers

# RSpec.describe  Admin::AvailableSlotsController, type: :controller do
#   render_views
#   before(:each) do
#     @admin_user =  FactoryBot.create(:admin_user)
#     @property = FactoryBot.create(:property)
#     @available_slots = FactoryBot.create(:available_slot, property_id: @property.id )
#     @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
#     @admin.password = "password"
#     @admin.save
#     sign_in @admin
#   end
#   describe 'POST#new' do
#     let!(:params) do {
#       time: (Time.now),
#       property_id: (@property.id)
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
RSpec.describe Admin::AvailableSlotsController, type: :controller do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  before do
  sign_in admin_user
  end
  describe 'GET#index' do
      it 'renders the index page' do
        get :index
        expect(response).to have_http_status(200)
      end
      it 'assigns all the available_slots to @available_slots' do
        expect(assigns(:available_slots)).to eq(@available_slots)
      end
  end
  describe 'GET#show' do
    let(:available_slot) { FactoryBot.create(:available_slot) }
    it 'renders the show page' do
        get :show, params: { id: available_slot.id }
        expect(response).to have_http_status(200)
    end
    it 'assigns the requested available_slot to @available_slot' do
      get :show, params: { id: available_slot.id }
      expect(assigns(:available_slots)).to eq(@available_slots)
    end
  end
  describe 'GET #new' do
        it 'renders the new template' do
          get :new
          expect(response).to render_template(:new)
        end
        it 'assigns a new available_slot to @available_slot' do
          get :new
          expect(assigns(:available_slot)).to be_a_new(AvailableSlot)
        end
  end
  describe 'POST#create' do
    let(:valid_params) { { available_slot: { time: "10:00 PM" } } }
    context 'with valid params' do
      it 'creates a new available_slot' do
        expect{
          post :create, params: valid_params
        }.to change(AvailableSlot, :count).by(0)
      end
      it 'redirects to the index path after successful creation' do
        post :create, params: valid_params
        expect(response).to have_http_status(200)
      end
    end
    context 'with invalid params' do
      let(:invalid_params) { { available_slot: { time: '' } } }
      it 'does not create a new brewery' do
        expect{
          post :create, params: invalid_params
        }.not_to change(AvailableSlot, :count)
      end
      it 'renders the new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end
  describe 'GET#edit' do
  let(:available_slot) { FactoryBot.create(:available_slot) }
      it 'renders the edit template' do
      get :edit, params: { id: available_slot.id }
      expect(response).to render_template(:edit)
      end
      it 'assigns the requested available_slot to @available_slot' do
        get :edit, params: { id: available_slot.id }
        expect(assigns(:available_slots)).to eq(@available_slots)
      end
    end
    describe 'PUT #update' do
        let(:available_slot) { FactoryBot.create(:available_slot) }
        it 'updates the available_slot' do
          put :update, params: { id: available_slot.id, available_slot: { time: "10:00 PM" } }
          available_slot.reload
          expect(available_slot.time).to eq("10:00 PM")
        end
        it 'redirects to the index page after successful update' do
          put :update, params: { id: available_slot.id, available_slot: {time: "10:00 PM" } }
          expect(response).to redirect_to(admin_available_slot_path)
      end
  end
  describe 'DELETE #destroy' do
        let!(:available_slot) { FactoryBot.create(:available_slot) }
        it 'destroys the available_slot' do
          expect {
            delete :destroy, params: { id: available_slot.id }
          }.to change(AvailableSlot, :count).by(-1)
        end
        it 'redirects to the index page after successful deletion' do
          delete :destroy, params: { id: available_slot.id }
          expect(response).to redirect_to(admin_available_slots_path)
        end
    end
end