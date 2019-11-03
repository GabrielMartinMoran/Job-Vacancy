HOST =
  case Padrino.env
  when :development
    'http://localhost:3000'
  when :test
    ENV['HOST'] || 'http://localhost:3000'
  when :staging
    ENV['HOST']
  when :production
    ENV['HOST']
  end
