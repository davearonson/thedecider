require 'spec_helper'

describe "factors/show.html.erb" do
  before(:each) do
    @factor = assign(:factor, stub_model(Factor,
      :name => "Name",
      :decision => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
