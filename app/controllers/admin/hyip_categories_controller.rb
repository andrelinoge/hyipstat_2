class Admin::HyipCategoriesController < Admin::ApplicationController
  before_action :set_admin_article_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = HyipCategory.all
  end

  def show
  end

  def new
    @category = HyipCategory.new
  end

  def edit
  end

  def create
    @category = HyipCategory.new(item_params)

    if @category.save
      redirect_to @category, notice: 'Article category was successfully created.'
    else
      render :new
    end
  end

  def update
    if @category.update(item_params)
      redirect_to @category, notice: 'Article category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_hyip_categories_url, notice: 'Article category was successfully destroyed.'
    head :no_content
  end

  private
    def set_admin_article_category
      @category = HyipCategory.find(params[:id])
    end

    def item_params
      params.fetch(:admin_hyip_category, {})
    end
end
