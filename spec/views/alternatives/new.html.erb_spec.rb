require 'spec_helper'

describe "alternatives/new.html.erb" do
  before(:each) do
    assign(:alternative, stub_model(Alternative,
      :name => "MyString",
      :decision => nil
    ).as_new_record)
  end

  it "renders new alternative form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => alternatives_path, :method => "post" do
      assert_select "input#alternative_name", :name => "alternative[name]"
      assert_select "input#alternative_decision", :name => "alternative[decision]"
    end
  end
end
