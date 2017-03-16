class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :meetings
  before_save { self.role ||= :member }

  enum role: [:member, :admin]

  def full_name
    "#{firstname} #{lastname}"
  end
end
