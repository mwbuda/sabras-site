
LogLevel = :debug

def index(*levels)
	result = {}
	i = 0
	levels.each {|level| result[level] = i ; i+= 1}
	result
end
	
LogLevels = index(
	:debug,
	:info,
	:warn,
	:error,
	:fatal,
	:unknown
)


Rails.logger.level = LogLevels[LogLevel]