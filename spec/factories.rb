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
    sequence(:name)    { |n| "#{n}-TestWine"}
    url "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
    wine_type "Cabernet Sauvignon"
    year "1996"
    price_retail 19.99
    


    factory :wine_complete do 
      appellation 
      varietal
      after(:build) { |wine| wine.product_attributes << create_list(:product_attribute, 5) }
      #product_attribute { FactoryGirl.create(:product_attribute)}
    end

  end

  factory :appellation do
    sequence(:id) { |n| n }
    sequence(:name)    { |n| "#{n}-TestAppellation"}
    url "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
  end

  factory :region do
    sequence(:id) { |n| n }
    sequence(:name)    { |n| "#{n}-TestRegion"}
    url "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"

    #area
  end

  factory :area do
    id 149591
    name "Barossa Valley"
    url "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
  end

  factory :varietal do
    sequence(:id) { |n| n }
    sequence(:name)    { |n| "#{n}-TestVarietal"}
    url "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
  end


  factory :geolocation do 
    id 12345
    lat 112.51511
    long 32.15159
    url "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
  end

  factory :product_attribute do
    sequence(:id) { |n| n }
    sequence(:name)    { |n| "##{n}-TestProdAttr"}
    url "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
  end


  
end

