FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}"}
    sequence(:email) { |n| "person_#{n}@example.com"}
    password  "foobar"
    password_confirmation "foobar"
  
    factory :admin do
      admin true
    end
  end


  factory :wine do
    sequence(:id)      { |n| n }
    sequence(:wine_id) { |n| "#{n}" }
    sequence(:name)    { |n| "Test Wine##{n}"}
    url "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
    wine_type "Cabernet Sauvignon"
    year "1996"
    price_retail 19.99
    


    factory :wine_complete do 
      appellation 
      varietal
      after_create { |wine| wine.product_attributes << FactoryGirl.create(:product_attribute) }
    end

  end

  factory :appellation do
    id 999999999999
    appellation_id "999999999999"
    name "Wonderful Place"
    url "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
  end

  factory :region do
    id 149591
    region_id "149591"
    name "Bordeaux"
    url "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
    area
  end

  factory :area do
    id 149591
    area_id "149591"
    name "Barossa Valley"
    url "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
  end

  factory :varietal do
    id 19591
    varietal_id "19591"
    name "Merlow"
    url "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
  end


  factory :geolocation do 
    lat 112.51511
    long 32.15159
    url "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
  end

  factory :product_attribute do
    product_attribute_id 1336
    name "Cabernet Sauvignon"
    url "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
  end


  
end

