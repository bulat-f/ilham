class Episode < ActiveRecord::Base
  belongs_to :fiction

  def next
    episodes = fiction.episodes.sort
    index = episodes.index(self)
    if index.nil?
      nil
    else
      episodes[index + 1]
    end
  end

  def prev
    episodes = fiction.episodes.sort
    index = episodes.index(self)
    if index.to_i == 0
      nil
    else
      episodes[index - 1]
    end
  end
end
