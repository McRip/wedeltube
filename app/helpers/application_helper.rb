module ApplicationHelper
  def createThumbSymbol name, index
    (name+index.to_s).to_sym
  end
end
