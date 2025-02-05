module FolderMethods
  def components_with_dimension
    components.includes(:dimension).map do |component|
      {
        id: component.id,
        name: component.name,
        folder: component.folder_id,
        price: component.price,
        code: component.code,
        name: component.name,
        wieght: component.wieght,
        measurement: component.measurement,
        currency: component.currency,
        dimension: component.dimension
      }
    end
  end
end

