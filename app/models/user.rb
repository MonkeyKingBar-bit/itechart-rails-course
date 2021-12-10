class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :login, presence: true, length: {minimum: 10, maximum: 100}
  validates :password, presence: true, length: {minimum: 6, maximum: 100}
end
