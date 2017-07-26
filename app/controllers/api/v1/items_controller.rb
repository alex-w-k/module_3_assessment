class Api::V1::ItemsController < ApiBaseController

  def index
    render json: Item.all
  end

  def show
    render json: Item.find(params[:id])
  end

  def destroy
    item = Item.find(params[:id])
    if item.destroy
      head :no_content
    end
  end

  def create
    @item = Item.new
    if @item.update_attributes(item_params)
      render json: Item.last
    else
      render nothing: true, status: :bad_request
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :image_url)
  end

end
