ActiveAdmin.register Property do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  menu priority: 1, label: 'Property'
  action_item :property_options, only: :index do
    dropdown_menu 'Options' do
      item 'Seats', admin_seats_path
      item 'Rooms', admin_rooms_path
    end
  end

  
  permit_params :name, :google_location_link, :description, :amenity, :company_id, :property_type
  index do
    selectable_column
    id_column
    column :name
    column :google_location_link
    column :description
    column :amenity
    column :company_id
    column :property_type
    actions
  end
  
  filter :name
  filter :google_location_link
  filter :description
  filter :amenity
  filter :company_id
  filter :property_type
  
  form do |f|
    # f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
      f.input :google_location_link
      f.input :description
      f.input :amenity
      f.input :company_id
      f.input :property_type
    end
    f.actions
  end
end
