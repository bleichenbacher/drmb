# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

require 'nanoc/cachebuster'

include Nanoc::Helpers::CacheBusting


module PostHelper
  def get_pretty_date(post)
    attribute_to_time(post[:created_at]).strftime('%-d.%m.%Y')
  end

  def get_post_start(post)
    content = post.compiled_content
    if content =~ /\s<!-- more -->\s/
      content = content.partition('<!-- more -->').first +
      "<div class='read-more'><a href='#{post.path}'>Weiter lesen &rsaquo;</a></div><br>"
    end
    return content
  end

end

include PostHelper

