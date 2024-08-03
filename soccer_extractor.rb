require './version'
require './extractor'
require './soccer_constants'

module SonataSoftware
  class SoccerExtractor < Extractor
    include SoccerConstants

    def find_smallest

      File.open(@file_path).each do |line|

        #########
        # Clean and normalize data
        line.strip!
        data         =  line.split(SPLITTER_REGEX)

        if !@header && data.size >= MINIMAL_COLUMNS_LENGTH_PER_ROW
          @header = true
          # NOP...
        elsif data.size >= MINIMAL_COLUMNS_LENGTH_PER_ROW  && !line.match(COMMENT_REGEX)
          team_name    =  data[TEAM_NAME_INDEX]
          _f           =  data[FOR_INDEX].to_i
          _a           =  data[AGAINST_INDEX].to_i
          @rows        << "#{line}"

           ##########################################
           # HEADS UP! this is a tricky part, since the diff could be negative
           ##########################################
          current_diff = (_f - _a).abs
          if current_diff < @smallest_spread.dig(:diff)
            @smallest_spread = {
              team_name: team_name, 
              diff: current_diff
            }
          end
        end
      end

      @outcome = "#{@smallest_spread.dig(:team_name)}"
    end

    def initialize_smallest_spread
      {
        team_name:nil, 
        diff: INITIAL_SPREAD
      }
    end

  end
end