class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :omniauthable

  has_many :written_fictions, foreign_key: "author_id", class_name: "Fiction", dependent: :destroy
  has_many :purchases, foreign_key: "reader_id", class_name: "Purchase"
  has_many :fictions, through: :purchases

  def remember_me
    true
  end

  def buy!(fiction)
    self.purchases.create!(fiction_id: fiction.id)
  end

  def bought?(fiction)
    self.purchases.find_by(fiction_id: fiction.id)
  end
end
