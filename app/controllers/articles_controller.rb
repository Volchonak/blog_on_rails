class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "111", except: [:index, :show]

  def index
    @articles = Article.all.paginate(page: params[:page], per_page: 1)
    @q = Article.ransack(params[:q])
  end

  def search
    @q = Article.ransack(params[:q])
    @articles = @q.result
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :image)
    end

end
