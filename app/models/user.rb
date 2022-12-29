class User < ApplicationRecord
  has_many :viewing_party_users
  has_many :viewing_parties, through: :viewing_party_users

  validates_presence_of :name, :email
  validates :password_digest, presence: true
  validates_uniqueness_of :email, case_sensitive: false
  has_secure_password

end
