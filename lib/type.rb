class Numeric
  def precision(pre)
    return self.round if pre == 0
    mult = 10.0 ** pre
    (self * mult).round / mult
  end
  def display
    (sprintf("%0.2f", self)).to_f
  end
end