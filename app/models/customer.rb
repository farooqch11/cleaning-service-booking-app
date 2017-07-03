class Customer < ApplicationRecord

  enum gender: [:male , :female]

  has_many :events

  validates :first_name , :last_name     , presence: true
  validates :email      , presence: true , uniqueness: true

  def image
    super.present? ?  super : "gravatar/gravatar_#{(1..15).to_a.sample(1).first}.png"
  end

  def full_name
    self.first_name + " " + self.last_name
  end

end
