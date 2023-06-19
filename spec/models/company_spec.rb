# require 'rails_helper'
# # require 'active_admin_helper'
# RSpec.describe Company, type: :model do
#     include Devise::Test::ControllerHelpers
#     before do
#     @admin_user = AdminUser.create(email: 'admin@example.com', password: 'password')
#       sign_in @admin_user
#     end
#     describe 'permit_params' do
#       it 'includes company_name and description' do
#         expected_params = [:company_name, :description]
#         expect(ActiveAdmin.registered_models[Company].permit_params).to eq(expected_params)
#       end
#     end
#   end
