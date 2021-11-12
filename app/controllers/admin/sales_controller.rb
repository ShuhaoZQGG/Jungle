class Admin::SalesController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD'], except: []
  
  def index
    @sales = Sale.all
  end

  def new
  end
end
