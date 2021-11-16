require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation for user" do
    before do
      @user = User.new
    end

    it "successfully creating a new user" do
      @new_user = User.new(name: "rspec_test", email: "rspec_test@gmail.com", password: "rspec_test", password_confirmation: "rspec_test")
      @new_user.save!
      expect(@new_user).to be_persisted
    end

    it "return error message if name is missing" do
      @new_user = User.new(email: "rspec_test@gmail.com", password: "rspec_test", password_confirmation: "rspec_test")
      expect(@new_user).to_not be_valid
      expect(@new_user.errors.messages[:name]).to include('can\'t be blank')
    end
  end
end
