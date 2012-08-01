puts File.dirname(__FILE__)
require File.dirname(__FILE__) + "/../../app/models/wine"
require File.dirname(__FILE__) + "/../../app/models/product_attribute"
require File.dirname(__FILE__) + "/../wine_api/category"
require File.dirname(__FILE__) + "/../wine_api/catalog"

require 'pry'

module WineApiDownloader
  class Downloader

    def initialize()
    	@api_key = 'd416c704b94a08167684e8f5d1d7e987'
    end

    def get_products(params={})
      params[:page_limit] == nil ? page_limit = 1 : page_limit = params[:page_limit]
      puts params
      puts page_limit
      @categories = get_categories()
    	# get category exclusion list from db
    	@cat_worklist = build_category_worklist(@categories)
    	# then for each worklist category download the products

    	@cat_worklist.each do |cat|
    		save_category_products(cat.Id, page_limit)
    	end


    	# then update the db for that category for only those items that don't exist
    end


    #private



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

    	def save_category_products(category_id, page_limit)
    		catalog = WineApi::Catalog.new
    		offset = 1 
        page_size = 100

    		# THE MODEL SHOULD BE DOING THIS STUFF

        until (offset >= (page_limit * page_size)) 
    			catalog.get(categories: category_id, offset: offset)
          #binding.pry
          catalog.products.each do |product|
            wine = Wine.create(id:           product.Id,
                               wine_id:      product.Id,
                               name:         product.Name,
                               url:          product.Url,
                               wine_type:    product.Type,
                               #year:         product.Year,
                               price_min:    product.PriceMin,
                               price_max:    product.PriceMax,
                               price_retail: product.PriceRetail)

              product.ProductAttributes.each do |attrib|
                a = ProductAttribute.find_or_create_by_id(id: attrib.Id)
                a.product_attribute_id = attrib.Id
                a.name = attrib.Name
                a.url = attrib.Url
                wine.product_attributes << a
              end

              unless (product.Varietal == nil)
                varietal = Varietal.find_by_id(product.Varietal.Id)
                unless (varietal)
                  varietal = wine.build_varietal(id: product.Varietal.Id,
                              varietal_id: product.Varietal.Id,
                                     name: product.Varietal.Name,
                                      url: product.Varietal.Url)
 
                end
                wine.varietal = varietal
                varietal.save
                wine.save                
              end


              unless (product.Appellation == nil)
                appellation = Appellation.find_by_id(product.Appellation.Id)
                unless (appellation)
                  appellation = wine.build_appellation(id: product.Appellation.Id,
                              appellation_id: product.Appellation.Id,
                                       name: product.Appellation.Name,
                                        url: product.Appellation.Url)

                  unless (product.Appellation.Region == nil)
                    region = Region.find_by_id(product.Appellation.Region.Id)
                    unless (region)
                      region = appellation.build_region(
                                       id: product.Appellation.Region.Id,
                                region_id: product.Appellation.Region.Id,
                                     name: product.Appellation.Region.Name,
                                      url: product.Appellation.Region.Url)                

                      unless (product.Appellation.Region.Area == nil)
                        area = Area.find_by_id(product.Appellation.Region.Area.Id)
                        unless (area)
                          area = region.build_area(
                                           id: product.Appellation.Region.Area.Id,
                                      area_id: product.Appellation.Region.Area.Id,
                                         name: product.Appellation.Region.Area.Name,
                                          url: product.Appellation.Region.Area.Url)
                          puts "bult an area"
                          puts product.Id
                        end
                        region.area = area
                        area.save
                      end
                      appellation.region = region
                      region.save
                    end
                  end
                end

                wine.appellation = appellation
                appellation.save
                wine.save                
              end

          end
          offset += page_size
        end
      end


      def get_single_product(product_id)
        catalog = WineApi::Catalog.new
        catalog.get(product_id: product_id)
      end



    end
  end