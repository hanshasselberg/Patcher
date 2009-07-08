# Ruby OsX Application Bundle Patcher

## What for?

This tiny ruby script patches specific files in application bundles, it reads all nessecary informations from a xml file. I was tired of patching manually...


## Usage

1. Create xml file with all information, an example one is patches.xml. The structure is simple:
<pre>
\<patches>
	\<patch app="YourAppName" version="VersionNumber">
		\<file path="Contents/MacOS/HelloWorld">
			\<md5>md5 value of original file\</md5>
			\<code>
				\<original>code to patch\</original>
				\<patched>replacement\</patched>
			\</code>
		\</file>	
	\</patch>
\</patches>
</pre>
\<patches> can contain multiple \<patch>-tags, as well as \<patch> can contain more than one \<file>-tags, \<file> can contain multiple \<md5>-tags and last but not least multiple \<code>-tags.

2. Call patcher.rb with 2 parameters: $PathToApplication $PathToPatchFile

3. You are done. A backup of the patched file was automatically created, in case something went wrong. The patcher appended the suffix .orig .

## Limitations

I tested only what I needed for my stuff, so be careful.