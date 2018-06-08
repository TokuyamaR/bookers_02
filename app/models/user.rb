class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  attachment :image_name

  validates :name, {presence: true,length:{in: 2..20}}
  validates :introduction, length:{maximum:50}
end
