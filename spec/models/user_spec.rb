require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation for user" do
    before do
      @user = User.new
    end

    it "successfully creating a new user" do
      @new_user = User.new(:name => "rspec", :email => "rspec@gmail.com", :password_digest => "rspec")
      @new_user.save!
      expect(@new_user).to be_persisted
    end

    it "return error message if name is missing" do
      @new_user = User.new(:email => "rspec@gmail.com", :password_digest => "rspec")
      @new_user.save!
      expect(@new_user.errors.messages[:name]).to include('can\'t be blank')
    end
  end
end
