# TODO: make separate levels for factor weight & rating level?
# TODO MAYBE: make size adjustable per user preference?

class Level

  # ruby has no enums :-(
  Very_Low  = 1
  Low       = 2
  Semi_Low  = 3
  Medium    = 4
  Semi_High = 5
  High      = 6
  Very_High = 7

  Count     = 7

  attr_reader :id, :name

  def initialize id, name
    @id, @name = id, name
  end

  def self.badNames
    return @@BadNames.clone
  end

  def self.goodColors
    return @@GoodColors.clone
  end

  def self.goodNames
    return @@GoodNames.clone
  end

  def self.weightNames
    return @@WeightNames.clone
  end

  @@BadNames = [
    new(Very_Low , 'Very Good'),
    new(Low      , 'Good'),
    new(Semi_Low , 'Semi Good'),
    new(Medium   , 'Medium'),
    new(Semi_High, 'Semi Bad'),
    new(High     , 'Bad'),
    new(Very_High, 'Very Bad')
  ]

  @@GoodColors = [
    new(Very_Low , 'red'),
    new(Low      , 'orangered'),
    new(Semi_Low , 'orange'),
    new(Medium   , 'yellow'),
    new(Semi_High, 'lime'),
    new(High     , 'lightgreen'),
    new(Very_High, 'forestgreen')
  ]

  @@GoodNames = [
    new(Very_Low , 'Very Bad'),
    new(Low      , 'Bad'),
    new(Semi_Low , 'Semi Bad'),
    new(Medium   , 'Medium'),
    new(Semi_High, 'Semi Good'),
    new(High     , 'Good'),
    new(Very_High, 'Very Good')
  ]

  @@WeightNames = [
    new(Very_Low , 'Very Low'),
    new(Low      , 'Low'),
    new(Semi_Low , 'Semi Low'),
    new(Medium   , 'Medium'),
    new(Semi_High, 'Semi High'),
    new(High     , 'High'),
    new(Very_High, 'Very High')
  ]

end
