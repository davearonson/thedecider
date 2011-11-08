require 'spec_helper'

describe "alternatives/index.html.erb" do
  before(:each) do
    assign(:alternatives, [
      stub_model(Alternative,
        :name => "Name",
        :decision => nil
      ),
      stub_model(Alternative,
        :name => "Name",
        :decision => nil
      )
    ])
  end

  it "renders a list of alternatives" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
