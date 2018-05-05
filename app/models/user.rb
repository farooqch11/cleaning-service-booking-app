class User < ApplicationRecord
  acts_as_paranoid

  enum role: [:owner, :manager , :cleaner]
  enum gender: [:male, :female]
  enum status: [:pending, :accepted , :canceled]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # validates :first_name , :last_name, presence: true , length: { maximum: 25 }
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
  validates_inclusion_of :status, in: statuses.keys
  validates_inclusion_of :role, in: roles.keys
  # validates_inclusion_of :role, in: roles.keys
  # validates_inclusion_of :gender, in: genders.keys


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
    # "#{first_name} #{last_name}"
    username
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    puts "Condition is: #{conditions}"
    where(["lower(username) = :value OR lower(email) = :value", { :value => conditions[:email].downcase }]).first
  end

  def full_address
    return "#{street}, #{city}, #{postcode}" if street && city && postcode
    return "#{city}, #{postcode}" if city && postcode
    return "#{street}, #{postcode}" if street && postcode
    return "#{self.city}" if self.city
    return "#{postcode}" if postcode
  end
end
