# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
  
  before { @user = User.new(:name => "Peter", :email => "peter@gmail.com", 
                            :password => 'foobar', :password_confirmation => 'foobar')}
  subject {@user}
  
  it {should respond_to (:name)}
  it {should respond_to (:email)}
  it {should respond_to (:password_digest)}
  it {should respond_to (:authenticate)}
    
  it {should be_valid}
  
  # test that user is valid only with name and email not empty
  
  describe "when name is not present" do
    before { @user.name = ""}
    it {should_not be_valid}
  end

  describe "when email is not present" do
    before { @user.email = ""}
    it {should_not be_valid}
  end
  
  # test that names are less than 51 char
  
  describe "when name is too long" do
    before { @user.name = "a" * 51}
    it {should_not be_valid}
  end
  
  describe "when email format is invalid" do
    it "should be valid" do
      addresses = %w[user@foo.com A_USER@FOO.COM frst.lst@foo.jp a+b.c@baz.cn]
      addresses.each do | a |
        @user.email = a
        @user.should be_valid
      end
    end
    it "should be invalid" do
      addresses = %w[user@foo-com A_USER@FOOCOM frst.lst@foo_jp a!b.c@baz.cn]
      addresses.each do | a |
        @user.email = a
        @user.should_not be_valid
      end
    end
  end
  
  describe "when email address is already taken" do
    before do 
      user_with_same_email = @user.dup
      user_with_same_email.save
    end
    it { should_not be_valid}
  end
  
  describe "when password is not present" do
    before do 
      @user.password = @user.password_confirmation = ""
    end
    it {should_not be_valid}
  end

  describe "when password is nil" do
    before do 
      @user.password = @user.password_confirmation = nil
    end
    it {should_not be_valid}
  end

  describe "when password confirmation is not present" do
    before do 
      @user.password_confirmation = ""
    end
    it {should_not be_valid}
  end
  
  describe "when password confirmation is nil" do
    before do 
      @user.password_confirmation = nil
    end
    it {should_not be_valid}
  end
  
  describe "when password and confirmation don't match" do
    before do 
      @user.password_confirmation = "mismatch"
    end
    it {should_not be_valid}
  end
  
  describe "when password is too short" do
    before do 
      @user.password_confirmation = @user.password_confirmation = "a" * 5
    end
    it {should be_invalid}
  end  
  
  # tests for authentification
  
  describe "return method of authenticate method" do
    before { @user.save }
    let (:found_user) {User.find_by_email(@user.email)}
    
    describe "with valid password" do
      it {should == found_user.authenticate(@user.password)}
    end
    
    describe "with invalid password" do
      let (:user_for_invalid_password) {found_user.authenticate("invalid")}
      it {should_not == user_for_invalid_password}
      specify { user_for_invalid_password.should be_false}
    end
  end
  
end
  
