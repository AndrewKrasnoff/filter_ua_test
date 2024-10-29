class GildedRose

  MAX_ITEM_QUALITY = 50

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when "Aged Brie"
        aged_brie_update(item)
      when "Sulfuras, Hand of Ragnaros"
      when "Backstage passes to a TAFKAL80ETC concert"
        backstage_update(item)
      when "Conjured Mana Cake"
        regular_update(item, 2)
      else regular_update(item)
      end
    end
  end

  private

  def aged_brie_update(item)
    item.sell_in -= 1
    item.quality += 1 if item.quality < MAX_ITEM_QUALITY
    item.quality += 1 if item.sell_in.negative? && item.quality < MAX_ITEM_QUALITY
  end

  def backstage_update(item)
    item.quality += case item.sell_in
                    when 0..5 then 3
                    when 6..10 then 2
                    else 1
                    end
    item.sell_in -= 1
    item.quality = 50 if item.quality > MAX_ITEM_QUALITY
    item.quality = 0 if item.sell_in.negative?
  end

  def regular_update(item, step = 1)
    item.sell_in -= 1
    item.quality -= step
    item.quality -= step if item.sell_in.negative?
    item.quality = 0 if item.quality.negative?
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

