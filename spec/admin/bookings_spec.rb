# require 'rails_helper'

# include Warden::Test::Helpers

# RSpec.describe  Admin::BookingsController, type: :controller do
#   render_views
#   before(:each) do
#     @admin_user =  FactoryBot.create(:admin_user)
#     @address = FactoryBot.create(:address)
#     @property = FactoryBot.create(:property)
#     @bookings = FactoryBot.create(:booking, address_id: @address.id, property_id: @property.id )
#     @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
#     @admin.password = "password"
#     @admin.save
#     sign_in @admin
#   end
#   describe 'POST#new' do
#     let!(:params) do {
#       reserved_date: (20-10-2000),
#       reserved_time:  ( Time.now ),
#       address_id:(@address.id),
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
#       get :show, params: { id: @address.id, property_id:@property.id }
#       expect(response).to have_http_status(200)
#     end
#   end
# end
require 'rails_helper'
RSpec.describe Admin::BookingsController, type: :controller do
    let(:admin_user) { FactoryBot.create(:admin_user) }
   before do
    sign_in admin_user
   end
  describe 'GET#index' do
      it 'renders the index page' do
        get :index
        expect(response).to have_http_status(200)
      end
      it 'assigns all the bookings to @bookings' do
        expect(assigns(:bookings)).to eq(@bookings)
      end
  end
  describe 'GET#show' do
    let(:booking) { FactoryBot.create(:booking) }
    it 'renders the show page' do
        get :show, params: { id: booking.id }
        expect(response).to have_http_status(200)
    end
    it 'assigns the requested booking to @booking' do
      get :show, params: { id: booking.id }
      expect(assigns(:bookings)).to eq(@bookings)
    end
  end
  describe 'GET #new' do
        it 'renders the new template' do
          get :new
          expect(response).to render_template(:new)
        end
        it 'assigns a new booking to @booking' do
          get :new
          expect(assigns(:booking)).to be_a_new(Booking)
        end
  end
  describe 'POST#create' do
    let(:valid_params) { { booking: { reserved_date: '29-10-2021' } } }
    context 'with valid params' do
      it 'creates a new booking' do
        expect{
          post :create, params: valid_params
        }.to change(Booking, :count).by(0)
      end
      it 'redirects to the index path after successful creation' do
        post :create, params: valid_params
        expect(response).to have_http_status(200)
      end
    end
    context 'with invalid params' do
      let(:invalid_params) { { booking: { reserved_date: '' } } }
      it 'does not create a new booking' do
        expect{
          post :create, params: invalid_params
        }.not_to change(Booking, :count)
      end
      it 'renders the new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end
  describe 'GET#edit' do
  let(:booking) { FactoryBot.create(:booking) }
      it 'renders the edit template' do
      get :edit, params: { id: booking.id }
      expect(response).to render_template(:edit)
      end
      it 'assigns the requested booking to @booking' do
        get :edit, params: { id: booking.id }
        expect(assigns(:bookings)).to eq(@bookings)
      end
    end
    describe 'PUT #update' do
        let(:booking) { FactoryBot.create(:booking) }
        it 'updates the booking' do
          put :update, params: { id: booking.id, booking: { reserved_date: '29-10-2021' } }
          booking.reload
          expected_date = Date.parse('29-10-2021')
          expect(booking.reserved_date).to eq(expected_date)
        end
        it 'redirects to the index page after successful update' do
          put :update, params: { id: booking.id, booking: { reserved_date: '29-10-2021' } }
          expect(response).to redirect_to(admin_booking_path)
      end
  end
  describe 'DELETE #destroy' do
        let!(:booking) { FactoryBot.create(:booking) }
        it 'destroys the booking' do
          expect {
            delete :destroy, params: { id: booking.id }
          }.to change(Booking, :count).by(-1)
        end
        it 'redirects to the index page after successful deletion' do
          delete :destroy, params: { id: booking.id }
          expect(response).to redirect_to(admin_bookings_path)
        end
    end
end