ActiveAdmin.register Address do
  permit_params :street, :city, :state, :zip_code, :property_id
  index do
    selectable_column
    id_column
    column :street
    column :city
    column :state
    column :zip_code
    column :property_id
    actions
  end
  
  filter :street
  filter :city
  filter :state
  filter :zip_code
  filter :property_id
  
  form do |f|
    # f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :street
      f.input :city
      f.input :state
      f.input :zip_code
      f.input :property_id
    end
    f.actions
  end
  
end
