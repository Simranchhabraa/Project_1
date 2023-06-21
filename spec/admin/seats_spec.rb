# require 'rails_helper'

# include Warden::Test::Helpers

# RSpec.describe  Admin::SeatsController, type: :controller do
#   render_views
#   before(:each) do
#     @admin_user =  FactoryBot.create(:admin_user)
#     @property = FactoryBot.create(:property)
#     @seats = FactoryBot.create(:seat, property_id: @property.id )
#     @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
#     @admin.password = "password"
#     @admin.save
#     sign_in @admin
#   end
#   describe 'POST#new' do
#     let!(:params) do {
#       available_seat: (' 12 '),
#       booked:  ( 'true' ),
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
RSpec.describe Admin::SeatsController, type: :controller do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  before do
  sign_in admin_user
  end
  describe 'GET#index' do
      it 'renders the index page' do
        get :index
        expect(response).to have_http_status(200)
      end
      it 'assigns all the seats to @seats' do
        expect(assigns(:seats)).to eq(@seats)
      end
  end
  describe 'GET#show' do
    let(:seat) { FactoryBot.create(:seat) }
    it 'renders the show page' do
        get :show, params: { id: seat.id }
        expect(response).to have_http_status(200)
    end
    it 'assigns the requested seat to @seat' do
      get :show, params: { id: seat.id }
      expect(assigns(:seats)).to eq(@seats)
    end
  end
  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
    it 'assigns a new seat to @seat' do
      get :new
      expect(assigns(:seat)).to be_a_new(Seat)
    end
  end
  describe 'POST#create' do
    let(:valid_params) { { seat: { seat_name: 'Example seat' } } }
    context 'with valid params' do
      it 'creates a new seat' do
        expect{
          post :create, params: valid_params
        }.to change(Seat, :count).by(0)
      end
      it 'redirects to the index path after successful creation' do
        post :create, params: valid_params
        expect(response).to have_http_status(200)
      end
    end
    context 'with invalid params' do
      let(:invalid_params) { { seat: { seat_name: '' } } }
      it 'does not create a new seat' do
        expect{
          post :create, params: invalid_params
        }.not_to change(Seat, :count)
      end
      it 'renders the new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end
  describe 'GET#edit' do
    let(:seat) { FactoryBot.create(:seat) }
    it 'renders the edit template' do
      get :edit, params: { id: seat.id }
      expect(response).to render_template(:edit)
    end
    it 'assigns the requested seat to @seat' do
      get :edit, params: { id: seat.id }
      expect(assigns(:properties)).to eq(@properties)
    end
  end
  describe 'PUT #update' do
    let(:seat) { FactoryBot.create(:seat) }
    it 'updates the seat' do
      put :update, params: { id: seat.id, seat: { seat_name: 'Updated seat' } }
      seat.reload
      expect(seat.seat_name).to eq('Updated seat')
    end
    it 'redirects to the index page after successful update' do
      put :update, params: { id: seat.id, seat: { seat_name: 'Updated seat' } }
      expect(response).to redirect_to(admin_seat_path)
    end
  end
  describe 'DELETE #destroy' do
    let!(:seat) { FactoryBot.create(:seat) }
    it 'destroys the seat' do
      expect {
        delete :destroy, params: { id: seat.id }
      }.to change(Seat, :count).by(-1)
    end
    it 'redirects to the index page after successful deletion' do
      delete :destroy, params: { id: seat.id }
      expect(response).to redirect_to(admin_seats_path)
    end
  end
end