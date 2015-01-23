namespace :ilham do
  desc "Generate basic genres"
  task genres: :environment do
    ["poetry", "short_story", "novella", "novel", "journalism", "criticism", "play"].each do |name|
      Genre.create(name: name)
    end
  end

  desc "Set a fist user as admin"
  task admin: :environment do
    user = User.first
    user.update_attribute(:admin, true) if user
  end

  desc "Resize images witch uploaded with carrierwave"
  task resize: :environment do
    Post.all.each do |post|
      post.cover.recreate_versions!
    end
  end
end
