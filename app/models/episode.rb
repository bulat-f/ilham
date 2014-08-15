class Episode < ActiveRecord::Base
  belongs_to :fiction

  def next
    episodes = self.fiction.episodes.sort
    index = episodes.index(self)
    if index.nil?
      nil
    else
      episodes[index + 1]
    end
  end

  def prev
    episodes = self.fiction.episodes.sort
    index = episodes.index(self)
    if index.to_i == 0
      nil
    else
      episodes[index - 1]
    end
  end
end
