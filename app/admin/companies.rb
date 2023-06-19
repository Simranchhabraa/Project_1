ActiveAdmin.register Company do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  collection_action :import_csv, method: :post do
    # Do some CSV importing work here...
    action_item :import_csv, only: :index do
      link_to "Import CSV", import_csv_admin_categories_path, method: :post
    redirect_to collection_path, notice: "CSV imported successfully!"
  end
end
  permit_params :company_name, :description
  index do
    selectable_column
    id_column
    column :company_name
    column :description
    actions
  end
  
  filter :company_name
  filter :description
  
  form do |f|
    # f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :company_name
      f.input :description
    end
    f.actions
  end
end
