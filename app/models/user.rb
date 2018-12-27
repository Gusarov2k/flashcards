class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :cards

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :email, uniqueness: true


end
