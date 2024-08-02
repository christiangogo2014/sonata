class Extractor

  attr_reader :file_path, :outcome, :header, :rows, :smallest_spread

  class << self
    def call(*args)
      new(*args)
    end
  end

  def initialize f
    @file_path = f
    @outcome = nil
    @header = false
    @rows = []
    @smallest_spread = initialize_smallest_spread
    find_smallest
  end

  def find_smallest
  	raise NotImplementedError, "find_smallest"
  end

  def initialize_smallest_spread
  	raise NotImplementedError, "initialize_smallest_spread"
  end

end