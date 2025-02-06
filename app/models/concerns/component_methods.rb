module ComponentMethods
  def with_dimension
    {
      data: self,
      dimension: dimension
    }
  end
end

