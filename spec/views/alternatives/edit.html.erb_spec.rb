require 'spec_helper'

describe "alternatives/edit.html.erb" do
  before(:each) do
    @user = assign(:user, stub_model(User, :id => 43))
    @decision = assign(:decision, stub_model(Decision, :id => 1, :user_id => 43))
    @alternative = assign(:alternative, stub_model(Alternative, :decision_id => 1))
  end

  it "renders the edit alternative form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => alternatives_path(@alternative), :method => "post" do
      assert_select "input#alternative_name", :name => "alternative[name]"
      assert_select "input#alternative_decision_id", :name => "alternative[decision_id]"
    end
  end
end
