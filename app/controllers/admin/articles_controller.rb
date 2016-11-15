class Admin::ArticlesController < Admin::ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def index
    @resources = Article.all
  end

  def show
  end

  def new
    @resource = Article.new
  end

  def edit
  end

  def create
    @resource = Article.new(resource_params)

    if @resource.save
      redirect_to [:admin, @resource], notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    if @resource.update(resource_params)
      redirect_to [:admin, @resource], notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @resource.destroy
    redirect_to admin_articles_url, notice: 'Article was successfully destroyed.'
  end

  private
    def set_resource
      @resource = Article.find(params[:id])
    end

    def resource_params
      params.require(:article).permit(:archive, :cover_cache, :crop_x, :crop_y, :crop_w, :crop_h, {
        title_translations: I18n.available_locales,
        content_translations: I18n.available_locales,
        meta_keywords_translations: I18n.available_locales,
        meta_description_translations: I18n.available_locales
      }, :cover)
    end
end
