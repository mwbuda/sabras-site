class MainController < ApplicationController
	
	class Section
		attr_reader :id, :title, :order
			
		def initialize(id,title, ord)
			@id = id
			@title = title
			@order = ord
		end
		
		def <=>(other)
			self.order <=> other.order
		end
	end
	
	def self.defineSection(id, title)
		@sections = [] if @sections.nil?
		@sections << Section.new(id,title, @sections.size)
	end
	
	def self.sections()
		@sections
	end
	
	defineSection(:home, 'Home')
	defineSection(:about, 'About')
	defineSection(:contact, 'Contact Us')
	defineSection(:offerings, 'Products & Services')
	defineSection(:careers, 'Careers')
	defineSection(:testimonial, 'Testimonial')
	
	def view
		Rails.logger.debug(self.class.sections.size)
		@sections = self.class.sections.sort
	end
	
		
end