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
end
