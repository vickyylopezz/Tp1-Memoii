class UserRepository < BaseRepository
  self.table_name = :users
  self.model_class = 'User'

  def find_by_email(email)
    row = dataset.first(email: email)
    load_object(row) unless row.nil?
  end

  def save(user)
    if find_by_email(user&.email).nil?
      !insert(user).id.nil?
    else
      raise DuplicatedUserError
    end
  end

  protected

  def changeset(user)
    {
      name: user.name,
      crypted_password: user.crypted_password,
      email: user.email
    }
  end
end
