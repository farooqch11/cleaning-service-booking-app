class Customer < ApplicationRecord

  has_many :events

  validates :first_name , :last_name  , length: {minimum: 2, maximum: 50}, allow_blank: true
  validates :nickname  , length: {minimum: 2, maximum: 50}   , presence: true
  validates :email   , length: {minimum: 5, maximum: 100}, allow_blank: true , uniqueness: true


  def image
    super.present? ?  super : "gravatar/gravatar_#{(10..15).to_a.sample(1).first}.png"
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
