class Api::V1::BookingsController < Api::V1::BaseController
    skip_before_action :verify_authenticity_token
    def select_seat 
        if params[:floor].present? && params[:seat].present?
            @bookings = Booking.where(floor_image: params[:floor]).joins(:properties).where(properties: { seat: params[:seat] })
            render json: @properties.to_json, status: :ok 
        else
            render json: { error: 'Record not found' }, status: :ok
        end
    end
end