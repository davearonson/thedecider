require 'spec_helper'

describe "alternatives/edit.html.erb" do
  before(:each) do
    @alternative = assign(:alternative, stub_model(Alternative,
      :name => "MyString",
      :decision => nil
    ))
  end

  it "renders the edit alternative form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => alternatives_path(@alternative), :method => "post" do
      assert_select "input#alternative_name", :name => "alternative[name]"
      assert_select "input#alternative_decision", :name => "alternative[decision]"
    end
  end
end
