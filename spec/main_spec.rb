require_relative '../lib/scale_converter_to_kelvin'
require_relative '../lib/scale_converter_from_kelvin'
require_relative '../lib/enums/temp_scale_names'
require_relative '../lib/main'

class Test
  include TempScaleNames

  RSpec.describe Main do
    describe 'Check scale' do
      context 'C (CELSIUS) is valid' do
        subject { Main.new.valid_scale?("C") }
        it { is_expected.to be_truthy }
      end
      context 'F (FAHRENHEIT) is valid' do
        subject { Main.new.valid_scale?("F") }
        it { is_expected.to be_truthy }
      end
      context 'K (KELVIN) is valid' do
        subject { Main.new.valid_scale?("K") }
        it { is_expected.to be_truthy }
      end
      context 'B is not valid' do
        subject { Main.new.valid_scale?("B") }
        it { is_expected.to be_falsy  }
      end
    end

    describe 'Checking for absolute zero' do
      context '0k is valid' do
        subject { Main.new.check_correctness_input_value(0) }
        it { is_expected.to be_truthy }
      end
      context '100k is valid' do
        subject { Main.new.check_correctness_input_value(100) }
        it { is_expected.to be_truthy }
      end
      context '-100 is not valid' do
        it {
          expect do
            Main.new.check_correctness_input_value(-100)
          end.to output("Error: incorrect number\n").to_stdout
        }
      end
    end

    describe 'Check input scale' do
      display = Main.new
      context 'C is correct' do
        it {
          display.stub(:gets).and_return("C\n")
          expect(display.input_scale("")).to eq("C")
        }
      end
      context 'B is not correct' do
        it {
          display.stub(:gets).and_return("B\n")
          expect do
            display.input_scale("")
          end.to output("\nIncorrect scale\n").to_stdout
        }
      end
    end

    describe 'Print message' do
      context 'Hello world!' do
        it {
          expect do
            Main.new.print_result("Hello world!")
          end.to output("Hello world!\n").to_stdout
        }
      end
    end

    describe 'Check input temp value' do
      display = Main.new
      context '100.08 is correct number format' do
        it {
          display.stub(:gets).and_return("100.08\n")
          expect(display.input_temp_value).to eq(100.08)
        }
      end
      context 'ABC is incorrect number format' do
        it {
          display.stub(:gets).and_return("ABC\n")
          expect do
            display.input_temp_value
          end.to output("Enter degree: \nError: incorrect number format\n").to_stdout
        }
      end
    end

    describe 'Check convert again' do
      display = Main.new
      context 'Y - convert again' do
        it {
          display.stub(:gets).and_return("Y\n")
          expect do
            display.convert_again
          end.to output("Do you want to convert again? [Y/N]\n").to_stdout
        }
      end
      context 'B - is incorrect answer' do
        it {
          display.stub(:gets).and_return("B\n")
          expect do
            display.convert_again
          end.to output("Do you want to convert again? [Y/N]\nIncorrect answer\n").to_stdout
        }
      end
      context 'N - doesn\'t convert again' do
        it {
          display.stub(:gets).and_return("N\n")
          expect(display.convert_again).to eq("exit")
        }
      end
    end
  end
end
