class User < ApplicationRecord
  acts_as_paranoid

  enum role: [:user, :admin]
  enum gender: [:male, :female]
  enum status: [:pending, :accepted , :canceled]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name , :last_name , presence: true , length: { maximum: 25 }
  before_save { self.email = email.downcase }

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

  def full_address
    return "#{street}, #{city}, #{postcode}" if street && city && postcode
    return "#{city}, #{postcode}" if city && postcode
    return "#{street}, #{postcode}" if street && postcode
    return "#{self.city}" if self.city
    return "#{postcode}" if postcode
  end
end
