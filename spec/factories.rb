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
    product_id "113077"
    name "Boozy Cabernet"
    url "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
    type "Cabernet Sauvignon"
    year "1996"
  end

  factory :appelation do
    appelation_id "113077"
    name "Barossa Valley"
    url "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
  end

end

