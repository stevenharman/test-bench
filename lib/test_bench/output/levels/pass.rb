module TestBench
  module Output
    module Levels
      class Pass
        include TestBench::Fixture::Output

        include Writer::Dependency

        include PrintError

        attr_accessor :previous_error

        def comment(text)
          writer
            .indent
            .text(text)
            .newline
        end

        def error(error)
          self.previous_error = error
        end

        def print_previous_error
          print_error(previous_error)

          self.previous_error = nil
        end

        def finish_test(title, result)
          unless result && title.nil?
            writer.indent

            writer.escape_code(:bold) unless result

            fg_color = result ? :green : :red

            writer
              .escape_code(fg_color)
              .text(title || 'Test')
              .escape_code(:reset_fg)

            writer.escape_code(:reset_intensity) unless result

            writer.newline
          end

          unless previous_error.nil?
            writer.increase_indentation

            print_previous_error

            writer.decrease_indentation
          end
        end

        def skip_test(title)
          title ||= 'Test'

          writer.indent

          if writer.styling?
            writer
              .escape_code(:yellow)
              .text(title)
              .escape_code(:reset_fg)
          else
            writer.text("#{title} (skipped)")
          end

          writer.newline
        end
      end
    end
  end
end
