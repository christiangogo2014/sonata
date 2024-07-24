####################################
#
#  The attached soccer.dat file contains the results from the English Premier League. 
#  The columns labeled ‘F’ and ‘A’ contain the total number of goals scored for and against 
#  each team in that season 
#  (so Arsenal scored 79 goals against opponents and had 36 goals scored against them). 
#
#  Write a program to _print the name of the team with the smallest difference in ‘for’ and ‘against’ goals_.
#  
require './soccer'

describe SoccerExtractor do

  let(:file_path){ './soccer (1).dat' }
  subject { described_class.call(file_path) }

  describe ".call" do

    context "when it loads the data form the scores file" do

      it "must have a file_path attr" do
        expect(subject.file_path).to eq file_path
      end

      # ignoring extra lines with garbage, in addition it ignores lines which starts with '-' 
      it "must load 20 records" do
        expect(subject.rows.count).to eq 20
      end

      # It was extracted by removing all spaces from smallest line
      it "use a MINIMAL_LINE_LENGTH constant" do
        expect(SoccerExtractor::MINIMAL_LINE_LENGTH).to eq 13
      end

      it "must print the name of the team with the smallest difference in ‘for’ and ‘against’ goals (i.e. Aston_Villa 1)." do
        expect(subject.outcome).to eq "Aston_Villa 1"
      end

    end
  end
end
