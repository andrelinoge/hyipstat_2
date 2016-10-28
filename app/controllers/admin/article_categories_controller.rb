class Admin::ArticleCategoriesController < Admin::ApplicationController
  before_action :set_resource, only: [:show, :edit, :update]

  def index
    @categories = ArticleCategory.all
  end

  def show
  end

  # predifiend categories in seeds file

  # def new
  #   @category = ArticleCategory.new
  # end

  # def create
  #   @category = ArticleCategory.new(resource_params)

  #   if @category.save
  #     redirect_to @category, notice: 'Article category was successfully created.'
  #   else
  #     render :new
  #   end
  # end

  def edit
  end

  def update
    if @category.update(resource_params)
      redirect_to [:admin, @category], notice: 'Article category was successfully updated.'
    else
      render :edit
    end
  end

  # def destroy
  #   @category.destroy
  #   redirect_to admin_hyip_categories_url, notice: 'Article category was successfully destroyed.'
  #   head :no_content
  # end

  private
    def set_resource
      @category = ArticleCategory.find(params[:id])
    end

    def resource_params
      params.require(:article_category).permit({
        name_translations: I18n.available_locales
      })
    end
end
