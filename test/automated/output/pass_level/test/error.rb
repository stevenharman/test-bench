require_relative '../../../automated_init'

context "Output" do
  context "Pass Level" do
    context "Test" do
      context "Error" do
        output = Output::Levels::Pass.new

        error = Controls::Error.example

        control_fixture = Controls::Fixture.example(output)

        control_fixture.instance_exec do
          test "Error example #1" do
            raise error
          end

          test "Passing example" do
            #
          end
        end

        test do
          assert(output.writer.written?(<<~TEXT))
          Finished test "Error example #1" (Result: failure)
          #{Controls::Error::Text.example(indentation_depth: 1).chomp}
          Finished test "Passing example" (Result: pass)
          TEXT
        end
      end
    end
  end
end
