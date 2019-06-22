# require_relative '../env'
require_relative 'herald'
require_relative 'push'

DB = {
  level: nil
}

at_exit do
  puts "EXIT!"
  # push_notification "exit"
end

def notify!(level)
  puts "Level up! (push notif.)"
  push_notification "Level UP! level: #{level}"
end

loop do
  char = "makevoid"
  resp = get :char_info, name: char
  char_info = parse_single_char resp
  level = char_info.fetch :level

  notify!(level) if DB[:level] && level == DB[:level]+1
  DB[:level] = level

  sleep 60
end
