class Admin::HyipsController < Admin::ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def index
    @resources = Hyip.all
  end

  def show
  end

  def new
    @resource = Hyip.new
  end

  def edit
  end

  def create
    @resource = Hyip.new(resource_params)

    if @resource.save
      redirect_to [:admin, @resource], notice: 'Hyip was successfully created.'
    else
      render :new
    end
  end

  def update
    if @resource.update(resource_params)
      redirect_to [:admin, @resource], notice: 'Hyip was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @resource.destroy
    redirect_to resources_url, notice: 'Hyip was successfully destroyed.'
  end

  private
    def set_resource
      @resource = Hyip.find(params[:id])
    end

    def resource_params
      params.require(:hyip).permit(:cover_cache, :hyip_category_id, :crop_x, :crop_y, :crop_w, :crop_h, {
        title_translations: I18n.available_locales,
        content_translations: I18n.available_locales,
        meta_keywords_translations: I18n.available_locales,
        meta_description_translations: I18n.available_locales
      }, :cover)
    end
end
