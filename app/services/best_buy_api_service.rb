class BestBuyApiService
  attr_reader :find
  def initialize(args)
    @zip = args[:zip] if args[:zip]
    @conn = Faraday.new(url: 'https://api.bestbuy.com')
  end

  def self.search(args)
    new(args).find_stores
  end

  def find_stores
    response = @conn.get("/v1/stores(area(#{zip},25))?format=json&show=longName,city,distance,phone,storeType&pageSize=50&apiKey=#{ENV['BEST_BUY_API_KEY']}")
    JSON.parse(response.body)["stores"]
  end

  private
  attr_reader :zip
end
