class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!

  layout 'admin'


	protected
  
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_admin_session_path
    end
  end
end
