class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      
      if item.quality > 0 and item.quality < 50      
        if item.name == "Aged Brie"
          item.quality += 1
        end 

        if item.name == "Backstage passes to a TAFKAL80ETC concert"
          item.quality += 2 if item.sell_in < 11
          item.quality += 1 if item.sell_in < 6
        end 
        
        if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert" and item.name != "Sulfuras, Hand of Ragnaros"
          item.quality -= 1
          item.quality -= 1 if item.sell_in < 0
        end
        
        if item.name != "Sulfuras, Hand of Ragnaros"
          item.sell_in -= 1
        end
      end 
    
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
