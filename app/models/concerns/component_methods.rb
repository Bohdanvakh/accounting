module ComponentMethods
  def with_dimension
    {
      id: id,
      name: name,
      folder: folder_id,
      price: price,
      code: code,
      name: name,
      wieght: wieght,
      measurement: measurement,
      currency: currency,
      dimension: dimension
    }
  end
end

