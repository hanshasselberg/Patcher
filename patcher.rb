#!/usr/bin/env ruby1.8.7
require 'rexml/document'

def patch patch, app_dir
  patch.elements.each('file') do |file|
    file_path = app_dir.path + "/" + file.attributes["path"]
    # backup original
    call = "cp " + file_path.gsub(" ", "\\ ") + " " + 
      file_path.gsub(" ", "\\ ") + ".orig"
    system(call)
    
    file_content = File.read(file_path)
    
    file.elements.each("code") do |code|
      gen_string = proc do |i, chr|
        i + chr.to_i(16).chr
      end
      
      old_code = code.elements["original"].text.split(" ").inject('', &gen_string)
      new_code = code.elements["patched"].text.split(" ").inject('', &gen_string)
    
      offset = file_content.index(old_code)

      if offset != nil
        new_code.bytes.each_with_index do |char, i|
          file_content[offset+i] = char
        end
      else
        p "old Code was not found and not patched."
      end

      File.open(file_path, 'wb') do |file|
        file.write(file_content)
      end
    end
  end
  p "Patch'd."
end

app_path = $*[0]
patch_path = $*[1]

raise "Usage #{$0} <executable> <patch>" if app_path.nil? or patch_path.nil?

app_dir = Dir.new(app_path)
app_name = app_dir.path.split("/").last.split(".").first

patch_content = File.read(patch_path)

patches_xml, patches = REXML::Document.new(patch_content), []

# collect patches for this application
patches_xml.elements.each('patches/patch') do |patch|
  patches << patch if patch.attributes["app"] == app_name
end

p "Didn't found any patches." if patches.size == 0

# compare md5's and select one patch if possible.
patches.each do |patch|
  md5_success = false;
  patch.elements.each('file') do |file|
    file_md5 = 
    `md5 '#{app_dir.path + "/" + file.attributes["path"]}'`[/= ([a-f0-9]+)$/, 1]
    file.elements.each('md5') do |md5|
      md5_success = true if md5.text == file_md5        
    end
  end
  # take the patch, when md5_error equal false
  if md5_success == true
    patch patch, app_dir
    break
  end
  p "Patch for version " + patch.attributes["version"] + " didn't match :(."
end
