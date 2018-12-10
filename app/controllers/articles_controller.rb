class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  # GET /articles
  def index
    @articles = Article.all
  end

  # GET /articles/1
  def show
    @article = Article.find(params[:id])
  end

  # GET /articles/new
  def new
    @article = current_user.articles.new
  end

  # GET /articles/1/edit
  def edit
    @article = current_user.articles.find(params[:id])
  end

  # POST /articles
  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new 
    end
  end

  # PATCH/PUT /articles/1
  def update
    @article = current_user.articles.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/1
  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:url, :list_id)
    end
end
