<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <xsl:template match="/">
"Repository","Title","Call No.","Language(s)","Origin","Date","CompuDate","Place","Subject","Genre","Front Cover","Navigation","Data","Ebook","Page Turning","Record","Video"<xsl:for-each select="collection(iri-to-uri('../../../Documents/openn/msDesc/WaltersMsDesc/?select=*.xml;recurse=yes'))">
            <xsl:variable name="repository" select="//tei:repository"/>
            <xsl:variable name="title" select="//tei:msContents/tei:msItem[1]/tei:title[@type='work']"/>
            <xsl:variable name="quot">"</xsl:variable>
            <xsl:variable name="doubleQuot">""</xsl:variable>
            <xsl:variable name="callNo" select="concat(//tei:msIdentifier/tei:repository,' ',//tei:msIdentifier/tei:idno)"/>
            <xsl:variable name="lang" select="//tei:textLang"/>
            <xsl:variable name="origin" select="//tei:origin/tei:p"/>
            <xsl:variable name="date" select="//tei:origin/tei:origDate"></xsl:variable>
            <xsl:variable name="place" select="//tei:origin/tei:origPlace"></xsl:variable>
            <xsl:variable name="subjects"><xsl:for-each select="//tei:keywords[@scheme='#keywords']/tei:list/tei:item"><xsl:value-of select="."/>;</xsl:for-each></xsl:variable>
    <xsl:variable name="genres">
        <xsl:for-each select="//tei:catRef">
            <xsl:variable name="genre" select="translate(@target,'#','')"/>
            <xsl:value-of select="//tei:category[@xml:id=$genre]/tei:catDesc"/>;</xsl:for-each>
    </xsl:variable>
    <xsl:variable name="WNo" select="tokenize(translate(document-uri(.),'_tei.xml',''),'/') [position() = last()]"/>
            <xsl:variable name="idno"><xsl:choose>
                <xsl:when test="matches(//tei:idno,'W.555') or matches(//tei:idno,'W.559') or matches(//tei:idno,'W.582') or matches(//tei:idno,'W.583') or matches(//tei:idno,'W.585') or matches(//tei:idno,'W.589') or matches(//tei:idno,'W.591') or matches(//tei:idno,'W.596') or matches(//tei:idno,'W.615') or matches(//tei:idno,'W.658')"><xsl:value-of select="translate(//tei:idno,'.','')"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="//tei:idno"/></xsl:otherwise>
            </xsl:choose></xsl:variable>
            <xsl:variable name="path">http://www.thedigitalwalters.org/Data/WaltersManuscripts/</xsl:variable>
            <xsl:variable name="cover" select="//tei:surface[1]/tei:graphic[contains(@url,'sap')]/@url"/>
            <xsl:variable name="WNav" select="concat($path,'html/',$WNo)"/>
            <xsl:variable name="WData" select="concat($path,$WNo,'/data/')"/>
            <xsl:variable name="ebook" select="concat('http://dorpdev.library.upenn.edu/ebooks/',$WNo,'.epub')"/>
            <xsl:variable name="pageTurn" select="concat('http://dorpdev.library.upenn.edu/BookReaders/',$WNo,'/index.html#page/1/mode/2up')"/>
            <xsl:variable name="record" select="concat($path,'html/',$WNo)"/>
            <xsl:variable name="video"></xsl:variable>
"<xsl:value-of select="$repository"/>","<xsl:value-of select="replace($title,$quot,$doubleQuot)"/>","<xsl:value-of select="$callNo"/>","<xsl:if test="not($lang)">None noted</xsl:if><xsl:value-of select="$lang"/>","<xsl:if test="not($origin)">None noted</xsl:if><xsl:value-of select="$origin"/>","<xsl:if test="not($date)">None noted</xsl:if><xsl:value-of select="$date"/>","<xsl:if test="not($place)">None noted</xsl:if><xsl:value-of select="$place"/>","<xsl:if test="not($subjects)">None noted</xsl:if><xsl:value-of select="$subjects"/>","<xsl:if test="not($genres)">None noted</xsl:if><xsl:value-of select="$genres"/>","<xsl:value-of select="concat($path,$WNo,'/','data','/',$idno,'/',$cover)"></xsl:value-of>","<xsl:value-of select="$WNav"/>","<xsl:value-of select="$WData"/>","<xsl:value-of select="$ebook"/>","<xsl:value-of select="$pageTurn"/>","<xsl:value-of select="$record"/>",""</xsl:for-each>    
    </xsl:template>
    
</xsl:stylesheet>