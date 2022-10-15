class DuplicatedUserError < RuntimeError
  def initialize(msg = 'This user email has an account associated')
    super(msg)
  end
end
