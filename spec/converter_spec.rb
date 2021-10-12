require_relative '../lib/scale_converter_to_kelvin'
require_relative '../lib/scale_converter_from_kelvin'
require_relative '../lib/enums/temp_scale_names'

class Test
  include TempScaleNames

  RSpec.describe ScaleConverterToKelvin do
    describe 'convert to KELVIN' do
      context 'from CELSIUS' do
        subject { ScaleConverterToKelvin.new.convert(0, from_scale = CELSIUS) }
        it { is_expected.to eq(273.15) }
      end
      context 'from FAHRENHEIT' do
        subject { ScaleConverterToKelvin.new.convert(0, from_scale = FAHRENHEIT) }
        it { is_expected.to eq(255.37) }
      end
      context 'from KELVIN' do
        subject { ScaleConverterToKelvin.new.convert(10, from_scale = KELVIN) }
        it { is_expected.to eq(10) }
      end
    end
  end

  RSpec.describe ScaleConverterFromKelvin do
    describe 'convert from KELVIN' do
      context 'to CELSIUS' do
        subject { ScaleConverterFromKelvin.new.convert(273.15, to_scale = CELSIUS) }
        it { is_expected.to eq(0) }
      end
      context 'to FAHRENHEIT' do
        subject { ScaleConverterFromKelvin.new.convert(255.37, to_scale = FAHRENHEIT) }
        it { is_expected.to eq(0) }
      end
      context 'to KELVIN' do
        subject { ScaleConverterFromKelvin.new.convert(10, to_scale = KELVIN) }
        it { is_expected.to eq(10) }
      end
    end
  end
end
