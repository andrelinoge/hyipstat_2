class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!

  layout 'admin'


	protected
  
  def authenticate_user!
    if current_user.nil? || current_user.role.user?
      sign_out
      redirect_to new_admin_user_session_path
    end
  end
end
