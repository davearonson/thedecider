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


  describe "GET edit" do
    it "assigns the requested alternative as @alternative" do
      alternative = Alternative.create! valid_attributes
      get :edit, :id => alternative.id.to_s
      assigns(:alternative).should eq(alternative)
    end
  end

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
        response.should redirect_to(Decision.find valid_attributes[:decision_id])
      end
    end

    describe "with invalid params" do
      it "doesn't create a new alternative" do
        pending "need to catch the exception here"
        # Trigger the behavior that occurs when invalid params are submitted
        Alternative.any_instance.stub(:save).and_return(false)
        post :create, :alternative => {}
        assigns(:alternative).should be_nil
      end

      it "re-renders the 'new' template" do
        pending "need to catch the exception here, and/or in the actual code"
        # Trigger the behavior that occurs when invalid params are submitted
        Alternative.any_instance.stub(:save).and_return(false)
        post :create, :alternative => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested alternative" do
        alternative = Alternative.create! valid_attributes
        # Assuming there are no other alternatives in the database, this
        # specifies that the Alternative created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Alternative.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => alternative.id, :alternative => {'these' => 'params'}
      end

      it "assigns the requested alternative as @alternative" do
        alternative = Alternative.create! valid_attributes
        put :update, :id => alternative.id, :alternative => valid_attributes
        assigns(:alternative).should eq(alternative)
      end

      it "redirects to the decision" do
        alternative = Alternative.create! valid_attributes
        put :update, :id => alternative.id, :alternative => valid_attributes
        response.should redirect_to(alternative.decision)
      end
    end

    describe "with invalid params" do
      it "assigns the alternative as @alternative" do
        alternative = Alternative.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Alternative.any_instance.stub(:save).and_return(false)
        put :update, :id => alternative.id.to_s, :alternative => {}
        assigns(:alternative).should eq(alternative)
      end

      it "re-renders the 'edit' template" do
        alternative = Alternative.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Alternative.any_instance.stub(:save).and_return(false)
        put :update, :id => alternative.id.to_s, :alternative => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested alternative" do
      alternative = Alternative.create! valid_attributes
      expect {
        delete :destroy, :id => alternative.id.to_s
      }.to change(Alternative, :count).by(-1)
    end

    it "redirects to the decision" do
      alternative = Alternative.create! valid_attributes
      delete :destroy, :id => alternative.id.to_s
      response.should redirect_to(alternative.decision)
    end
  end

end
