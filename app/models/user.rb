class User < ActiveRecord::Base
 has_many :collaborators
 has_many :wikis, through: :collaborators
  
  
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  enum role: [:standard, :premium, :admin]
  after_initialize { self.role ||= :standard }
  
  
end
