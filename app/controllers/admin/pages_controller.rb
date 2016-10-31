class Admin::PagesController < Admin::ApplicationController
  before_action :set_resource, only: [:show, :edit, :update]

  def index
    @resources = Page.all
  end

  def show
  end


  def edit
  end


  def update
    if @resource.update(resource_params)
      redirect_to [:admin, @resource], notice: 'Page was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_resource
      @resource = Page.find(params[:id])
    end

    def resource_params
      params.require(:page).permit( :cover_cache, :crop_x, :crop_y, :crop_w, :crop_h, {
        title_translations: I18n.available_locales,
        content_translations: I18n.available_locales,
        meta_keywords_translations: I18n.available_locales,
        meta_description_translations: I18n.available_locales
      }, :cover)
    end
end
