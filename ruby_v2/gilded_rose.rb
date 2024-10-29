
MAX_ITEM_QUALITY = 50

class GildedRose
  attr_accessor :items

  def initialize(items)
    @items = items.map { |item| create_item(item) }
  end

  def update_quality
    items.each(&:update_quality)
  end

  private

  def create_item(item)
    case item.name
    when "Aged Brie"
      AgedBrie.new(item.name, item.sell_in, item.quality)
    when "Sulfuras, Hand of Ragnaros"
      Sulfuras.new(item.name, item.sell_in, item.quality)
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePass.new(item.name, item.sell_in, item.quality)
    when "Conjured Mana Cake"
      Conjured.new(item.name, item.sell_in, item.quality)
    else RegularItem.new(item.name, item.sell_in, item.quality)
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name    = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class AgedBrie < Item
  def update_quality
    @sell_in -= 1
    @quality += 1 if @quality < MAX_ITEM_QUALITY
    @quality += 1 if @sell_in.negative? && @quality < MAX_ITEM_QUALITY
  end
end

class Sulfuras < Item
  def update_quality; end
end

class BackstagePass < Item
  def update_quality
    @quality += case @sell_in
                when 0..5 then 3
                when 6..10 then 2
                else 1
                end

    @sell_in -= 1
    @quality = 50 if @quality > MAX_ITEM_QUALITY
    @quality = 0 if @sell_in.negative?
  end
end

class Conjured < Item
  def update_quality
    @sell_in -= 1
    @quality -= 2
    @quality -= 2 if @sell_in.negative?
    @quality = 0 if @quality.negative?
  end
end

class RegularItem < Item
  def update_quality
    @sell_in -= 1
    @quality -= 1
    @quality -= 1 if @sell_in.negative?
    @quality = 0 if @quality.negative?
  end
end


