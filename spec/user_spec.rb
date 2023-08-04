require 'rails_helper' 
require './app/models/user.rb'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    # validation tests/examples here
    before do 
      @user = User.new(first_name: "Test", last_name: "User", email: "test@test.com", password: "password", password_confirmation: "password")
    end
    
    it "is valid with valid attributes" do
      expect(@user).to be_valid
    end
    
    it "is not valid without a password" do
      @user.password = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    
    it "is not valid if the password and password_confirmation do not match" do
      @user.password_confirmation = "testuserpassword"
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    
    it "is not valid without an email" do
      @user.email = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    
    it "is not valid if the email is not unique" do
      @user.save
      @user2 = User.new(first_name: "Test", last_name: "User", email: "TEST@TEST.COM", password: "password", password_confirmation: "password")
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
    
    it "is not valid without a first_name" do
      @user.first_name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    
    it "is not valid without a last_name" do
      @user.last_name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    
    it "is not valid if the password is less than 6 characters long" do
      @user.password = "short"
      @user.password_confirmation = "short"
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    
  end
  describe '.authenticate_with_credentials' do 
    # authenticate_with_credentials tests/examples here
    before do 
      @user = User.create(first_name: "Test", last_name: "User", email: "test@test.com", password: "password", password_confirmation: "password")
    end

    it "returns the user if the email and password are correct" do
      user = User.authenticate_with_credentials("test@test.com", "password")
      expect(user).to eq(@user)
    end
    
    it "returns nil if the email is incorrect and the password is correct" do
      user = User.authenticate_with_credentials("user@test.com", "password")
      expect(user).to be_nil
    end
    
    it "returns nil if the email is correct and the password is incorrect" do
      user = User.authenticate_with_credentials("test@test.com", "wrongpassword")
      expect(user).to be_nil
    end
    
    it "returns the user if the email has leading or trailing spaces" do
      user = User.authenticate_with_credentials(" test@test.com ", "password")
      expect(user).to eq(@user)
    end
    
    it "returns the user if the email has a different case" do
      user = User.authenticate_with_credentials("TEST@TEST.COM", "password")
      expect(user).to eq(@user)
    end
    
  end
end