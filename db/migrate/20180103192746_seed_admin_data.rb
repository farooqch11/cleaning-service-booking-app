class SeedAdminData < ActiveRecord::Migration[5.0]
  def change
    Admin.find_or_create_by(email:'admin@joannacleaning.com',password:'password',password_confirmation:'password',role:'admin')
  end
end
