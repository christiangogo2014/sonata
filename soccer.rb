class SoccerExtractor

  attr_reader :file_path, :rows, :outcome
  MINIMAL_LINE_LENGTH = 13
  COMMENT_REGEX = /^-/

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
    smallest_spread = {team_name:nil, diff: 999999999}

    File.open(@file_path).each do |line|
      line.strip!
      if !@header && line.size >= MINIMAL_LINE_LENGTH
        @header = true
        # NOP...
        # p "NOP: #{line}"
      elsif line.size >= MINIMAL_LINE_LENGTH  && !line.match(COMMENT_REGEX)
        @rows        << "#{line}"
        data         =  line.split(/ +/)
        #row_num      =  data[0].to_i
        team_name    =  data[1]
        #_p           =  data[2].to_i
       	#_w           =  data[3].to_i
       	#_l           =  data[4].to_i
       	#_d           =  data[5].to_i
       	_f           =  data[6].to_i
       	#_sep         =  data[7].to_i
       	_a           =  data[8].to_i
       	#_pts         =  data[9].to_i
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

    @outcome = "#{smallest_spread.dig(:team_name)} #{smallest_spread.dig(:diff)}"
  end

end