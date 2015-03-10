#!/usr/bin/env ruby

require 'csv'
require 'nokogiri'

# <xsl:variable name="institution" select="//tei:institution"/>
# <xsl:variable name="repository" select="//tei:repository"/>
# <xsl:variable name="title" select="//tei:msContents/tei:msItem[1]/tei:title"/>
# <xsl:variable name="callNo" select="concat(//tei:msIdentifier/tei:institution,' ',//tei:msIdentifier/tei:idno[@type='call-number'])"/>
# <xsl:variable name="lang" select="//tei:textLang"/>
# <xsl:variable name="origin" select="//tei:origin/tei:p"/>
# <xsl:variable name="date" select="//tei:origin/tei:origDate"/>
# <xsl:variable name="place" select="//tei:origin/tei:origPlace"></xsl:variable>
# <xsl:variable name="subjects"><xsl:for-each select="//tei:keywords[@n='subjects']/tei:term"><xsl:value-of select="."/>;</xsl:for-each></xsl:variable>
# <xsl:variable name="genres"><xsl:for-each select="//tei:keywords[@n='form/genre']/tei:term"><xsl:value-of select="."/>;</xsl:for-each></xsl:variable>
# <xsl:variable name="ljsNo" select="tokenize(translate(document-uri(.),'_TEI.xml',''),'/') [position() = last()]"/>
# <xsl:variable name="path">http://openn.library.upenn.edu/Data/LJSchoenbergManuscripts/</xsl:variable>
# <xsl:variable name="cover" select="//tei:surface[1]/tei:graphic[contains(@url,'web')]/@url"/>
# <xsl:variable name="opennNav" select="concat($path,'html/','l',$ljsNo,'.html')"/>
# <xsl:variable name="opennData" select="concat($path,'l',$ljsNo,'/data/')"/>
# <xsl:variable name="ebook" select="concat('http://dorpdev.library.upenn.edu/ebooks/l',$ljsNo,'.epub')"/>
# <xsl:variable name="pageTurn" select="concat('http://dorpdev.library.upenn.edu/BookReaders/l',$ljsNo,'/index.html#page/1/mode/2up')"/>
# <xsl:variable name="record" select="//tei:altIdentifier[@type='resource']/tei:idno"/>
# <xsl:variable name="video"></xsl:variable>

# opennNav:    "concat($path,'html/','l',$ljsNo,'.html')",
# opennData:   "concat($path,'l',$ljsNo,'/data/')",
# ljsNo:       "tokenize(translate(document-uri(.),'_TEI.xml',''),'/') [position() = last()]",
# ebook:       "concat('http://dorpdev.library.upenn.edu/ebooks/l',$ljsNo,'.epub')",
# pageTurn:    "concat('http://dorpdev.library.upenn.edu/BookReaders/l',$ljsNo,'/index.html#page/1/mode/2up')",

# "<xsl:value-of select="concat($institution,' ',$repository)"></xsl:value-of>"
# "<xsl:value-of select="translate($title,'&quot;','&quot;&quot;')"/>"
# "<xsl:value-of select="$callNo"/>"
# "<xsl:if test="not($lang)">None noted</xsl:if><xsl:value-of select="$lang"/>"
# "<xsl:if test="not($origin)">None noted</xsl:if><xsl:value-of select="$origin"/>"
# "<xsl:if test="not($date)">None noted</xsl:if><xsl:value-of select="$date"/>"
# "<xsl:if test="not($place)">None noted</xsl:if><xsl:value-of select="$place"/>"
# "<xsl:if test="not($subjects)">None noted</xsl:if><xsl:value-of select="$subjects"/>"
# "<xsl:if test="not($genres)">None noted</xsl:if><xsl:value-of select="$genres"/>"
# "<xsl:value-of select="concat($path,'l',$ljsNo,'/','data','/',$cover)"></xsl:value-of>"
# "<xsl:value-of select="$opennNav"/>"
# "<xsl:value-of select="$opennData"/>"
# "<xsl:value-of select="$ebook"/>"
# "<xsl:value-of select="$pageTurn"/>"
# "<xsl:value-of select="$record"/>"
# ""


path  = 'http://openn.library.upenn.edu/Data/LJSchoenbergManuscripts'

ns = { tei: 'http://www.tei-c.org/ns/1.0' }

xpaths = {
          institution: "//tei:institution",
          repository:  "//tei:repository",
          title:       "//tei:msContents/tei:msItem[1]/tei:title",
          callNo:      "//tei:msIdentifier/tei:idno[@type='call-number']",
          lang:        "//tei:textLang",
          origin:      "//tei:origin/tei:p",
          date:        "//tei:origin/tei:origDate",
          place:       "//tei:origin/tei:origPlace",
          subjects:    "//tei:keywords[@n='subjects']/tei:term",
          genres:      "//tei:keywords[@n='form/genre']/tei:term",
          cover:       "//tei:surface[1]/tei:graphic[contains(@url,'web')]/@url",
          record:      "//tei:altIdentifier[@type='resource']/tei:idno",
         }

def check_blank s
  if s.nil? || s.strip.size == 0 
    "Not Noted"
  else
    s.strip
  end
end

# create a new csv file
CSV.open "output.csv", "wb" do |csv|
  # add the header row
  csv << [ "Repository","Title","Call No.","Language(s)","Origin","Date","Place","Subject","Genre","Front Cover","OPenn Navigation","OPenn Data","Ebook","Page Turning","Record","Video" ]

  # read each argument; each should be a file
  ARGV.each do |arg|
    # read the file and parse
    xml = Nokogiri::XML(File.read(arg))

    # data_hash to hold all our values
    data_hash = {}
    xpaths.each do |k,v|
      data_hash[k] = xml.xpath(v, ns).text
    end

    # data for each row goes in an array called row
    row = []
    # repo
    row << "#{data_hash[:instituion]} #{data_hash[:repository]}"

    # title
    row << data_hash[:title]

    # call no.
    row << "#{data_hash[:instituion]} #{data_hash[:callNo]}"

    # language
    row << check_blank(data_hash[:lang])

    # "Origin"
    row << check_blank(data_hash[:origin])

    # "Date"
    row << check_blank(data_hash[:date])

    # "Place"
    # "Subject"
    # "Genre"
    # "Front Cover"
    # "OPenn Navigation"
    # "OPenn Data"
    # "Ebook"
    # "Page Turning"
    # "Record"
    # "Video"

    # add the row
    csv << row
  end
end
