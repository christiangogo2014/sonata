require './soccer_constants'

class SoccerExtractor
  include SoccerConstants

  attr_reader :file_path, :rows, :outcome

  class << self
    def call(*args)
      new(*args)
    end
  end

  def initialize f
    @outcome = nil
    @file_path = f
    @header = false
    @rows = []
    find_smallest_diff
  end

  def find_smallest_diff
    smallest_spread = {team_name:nil, diff: INITIAL_SPREAD}

    File.open(@file_path).each do |line|

      #########
      # Clean and normalize data to be processed
      line.strip!
      data         =  line.split(/#{SPLITTER_REGEX}/)

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
        # p "#{team_name}: #{current_diff}"
        if current_diff < smallest_spread.dig(:diff)
          smallest_spread = {
            team_name: team_name, 
            diff: current_diff
          }
        end
      end
    end

    @outcome = "#{smallest_spread.dig(:team_name)}"
  end

end