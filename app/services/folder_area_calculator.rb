class FolderAreaCalculator
  def initialize(folder)
    @folder = folder
  end

  def calculate
    area = 0
    @folder.components.each do |component|
      component_measurement = component.dimension.measurement
      if component_measurement == "cm"
        area += component.dimension.length * component.dimension.width * component.dimension.height
      else
        area += (component.dimension.length * component.dimension.width * component.dimension.height) / (2.54 ** 3)
      end
    end
    area.to_i
  end
end
