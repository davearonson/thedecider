require 'spec_helper'

describe "decisions/edit.html.erb" do
  before(:each) do
    @decision = assign(:decision, stub_model(Decision,
      :name => "MyString",
      :user => nil
    ))
  end

  it "renders the edit decision form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => decisions_path(@decision), :method => "post" do
      assert_select "input#decision_name", :name => "decision[name]"
      assert_select "input#decision_user", :name => "decision[user]"
    end
  end
end
