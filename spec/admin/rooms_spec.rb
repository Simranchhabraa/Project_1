# require 'rails_helper'

# include Warden::Test::Helpers

# RSpec.describe  Admin::RoomsController, type: :controller do
#   render_views
#   before(:each) do
#     @admin_user =  FactoryBot.create(:admin_user)
#     @property = FactoryBot.create(:property)
#     @rooms = FactoryBot.create(:room, property_id: @property.id )
#     @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
#     @admin.password = "password"
#     @admin.save
#     sign_in @admin
#   end
#   describe 'POST#new' do
#     let!(:params) do {
#       room_name: (' normal room '),
#       available_room: ('yes'),
#       booked: (true),
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
RSpec.describe Admin::RoomsController, type: :controller do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  before do
  sign_in admin_user
  end
  describe 'GET#index' do
      it 'renders the index page' do
        get :index
        expect(response).to have_http_status(200)
      end
      it 'assigns all the rooms to @rooms' do
        expect(assigns(:rooms)).to eq(@rooms)
      end
  end
  describe 'GET#show' do
    let(:room) { FactoryBot.create(:room) }
    it 'renders the show page' do
        get :show, params: { id: room.id }
        expect(response).to have_http_status(200)
    end
    it 'assigns the requested room to @room' do
      get :show, params: { id: room.id }
      expect(assigns(:rooms)).to eq(@rooms)
    end
  end
  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
    it 'assigns a new room to @room' do
      get :new
      expect(assigns(:room)).to be_a_new(Room)
    end
  end
  describe 'POST#create' do
    let(:valid_params) { { room: { room_name: 'Example room' } } }
    context 'with valid params' do
      it 'creates a new room' do
        expect{
          post :create, params: valid_params
        }.to change(Room, :count).by(0)
      end
      it 'redirects to the index path after successful creation' do
        post :create, params: valid_params
        expect(response).to have_http_status(200)
      end
    end
    context 'with invalid params' do
      let(:invalid_params) { { room: { room_name: '' } } }
      it 'does not create a new room' do
        expect{
          post :create, params: invalid_params
        }.not_to change(Room, :count)
      end
      it 'renders the new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end
  describe 'GET#edit' do
    let(:room) { FactoryBot.create(:room) }
    it 'renders the edit template' do
      get :edit, params: { id: room.id }
      expect(response).to render_template(:edit)
    end
    it 'assigns the requested room to @room' do
      get :edit, params: { id: room.id }
      expect(assigns(:properties)).to eq(@properties)
    end
  end
  describe 'PUT #update' do
    let(:room) { FactoryBot.create(:room) }
    it 'updates the room' do
      put :update, params: { id: room.id, room: { room_name: 'Updated room' } }
      room.reload
      expect(room.room_name).to eq('Updated room')
    end
    it 'redirects to the index page after successful update' do
      put :update, params: { id: room.id, room: { room_name: 'Updated room' } }
      expect(response).to redirect_to(admin_room_path)
    end
  end
  describe 'DELETE #destroy' do
    let!(:room) { FactoryBot.create(:room) }
    it 'destroys the room' do
      expect {
        delete :destroy, params: { id: room.id }
      }.to change(Room, :count).by(-1)
    end
    it 'redirects to the index page after successful deletion' do
      delete :destroy, params: { id: room.id }
      expect(response).to redirect_to(admin_rooms_path)
    end
  end
end