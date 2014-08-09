class EpisodesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin_user,         only: [:new, :create, :edit, :update, :destroy]

  before_action :find_fiction,       only: [:index, :show, :new, :edit, :update, :destroy]
  before_action :find_episode,       only: [:show, :new, :edit, :update, :destroy]
  before_action :bought,             only: [:show]

  def index
    @episodes = @fiction.episodes
  end

  def show
  end

  def new
    @episode = @fiction.episodes.build
  end

  def create
    @episode = Episode.new(episode_params)
    puts @fiction
    if @episode.save
      flash[:success] = 'Episode saved'
      redirect_to fiction_episode_path(@episode.fiction, @episode)
    else
      flash.now[:warning] = "Error. Episode don't save"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @episode.update_attributes(episode_params)
      flash[:success] = "Episode's atribute are updated"
      redirect_to fiction_episode_path(@episode.fiction, @episode)
    else
      flash.now[:warning] = "Episode's atributes are not correct"
      render 'edit'
    end
  end

  def destroy
    show_episode = @episode.next || @episode.prev
    @episode.destroy
    flash[:success] = "Episode destroyed"
    if show_episode
      redirect_to [@fiction, show_episode]
    else
      redirect_to @fiction
    end
  end

  private

  def episode_params
    params.require(:episode).permit(:title, :body, :fiction_id)
  end

  def find_fiction
    @fiction = Fiction.find_by_id(params[:fiction_id])
  end

  def find_episode
    @episode = @fiction.episodes.find_by_id(params[:id]) unless @fiction.nil?
  end

  def bought
    unless current_user.bought?(@fiction) or current_user.admin?
      flash[:warning] = 'flash.not-bought'
      redirect_to fiction_path(@fiction)
    end
  end
end
