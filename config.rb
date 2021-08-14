# Blog
activate :blog do |blog|
  blog.prefix = "blog"
  blog.permalink = "{title}.html"
  blog.sources = "{title}.html"
  blog.layout = "blog_layout"
  blog.new_article_template = File.expand_path("./source/partials/blog/_post_template.erb")
  
end

# Pretty routes
activate :directory_indexes


# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

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
        <time>#{article.date}</time>
        <span>
          #{(article.body.length / 200.0).ceil} min read
        </span>
      </div>
    </div>
  </div>
  "

  end
end

# Development-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :development do
  activate :external_pipeline,
    name: :gulp,
    command: 'npm start',
    source: '.tmp',
    latency: 1
end


# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :external_pipeline,
    name: :gulp,
    command: 'npm run build',
    source: '.tmp',
    latency: 1

  ignore 'stylesheets/components/*.css'
end


# development 
activate :livereload