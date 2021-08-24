# Blog
activate :blog do |blog|
  blog.name = "blog"
  blog.prefix = "blog"
  blog.permalink = "{title}.html"
  blog.sources = "{title}.html"
  blog.layout = "blog_layout"
  blog.new_article_template = File.expand_path("./source/partials/blog/_post_template.erb")
  blog.summary_length = 100
end

activate :blog do |changelog|
  changelog.name = "changelog"
  changelog.prefix = "changelog"
  changelog.permalink = "{title}.html"
  changelog.sources = "{title}.html"
  # changelog.layout = "changelog_layout"
  changelog.new_article_template = File.expand_path("./source/partials/blog/_post_template.erb")
  changelog.summary_length = 100
end

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false


# Helpers

helpers do

  def resolve_author_data(author_name)
    authors = {
      harrison: {
        name: "Harrison Broadbent", 
        image: "images/authors/harrison.jpg",
        url: "/about"
      }
    }

    return authors[author_name.to_sym]
  end


  def blog_card_bottom_helper(article)

    author = resolve_author_data(article.data.author)

    return "
    <div class='mt-6 flex items-center'>
    <div class='flex-shrink-0'>
      <a href='#{author[:url]}'>
        <span class='sr-only'>#{author[:name]}</span>
        <img
          class='h-10 w-10 rounded-full'
          src='#{author[:image]}'
        />
      </a>
    </div>
    <div class='ml-3'>
      <p class='text-sm font-medium text-gray-900'>
        <a href='#{author[:url]}' class='hover:underline'> #{author[:name]} </a>
      </p>
      <div class='flex space-x-1 text-sm text-gray-500'>
        <time>#{article.date.strftime('%b %e, %Y')}</time>
        <span>
          #{(article.body.length / 200.0).ceil} min read
        </span>
      </div>
    </div>
  </div>
  "

  end

  def generate_meta_tags(current_page)
    return "
    <meta name='title' content='Sponsaurus | #{current_page.data.title || data.site.title}'>
    <meta name='description' content='#{current_page.data.description || data.site.description}'>

    <!-- Open Graph / Facebook -->
    <meta property='og:type' content='website'>
    <meta property='og:url' content='#{current_page.url}'>
    <meta property='og:title' content='#{current_page.data.title || data.site.title}'>
    <meta property='og:description' content='#{current_page.data.description || data.site.description}'>
    <meta property='og:image' content='#{current_page.data.thumbnail || '/images/logo_square.png'}'>

    <!-- Twitter -->
    <meta property='twitter:card' content='summary'>
    <meta property='twitter:url' content='#{current_page.url}'>
    <meta property='twitter:title' content='#{current_page.data.title || data.site.title}'>
    <meta property='twitter:description' content='#{current_page.data.description || data.site.description}'>
    <meta property='twitter:image' content='/images/logo_square.png'>

    "
  end

end

# Standard plugins
activate :directory_indexes
activate :autoprefixer

# Development-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :development do
  activate :livereload
  activate :external_pipeline,
    name: :gulp,
    command: 'npm start',
    source: '.tmp',
    latency: 1
end


# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :sitemap, :hostname => "https://sponsaurus.com"
  activate :robots, 
  rules: [
    { user_agent: '*', allow: %w[/] }
  ],
  sitemap: 'https://sponsaurus.com/sitemap.xml'
  
  # Build TailwindCSS
  activate :external_pipeline,
            name: :gulp,
            command: 'npm run build',
            source: '.tmp',
            latency: 1
  
  ignore 'stylesheets/components/*.css'

  # minify just html and js (css causes issues)
  activate :minify_html
  # activate :minify_css
  activate :minify_javascript
end