class Admin::ArticleCategoriesController < Admin::ApplicationController
  before_action :set_resource, only: [:show, :edit, :update]

  def index
    @categories = ArticleCategory.all
  end

  def show
  end

  # predifiend categories in seeds file

  def edit
  end

  def update
    if @category.update(resource_params)
      redirect_to [:admin, @category], notice: 'Article category was successfully updated.'
    else
      render :edit
    end
  end

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
