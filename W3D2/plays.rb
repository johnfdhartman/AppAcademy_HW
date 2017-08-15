require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end

  def self.find_by_title(title)
    new_play = PlayDBConnection.instance.execute(<<-SQL, @title)
      SELECT
        *
      FROM
        plays
      WHERE
        title = ?
    SQL
    Play.new(new_play.first)
  end

  def self.find_by_playwright(name)
    pw = Playwright.find_by_name(name)
    plays_by_writer = PlayDBConnection.instance.execute(<<-SQL, @title)
      SELECT
          *
        FROM
          plays
        WHERE
          playwright_id = ?
      SQL
    plays_by_writer.map{|play| Play.new(play)}
  end
end

class Playwright

  def self.all
    data = PlayDBConnection.execute("SELECT * FROM playwrights")
    data.map {|datum| Playwright.new(datum)}
  end

  def self.find_by_name(name)
    new_pw = PlayDBConnection.instance.execute(<<-SQL, @name)
      SELECT
        *
      FROM
        playwrights
      WHERE
        name = ?
    SQL
    Playwright.new(new_pw)
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
  end

  def create
    PlayDBConnection.instance.execute(<<-SQL, @name)
      INSERT INTO
        playwrights (name)
      VALUES
        ?
    SQL
    id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    PlayDBConnection.instance.execute(<<-SQL, @name, @id)
      UPDATE
        playwrights
      SET
        name = ?
      WHERE
        id = ?
    SQL
  end

  def get_plays
    PlayDBConnection.instance.execute(<<-SQL, @name)
      SELECT
        titles
      FROM
        playwrights
      JOIN
        plays ON plays.playwright_id = playwrights.id
      WHERE
        playwrights.name = ?
    SQL
  end


end
