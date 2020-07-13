module Validation
  attr_reader :validation_type, :option_key, :option_value
  def validate(validation_type, option_validate = {})
    @validation_type = validation_type
    @option_key = option_validate.keys.first.to_s
    @option_value = option_validate.values.first
    send(@option_key)
  end

  def presence
    !self.send(:name).empty?
  end

  def type
    self.class == option_value || User
  end

  def format
    regex = Regexp.new option_value || /A-Z{0,3}/
    regex.match?(self.send(:number))
  end

  def valid!
    puts 'Name is not exist' unless presence
    puts 'Type is not User' unless type
    puts 'Number is not valid' unless number
  end

  def valid?
    format && presence && type
  end
end

class User
  include Validation
  attr_reader :name, :number

  def initialize(name, number)
    @name = name
    @number = number
  end
end

user = User.new('name', '123')
second_user = User.new('', '123')
puts user.validate(:name, presence: true)
puts user.validate(:owner, type: User)
puts user.validate(:number, format: 'A-Z{0,3}')
puts second_user.valid!
puts second_user.valid?
