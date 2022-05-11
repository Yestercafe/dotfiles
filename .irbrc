# Pretty Print method
require 'pp'

# Automatic Indentation
IRB.conf[:AUTO_INDENT]=true

# Tab Completion
require 'irb/completion'

# Prompt
IRB.conf[:PROMPT][:RVM] = {
  :PROMPT_I => "%N(%m):%03n:%i> ",
  :PROMPT_S => "%N(%m):%03n:%i%l ",
  :PROMPT_C => "%N(%m):%03n:%i* ",
  :RETURN => "%s\n" # used to printf
}

# Optimize structured data prompt
# require 'pp'
# require 'awesome_print'
# module IRB
#   class Irb
#     def output_value
#       pp @context.last_value
#     end
#   end
# end

