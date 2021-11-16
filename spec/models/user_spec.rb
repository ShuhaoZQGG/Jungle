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

    it "return error message if email is missing" do
      @new_user = User.new(name: "rspec_test",  password: "rspec_test", password_confirmation: "rspec_test")
      expect(@new_user).to_not be_valid
      expect(@new_user.errors.messages[:email]).to include('can\'t be blank')
    end

    it "return error message if password is missing" do
      @new_user = User.new(name: "rspec_test", email: "rspec_test@gmail.com")
      expect(@new_user).to_not be_valid
      expect(@new_user.errors.messages[:password]).to include('can\'t be blank')
    end

    it 'is invalid if password and password_confirmation didn\'t match' do
      @new_user = User.new(name: "zsh", email: "zsh@gmail.com", password: "password", password_confirmation: "passwor")
      @new_user.save
      expect(@new_user).to_not be_valid
      expect(@new_user.errors.messages[:password_confirmation]).to include('doesn\'t match Password')
    end

    it 'is invalid short passwords' do
      @new_user = User.new(name: "zsh", email: "zsh@gmail.com", password: "zsh", password_confirmation: "zsh")
      @new_user.save
      expect(@new_user).to_not be_valid
      expect(@new_user.errors.messages[:password]).to include('is too short (minimum is 6 characters)')
    end

    it 'only allowed unique emails' do
      @new_user = User.new(name: "zsh", email: "zsh@gmail.com", password: "zshqgg", password_confirmation: "zshqgg")

      @new_user2 = User.new(name: "shz", email: "zsh@gmail.com", password: "zshqgg", password_confirmation: "zshqgg")
      @new_user.save
      @new_user2.save

      expect(@new_user).to be_valid
      expect(@new_user2).to_not be_valid
      expect(@new_user2.errors.messages[:email]).to include('has already been taken')
    end
  end

  describe 'authenticate with credentials' do
    it "return nil with nil email and password" do
      expect(User.authenticate_with_credentials(nil, nil)).to eq(false)
    end

    it "return nil with valid email and nil password" do
      User.new(
        name:                  "rspec",
        email:                 "rspec@mail.com",
        password:              "password",
        password_confirmation: "password"
      ).save
      expect(User.authenticate_with_credentials("rspec@mail.com", nil)).to eq(false)
    end

    it 'return user with valid email and password' do 
      User.new(
        name:                  "rspec",
        email:                 "rspec@mail.com",
        password:              "password",
        password_confirmation: "password"
      ).save

      validated_user = User.authenticate_with_credentials("rspec@mail.com", "password")
      expect(validated_user.email).to eq("rspec@mail.com")
    end

    it "return a user with valid email and password case insensitive" do
      User.new(
        name:                  "rspec",
        email:                 "rspec@mail.com",
        password:              "password",
        password_confirmation: "password"
      ).save

      user = User.authenticate_with_credentials("RspEC@Mail.com", "password")
      expect(user.email).to eq("rspec@mail.com")
    end

    it "return a user with valid email and password case insensitive with leading spaces" do
      User.new(
        name:                  "rspec",
        email:                 "rspec@mail.com",
        password:              "password",
        password_confirmation: "password"
      ).save

      user = User.authenticate_with_credentials("   RSpec@Mail.com", "password")
      expect(user.email).to eq("rspec@mail.com")
    end

    it "return a user with valid email and password case insensitive with leading and trailing spaces" do
      User.new(
        name:                  "rspec",
        email:                 "rspec@mail.com",
        password:              "password",
        password_confirmation: "password"
      ).save

      user = User.authenticate_with_credentials("   RSPEC@Mail.com"   , "password")
      expect(user.email).to eq("rspec@mail.com")
    end
  end
end
