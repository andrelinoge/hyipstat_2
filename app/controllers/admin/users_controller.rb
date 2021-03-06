class Admin::UsersController < Admin::ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def index
    @resources = User.all
  end

  def show
  end

  def new
    @resource = User.new
  end

  def edit
  end

  def create
    @resource = User.new(resource_params)

    if @resource.save
      redirect_to [:admin, @resource], notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if @resource.update(resource_params)
      redirect_to [:admin, @resource], notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @resource.destroy
    redirect_to resources_url, notice: 'User was successfully destroyed.'
  end

  private
    def set_resource
      @resource = User.find(params[:id])
    end

    def resource_params
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end

      params.require(:user).permit(:avatar_cache, :crop_x, :crop_y, :crop_w, :crop_h, :birthday,
        :login_name, :first_name, :last_name, :email, :sex, :role, :password, :password_confirmation, {
        title_translations: I18n.available_locales,
        content_translations: I18n.available_locales,
        meta_keywords_translations: I18n.available_locales,
        meta_description_translations: I18n.available_locales
      }, :avatar)
    end
end
