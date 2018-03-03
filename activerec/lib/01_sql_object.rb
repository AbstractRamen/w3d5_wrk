require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject


  def self.columns
    # ...
   return @columns if @columns
   col = DBConnection.execute2(<<-SQL)
    SELECT
      *
    FROM
      #{self.table_name}
    LIMIT
      0
   SQL
   @columns = col.first.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |unit|
      define_method(unit) do
        self.attributes[unit]
      end

      define_method("#{unit}=") do |val|
        self.attributes[unit] = val
      end
    end
  end

  def self.table_name
    # ...
    @table_name ||= self.to_s.tableize
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end


  def self.all
    # ...
    # DBConnection.execute(<<-SQL, self.table_name)
    #   SELECT
    #     *
    #   FROM
    #     (#{self.table_name})
    # SQL

  end

  def self.parse_all(results)
    # ...
    results.each do |k, v|
      params = {}
      self.new(params)
    end

  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
    params.each do |k,v|
      k = k.to_sym
      if self.class.columns.include?(k)
        self.send("#{k}=", v)
      else
        raise "unknown attribute '#{k}'"
      end
    end
  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
