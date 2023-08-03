class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true

  def to_s
    "id: #{id}, first_name: #{first_name}, last_name: #{last_name}, email: #{email}, password_digest: #{password_digest}, created_at: #{created_at}, updated_at: #{updated_at}"
  end
end
