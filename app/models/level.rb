class Level

  # ruby has no enums :-(
  Very_Low  = 0
  Low       = 1
  Semi_Low  = 2
  Medium    = 3
  Semi_High = 4
  High      = 5
  Very_High = 6

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
  new Very_Low , "Very Low",  "red"
  new Low      , "Low",       "light red"
  new Semi_Low , "Semi-Low",  "orange"
  new Medium   , "Medium",    "yellow"
  new Semi_High, "Semi-High", "lime"
  new High     , "High",      "light green"
  new Very_High, "Very High", "green"
end
