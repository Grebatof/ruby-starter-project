require_relative './enums/temp_scale_names'

class ScaleConverterFromKelvin
  include TempScaleNames

  KELVINS = 273.15

  def convert(degree_kelvin, to_scale)
    case to_scale
    when CELSIUS
      to_celsius(degree_kelvin)
    when FAHRENHEIT
      to_fahrenheit(degree_kelvin)
    when KELVIN
      degree_kelvin
    end
  end

  private

  def to_fahrenheit(degree_kelvin)
    ((degree_kelvin * 9 / 5) - 459.67).round(2)
  end

  def to_celsius(degree_kelvin)
    (degree_kelvin - KELVINS).round(2)
  end
end
