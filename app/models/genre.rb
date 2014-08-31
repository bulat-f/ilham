class Genre < ActiveRecord::Base

  has_many :fictions

  def poetry?
    if self.name == 'poetry'
      true
    else
      false
    end
  end
end
