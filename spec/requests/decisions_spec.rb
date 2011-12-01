require 'spec_helper'

describe "Decisions" do

  # TODO: make the below stuff into fixtures?

  valid_user_attributes = {
    username: 'dave',  # so it will be an admin
    password: 'testing',
    realname: 'Fester Bestertester',
    email: 'fester@bestertester.org'
  }

  User.create valid_user_attributes
  @user = User.find_by_username valid_user_attributes[:username]

  valid_login_attributes = {
    username: valid_user_attributes[:username],
    password: valid_user_attributes[:password],
  }

  before :each do
    @user = User.find_by_username valid_user_attributes[:username]
    # TODO: FIGURE OUT HOW TO GET THIS IN HERE!
    sign_in @user
  end


  describe "GET /decisions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get decisions_path
      response.status.should == 200
    end
  end
end
