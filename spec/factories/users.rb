Factory.define :valid_user , :class => User do |u|
  u.id 43
  u.username "georgewbush"
end

Factory.define :invalid_user , :class => User do |u|
end
