# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

predifined_categories_en = %w{beginners news overviews articles reports discussions interviews analytics competitions hatchery} 
predifined_categories_ru = %w{начинающим новости обзоры статьи отчеты дискуссии интервью аналитика соревнования инкубатор}

predifined_categories_en.each_with_index do |en_value, index|
  category = ArticleCategory.create name_translations: {en: en_value, ru: predifined_categories_ru[index] }
end

Rake::Task['mongoid_slug:set'].execute