module ApplicationHelper
	def check_admin
		if current_user.present? and current_user.admin
			true
		else
			false
		end
	end
	def number_convert(number)
		 number_to_human(number, :format => '%n%u', :precision => 2, :units => { :thousand => 'K', :million => 'M', :billion => 'B' })
	end
end
