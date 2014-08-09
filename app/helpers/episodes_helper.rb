module EpisodesHelper

  def next_episode_link(episode)
    unless episode.next.nil?
      fiction_episode_path(episode.fiction, episode.next)
    else
      '#'
    end
  end

  def prev_episode_link(episode)
    unless episode.prev.nil?
      fiction_episode_path(episode.fiction, episode.prev)
    else
      '#'
    end
  end
end
