<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : fichePatient.xsl
    Created on : 16 novembre 2021, 18:43
    Author     : zaettal
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <html>
            <head>
                <title>fichePatient </title>
            </head>
            <body>
                <h1><xsl:value-of select="/patient/nom"/>&#160;<xsl:value-of select="/patient/prénom"/></h1>
                <p>
                    <xsl:value-of select="/patient/sexe"/><br/>
                    <xsl:value-of select="/patient/naissance"/><br/> 
                    <xsl:value-of select="/patient/numéroSS"/><br/> 
                </p>
                <address>
                    <xsl:value-of select="concat(/adresse/numéro,' ')"/>
                    <xsl:value-of select="/adresse/rue"/>&#160;
                    <xsl:value-of select="/adresse/codePostal"/>&#160;
                    <xsl:value-of select="/adresse/ville"/>
                    <br/>
                </address>
                <table>
                    <thead>
                        <tr>
                            <th>
                                Date
                            </th>
                            <th>
                                Libellé
                            </th>
                            <th>
                                Intervenant
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <!--<xsl:apply-templates select="//visite"/>-->
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
    
    <!--
    <xsl:template match="visite">
        <tr>
            <td><xsl:value-of select="@date"/></td>
            <td><xsl:apply-templates select="acte"/></td>
            <td>
                <xsl:value-of select="intervenant/nom"/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="acte">
        <xsl:value-of select="text()"/>
    </xsl:template>-->
</xsl:stylesheet>
