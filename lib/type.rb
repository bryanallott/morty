class Numeric
  def precision(pre)
    return self.round if pre == 0
    mult = 10.0 ** pre
    (self * mult).round / mult
  end
  def display
    return sprintf("%0.2f",self)
  end
end