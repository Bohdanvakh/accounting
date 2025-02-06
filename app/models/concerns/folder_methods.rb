module FolderMethods
  def components_with_dimension
    components.includes(:dimension).map do |component|
      {
        data: component,
        dimension: component.dimension
      }
    end
  end
end

