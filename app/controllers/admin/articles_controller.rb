class Admin::ArticlesController < Admin::ApplicationController
  before_action :set_admin_article, only: [:show, :edit, :update, :destroy]

  def index
    @admin_articles = Article.includes(:article_category).all
  end

  def show
  end

  def new
    @admin_article = Article.new
  end

  def edit
  end

  def create
    @admin_article = Article.new(admin_article_params)

    if @admin_article.save
      redirect_to [:admin, @admin_article], notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    if @admin_article.update(admin_article_params)
      redirect_to [:admin, @admin_article], notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @admin_article.destroy
    redirect_to admin_articles_url, notice: 'Article was successfully destroyed.'
  end

  private
    def set_admin_article
      @admin_article = Article.find(params[:id])
    end

    def admin_article_params
      params.require(:article).permit(:archive, :article_category_id, {
        title_translations: I18n.available_locales,
        content_translations: I18n.available_locales,
        meta_keywords_translations: I18n.available_locales,
        meta_description_translations: I18n.available_locales
      })
    end
end
