require 'spec_helper'

describe "factors/edit.html.erb" do
  before(:each) do
    @factor = assign(:factor, stub_model(Factor,
      :name => "MyString",
      :decision => nil
    ))
  end

  it "renders the edit factor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => factors_path(@factor), :method => "post" do
      assert_select "input#factor_name", :name => "factor[name]"
      assert_select "input#factor_decision", :name => "factor[decision]"
    end
  end
end
