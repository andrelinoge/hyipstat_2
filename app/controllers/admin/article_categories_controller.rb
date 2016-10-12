class Admin::ArticleCategoriesController < Admin::ApplicationController
  before_action :set_admin_article_category, only: [:show, :edit, :update, :destroy]

  def index
    @admin_article_categories = ArticleCategory.all
  end

  def show
  end

  def new
    @admin_article_category = ArticleCategory.new
  end

  def edit
  end

  def create
    @admin_article_category = ArticleCategory.new(admin_article_category_params)

    if @admin_article_category.save
      redirect_to @admin_article_category, notice: 'Article category was successfully created.'
    else
      render :new
    end
  end

  def update
    if @admin_article_category.update(admin_article_category_params)
      redirect_to @admin_article_category, notice: 'Article category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @admin_article_category.destroy
    redirect_to admin_article_categories_url, notice: 'Article category was successfully destroyed.'
    head :no_content
  end

  private
    def set_admin_article_category
      @admin_article_category = ArticleCategory.find(params[:id])
    end

    def admin_article_category_params
      params.fetch(:admin_article_category, {})
    end
end
