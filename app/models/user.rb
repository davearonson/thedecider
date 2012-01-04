class User < ActiveRecord::Base

  has_many :decisions, :dependent => :destroy

  validates :realname, :length => { :minimum => 2, :maximum => 50 },
            :presence => true, :uniqueness => true

  validates :username, :length => { :minimum => 2, :maximum => 20 },
            :presence => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # TODO: rememberable doesn't seem to work; why?
  # TODO MAYBE: can we make email NOT have to be unique?
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # TODO: can we protect username?
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :username, :realname

  def is_admin?
    result = username == 'dave'
  end

  def user_id
    id
  end

  # keep devise happy :-P
  def name
    username
  end

end
