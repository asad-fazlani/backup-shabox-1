namespace :my_namespace do
  desc "TODO"
  task set_username: :environment do
    User.all.each do |user|
      #check user name present or not
      if user.username.present?
        validation = /\A[a-z0-9_]{4,16}\z/
        if (user.username =~ validation).present?

         user.update_attribute(:username ,user.username.downcase.delete(' '))
       else
        if user.display_name.present?
          user.update_attribute(:username, user.display_name.downcase.delete(' '))
        else
          if user.email[0,4].include?('@')
            user.update_attribute(:username ,user.email[0,4].gsub!(/[@]/,''))
          else
            user.update_attribute(:username ,user.email[0,4])
          end
        end
      end
    else
        # debugger
        validation = /\A[a-z0-9_]{4,16}\z/
        if (user.username =~ validation).present?

         user.update_attribute(:username ,user.username.downcase.delete(' '))
       else
        if user.display_name.present?
          user.update_attribute(:username, user.display_name.downcase.delete(' '))
        else
          if user.email[0,4].include?('@')
            user.update_attribute(:username ,user.email[0,4].gsub!(/[@]/,''))
          else
            user.update_attribute(:username ,user.email[0,4])
          end
        end
      end
    end
    
  end
end

end
