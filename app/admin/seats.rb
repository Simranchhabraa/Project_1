ActiveAdmin.register Seat do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :seat_name, :available_seat, :booked, :property_id
  index do
    selectable_column
    id_column
    column :seat_name
    column :available_seat
    column :booked
    column :property_id
    actions
  end
  
  filter :seat_name
  filter :available_seat
  filter :booked
  filter :property_id
  
  form do |f|
    # f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :seat_name
      f.input :available_seat
      f.input :booked
      f.input :property_id
    end
    f.actions
  end
end
