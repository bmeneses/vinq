puts File.dirname(__FILE__)
require File.dirname(__FILE__) + "/../../app/models/wine"
require File.dirname(__FILE__) + "/../../app/models/product_attribute"
require File.dirname(__FILE__) + "/../wine_api/category"
require File.dirname(__FILE__) + "/../wine_api/catalog"

module WineApiDownloader
  class Downloader

    def initialize()
    	@api_key = 'd416c704b94a08167684e8f5d1d7e987'
    end

    def get_all_products(params={})
      #what was I thinking about page limit defaulting to 1?
      params[:page_limit] == nil ? page_limit = 1 : page_limit = params[:page_limit]
      @categories = get_categories()

      product_dl = WineApiDownloader::ProductDownloader.new

    	@categories.each do |cat|
    		product_dl.save_category_products(cat.Id, page_limit)
    	end
    end

    def get_categories
      categories = WineApi::Category.new
      categories.get
    end

    def build_category_worklist(fresh_categories)
    		# fresh_categories.select do |cat|
    		# 	wine_db_cats = ProductAttribute.where("id = ?", cat.Id)
    		# 	# binding.pry
    		# 	wine_db_cats.count != get_category_product_count(cat.Id)
    		# end

    		# let's just do this as the above functionality has no tests
    		fresh_categories
    	end

    	def get_category_product_count(category_id)
    		catalog = WineApi::Catalog.new
    		catalog.get(categories: category_id, limit: 1)
    		catalog.total_products
    	end


    end
  end
