class NewsController < ApplicationController
  include HomepageHelper
  before_action only: [:show, :edit, :new, :update, :destroy]
  require "rest-client"
  require "json"

  def index
    @articles = Article.all
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

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
end