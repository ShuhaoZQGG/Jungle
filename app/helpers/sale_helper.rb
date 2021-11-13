module SaleHelper

  def active_sale?
    Sale.active.any?
  end

  def sales_name
    Sale.active[0].name
  end

  def sales_percent_off
    Sale.active[0].percent_off
  end
end