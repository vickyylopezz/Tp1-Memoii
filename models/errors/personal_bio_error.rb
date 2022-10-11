class PersonalBioBlankError < RuntimeError
  def initialize(msg = message)
    super(msg)
  end

  def message
    "Field description can't be blank"
  end
end

class PersonalBioToLongError < RuntimeError
  def initialize(msg = message)
    super(msg)
  end

  def message
    'Field description cannot be longer than 500 chars'
  end
end
