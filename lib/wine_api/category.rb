require 'pry'
module WineApi
  class Category
    include HTTParty
    attr_accessor :json_response, :url, :response_hash


    def initialize()
      @api_key = 'd416c704b94a08167684e8f5d1d7e987'
    end

    
    def get
      base_url = 'http://services.wine.com/api/beta2/service.svc/json/categorymap'

      @url = "#{base_url}?filter=categories(490)" +
                        "&apikey=#{@api_key}"
      begin
        @json_response = HTTParty.get(URI.encode(@url))
        rescue SocketError
          @response_hash = Hashie::Mash.new({})
        return
      end

      
      @response_hash = Hashie::Mash.new(@json_response.to_hash)
      @response_hash.Categories.select { |category| category.Id == 4 }[0].Refinements
    end


  end
end