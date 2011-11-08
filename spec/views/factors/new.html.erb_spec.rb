require 'spec_helper'

describe "factors/new.html.erb" do
  before(:each) do
    assign(:factor, stub_model(Factor,
      :name => "MyString",
      :decision => nil
    ).as_new_record)
  end

  it "renders new factor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => factors_path, :method => "post" do
      assert_select "input#factor_name", :name => "factor[name]"
      assert_select "input#factor_decision", :name => "factor[decision]"
    end
  end
end
