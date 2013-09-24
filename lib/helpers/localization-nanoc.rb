module Nanoc::Helpers

  # TODO document
  #
  # Requires language_code_of(item) and canonical_identifier_of(item) to be implemented.
  module Localization

	    # TODO document
	    def items_in(language_code)
	      all_items.select { |i| language_code_of(i) == language_code }
	    end

	    # TODO document
	    #def translations_of(item)
	     # all_items.select { |i| !language_code_of(i).nil? && canonical_identifier_of(i) == canonical_identifier_of(item) && i.path != item.path }
	    # end
	
	    # TODO document
	    #def translation_of(item, params={})
	    #  translations_of(item).find { |i| language_code_of(i) == params[:in] }
	    #end
	    def translations_of(item)
		  @items.select do |i| 
		    i[:canonical_identifier] == item[:canonical_identifier]
		  end
		end

		# Language names in English
		LANGUAGE_CODE_TO_NAME_MAPPING = {
		'en' => 'English',
		'de' => 'Deutsch', 
		'fr' => 'Français'
		}
		
	

	
		# Returns the language_code attribute, or, if the former is nil, the
		# language code derived from the path.
		
		def language_code_of(item)
		# "/en/foo/" becomes "en"
		  #item.language_code || (item.path.match(/^\/(..)\//) || [])[1] 
		    (item.identifier.match(/^\/([a-z]{2})\//) || [])[1]
		end
		
		# Returns the item_id attribute of the given item.
		def canonical_identifier_of(item)
		  
		  item[:item_id]
		end
		

	
		def language_name_of(item)
		  if item[:canonical_identifier] != '' then
		    language_name_for_code(language_code_of(item))
		  end
		end
	
		def language_name_for_code(code)
			LANGUAGE_CODE_TO_NAME_MAPPING[code]
		end

  	  	
	  # Returns all articles in the given language
	  def articles_in(lang)
	    items_in(lang).select { |p| p.kind == 'article' }.sort_by { |a| a.created_at }.reverse
	  end


  end

end
