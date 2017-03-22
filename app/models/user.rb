class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :meetings
  before_save { self.role ||= :member }
  default_scope { order('firstname ASC') }

  enum role: [:member, :admin]

  def full_name
    "#{firstname} #{lastname}"
  end

  def partial_name
    "#{firstname} #{lastname[0]}."
  end
end
