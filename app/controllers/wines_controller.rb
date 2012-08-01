require 'pry'
class WinesController < ApplicationController

 def index
    @wines = Wine.paginate(page: params[:page])
 end


end
