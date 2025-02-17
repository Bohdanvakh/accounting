class FolderWeightCalculator
  LBS_TO_KG = 0.453592

  def initialize(folder)
    @folder = folder
  end

  def calculate
    weight = 0
      @folder.components.map do |component|
        component.measurement == "kg" ? weight += component.weight : weight += component.weight * LBS_TO_KG
      end
    weight
  end
end
