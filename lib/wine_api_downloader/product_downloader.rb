require File.dirname(__FILE__) + "/../../app/models/wine"
require File.dirname(__FILE__) + "/../../app/models/product_attribute"
require File.dirname(__FILE__) + "/../wine_api/category"
require File.dirname(__FILE__) + "/../wine_api/catalog"

require 'pry'

module WineApiDownloader
	class ProductDownloader

		def save_category_products(category_id, page_limit)
			catalog = WineApi::Catalog.new
			offset = 1 
			page_size = 100

			until (offset >= (page_limit * page_size)) 
				catalog.get(categories: category_id, offset: offset)
				save_catalog_object(catalog)
				offset += page_size
			end 
		end

		def save_product_by_id(product_id)
		  catalog = WineApi::Catalog.new
		  catalog.get(product_id: product_id)
		  save_catalog_object(catalog)
		end


		private

			def save_catalog_object(catalog)
				catalog.products.each do |product|
					@wine = assign_wine(product)
					assign_product_attributes(product)
					assign_varietal(product)             
					assign_appellation(product)		

					begin #WTF IS HAPPENING HERE? Exceptions that should be thrown
							  # at line 72 are bubbling up here.
						@wine.save
					rescue ActiveRecord::RecordNotUnique
						Rails.logger.info "Rescue at @wine.save id #{product.id}"
					end    
				end
			end

			def assign_wine(product)
				value = Wine.create(id: product.Id,
														name:         product.Name,
														url:          product.Url,
														wine_type:    product.Type,
														price_min:    product.PriceMin,
														price_max:    product.PriceMax,
														price_retail: product.PriceRetail)
			end

			def assign_product_attributes(product)

				product.ProductAttributes.each do |attrib|
					new_attribute = ProductAttribute.find_by_id(attrib.Id)
					begin
						if new_attribute == nil
							#begin
								new_attribute = @wine.product_attributes.create(id: attrib.Id,
																															 name: attrib.Name,																															 
																															 url: attrib.Url)
						else
							@wine.product_attributes << new_attribute
						end
					rescue ActiveRecord::RecordNotUnique
						
						Rails.logger.info "ProductDownloader: AttributeId id #{attrib.Id} did not " +
															"associate with Wine id #{product.Id} (Duplicate)"
				
					end
				end
			end

			def assign_varietal(product)
				unless (product.Varietal == nil)
					varietal = Varietal.find_by_id(product.Varietal.Id)
					unless (varietal)
						varietal = @wine.build_varietal(id: product.Varietal.Id,
							name: product.Varietal.Name,
							url: product.Varietal.Url)
							varietal.save
					end
					@wine.varietal = varietal
				end				
			end

			def assign_appellation(product)

				unless (product.Appellation == nil)	
					appellation = Appellation.find_by_id(product.Appellation.Id)
					unless (appellation)
						appellation = @wine.build_appellation(
							id: product.Appellation.Id,
						name: product.Appellation.Name,
						 url: product.Appellation.Url)

						assign_region(product)
						appellation.save					
					end
					@wine.appellation = appellation
				end
			end

			def assign_region(product)
				unless (product.Appellation.Region == nil)
					region = Region.find_by_id(product.Appellation.Region.Id)
					unless (region)
						region = @wine.appellation.build_region(
							id: product.Appellation.Region.Id,
							name: product.Appellation.Region.Name,
							url: product.Appellation.Region.Url)                
						
						assign_area(product)

						@wine.appellation.region = region
						region.save
					end
				end
			end

			def assign_area(product)
				unless (product.Appellation.Region.Area == nil)
					area = Area.find_by_id(product.Appellation.Region.Area.Id)
					unless (area)
						area = @wine.appellation.region.build_area(
							id: product.Appellation.Region.Area.Id,
							name: product.Appellation.Region.Area.Name,
							url: product.Appellation.Region.Area.Url)
						puts product.Id
					end
					@wine.appellation.region.area = area
					area.save
				end
			end

	end
end


