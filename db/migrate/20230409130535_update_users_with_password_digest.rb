class UpdateUsersWithPasswordDigest < ActiveRecord::Migration[7.0]
  def up
    User.all.each do |user|
      user.password_digest = BCrypt::Password.create(user.password)
      user.save!
    end
  end

  def down
    User.update_all(password_digest: nil)
  end
end
