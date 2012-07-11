require 'pry'
module WineApi
  class Catalog
    include HTTParty
    attr_accessor :json_response, :url, :response_hash

    def get(params)
      
      base_url = 'http://services.wine.com/api/beta2/service.svc/json/catalog'
      params[:offset] == nil ? req_offset = 1 : req_offset = params[:offset]
      req_size = '100'
      req_sort = 'justIn|descending'

      @url = "#{base_url}?"

      if (params[:product_id] == nil && params[:categories] != nil)
        @url += "filter=categories(#{params[:categories]})" + 
                "&size=#{req_size}" + 
                "&offset=#{req_offset}" +
                "&sort=#{req_sort}" + 
                "&apikey=#{params[:api_key]}"
      elsif (params[:product_id] != nil && params[:categories] == nil)
        @url += "filter=product(#{params[:product_id]})" +
                "&apikey=#{params[:api_key]}"
      end

      begin
        @json_response = HTTParty.get(URI.encode(@url))
        rescue SocketError
          @response_hash = Hashie::Mash.new({})
        return
      end

      
      @response_hash = Hashie::Mash.new(@json_response.to_hash)
      @response_hash
    end


  end
end