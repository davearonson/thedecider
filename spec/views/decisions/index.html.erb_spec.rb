require 'spec_helper'

describe "decisions/index.html.erb" do
  before(:each) do
    assign(:decisions, [
      stub_model(Decision,
        :name => "Name",
        :user => nil
      ),
      stub_model(Decision,
        :name => "Name",
        :user => nil
      )
    ])
  end

  it "renders a list of decisions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
