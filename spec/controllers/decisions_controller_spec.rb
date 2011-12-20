require 'spec_helper'

describe DecisionsController do

  @incrementor = 0

  # TODO: make the below stuff into fixtures, or better yet use factory_girl?

  valid_user_attributes = {
    username: 'dave',  # so it will be an admin so we don't have security hassles
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

  def valid_attributes
    {
      name: 'decision ' + @incrementor.to_s,
      user_id: @user.id
    }
  end


  before :each do
    @user = User.find_by_username valid_user_attributes[:username]
    sign_in @user
    @incrementor = @incrementor ? @incrementor + 1 : 0
  end



  describe "GET index" do
    it "works" do
      get :index
      response.status.should == 200
    end
  end

  describe "GET new" do
    it "assigns a new decision as @decision" do
      get :new
      assigns(:decision).should be_a_new(Decision)
    end
  end

  describe "GET edit" do
    it "assigns the requested decision as @decision" do
      decision = Decision.create! valid_attributes
      get :edit, :id => decision.id.to_s
      assigns(:decision).should eq(decision)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Decision" do
        expect {
          post :create, :decision => valid_attributes
        }.to change(Decision, :count).by(1)
      end

      it "assigns a newly created decision as @decision" do
        post :create, :decision => valid_attributes
        assigns(:decision).should be_a(Decision)
        assigns(:decision).should be_persisted
      end

      it "redirects to the created decision" do
        post :create, :decision => valid_attributes
        response.should redirect_to(Decision.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved decision as @decision" do
        # Trigger the behavior that occurs when invalid params are submitted
        Decision.any_instance.stub(:save).and_return(false)
        post :create, :decision => {}
        assigns(:decision).should be_a_new(Decision)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Decision.any_instance.stub(:save).and_return(false)
        post :create, :decision => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested decision" do
        decision = Decision.create! valid_attributes
        # Assuming there are no other decisions in the database, this
        # specifies that the Decision created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Decision.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => decision.id, :decision => {'these' => 'params'}
      end

      it "assigns the requested decision as @decision" do
        decision = Decision.create! valid_attributes
        put :update, :id => decision.id, :decision => valid_attributes
        assigns(:decision).should eq(decision)
      end

      it "redirects to the decision" do
        decision = Decision.create! valid_attributes
        put :update, :id => decision.id, :decision => valid_attributes
        response.should redirect_to(decision)
      end
    end

    describe "with invalid params" do
      it "assigns the decision as @decision" do
        decision = Decision.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Decision.any_instance.stub(:save).and_return(false)
        put :update, :id => decision.id.to_s, :decision => {}
        assigns(:decision).should eq(decision)
      end

      it "re-renders the 'edit' template" do
        decision = Decision.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Decision.any_instance.stub(:save).and_return(false)
        put :update, :id => decision.id.to_s, :decision => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested decision" do
      decision = Decision.create! valid_attributes
      expect {
        delete :destroy, :id => decision.id.to_s
      }.to change(Decision, :count).by(-1)
    end

    it "redirects to the decisions list" do
      decision = Decision.create! valid_attributes
      delete :destroy, :id => decision.id.to_s
      response.should redirect_to(decisions_url)
    end
  end

end
