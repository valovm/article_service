class ArticleService

  def build(articles, news, cols = 3)
    init articles, news, cols
    schema.transpose
  end

  private

  def init(articles, news, cols)
    @articles = articles
    @news = news
    @cols = cols
    @n_index = 0
    @a_index = 0
  end

  def schema
    a_pos = 0
    size = @articles.size + @news.size - 1

    return (0..size).step(@cols).map do
      row = (0..@cols - 1).map do |i|
        type_material = i == a_pos ? :article : :new
        get_material type_material
      end
      a_pos = a_pos >= @cols - 1 ? 0 : a_pos + 1
      row
    end
  end

  def get_material(priority_type)
    case priority_type
    when :article
      current_article || current_new
    when :new
      current_new || current_article
    end
  end

  def current_article
    res = @articles[@a_index]
    @a_index += 1

    res
  end

  def current_new
    res = @news[@n_index]
    @n_index += 1

    res
  end
end
