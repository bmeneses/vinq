# require 'pry'

module WineApi
  class Catalog
    include HTTParty
    attr_accessor :total_products,
                  :product_count,
                  :offset,
                  :return_code,
                  :products

    def initialize
      @api_key = 'd416c704b94a08167684e8f5d1d7e987'
    end


    # Gets Products from the Wine.com api
    #
    # == Parameters:
    #
    #
    #
    def get(params)

      request_url = create_url(params)
      begin
        @json_response = HTTParty.get(URI.encode(request_url))
        rescue SocketError
          @response_hash = Hashie::Mash.new({})
        return
      end

      @response_hash = Hashie::Mash.new(@json_response.to_hash)
      set_attrs(@response_hash)
      @response_hash
    end

    private

      def set_attrs(hash)
        @total_products = hash.Products.Total
        @product_count = hash.Products.List.count
        @products = hash.Products.List
        @offset = hash.Products.Offset
        @return_code = hash.Status.ReturnCode
      end

      def create_url(params)
        base_url = 'http://services.wine.com/api/beta2/service.svc/json/catalog?'
        url = base_url

        if  category_query?(params)
          url = base_url + url_for_category_query(params)
        elsif product_query?(params)
          url = base_url + url_for_product_query(params)

        else
          raise ArgumentError.new("Need to have a hash with one of" +
                                     " :product_id or :categories")
        end
        url
      end

      def category_query?(params)
        params[:product_id] == nil && params[:categories] != nil
      end

      def product_query?(params)
        params[:product_id] != nil && params[:categories] == nil
      end

      def url_for_category_query(params)
        params[:offset] == nil ? req_offset = 1 : req_offset = params[:offset]
        params[:limit]  == nil ? req_size = 100 : req_size = params[:limit]
        req_sort = 'justIn|descending'

        url = "filter=categories(#{params[:categories]})" +
              "&size=#{req_size}" +
              "&offset=#{req_offset}" +
              "&sort=#{req_sort}" +
              "&apikey=#{@api_key}"
        url
      end

      def url_for_product_query(params)
        url = "filter=product(#{params[:product_id]})" +
              "&apikey=#{@api_key}"
        url
      end










  end



end
