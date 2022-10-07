class Clothing
  attr_accessor :name, :type, :min_temp, :max_temp

  def initialize(params)
    @name = params[:name]
    @type = params[:type]
    @min_temp = params[:min_temp]
    @max_temp = params[:max_temp]
  end

  def suitable?(temp)
    (@min_temp..@max_temp).member?(temp)
  end

  def to_s
    "#{@type}: #{@name} (#{@min_temp}..#{@max_temp})"
  end
end
