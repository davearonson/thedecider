require 'spec_helper'

describe "decisions/index.html.erb" do
  before(:each) do
    @names = ["What excuse to use to invade Irakistan",
              "Who to misunderestimate",
              "How far to stick my foot in my mouth"]
    @user = assign(:user, stub_model(User, :id => 43))
    @decisions = @names.map { |name|
      assign(:decision, stub_model(Decision, :name => name, :user_id => 43))
    }
  end

  it "renders a list of decisions" do
    render
    @names.map { |name|
      assert_select "tr>td", :text => name, :count => 1
    }
  end
end
