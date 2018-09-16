<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:foo="http://www.foo.org/" xmlns:bar="http://www.bar.org">
<xsl:template match="QPXResultSet">
  <html>
  <body>
    <h2>ITA Solutions</h2>
    <table border="0">
      <tr bgcolor="#9acd32">
        <th>DisplayTotal</th>
        <th>FareInfos</th>
        <th>BookingCode</th>
        <th>CabintType</th>
        <th>Origin</th>
        <th>Destination</th>
        <th>DepartureTime</th>
        <th>CarrierCode</th>
        <th>FlightNumber</th>
      </tr>
      <xsl:for-each select="Solution">
        <xsl:variable name="TripLinkID" select="TripLink/@objectID"/>
        <xsl:variable name="TripInfo" select="/QPXResultSet/ResultSetHeader/SharedObjectDatabase/TripInfo[@objectID=$TripLinkID]"/>
        <xsl:variable name="SliceItineraryLinkID" select="$TripInfo/SliceItineraryLink[@sliceIndex='0']/@objectID"/>
        <xsl:variable name="SliceItineraryInfo" select="/QPXResultSet/ResultSetHeader/SharedObjectDatabase/SliceItineraryInfo[@objectID=$SliceItineraryLinkID]"/>
        <xsl:variable name="SegmentLinkID" select="$SliceItineraryInfo/SegmentLink/@objectID"/>
        <xsl:variable name="SegmentInfo" select="/QPXResultSet/ResultSetHeader/SharedObjectDatabase/SegmentInfo[@objectID=$SegmentLinkID]"/>
        <xsl:variable name="LegLinkID" select="$SegmentInfo/LegLink/@objectID"/>
        <xsl:variable name="LegInfo" select="/QPXResultSet/ResultSetHeader/SharedObjectDatabase/LegInfo[@objectID=$LegLinkID]"/>
        <xsl:variable name="DepartureTime" select="$LegInfo/DepartureTime"/>
        <xsl:sort select="TripLink/@objectID"/>
        <tr>
          <td><xsl:value-of select="DisplayTotal"/></td>
          <td>
            <xsl:for-each select="PaxPricingInfo/FareLink">
                <xsl:variable name="FareLinkObjectID" select="./@objectID" />
                <xsl:variable name="FareInfo" select="/QPXResultSet/ResultSetHeader/SharedObjectDatabase/FareInfo[@objectID=$FareLinkObjectID]"/>
                <xsl:value-of select="concat($FareInfo/City1, '/', $FareInfo/City2, '/', $FareInfo/BasePrice, '/', $FareInfo/@record1FareType)" /> <br />
                <!--xsl:value-of select="$FareInfo/City1" />/<xsl:value-of select="$FareInfo/City2" />/<xsl:value-of select="$FareInfo/BasePrice" />/<xsl:value-of select="$FareInfo/@record1FareType" /><br /-->
            </xsl:for-each>
          </td>
          <td><xsl:value-of select="PaxPricingInfo/BookingInfo/BookingCode"/></td>
          <td><xsl:value-of select="PaxPricingInfo/BookingInfo/CabinType"/></td>
          <td><xsl:value-of select="$LegInfo/OriginAirport" /></td>
          <td><xsl:value-of select="$LegInfo/DestinationAirport" /></td>
          <td><xsl:value-of select="$DepartureTime" /></td>
          <td><xsl:value-of select="$LegInfo/FlightCode/CarrierCode" /></td>
          <td><xsl:value-of select="$LegInfo/FlightCode/FlightNumber" /></td>
        </tr>
      </xsl:for-each>
    </table>
  </body>
  </html>
</xsl:template>
</xsl:stylesheet>