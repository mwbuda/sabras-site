

module SabrasLayoutHelper
	
	include ActionView::Helpers::TagHelper
	
	def pageRow(id = nil, &rowContent)
		opts = {:class => 'row'}
		opts[:id] = id unless id.nil?
		
		content_tag(:div, content_tag(:div, capture(&rowContent)), opts)
	end
	
	def contentSection(id, sectid = nil, &sectionContent)
		pageRow(sectid) do 
			content_tag(:div, capture(&sectionContent), :id => id, :class => 'panel')
		end
	end
	
	def contentSectionShowHide(btnId, contentId, title, cssClass)
		content_tag(:a, title, {
			:id => btnId,
			:href => '#',
			:class => cssClass,
			:onclick => "showHide('#{contentId}'); return false;"
		}) 
	end
end

