require 'json'

module TicketFinder
  class DatabaseMissing < StandardError; end
  class IndexMissing < StandardError; end
  class IncorrectDatabase < StandardError; end

  class Database

    def initialize(name)
      raise IncorrectDatabase.new unless ::TicketFinder::DATABASES.include?(name)
      @name = name
    end

    def read_db
      raise DatabaseMissing unless db_exist?
      ::JSON.parse(File.read(db_file_path))
    end

    def read_index
      raise IndexMissing unless index_exist?
      ::JSON.parse(File.read(index_file_path))
    end

    def write_index(index)
      File.open(index_file_path, 'w') { |file| file.write(index.to_json) }
    end

    def index_exist?
      File.file?(index_file_path)
    end

    def db_exist?
      File.file?(db_file_path)
    end

    private

    def index_file_path
      "#{project_root}/index/#{@name}.json"
    end

    def db_file_path
      "#{project_root}/data/#{@name}.json"
    end

    def project_root
      File.absolute_path(File.dirname(__FILE__) + '/../..')
    end

  end
end
