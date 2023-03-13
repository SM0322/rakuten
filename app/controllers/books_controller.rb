class BooksController < ApplicationController
  def index
    @books = Book.all
  end
  
  def show
    @book = Book.find(params[:id])
    @review = Review.new
    @reviews = @book.reviews.all
  end
  
  def new
    @books = []
    @title = params[:title]
    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title,
        booksGenreId: '001004',
        hits: 20,
      })

      results.each do |result|
        book = Book.new(read(result))
        @books << book
      end
    end
  end
  
  def create
    @book = Book.find_or_initialize_by(isbn: params[:isbn])

    unless @book.persisted?
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)
      @book = Book.new(read(results.first))
      @book.save
      redirect_to books_path
    end
  end
  
  private
  
  def read(result)
    title = result['title']
    url = result['itemUrl']
    isbn = result['isbn']
    image_url = result['mediumImageUrl'].gsub('?_ex=120x120', '')
    {
      title: title,
      url: url,
      isbn: isbn,
      image_url: image_url,
    }
  end
end
