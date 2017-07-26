class SearchController < ApplicationController
  def show
    @stores = Store.search(search_params)
  end

  private

  def search_params
    params.permit(:zip)
  end
end
