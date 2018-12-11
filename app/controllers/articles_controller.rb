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

    agent = Mechanize.new
    page = agent.get(@article.url)
    host_url = URI.parse(@article.url).host

    host_agent = Mechanize.new
    host_page = agent.get(host_url)

    title = page.at('head meta[property="og:title"]')
    description = page.at('head meta[property="og:description"]')
    site_name = page.at('head meta[property="og:site_name"]')
    image = page.at('head meta[property="og:image"]')

    @article.title = title['content']
    @article.description = description['content']
    @article.image = image['content']

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

    if request.referer.include?("/articles/#{@article.id}")
      redirect_to articles_url 
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:url, :title, :list_id)
    end
end
