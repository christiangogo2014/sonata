####################################
#
#  In the attached file (w_data.dat), you’ll find daily weather data. 
#  Download this text file, then write a program to output the day number (column one) 
#  with the smallest temperature spread (the maximum temperature is the second column
#  the minimum the third column).
#  
require './weather'

describe WeatherExtractor do

  let(:file_path){ './w_data (1).dat' }
  subject { described_class.call(file_path) }

  describe ".call" do

    context "when it loads the data form the daily file" do

      it "must have a file_path attr" do
        expect(subject.file_path).to eq file_path
      end

      # ignoring extra lines with garbage
      it "must load 31 records" do
        expect(subject.rows.count).to eq 31
      end

      # It was extracted by removing all spaces from smallest line
      it "use a MINIMAL_LINE_LENGTH constant" do
        expect(WeatherExtractor::MINIMAL_LINE_LENGTH).to eq 40
      end

      it "must output the day number (column one) with the smallest temperature spread (i.e. 14 2)." do
        expect(subject.outcome).to eq "14 2"
      end

    end
  end
end
