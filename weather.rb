class WeatherExtractor

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
    smallest_spread = {day_number:nil, spread: 999999999}
    File.open(@file_path).each do |line|
      line.strip!
      if !@header && line.size >= MINIMAL_LINE_LENGTH 
        @header = true
        # NOP...
        # p "NOP: #{line}"
      elsif line.size >= MINIMAL_LINE_LENGTH 
        @rows        << "#{line}"
        data         =  line.split(/ +/)
        day_number   =  data[0]
        max_temp     =  data[1].to_i
        min_temp     =  data[2].to_i
        current_spread = max_temp - min_temp
        # p "#{day_number}: #{current_spread}"
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