class Icon
  attr_accessor :meaning, :fa_name, :fa_bg_name

  def initialize(meaning, fa_name = nil, fa_bg_name = nil)
    @meaning = meaning
    @fa_name = fa_name || meaning
    @fa_bg_name = fa_bg_name
  end

  def self.method_missing(name)
    self.for(name)
  end

  def self.for(name)
    ICON_MAPPINGS[name.downcase.to_sym] || Icon.circle #nil
  end
end
