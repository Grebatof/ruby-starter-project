require_relative './enums/temp_scale_names'

class ScaleConverterToKelvin
  include TempScaleNames

  KELVINS = 273.15

  def convert(degree, from_scale)
    case from_scale
    when CELSIUS
      from_celsius(degree)
    when FAHRENHEIT
      from_fahrenheit(degree)
    when KELVIN
      degree
    end
  end

  private

  def from_fahrenheit(degree)
    ((degree + 459.67) * 5 / 9).round(2)
  end

  def from_celsius(degree)
    (degree + KELVINS).round(2)
  end
end
