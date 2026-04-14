#!/usr/bin/env ruby

# Release script to upload your game to itch.io.
# Requires Ruby and the itch.io `butler` CLI to be installed.

require "fileutils"

pdxinfo = File.read("source/pdxinfo").chomp
  .split("\n")
  .reject { |l| l.strip.empty? || l.start_with?("#") }
  .map { |l| l.split("=", 2) }.to_h
game_name = pdxinfo["name"]
version = pdxinfo["version"]
build_number = pdxinfo["buildNumber"]
itch = pdxinfo["itch"]
id = "#{version} (#{build_number})"

puts("Preparing to release #{game_name} #{id}...")
abort("itch key not specified in source/pdxinfo, can't release") if itch.nil?
abort("butler not installed or not in path") unless system("butler --version")
# Remove this safety check if you don't want it
abort("pdxinfo's version ends in -dev! can't release a dev version") if version.include?("-dev")
print "Did you update the version, build number, and tag in git? (y/n): "
answer = gets.chomp
abort("Bump the verison first!") if (answer != "y")
puts "Compiling release build #{id}..."
abort("Clean failed") unless system("just clean")
abort("Release build failed") unless system("just build")

zip_name = "#{game_name}.pdx.zip"
archive_name = "#{game_name}-v#{version}-b#{build_number}.pdx.zip"
system("rm -f #{zip_name}")
abort("Zip failed") unless system("zip -r #{zip_name} #{game_name}.pdx")

puts "Pushing Playdate build to itch.io..."
abort("Push to itch.io failed") unless system("butler push #{zip_name} #{itch}:playdate --userversion #{version}")

FileUtils.mkdir_p("builds")
FileUtils.cp(zip_name, "builds/#{archive_name}")
puts "Archived to builds/#{archive_name}"
puts "Released #{id} to itch.io!"
