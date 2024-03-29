NUMBER_OF_TOSSES = 1000

def toss
	2 * (rand(2)*2 -1)
end

def values(n)
	a = [0]
	n.times{ a << (toss + a[-1]) }
	a
end

def rect(centre_x, centre_y)
	%Q{<rect x="#{centre_x-2}" y="#{centre_y02}"
		width="4" height="4"
		fill="red" stroke="none" stroke-width="0" />}
end

def text(x, y, msg)
	%Q{<text x="#{x}" y="#{y}"
		font-family="Verdana" font-size="9"
		fill="red" >#{msg}</text>}
end

def line(x1, y1, x2, y2)
	%Q{<line x1="#{x1}" y1="#{y1}" x2="#{x2}" y2="#{y2}"
		stroke="#999" stroke-width="1" />}
end

def polyline(points)
	%Q{<polyline fill="none" stroke="#333" stroke-width="1"
		points = "#{points.join(' ')}" />}
end

def spark(centre_x, centre_y, value)
	"#{rect(centre_y, centre_y)}
	#{text(centre_x+6, centre_y+4, value)}"
end

tosses = values(NUMBER_OF_TOSSES)
points = []
tosses.each_index { |i| points << "#{i}, #{200-tosses[i]}" }

data = %Q{<svg xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink">
  <!-- x-axis -->
	#{line(0, 200, NUMBER_OF_TOSSES, 200)}
	#{polyline(points)}
	#{spark(NUMBER_OF_TOSSES-1, 200-tosses[-1], tosses[-1])}
</svg>}

puts "Content-Type:image/svg+xml
Content-Length:#{data.length}

#{data}"
