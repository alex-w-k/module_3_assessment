class Api::V1::ItemsController < ApiBaseController
  def index
    render json: Item.all
  end

  def show
    render json: Item.find(params[:id])
  end

end
