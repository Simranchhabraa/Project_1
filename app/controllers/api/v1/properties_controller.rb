class Api::V1::PropertiesController < Api::V1::BaseController
    skip_before_action :verify_authenticity_token

    def create
        # debugger 
        if params[:date].present? && params[:type].present? && params[:time].present?
            @properties = Property.where(property_type: params[:type]).joins(:bookings).where(bookings: { reserved_date: params[:date] }).joins(:available_slots).where(available_slots: { time: params[:time] })
            render json: @properties.to_json, status: :ok 
        else
            render json: { error: 'Record not found' }, status: :ok
        end
    end
  
    # def show 
        # @properties = Property.find(params[:id])
    #     if @properties.present?
    #         render json: @properties.to_json, status: :ok 
    #     else
    #         render json: { error: 'Record not found' }, status: :ok
    #     end
    # end
    # private
  
    # def property_params
    #   params.permit(:name, :property_type, :google_location_link, :description, :amenity, :room, :seat, :company_id)
    # end
end  