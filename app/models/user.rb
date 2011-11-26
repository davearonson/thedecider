class User < ActiveRecord::Base

  has_many :decisions, :dependent => :destroy

  validates_presence_of :name, :realname

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
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
