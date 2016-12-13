class Admin::SessionsController < Devise::SessionsController

  layout "admin_sign_in"

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def new
  end

end