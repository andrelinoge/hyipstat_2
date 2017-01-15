class Admin::SettingsController < Admin::ApplicationController
  before_action :set_resource, only: [:edit, :update]

  def index
    @resources = AppSetting.all
  end


  def edit
  end

  def update
    if @resource.update(resource_params)
      redirect_to admin_settings_path, notice: 'Setting was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_resource
    @resource = AppSetting.find(params[:id])
  end

  def resource_params
    params.require(:app_setting).permit(:value)
  end


end
