require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validation' do
    before do
      @category = Category.new(:name => "Grocery")
    end 

    it "it should successfully create a new product with category Grocery" do
      @new_product = Product.new(:name => "Cilantro",:price => 2.5, :quantity => 20, :category => @category)
      @new_product.save!
      expect(@new_product).to be_persisted
    end

    it 'is invalid without a name' do
      @new_product = Product.new(:price => 2.5, :quantity => 20, :category => @category)
      expect(@new_product).to_not be_valid
      expect(@new_product.errors.messages[:name]).to include('can\'t be blank')
    end

    it 'is invalid without a price' do
      @new_product = Product.new(:name => "Cilantro",:price => "hi", :quantity => 20, :category => @category)
      expect(@new_product).to_not be_valid
      expect(@new_product.errors.messages[:price]).to include('is not a number')
    end

    it 'is invalid without quantity' do
      @new_product = Product.new(:name => "Cilantro",:price => 2.5, :category => @category)
      expect(@new_product).to_not be_valid
      expect(@new_product.errors.messages[:quantity]).to include('can\'t be blank')
    end

    it 'is invalid without category' do
      @new_product = Product.new(:name => "Cilantro",:price => 2.5, :quantity => 20)
      expect(@new_product).to_not be_valid
      expect(@new_product.errors.messages[:category]).to include('can\'t be blank')
    end
  end
end
