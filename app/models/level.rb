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

  attr_reader :id, :name, :color

  def initialize id, name, color
    @id, @name, @color = id, name, color
    @@list[id] = self
  end

  def self.getLevels
    @@list.clone
  end

  @@list = [];
  new 0        , "ERROR!",    "black"
  new Very_Low , "Very Low",  "red"
  new Low      , "Low",       "light red"
  new Semi_Low , "Semi-Low",  "orange"
  new Medium   , "Medium",    "yellow"
  new Semi_High, "Semi-High", "lime"
  new High     , "High",      "light green"
  new Very_High, "Very High", "green"
end
