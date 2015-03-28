class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :omniauthable

  has_many :written_fictions, foreign_key: "author_id", class_name: "Fiction", dependent: :destroy
  has_many :purchases, foreign_key: "reader_id", class_name: "Purchase"
  has_many :fictions, through: :purchases
  has_many :payments
  has_many :articles

  scope :writers, -> { where(writer: true) }

  def to_s
    if self.name.blank? && self.surname.blank?
      self.email
    else
      "#{self.name} #{self.surname}"
    end
  end

  def remember_me
    true
  end

  def buy!(fiction)
    id = fiction.class == Fixnum ? fiction : fiction.id
    self.purchases.create!(fiction_id: id)
  end

  def bought?(fiction)
    !purchases.find_by(fiction_id: fiction.id).nil?
  end

  def can_read?(fiction)
    bought?(fiction) || self.admin? || self.written_fictions.include?(fiction)
  end
end
