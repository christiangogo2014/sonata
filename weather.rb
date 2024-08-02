require './extractor'
require './weather_constants'

class WeatherExtractor < Extractor
  include WeatherConstants

  def find_smallest
    
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
        @rows        << "#{line}"
        
        current_spread = max_temp - min_temp
        if current_spread < @smallest_spread.dig(:spread)
          @smallest_spread = {
            day_number: day_number, 
            spread: current_spread
          }
        end
      end
      @outcome = "#{@smallest_spread.dig(:day_number)} #{@smallest_spread.dig(:spread)}"
    end
  end

  def initialize_smallest_spread
    {
      day_number:nil, 
      spread: INITIAL_SPREAD
    }
  end

end