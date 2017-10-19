Icon = Struct.new(:meaning, :fa_name, :fa_bg_name)

class Icon
  def self.method_missing(name)
    self.for(name)
  end

  def self.for(name)
    ICON_MAPPINGS[name.downcase.to_sym] || Icon.circle #nil
  end
end
