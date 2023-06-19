ActiveAdmin.register AvailableSlot do
  permit_params :time, :property_id
  index do
    selectable_column
    id_column
    column :time
    column :property_id
    actions
  end
  
  filter :time
  filter :property_id
  
  form do |f|
    # f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :time
      f.input :property_id
    end
    f.actions
  end
end
