ActiveAdmin.register Room do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :room_name, :available_room, :booked, :property_id
  index do
    selectable_column
    id_column
    column :room_name
    column :available_room
    column :booked
    column :property_id
    actions
  end
  
  filter :room_name
  filter :available_room
  filter :booked
  filter :property_id
  
  form do |f|
    # f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :room_name
      f.input :available_room
      f.input :booked
      f.input :property_id
    end
    f.actions
  end
  
end
