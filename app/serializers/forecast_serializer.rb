class ForecastSerializer

  def self.serialized(results)
    new(results).serialized
  end

  def initialize(results)
    @results = results
  end

  def serialized
    @results.each_with_index{ |r| [index: r['temp']] }
  end

end