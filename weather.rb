require './weather_constants'

class WeatherExtractor
  include WeatherConstants

  attr_reader :file_path, :rows, :outcome, :header
  MINIMAL_LINE_LENGTH = 40

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
    find_smallest
  end

  def find_smallest
    smallest_spread = {day_number:nil, spread: INITIAL_SPREAD}
    File.open(@file_path).each do |line|

      #########
      # Clean and normalize data
      line.strip!
      data         =  line.split(SPLITTER_REGEX)

      if !@header && data.size >= MINIMAL_COLUMNS_LENGTH_PER_ROW
        @header = true
        # NOP...
      elsif data.size >= MINIMAL_COLUMNS_LENGTH_PER_ROW
        day_number   =  data[DAY_NUMBER_INDEX]
        max_temp     =  data[MAX_TEMP_INDEX].to_i
        min_temp     =  data[MIN_TEMP_INDEX].to_i
        @rows          << "#{line}"
        
        current_spread = max_temp - min_temp
        if current_spread < smallest_spread.dig(:spread)
          smallest_spread = {
            day_number: day_number, 
            spread: current_spread
          }
        end
      end
      @outcome = "#{smallest_spread.dig(:day_number)} #{smallest_spread.dig(:spread)}"
    end
  end

end