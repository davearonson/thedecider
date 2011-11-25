require 'spec_helper'

describe AlternativesController do

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

      it "redirects to the created alternative" do
        post :create, :alternative => valid_attributes
        response.should redirect_to(Alternative.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved alternative as @alternative" do
        # Trigger the behavior that occurs when invalid params are submitted
        Alternative.any_instance.stub(:save).and_return(false)
        post :create, :alternative => {}
        assigns(:alternative).should be_a_new(Alternative)
      end

      it "re-renders the 'new' template" do
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

      it "redirects to the alternative" do
        alternative = Alternative.create! valid_attributes
        put :update, :id => alternative.id, :alternative => valid_attributes
        response.should redirect_to(alternative)
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

    it "redirects to the alternatives list" do
      alternative = Alternative.create! valid_attributes
      delete :destroy, :id => alternative.id.to_s
      response.should redirect_to(alternatives_url)
    end
  end

end
