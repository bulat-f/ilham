module FictionsHelper

  def first_episode_path(fiction)
    first = fiction.episodes.sort.first
    if first
      fiction_episode_path(fiction, first)
    else
      '#'
    end
  end
end
