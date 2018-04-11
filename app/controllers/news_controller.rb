class NewsController < ApplicationController
  include HomepageHelper
  before_action :set_article, only: [:show, :edit, :new, :update, :destroy, :upvote, :downvote]
  require "rest-client"
  require "json"

  def index
    @articles = Article.all
    if @articles.empty?
      get_news
    end
  end

  def show
    redirect_to(news_index_path)
  end

  def destroy
    log_out
    redirect_to root_url
    flash[:danger] = "successfully loged out"
  end

  def upvote
    if logged_in?
      @article.votes.create(user: current_user)
    else
      flash[:danger] = "You need to be logged in to upvote."
    end

    redirect_to(news_index_path)
  end

  # POST /topics/1
  def downvote
    if logged_in?
      @article.votes.last.destroy
    else
      flash[:danger] = "You need to be logged in to downvote."
    end
    redirect_to(news_index_path)
  end

  def get_news
    require "open-uri"
    url = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=b4e01154f2ca4fb5889b640bce9e15d4"
    response = RestClient.get(url)
    @hash = JSON.parse(response)
    @hash["articles"].each do |article|
      Article.create(:source => article["source"]["name"], :title => article["title"],
                     :description => article["description"], :url => article["url"],
                     :image => article["urlToImage"], :date => article["publishedAt"])
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find_by(id: params[:id])
  end
end
