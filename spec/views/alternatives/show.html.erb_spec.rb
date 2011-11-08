require 'spec_helper'

describe "alternatives/show.html.erb" do
  before(:each) do
    @alternative = assign(:alternative, stub_model(Alternative,
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
