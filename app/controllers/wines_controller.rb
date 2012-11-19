class WinesController < ApplicationController

 def index

 		@filters ||= []

 		if params[:filter] == nil
    	@wines = Wine.paginate(page: params[:page])
    	@appellations = Appellation.all
    	@regions = Region.all
    elsif params[:filter] == "appellation"
    	@filters << "appellation"
    	@wines = Wine.where(appellation_id: params[:appellation]).paginate(page: params[:page])
    	@appellations = filter_attribute("appellation")
    	@regions = filter_attribute("region")
    end
 end

 private

 	def filter_attribute(attribute)
 		@wines.map{ |wine| wine.send(attribute)}.uniq
 	end

end
