<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output encoding="UTF-8" method="text" version="1.0" indent="yes"/>
  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="matroska_tagging_registry">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="class">
    <xsl:text>## </xsl:text>
    <xsl:value-of select="@name"/>
    <xsl:text>&#xa;&#xa;</xsl:text>
    <xsl:value-of select="description"/>
    <xsl:text>&#xa;&#xa;</xsl:text>
    <!-- markdown table header -->
    <xsl:text>Tag Name             | Type   | Description&#xa;</xsl:text>
    <xsl:text>:--------------------|:-------|:-----------&#xa;</xsl:text>
    <xsl:variable name="thisclass">
      <xsl:value-of select="@name"/>
    </xsl:variable>
    <xsl:for-each select="../../tags/tag[@class=$thisclass]">
      <!-- build markdown table with whitespace padding for alignment -->
      <xsl:variable name="titlewidth">22</xsl:variable>
      <xsl:variable name="typewidth">8</xsl:variable>
      <xsl:value-of select="@name"/>
      <xsl:value-of select="substring('                                          ',0,$titlewidth - string-length(@name))"/>
      <xsl:text>| </xsl:text>
      <xsl:value-of select="@type"/>
      <xsl:value-of select="substring('                                          ',0,$typewidth - string-length(@type))"/>
      <xsl:text>| </xsl:text>
      <xsl:value-of select="description"/>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>
  <xsl:template match="text()"/>
</xsl:stylesheet>
