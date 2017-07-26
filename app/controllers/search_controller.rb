class SearchController < ApplicationController
  def show
    response = Faraday.get("https://api.bestbuy.com/v1/stores(area(#{params[:zip]},25))?format=json&show=storeId,storeType,name&pageSize=17&apiKey=#{ENV["BEST_BUY_API_KEY"]}")
    @stores = JSON.parse(response.body)["stores"].map do |store|
      Store.new(store)
    end
  end
end
