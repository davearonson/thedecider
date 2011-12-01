require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe FactorsController do

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

  valid_decision_attributes = {
    name: 'what name to use',
    user_id: @user.id
  }

  Decision.create valid_decision_attributes
  @decision = Decision.find_by_name valid_decision_attributes[:name]

  valid_factor_attributes = {
    name: 'blargh',
    weight_id: Level::Medium,
    decision_id: @decision.id
  }
  valid_attributes = valid_factor_attributes

  Factor.create valid_factor_attributes
  @factor = Factor.find_by_name valid_factor_attributes[:name]

  before :each do
    @user = User.find_by_username valid_user_attributes[:username]
    sign_in @user
  end

  describe "GET edit" do
    it "assigns the requested factor as @factor" do
      factor = Factor.create! valid_attributes
      get :edit, :id => factor.id.to_s
      assigns(:factor).should eq(factor)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Factor" do
        expect {
          post :create, :factor => valid_attributes
        }.to change(Factor, :count).by(1)
      end

      it "assigns a newly created factor as @factor" do
        post :create, :factor => valid_attributes
        assigns(:factor).should be_a(Factor)
        assigns(:factor).should be_persisted
      end

      it "redirects to the decision" do
        post :create, :factor => valid_attributes
        response.should redirect_to(Factor.last.decision)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved factor as @factor" do
        # Trigger the behavior that occurs when invalid params are submitted
        Factor.any_instance.stub(:save).and_return(false)
        post :create, :factor => {}
        assigns(:factor).should be_a_new(Factor)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Factor.any_instance.stub(:save).and_return(false)
        post :create, :factor => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested factor" do
        factor = Factor.create! valid_attributes
        # Assuming there are no other factors in the database, this
        # specifies that the Factor created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Factor.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => factor.id, :factor => {'these' => 'params'}
      end

      it "assigns the requested factor as @factor" do
        factor = Factor.create! valid_attributes
        put :update, :id => factor.id, :factor => valid_attributes
        assigns(:factor).should eq(factor)
      end

      it "redirects to the decision" do
        factor = Factor.create! valid_attributes
        put :update, :id => factor.id, :factor => valid_attributes
        response.should redirect_to(factor.decision)
      end
    end

    describe "with invalid params" do
      it "assigns the factor as @factor" do
        factor = Factor.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Factor.any_instance.stub(:save).and_return(false)
        put :update, :id => factor.id.to_s, :factor => {}
        assigns(:factor).should eq(factor)
      end

      it "re-renders the 'edit' template" do
        factor = Factor.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Factor.any_instance.stub(:save).and_return(false)
        put :update, :id => factor.id.to_s, :factor => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested factor" do
      factor = Factor.create! valid_attributes
      expect {
        delete :destroy, :id => factor.id.to_s
      }.to change(Factor, :count).by(-1)
    end

    it "redirects to the decision" do
      factor = Factor.create! valid_attributes
      delete :destroy, :id => factor.id.to_s
      response.should redirect_to(factor.decision)
    end
  end

end
