  
#!/usr/bin/env ruby
`rspec --order default --require spec_helper --format documentation --no-color --out specs.md`
specs = open("specs.md").read

# Currently only removes the failures (when run on the NOT target
# TODO should remove successes too, when run on the target)
new_spec_content = specs.gsub(/Failures:(.|\n)*/, "").gsub(/\(FAILED - \d+\)/, "")
new_spec_content = new_spec_content.gsub(/$\n^\s\s/, " ")

top = <<~HEREDOC
<details>
  <summary>Click here to see names of each test</summary>
HEREDOC
readme = File.open("README.md", "a")
readme.write("\n")
readme.write("## Specs")
readme.write("\n")
readme.write(top)
readme.write(new_spec_content)
readme.write("</details>")
readme.close

File.delete("specs.md")
