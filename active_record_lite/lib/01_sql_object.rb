require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @column if @column

    cols = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        "#{self.table_name}"
      LIMIT
        0
    SQL

    cols[0].map!(&:to_sym)
    @column = cols[0]
  end

  def self.finalize!
    self.columns.each do |name|
      define_method(name) do
        self.attributes[name]
      end

      define_method("#{name}=") do |value|
        self.attributes[name] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    "#{self.to_s.downcase}s"
  end

  def self.all
    table = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        "#{self.table_name}"
    SQL
    table[1..-1]
  end

  def self.parse_all(results)

  end

  def self.find(id)
    table = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        "#{self.table_name}"
    SQL

    table[1+id]
  end

  def initialize(params = {})

  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    
  end

  def insert
    DBConnection.execute2(<<-SQL)

    SQL
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
