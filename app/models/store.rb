class Store
  attr_accessor :id, :type, :name
  def initialize(params)
    @id = params["storeId"]
    @type = params["storeType"]
    @name = params["name"]
  end
end
