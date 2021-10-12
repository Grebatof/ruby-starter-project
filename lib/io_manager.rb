require_relative './enums/io_states'
require_relative './enums/temp_scale_names'
require_relative './scale_converter_to_kelvin'
require_relative './scale_converter_from_kelvin'

class IOManager
  include IOStates
  include TempScaleNames

  @current_state = READ_FROM_TEMP_SCALE
  @from_scale = CELSIUS
  @to_scale = CELSIUS

  def initialize
    @current_state = READ_FROM_TEMP_SCALE
    @from_scale = CELSIUS
    @to_scale = CELSIUS
  end

  def valid_scale?(scale)
    [FAHRENHEIT, KELVIN, CELSIUS].include?(scale)
  end

  def check_correctness_input_value(temp_value_kelvin)
    if temp_value_kelvin.negative?
      @current_state = READ_FROM_TEMP_SCALE
      puts 'Error: incorrect number'
      return
    end
    next_state
  end

  def input_temp_value
    puts 'Enter degree: '
    temperature = gets
    temperature ||= ''
    temperature.chomp!

    if temperature.match(Regexp.new(/[+-]?[0-9]+(\\.[0-9]+)?/)).nil?
      puts 'Error: incorrect number format'
      return
    end

    next_state
    temperature.to_f
  end

  def input_scale(message)
    puts message
    start_scale = gets
    start_scale ||= ''
    start_scale = start_scale.upcase
    start_scale.chomp!

    if valid_scale?(start_scale)
      next_state
      return start_scale
    end

    puts 'Incorrect scale'
  end

  def convert_again
    puts('Do you want to convert again? [Y/N]')
    continue = gets
    continue ||= ''
    continue = continue.upcase
    continue.chomp!

    case continue
    when 'Y'
      next_state
      return
    when 'N'
      exit
    end

    puts 'Incorrect answer'
  end

  def next_state
    @current_state = (@current_state + 1).modulo(IOStates.constants.count)
  end

  def print_result(message)
    puts message
    next_state
  end

  def start
    temp_value = 0
    temp_value_kelvin = 0

    loop do
      case @current_state
      when READ_FROM_TEMP_SCALE
        @from_scale = input_scale('Enter scale you want to convert from (C, K, F): ')
      when READ_FROM_TEMP_VALUE
        temp_value = input_temp_value
      when CONVERT_TO_KELVIN
        temp_value_kelvin = ScaleConverterToKelvin.new.convert(temp_value, @from_scale)
        check_correctness_input_value(temp_value_kelvin)
      when READ_TO_TEMP_SCALE
        @to_scale = input_scale('Enter result scale (C, K, F): ')
      when CONVERT_TO_TEMP_SCALE
        result = ScaleConverterFromKelvin.new.convert(temp_value_kelvin, @to_scale)
        print_result("#{temp_value}°#{@from_scale} = #{result}°#{@to_scale}")
      when CONTINUE_OR_EXIT
        convert_again
      end
    end
  end
end

io = IOManager.new
io.start
