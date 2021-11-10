class Admin::DashboardController < ApplicationController
  def show
    @product_count = Product.count()
    @cateory_count = Category.count()
  end
end
