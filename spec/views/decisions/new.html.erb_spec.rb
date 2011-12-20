require 'spec_helper'

describe "decisions/new.html.erb" do
  before(:each) do
    @user = assign(:user, stub_model(User, :id => 43))
    @decision = assign(:decision, stub_model(Decision, :id => 1, :user_id => 43))
  end

  it "renders new decision form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => decisions_path, :method => "post" do
      assert_select "input#decision_name", :name => "decision[name]"
      assert_select "input#decision_user_id", :name => "decision[user_id]"
    end
  end
end
