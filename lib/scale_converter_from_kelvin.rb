require_relative './enums/temp_scale_names'

class ScaleConverterFromKelvin
  include TempScaleNames

  def convert(degree, to_scale)
    case to_scale
    when CELSIUS
      to_celsius(degree)
    when FAHRENHEIT
      to_fahrenheit(degree)
    when KELVIN
      degree
    end
  end

  private

  def to_fahrenheit(degree)
    ((degree * 9 / 5) - 459.67).round(2)
  end

  def to_celsius(degree)
    (degree - 273.15).round(2)
  end
end
