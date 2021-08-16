##### Requirements 
# - Quality decreases each day.
# - Once the sell by date has passed, Quality degrades twice as fast
# - "Aged Brie" actually increases in Quality the older it gets.
# - "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
# - "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
#   Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
#   Quality drops to 0 after the concert
# - The Quality of an item is never negative
# - The Quality of an item is never more than 50


require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do

    context "foo" do  
      items = [Item.new("foo", 2, 10)]
      GildedRose.new(items).update_quality()   
      
      it "does not change the name" do
        expect(items[0].name).to eq "foo"
      end

      it "decreases the quality each day" do
        expect(items[0].quality).to eq 9
      end

      it "decreases the quality twice as fast once the sell date is passed" do
        items = [Item.new("foo", -1, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 8
      end
    end 
  
    context "Aged Brie" do 
      it "actually increases in Quality the older it gets." do 
        items = [Item.new("Aged Brie", 8, 10)]
        GildedRose.new(items).update_quality()  
        expect(items[0].quality).to eq 11
      end 
    end 

    context "Sulfuras, Hand of Ragnaros" do 
      it "never decreases in quality" do 
        items = [Item.new("Sulfuras, Hand of Ragnaros", 4, 10)]
        GildedRose.new(items).update_quality()  
        expect(items[0].quality).to eq 10
      end 
      it "never decreases days_in" do 
        items = [Item.new("Sulfuras, Hand of Ragnaros", 4, 10)]
        GildedRose.new(items).update_quality()  
        expect(items[0].sell_in).to eq 4
      end 
    end 

    context "Backstage passes to a TAFKAL80ETC concert"do 
      it "Quality increases by 2 when there are less than 10 and more than 5 days left" do 
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 2)]
        GildedRose.new(items).update_quality()  
        expect(items[0].quality).to eq 4
      end 
      it "Quality increases by 3 when there are less than 5 and more than 0 days left" do 
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 1)]
        GildedRose.new(items).update_quality()  
        expect(items[0].quality).to eq 4
      end 
      it "Quality drops to 0 after 0 days left" do 
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 0)]
        GildedRose.new(items).update_quality()  
        expect(items[0].quality).to eq 0
      end 
    end 

    context "Quality" do 
      it "of any item is never more than 50" do 
        items = [Item.new("Sulfuras, Hand of Ragnaros", 4, 50)]
        GildedRose.new(items).update_quality()  
        expect(items[0].quality).to eq 50
      end 

      it "of any item is never negative" do 
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", -4, 0)]
        GildedRose.new(items).update_quality()  
        expect(items[0].quality).to eq 0
      end 
    end 

  end
end


