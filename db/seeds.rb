require 'database_cleaner'
require 'faker'

DatabaseCleaner[:mongoid].strategy = :truncation
puts "Truncationing of DB...".colorize(:red)
DatabaseCleaner.clean

puts "Seeding DB with predifined data:".colorize(:yellow)

puts "Seeding article categories...".colorize(:green)
predifined_categories_en = %w{Beginners News Overviews Articles Reports Discussions Interviews Analytics Competitions Hatchery} 
predifined_categories_ru = %w{Начинающим Новости Обзоры Статьи Отчеты Дискуссии Интервью Аналитика Соревнования Инкубатор}

predifined_categories_en.each_with_index do |en_value, index|
  category = ArticleCategory.create name_translations: {en: en_value, ru: predifined_categories_ru[index] }
end

puts "Seeding static pages...".colorize(:green)
predifined_static_pages_en = Page::PAGE_CATEGORIES 
predifined_static_pages_ru = %w{онас}

predifined_static_pages_en.each_with_index do |en_value, index|
  Page.create ({
  	category: en_value,
  	title_translations: {en: en_value, ru: predifined_static_pages_ru[index] },
  	content_translations: {en: en_value, ru: predifined_static_pages_ru[index] },
  	meta_keywords_translations: {en: en_value, ru: predifined_static_pages_ru[index] },
  	meta_description_translations: {en: en_value, ru: predifined_static_pages_ru[index] }
  })
end

puts "Seeding hyip categories...".colorize(:green)
predifined_hyip_categories_en = [
  'Our choince', 'With insurance', 'In testing', 'Hatchery', 'Low-income', 'Average-income', 
  'High yielding', 'Sorted by date', 'Old', 'Restarts', 'Scam'
]
predifined_hyip_categories_ru = [
  'Наш выбор', 'С страхования', 'Во время тестирования', 'Инкубатор', 
  'С низким уровнем доходов', 'С средним уровнем доход', 'С высоким уровнем доходов', 'Сортировка по дате ','Старые',
  'Рестарт ', 'Скамы'
]

predifined_hyip_categories_en.each_with_index do |en_value, index|
  category = HyipCategory.create name_translations: {en: en_value, ru: predifined_hyip_categories_ru[index] }
end

puts "Setting slugs for all sort of articles, categories, pages...".colorize(:green)
Rake::Task['mongoid_slug:set'].execute

puts "Seeding with test users...".colorize(:green)

USER_PASSWORD = ENV['USER_PASSWORD'] || 'userPassword123'

User::ROLES.each do |role|
  User.create({
    login_name: Faker::Name.first_name.downcase,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    role: role,
    sex: :male,
    email: "#{role}@mail.com",
    password: USER_PASSWORD,
    password_confirmation: USER_PASSWORD,
    confirmed_at: DateTime.now
  })

 puts "#{role}@mail.com".colorize(:marvel), "#{USER_PASSWORD}".colorize(:pink)
end

puts "Done!".colorize(:yellow)