class Store
  attr_accessor :type, :name, :distance, :phone
  def initialize(params)
    @type = params["storeType"]
    @name = params["longName"]
    @distance = params["distance"]
    @phone = params["phone"]
  end

  def self.search(args)
    stores = BestBuyApiService.search(args)
    stores.map do |store|
      new(store)
    end
  end
end
