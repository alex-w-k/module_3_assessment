class Store
  attr_accessor :id, :type, :name, :distance, :phone
  def initialize(params)
    @type = params["storeType"]
    @name = params["longName"]
    @distance = params["distance"]
    @phone = params["phone"]
  end

  def self.search(args)
    stores = BestBuyApiService.search(args)
    stores.map do |store|
      binding.pry
      new(store)
    end
  end
end
