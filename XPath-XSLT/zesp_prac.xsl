<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match='/'>
    <html>
        <body>
            <h1>ZESPOŁY</h1>
            <table>
                <tr><th>lp</th><th></th></tr>
                <xsl:apply-templates select="//ZESPOLY/ROW" mode="lista1">
                </xsl:apply-templates>
            </table>
            <div>
                <xsl:apply-templates select="//ZESPOLY/ROW" mode="lista2">
                </xsl:apply-templates>
            </div>
        </body>
    </html>
</xsl:template>
<xsl:template match="*" mode="lista1">
<tr>
    <td><xsl:value-of select="position()"/>.</td>
    <td>
        <xsl:element name="a">
        <xsl:attribute name="href">
            #<xsl:value-of select="ID_ZESP"/>
        </xsl:attribute>

            <xsl:value-of select="NAZWA"/>
        </xsl:element>
    </td>
</tr>
</xsl:template>
<xsl:template name="getNazwisko">
    <xsl:param name="ID_PRAC" select="."/>
    <xsl:value-of select="//PRACOWNICY/ROW[ID_PRAC = $ID_PRAC]/NAZWISKO"/>
</xsl:template>
<xsl:template match="*" mode="lista2">
    <div>
        <xsl:element name="h4">
        <xsl:attribute name="id">
            <xsl:value-of select="ID_ZESP"/>
        </xsl:attribute>
            Nazwa: <xsl:value-of select="NAZWA"/>
        </xsl:element>
        <h4>ADRES: <xsl:value-of select="ADRES"/></h4>
    </div>
    <xsl:if test="count(PRACOWNICY/ROW)">
        <table border="1">
            <tr><th>Nazwisko</th><th>Etat</th><th>Zatrudniony</th><th>Płaca pod.</th><th>Id szefa</th></tr>
            <xsl:for-each select="PRACOWNICY/ROW">
                <xsl:sort select="NAZWISKO"/>
                <tr>
                    <td><xsl:value-of select="NAZWISKO"/></td>
                    <td><xsl:value-of select="ETAT"/></td>
                    <td><xsl:value-of select="ZATRUDNIONY"/></td>
                    <td><xsl:value-of select="PLACA_POD"/></td>
                    <td>
                        <xsl:choose>
                            <xsl:when test="ID_SZEFA">
                                <xsl:call-template name="getNazwisko">
                                    <xsl:with-param name="ID_PRAC"
                                                    select="ID_SZEFA"/>
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                                BRAK
                            </xsl:otherwise>
                        </xsl:choose>

                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:if>
    Liczba pracowników: <xsl:value-of select="count(PRACOWNICY/ROW)"/>
</xsl:template>
</xsl:stylesheet>