ActiveAdmin.register Booking do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :address_id, :reserved_date, :reserved_time, :property_id
  index do
    selectable_column
    id_column
    column :user_id
    column :address_id
    column :reserved_date
    column :reserved_time
    column :property_id
    actions
  end
  
  filter :user_id
  filter :address_id
  filter :reserved_date
  filter :reserved_time
  filter :property_id
  
  form do |f|
    # f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :user_id
      f.input :address_id
      f.input :reserved_date
      f.input :reserved_time
      f.input :property_id
    end
    f.actions
  end
  
end
