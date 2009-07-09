# Ruby OsX Application Bundle Patcher

## What for?

This tiny ruby script patches specific files in application bundles, it reads all nessecary informations from a xml file. I was tired of patching manually...


## Usage

1. Create xml file with all information. The structure is simple:

<pre>
&lt;patches&gt;
	&lt;patch app="YourAppName" version="VersionNumber"&gt;
		&lt;file path="PathToFile"&gt;
			&lt;md5&gt;md5 value of original file&lt;/md5&gt;
			&lt;code&gt;
				&lt;original&gt;code to patch&lt;/original&gt;
				&lt;patched&gt;replacement&lt;/patched&gt;
			&lt;/code&gt;
		&lt;/file&gt;	
	&lt;/patch&gt;
&lt;/patches&gt;
</pre>
&lt;patches&gt; can contain multiple &lt;patch&gt;-tags, as well as &lt;patch&gt; can contain more than one &lt;file&gt;-tags, &lt;file&gt; can contain multiple &lt;md5&gt;-tags and last but not least multiple &lt;code&gt;-tags.

2. Call patcher.rb with 2 parameters: $PathToApplication $PathToPatchFile

3. You are done. A backup of the patched file was automatically created, in case something went wrong. The patcher appended the suffix .orig .

## Example

There is an example application "HelloWorld.app" and a corresponding xml-file. Feel free to test it with ./patcher.rb ./HelloWorld.app/ ./patches.xml .

## Acknowledgment

Torsten wrote the very first patch script, which inspired me to pimp it up a bit. The sample Application is taken from Andrew Nesbitt's blog: http://teabass.com/hello-world-in-cocoa/ , which was modified by me, to demonstrate how the patcher works.

## Limitations

At the moment, this script only works with ruby version 1.8.7. 
I tested only what I needed for my stuff, so be careful.