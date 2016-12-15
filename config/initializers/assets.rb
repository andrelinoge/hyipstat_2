# Be sure to restart your server when you modify this file.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'components', 'gentelella', 'production')
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'components', 'gentelella', 'production', 'images')
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( admin-manifest.css admin-manifest.js admin-theme-manifest.js admin/ckeditor_config.js)
Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
