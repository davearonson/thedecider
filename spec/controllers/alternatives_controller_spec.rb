require 'spec_helper'

describe AlternativesController do

  # TODO: make the below stuff into fixtures, or better yet use factory_girl?

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

  valid_decision_attributes = {
    name: 'what name to use',
    user_id: @user.id
  }

  Decision.create valid_decision_attributes
  @decision = Decision.find_by_name valid_decision_attributes[:name]

  valid_alternative_attributes = {
    name: 'blargh',
    decision_id: @decision.id
  }
  valid_attributes = valid_alternative_attributes

  Alternative.create valid_alternative_attributes
  @alternative = Alternative.find_by_name valid_alternative_attributes[:name]

  before :each do
    @user = User.find_by_username valid_user_attributes[:username]
    sign_in @user
  end

  # since alts are now part of form, there is no
  # edit in controller, only new/create!
  # describe "GET edit" do
  # end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Alternative" do
        expect {
          post :create, :alternative => valid_attributes
        }.to change(Alternative, :count).by(1)
      end

      it "assigns a newly created alternative as @alternative" do
        post :create, :alternative => valid_attributes
        assigns(:alternative).should be_a(Alternative)
        assigns(:alternative).should be_persisted
      end

      it "redirects to the created alternative's decision" do
        post :create, :alternative => valid_attributes
        response.should redirect_to edit_decision_path(valid_attributes[:decision_id])
      end
    end

    describe "with invalid params" do
      it "doesn't create a new alternative" do
        pending "need to rearrange this; currently can't find a decision w/o an id"
        # Trigger the behavior that occurs when invalid params are submitted
        Alternative.any_instance.stub(:save).and_return(false)
        post :create, :alternative => {}
        assigns(:alternative).should be_nil
      end

      it "re-renders the 'new' template" do
        pending "need to rearrange this; currently can't find a decision w/o an id"
        # Trigger the behavior that occurs when invalid params are submitted
        Alternative.any_instance.stub(:save).and_return(false)
        post :create, :alternative => {}
        response.should render_template("new")
      end
    end
  end

  # since alts are now part of form, there is no
  # update in controller, only new/create!
  # describe "PUT update" do
  # end

  # since alts are now part of form, there is no
  # delete in controller, only new/create!
  # describe "DELETE destroy" do
  # end

end
