require 'spec_helper'

describe "factors/edit.html.erb" do
  before(:each) do
    @user = assign(:user, stub_model(User, :id => 43))
    @decision = assign(:decision, stub_model(Decision, :id => 1, :user_id => 43))
    @factor = assign(:factor, stub_model(Factor, :decision_id => 1))
  end

  it "renders the edit factor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => factors_path(@factor), :method => "post" do
      assert_select "input#factor_name", :name => "factor[name]"
      assert_select "select#factor_weight_id", :name => "factor[weight_id]"
      assert_select "input#factor_decision_id", :name => "factor[decision_id]"
    end
  end
end
