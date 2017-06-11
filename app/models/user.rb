class User < ApplicationRecord
  enum role: [:user, :admin]
  enum gender: [:male, :female]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name , :last_name , presence: true

  def image
    super.present? ?  super : "gravatar/gravatar_#{(1..15).to_a.sample(1).first}.png"
  end

  def admin?
    self.type == "Admin"
  end
  def employee?
    self.type == "Employee"
  end
  def full_name
    self.first_name + " " + self.last_name
  end
end
