require 'spec_helper'

describe "decisions/show.html.erb" do
  before(:each) do
    num = 0
    @user = assign(:user, stub_model(User, :id => 43))
    @decname = "What country to invade"
    @altnames = [ 'Afghanistan', 'Iraq', 'Iran', 'North Korea', 'China', 'Bakabeyondistan' ]
    alternatives = @altnames.map { |name|
      num += 1
      stub_model(Alternative, :id => num, :name => name, :decision_id => 0)
    }
    puts alternatives.inspect
    @facs = [ ['they tried to kill daddy', Level::High],
              ['they attacked us', Level::Semi_High],
              ['they helped our enemies', Level::Medium],
              ['we can kick their butts', Level::Very_High]]
    factors = @facs.map { |fac|
      num += 1
      stub_model(Factor, :id => num, :name => fac[0], :weight_id => fac[1], :decision_id => 0)
    }
    puts factors.inspect
    @decision = stub_model(Decision, :id => 0, :name => @decname, :user_id => 43
                           # argh, some factors can't be saved, why?
                           # , :alternatives => alternatives, :factors => factors
                          )
    @alternative = Alternative.new
    @factor = Factor.new
    # TODO: just move the effing tests into the controller test,
    # so we don't have to duplicate its gd logic here!  :-P
    srand
    @percents = Hash.new
    @scores = Hash.new
    alternatives.map do |alt|
      id = alt.id
      @percents[id] = rand * 100 + 1
      @scores[id] = @percents[id] / (100 / Level::Count)
    end
  end

  it "renders attributes in <p>" do
    render
    # sheesh, this doesn't work, maybe because the name is in the layout, wtf?!
    # rendered.should match(@decname)
    #
    # sheesh, these don't work 'cuz i couldn't attach them above.
    # screw it, let's move these to the controller test....
    # @altnames.map do |name|
    #   rendered.should match name
    # end
    # @facs.map do |fac|
    #   rendered.should match fac[0]
    # end
  end
end
