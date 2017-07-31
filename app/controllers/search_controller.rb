class SearchController < ApplicationController
  def show
    @stores = Store.search(search_params).paginate(params[:page], 10)
  end

  private

  def search_params
    params.permit(:zip)
  end
end
