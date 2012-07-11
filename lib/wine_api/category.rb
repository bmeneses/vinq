require 'pry'
module WineApi
  class Category
    include HTTParty
    attr_accessor :json_response, :url, :response_hash
    def get(params)      
      base_url = 'http://services.wine.com/api/beta2/service.svc/json/categorymap'
      api_key = params[:api_key]

      @url = "#{base_url}?filter=categories(490)" +
                        "&apikey=#{params[:api_key]}"
      begin
        @json_response = HTTParty.get(URI.encode(@url))
        rescue SocketError
          @response_hash = Hashie::Mash.new({})
        return
      end

      
      @response_hash = Hashie::Mash.new(@json_response.to_hash)
      @response_hash.Categories.select { |category| category.Id == 5 }[0].Refinements
    end


  end
end