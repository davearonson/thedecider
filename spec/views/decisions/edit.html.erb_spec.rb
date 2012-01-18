require 'spec_helper'

describe "decisions/edit.html.erb" do
  before(:each) do
    @user = assign(:user, stub_model(User, :id => 43))
    @decision = assign(:decision, stub_model(Decision, :user_id => 43))
  end

  it "renders the edit decision form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => decisions_path(@decision), :method => "post" do
      assert_select "input#decision_name", :name => "decision[name]"
      # no, this only happens if user is admin!
      # assert_select "input#decision_user_id", :name => "decision[user_id]"
    end
  end
end
