<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:catESAD_cu="urn:customs.ru:CUESADCommonAggregateTypesCust:5.17.0" xmlns:cat_ru="urn:customs.ru:CommonAggregateTypes:5.10.0" xmlns:esif="urn:customs.ru:Information:CustomsDocuments:ESADInfo:5.17.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:output encoding="UTF-8" indent="yes" method="html" version="1.0"/>
   <xsl:template name="russian_date">
      <xsl:param name="dateIn"/>
      <xsl:choose>
         <xsl:when test="substring($dateIn,5,1)='-' and substring($dateIn,8,1)='-'">
            <xsl:value-of select="substring($dateIn,9,2)"/>.<xsl:value-of select="substring($dateIn,6,2)"/>.<xsl:value-of select="substring($dateIn,1,4)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$dateIn"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="sub_time">
      <xsl:param name="timeLn"/>
      <xsl:choose>
         <xsl:when test="substring($timeLn,11, 1)='Z' ">
            <xsl:value-of select="substring($timeLn, 1, 8)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$timeLn"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="ddmmyy">
      <xsl:param name="reg"/>
      <xsl:choose>
         <xsl:when test="substring($reg,5,1)='-' ">
            <xsl:value-of select="substring($reg,9,2)"/>
            <xsl:value-of select="substring($reg,6,2)"/>
            <xsl:value-of select="substring($reg,3,2)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$reg"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="/">
      <xsl:apply-templates/>
   </xsl:template>
   <xsl:template match="esif:ESADInfo">
      <html>
         <head>
            <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
            <title>Данные декларации на товары</title>
            <style type="text/css">
						.page {
							width: 210mm;
							/*height: 297mm;*/
							margin-top: 6pt;
							margin-bottom: 6pt;
							padding: 10mm;
							padding-left: 20mm;
							background: #ffffff;
							border: solid 1pt #000000;
						}
						
						.page1 {
							width: 297mm;
							/*height: 297mm;*/
							margin-top: 6pt;
							margin-bottom: 6pt;
							padding: 10mm;
							/*padding-left: 20mm;*/
							background: #ffffff;
							border: solid 1pt #000000;
						}
						
						.space {
							width: 30px;
						}
						
						.spec_column {
							border-bottom: 0px; 
							border-left:0px; 
							border-right:0px; 
							font-size: 10pt;
						}
						
						.header {
							font-weight: bold;
						}
						
						.docs td {
							padding:5px
						}
						
						.goods tr td {
							vertical-align: top;
							padding: 5px;
						}
                   </style>
         </head>
         <body>
            <div class="page">
               <h2 align="center">Сведения из ЭДТ</h2>
               <span>Регистрационный номер декларации на товары/таможенной декларации: </span>
               <span style="width:30px"/>
               <span>
                  <xsl:value-of select="esif:GTDID/cat_ru:CustomsCode"/>
                  <xsl:text>/</xsl:text>
				  <xsl:call-template name="ddmmyy">
                     <xsl:with-param name="reg" select="esif:GTDID/cat_ru:RegistrationDate"/>
                  </xsl:call-template>
                  <xsl:text>/</xsl:text>
				  <xsl:value-of select="esif:GTDID/cat_ru:GTDNumber"/>
               </span>
               <!-- Грузоотправитель -->
               <p class="header">Грузоотправитель</p>
               <xsl:apply-templates select="esif:Consignor"/>
               <!-- Грузополучатель -->
               <p class="header">Грузополучатель</p>
               <xsl:apply-templates select="esif:Consignee"/>
               <!--Документ, подтверждающий совершение внешнеэкономической сделки-->
               <xsl:if test="esif:SupportingDocuments">
				   <p class="header">Документ, подтверждающий совершение внешнеэкономической сделки</p>
				   <xsl:apply-templates select="esif:SupportingDocuments"/>
               </xsl:if>
               <!-- Транспортный (перевозочный) документ (железнодорожная накладная) -->
               <p class="header">Транспортный (перевозочный) документ (железнодорожная накладная)</p>
               <xsl:apply-templates select="esif:TransportDocuments"/>
               <!--xsl:if test="esif:DestinationCustomsCode">
				   <p><span>Код таможенного органа назначения: <xsl:value-of select="esif:DestinationCustomsCode"/></span></p>
               </xsl:if>
               <xsl:if test="esif:TransitDateLimit">
				   <p><span>Срок таможенного транзита: <xsl:call-template name="russian_date"><xsl:with-param name="dateIn" select="esif:TransitDateLimit"/></xsl:call-template>
				   </span></p>
               </xsl:if-->
               <xsl:if test="esif:CustomsModeCode">
				   <p><span>Код таможенной процедуры: <xsl:value-of select="esif:CustomsModeCode"/></span></p>
               </xsl:if>
            </div>
            <div class="page1">
               <!-- Сведения о товаре -->
               <p class="header">Сведения о товаре</p>
               <table border="1" style="border-collapse: collapse; width: 100%; position:relative">
                  <tbody class="goods">
                     <tr>
						<td width="3%">п\п</td>
                        <td width="10%">Наименование</td>
                        <xsl:if test="esif:GoodsList/esif:GoodsTNVEDCode">
                           <td width="3%">Код товара по ТН ВЭД ЕАЭС</td>
                        </xsl:if>
                        <xsl:if test="esif:GoodsList/esif:GrossWeightQuantity">
                           <td width="3%">Вес товара, брутто (кг)</td>
                        </xsl:if>
                        <xsl:if test="esif:GoodsList/esif:SupplementaryQuantity">
                           <td width="3%">Кол-во товара в ДЕИ</td>
                           <xsl:if test="esif:GoodsList/esif:SupplementaryQuantity/cat_ru:MeasureUnitQualifierName">
                              <td width="3%">Условное обозначение ДЕИ</td>
                           </xsl:if>
                           <xsl:if test="esif:GoodsList/esif:SupplementaryQuantity/cat_ru:MeasureUnitQualifierCode">
                              <td width="3%">Код единицы измерения (ТН ВЭД ЕАЭС)</td>
                           </xsl:if>
                        </xsl:if>
                        <xsl:if test="esif:GoodsList/esif:GoodsPackaging">
                           <xsl:if test="esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PakageQuantity">
                              <td width="5%">Общее кол-во грузовых мест, занятых товаром</td>
                           </xsl:if>
                           <xsl:if test="esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PakageTypeCode">
                              <td width="7%">Наличие упаковки</td>
                           </xsl:if>
                           <xsl:if test="esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PakagePartQuantity">
                              <td width="5%">Кол-во грузовых мест, частично занятых товаром</td>
                           </xsl:if>
                           <xsl:if test="esif:GoodsList/esif:GoodsPackaging/catESAD_cu:RBCargoKind">
                              <td width="3%">Вид грузовых мест</td>
                           </xsl:if>
                           <xsl:if test="esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PackageCode">
                              <td width="3%">Код вида груза</td>
                           </xsl:if>
                           <!-- PackingInformation -->
                           <xsl:if test="esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PackingInformation/catESAD_cu:PackingCode">
                              <td width="3%">Код вида упаковки товаров</td>
                           </xsl:if>
                           <xsl:if test="esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PackingInformation/catESAD_cu:PakingQuantity">
                              <td width="3%">Кол-во упаковок</td>
                           </xsl:if>
                           <!-- PalleteInformation -->
                           <xsl:if test="esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PalleteInformation/catESAD_cu:PalleteQuantity">
                              <td width="3%">Кол-во поддонов</td>
                           </xsl:if>
                           <xsl:if test="esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PalleteInformation/catESAD_cu:PalleteDescription">
                              <td width="10%">Описание поддонов</td>
                           </xsl:if>
                           <xsl:if test="esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PalleteInformation/catESAD_cu:PalleteCode">
                              <td width="3%">Код вида поддона</td>
                           </xsl:if>
                           <!-- UnitPackInfo -->
                           <xsl:if test="esif:GoodsList/esif:GoodsPackaging/catESAD_cu:UnitPackInfo/catESAD_cu:PackingCode">
                              <td width="3%">Код вида инд. упаковки товаров</td>
                           </xsl:if>
                           <xsl:if test="esif:GoodsList/esif:GoodsPackaging/catESAD_cu:UnitPackInfo/catESAD_cu:PakingQuantity">
                              <td width="5%">Кол-во инд. упаковок</td>
                           </xsl:if>
                           <!-- CargoInfo -->
                           <xsl:if test="esif:GoodsList/esif:GoodsPackaging/catESAD_cu:CargoInfo/catESAD_cu:PackingCode">
                              <td width="3%">Код вида упаковки товаров (при перевозе без упаковки)</td>
                           </xsl:if>
                           <xsl:if test="esif:GoodsList/esif:GoodsPackaging/catESAD_cu:CargoInfo/catESAD_cu:PakingQuantity">
                              <td width="5%">Кол-во упаковок (при перевозке без упаковки)</td>
                           </xsl:if>
                        </xsl:if>
                        <!-- Container -->
                        <xsl:if test="esif:GoodsList/esif:Container/catESAD_cu:ContainerQuantity">
                           <td width="5%">Количество контейнеров</td>
                        </xsl:if>
                        <xsl:if test="esif:GoodsList/esif:Container/catESAD_cu:ContainerKind">
                           <td width="3%">Тип контейнера</td>
                        </xsl:if>
                        <xsl:if test="esif:GoodsList/esif:Container/catESAD_cu:ContainerNumber">
                           <td width="100px">Номер контейнера (заполненность)</td>
                        </xsl:if>
                        <!--xsl:if test="esif:GoodsList/esif:PrecedingDocument">
                           <td width="100px">Предшествующий  документ</td>
                        </xsl:if-->
                     </tr>
                     <xsl:apply-templates select="esif:GoodsList"/>
                  </tbody>
               </table>
            </div>
         </body>
      </html>
   </xsl:template>
   <xsl:template match="esif:Consignor | esif:Consignee">
      <div>
         <table style="margin-top:-15px" width="100%">
            <tbody>
               <xsl:if test="cat_ru:OrganizationName">
                  <tr>
                     <td width="55%">Наименование организации / ФИО физического лица</td>
                     <td>
                        <xsl:value-of select="cat_ru:OrganizationName"/>
                     </td>
                  </tr>
               </xsl:if>
               <xsl:if test="cat_ru:ShortName">
                  <tr>
                     <td>Краткое наименование организации</td>
                     <td>
                        <xsl:value-of select="cat_ru:ShortName"/>
                     </td>
                  </tr>
               </xsl:if>
               <xsl:if test="cat_ru:OrganizationLanguage">
                  <tr>
                     <td>Код языка для заполнения наименования </td>
                     <td>
                        <xsl:value-of select="cat_ru:OrganizationLanguage"/>
                     </td>
                  </tr>
               </xsl:if>
               <xsl:choose>
                  <xsl:when test="cat_ru:RFOrganizationFeatures">
                     <xsl:apply-templates select="cat_ru:RFOrganizationFeatures"/>
                  </xsl:when>
                  <xsl:when test="cat_ru:RKOrganizationFeatures">
                     <xsl:apply-templates select="cat_ru:RKOrganizationFeatures"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:apply-templates select="cat_ru:RBOrganizationFeatures"/>
                  </xsl:otherwise>
               </xsl:choose>
               <!--xsl:if test="esif:Code">
                  <tr>
                     <td>Код грузоотправителя</td>
                     <td>
                        <xsl:value-of select="esif:Code"/>
                     </td>
                  </tr>
               </xsl:if-->
               <xsl:if test="esif:Address">
                  <tr>
                     <td colspan="2">
                        <b>Адрес</b>
                     </td>
                  </tr>
                  <xsl:if test="esif:Address/cat_ru:PostalCode">
                     <tr>
                        <td>Почтовый индекс</td>
                        <td>
                           <xsl:value-of select="esif:Address/cat_ru:PostalCode"/>
                        </td>
                     </tr>
                  </xsl:if>
                  <xsl:if test="esif:Address/cat_ru:CountryCode">
                     <tr>
                        <td>Код страны</td>
                        <td>
                           <xsl:value-of select="esif:Address/cat_ru:CountryCode"/>
                        </td>
                     </tr>
                  </xsl:if>
                  <xsl:if test="esif:Address/cat_ru:CounryName">
                     <tr>
                        <td>Краткое название страны</td>
                        <td>
                           <xsl:value-of select="esif:Address/cat_ru:CounryName"/>
                        </td>
                     </tr>
                  </xsl:if>
                  <xsl:if test="esif:Address/cat_ru:Region">
                     <tr>
                        <td>Область</td>
                        <td>
                           <xsl:value-of select="esif:Address/cat_ru:Region"/>
                        </td>
                     </tr>
                  </xsl:if>
                  <xsl:if test="esif:Address/cat_ru:City">
                     <tr>
                        <td>Населенный пункт</td>
                        <td>
                           <xsl:value-of select="esif:Address/cat_ru:City"/>
                        </td>
                     </tr>
                  </xsl:if>
                  <xsl:if test="esif:Address/cat_ru:StreetHouse">
                     <tr>
                        <td>Улица, номер дома, номер офиса</td>
                        <td>
                           <xsl:value-of select="esif:Address/cat_ru:StreetHouse"/>
                        </td>
                     </tr>
                  </xsl:if>
               </xsl:if>
            </tbody>
         </table>
      </div>
   </xsl:template>
   <xsl:template match="esif:SupportingDocuments | esif:TransportDocuments">
      <table style="margin-top:-15px" width="100%">
         <tbody>
            <xsl:if test="cat_ru:PrDocumentName">
               <tr>
                  <td width="55%">Наименование документа</td>
                  <td>
                     <xsl:value-of select="cat_ru:PrDocumentName"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="cat_ru:PrDocumentNumber">
               <tr>
                  <td>Номер документа</td>
                  <td>
                     <xsl:value-of select="cat_ru:PrDocumentNumber"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="cat_ru:PrDocumentName">
               <tr>
                  <td>Дата документа</td>
                  <td>
                     <xsl:call-template name="russian_date">
                        <xsl:with-param name="dateIn" select="cat_ru:PrDocumentDate"/>
                     </xsl:call-template>
                  </td>
               </tr>
            </xsl:if>
            <tr>
               <td>Код вида представляемого документа. Заполняется в соответствии с классификатором видов документов, используемых при заявлении сведений в графе 44.</td>
               <td>
                  <xsl:value-of select="esif:PresentedDocumentModeCode"/>
               </td>
            </tr>
            <xsl:if test="esif:DocumentBeginActionsDate">
               <tr>
                  <td width="55%">Дата начала действия документа</td>
                  <td>
                     <xsl:call-template name="russian_date">
                        <xsl:with-param name="dateIn" select="esif:DocumentBeginActionsDate"/>
                     </xsl:call-template>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="esif:DocumentEndActionsDate">
               <tr>
                  <td width="55%">Дата окончания действия документа</td>
                  <td>
                     <xsl:call-template name="russian_date">
                        <xsl:with-param name="dateIn" select="esif:DocumentEndActionsDate"/>
                     </xsl:call-template>
                  </td>
               </tr>
            </xsl:if>
            <tr>
               <td colspan="2" height="25px"/>
            </tr>
         </tbody>
      </table>
   </xsl:template>
   <xsl:template match="cat_ru:RKOrganizationFeatures">
      <xsl:if test="cat_ru:BIN">
         <tr>
            <td>БИН</td>
            <td>
               <xsl:value-of select="cat_ru:BIN"/>
            </td>
         </tr>
      </xsl:if>
      <xsl:if test="cat_ru:IIN">
         <tr>
            <td>ИИН</td>
            <td>
               <xsl:value-of select="cat_ru:IIN"/>
            </td>
         </tr>
      </xsl:if>
      <xsl:if test="cat_ru:ITN">
         <tr>
            <td>ИТН</td>
            <td>
               <xsl:value-of select="cat_ru:ITN/cat_ru:CategoryCode"/>
					/<xsl:value-of select="cat_ru:ITN/cat_ru:KATOCode"/>
					/<xsl:value-of select="cat_ru:ITN/cat_ru:RNN"/>
               <xsl:if test="cat_ru:IIN/cat_ru:ITNReserv">
						/<xsl:value-of select="cat_ru:ITN/cat_ru:ITNReserv"/>
               </xsl:if>
            </td>
         </tr>
      </xsl:if>
   </xsl:template>
   <xsl:template match="cat_ru:RBOrganizationFeatures">
      <xsl:if test="cat_ru:UNP">
         <tr>
            <td>УНП</td>
            <td>
               <xsl:value-of select="cat_ru:UNP"/>
            </td>
         </tr>
      </xsl:if>
      <xsl:if test="cat_ru:RBIdentificationNumber">
         <tr>
            <td>Идентификационный номер физического лица</td>
            <td>
               <xsl:value-of select="cat_ru:RBIdentificationNumber"/>
            </td>
         </tr>
      </xsl:if>
   </xsl:template>
   <xsl:template match="cat_ru:RFOrganizationFeatures">
      <xsl:if test="cat_ru:OGRN">
         <tr>
            <td>ОГРН/ОГРНИП</td>
            <td>
               <xsl:value-of select="cat_ru:OGRN"/>
            </td>
         </tr>
      </xsl:if>
      <xsl:if test="cat_ru:OGRN">
         <tr>
            <td>ИНН</td>
            <td>
               <xsl:value-of select="cat_ru:INN"/>
            </td>
         </tr>
      </xsl:if>
      <xsl:if test="cat_ru:OGRN">
         <tr>
            <td>КПП</td>
            <td>
               <xsl:value-of select="cat_ru:KPP"/>
            </td>
         </tr>
      </xsl:if>
   </xsl:template>
   <xsl:template match="esif:GoodsList">
      <tr>
         <td>
            <xsl:value-of select="esif:GoodsNumeric"/>
         </td>
         <td>
            <xsl:for-each select="esif:GoodsDescription">
               <xsl:value-of select="."/>
               <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
            </xsl:for-each>
         </td>
         <xsl:if test="../esif:GoodsList/esif:GoodsTNVEDCode">
            <td>
               <xsl:value-of select="esif:GoodsTNVEDCode"/>
            </td>
         </xsl:if>
         <xsl:if test="../esif:GoodsList/esif:GrossWeightQuantity">
            <td>
               <xsl:value-of select="esif:GrossWeightQuantity"/>
            </td>
         </xsl:if>
         <xsl:if test="../esif:GoodsList/esif:SupplementaryQuantity">
            <td>
               <xsl:value-of select="esif:SupplementaryQuantity/cat_ru:GoodsQuantity"/>
            </td>
            <xsl:if test="../esif:GoodsList/esif:SupplementaryQuantity/cat_ru:MeasureUnitQualifierName">
               <td>
                  <xsl:value-of select="esif:SupplementaryQuantity/cat_ru:MeasureUnitQualifierName"/>
               </td>
            </xsl:if>
            <xsl:if test="../esif:GoodsList/esif:SupplementaryQuantity/cat_ru:MeasureUnitQualifierCode">
               <td>
                  <xsl:value-of select="esif:SupplementaryQuantity/cat_ru:MeasureUnitQualifierCode"/>
               </td>
            </xsl:if>
         </xsl:if>
         <xsl:if test="../esif:GoodsList/esif:GoodsPackaging">
            <xsl:if test="../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PakageQuantity">
               <td>
                  <xsl:value-of select="esif:GoodsPackaging/catESAD_cu:PakageQuantity"/>
               </td>
            </xsl:if>
            <xsl:if test="../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PakageTypeCode">
               <td>
                  <xsl:choose>
                     <xsl:when test="esif:GoodsPackaging/catESAD_cu:PakageTypeCode = '0'"> Без упаковки</xsl:when>
                     <xsl:when test="esif:GoodsPackaging/catESAD_cu:PakageTypeCode = '1'"> С упаковкой</xsl:when>
                     <xsl:when test="esif:GoodsPackaging/catESAD_cu:PakageTypeCode = '2'"> 
								Без упаковки в оборудованных емкостях транспортного средства
							</xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="esif:GoodsPackaging/catESAD_cu:PakageTypeCode"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </td>
            </xsl:if>
            <xsl:if test="../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PakagePartQuantity">
               <td>
                  <xsl:value-of select="esif:GoodsPackaging/catESAD_cu:PakagePartQuantity"/>
               </td>
            </xsl:if>
            <xsl:if test="../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:RBCargoKind">
               <td>
                  <xsl:value-of select="esif:GoodsPackaging/catESAD_cu:RBCargoKind"/>
               </td>
            </xsl:if>
            <xsl:if test="../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PackageCode">
               <td>
                  <xsl:value-of select="esif:GoodsPackaging/catESAD_cu:PackageCode"/>
               </td>
            </xsl:if>
            <!-- PackingInformation -->
            <xsl:if test="../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PackingInformation">
               <xsl:if test="../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PackingInformation/catESAD_cu:PackingCode">
                  <td>
                     <xsl:for-each select="esif:GoodsPackaging/catESAD_cu:PackingInformation">
                        <xsl:value-of select="catESAD_cu:PackingCode"/>
                        <br/>
                        <br/>
                     </xsl:for-each>
                  </td>
               </xsl:if>
               <xsl:if test="../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PackingInformation/catESAD_cu:PakingQuantity">
                  <td>
                     <xsl:for-each select="esif:GoodsPackaging/catESAD_cu:PackingInformation">
                        <xsl:choose>
                           <xsl:when test="catESAD_cu:PakingQuantity">
                              <xsl:value-of select="catESAD_cu:PakingQuantity"/>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </xsl:otherwise>
                        </xsl:choose>
                        <br/>
                        <br/>
                     </xsl:for-each>
                  </td>
               </xsl:if>
            </xsl:if>
            <!-- PalleteInformation -->
            <xsl:if test="../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PalleteInformation">
               <xsl:choose>
                  <xsl:when test="../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PalleteInformation/catESAD_cu:PalleteDescription and ../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PalleteInformation/catESAD_cu:PalleteCode">
                     <td colspan="3">
                        <table border="1" style="border:0; border-collapse:collapse; margin: -5px;">
                           <tbody>
                              <xsl:for-each select="esif:GoodsPackaging/catESAD_cu:PalleteInformation">
                                 <tr>
                                    <xsl:choose>
                                       <xsl:when test="position()=1">
                                          <td style="border-left: 0; border-top:0" width="81px">
                                             <xsl:value-of select="catESAD_cu:PalleteQuantity"/>
                                          </td>
                                          <td style="border-top:0">
                                             <xsl:value-of select="catESAD_cu:PalleteDescription"/>
                                          </td>
                                          <td style="border-right: 0; border-top:0" width="57px">
                                             <xsl:value-of select="catESAD_cu:PalleteCode"/>
                                          </td>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <td style="border-left: 0;" width="81px">
                                             <xsl:value-of select="catESAD_cu:PalleteQuantity"/>
                                          </td>
                                          <td>
                                             <xsl:value-of select="catESAD_cu:PalleteDescription"/>
                                          </td>
                                          <td style="border-right: 0; " width="57px">
                                             <xsl:value-of select="catESAD_cu:PalleteCode"/>
                                          </td>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                 </tr>
                              </xsl:for-each>
                           </tbody>
                        </table>
                     </td>
                  </xsl:when>
                  <xsl:when test="(../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PalleteInformation/catESAD_cu:PalleteDescription and not( ../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PalleteInformation/catESAD_cu:PalleteCode) ) or (not(../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PalleteInformation/catESAD_cu:PalleteDescription) and ../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:PalleteInformation/catESAD_cu:PalleteCode )  ">
                     <td colspan="2">
                        <table border="1" style="border:0; border-collapse:collapse; margin: -5px;">
                           <tbody>
                              <xsl:for-each select="esif:GoodsPackaging/catESAD_cu:PalleteInformation">
                                 <tr>
                                    <xsl:choose>
                                       <xsl:when test="position()=1">
                                          <td style="border-left: 0; border-top:0" width="81px">
                                             <xsl:value-of select="catESAD_cu:PalleteQuantity"/>
                                          </td>
                                          <td style="border-right: 0; border-top:0" width="57px">
                                             <xsl:value-of select="catESAD_cu:PalleteDescription"/>
                                             <xsl:value-of select="catESAD_cu:PalleteCode"/>
                                          </td>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <td style="border-left: 0;" width="81px">
                                             <xsl:value-of select="catESAD_cu:PalleteQuantity"/>
                                          </td>
                                          <td style="border-right: 0;" width="57px">
                                             <xsl:value-of select="catESAD_cu:PalleteDescription"/>
                                             <xsl:value-of select="catESAD_cu:PalleteCode"/>
                                          </td>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                 </tr>
                              </xsl:for-each>
                           </tbody>
                        </table>
                     </td>
                  </xsl:when>
                  <xsl:otherwise>
                     <td>
                        <xsl:value-of select="catESAD_cu:PalleteQuantity"/>
                     </td>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:if>
            <!-- UnitPackInfo -->
            <xsl:if test="../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:UnitPackInfo/catESAD_cu:PackingCode">
               <td>
                  <xsl:for-each select="esif:GoodsPackaging/catESAD_cu:UnitPackInfo">
                     <xsl:value-of select="catESAD_cu:PackingCode"/>
                     <br/>
                     <br/>
                  </xsl:for-each>
               </td>
            </xsl:if>
            <xsl:if test="../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:UnitPackInfo/catESAD_cu:PakingQuantity">
               <td>
                  <xsl:for-each select="esif:GoodsPackaging/catESAD_cu:UnitPackInfo">
                     <xsl:choose>
                        <xsl:when test="catESAD_cu:PakingQuantity">
                           <xsl:value-of select="catESAD_cu:PakingQuantity"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                        </xsl:otherwise>
                     </xsl:choose>
                     <br/>
                     <br/>
                  </xsl:for-each>
               </td>
            </xsl:if>
            <!-- CargoInfo -->
            <xsl:if test="../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:CargoInfo/catESAD_cu:PackingCode">
               <td>
                  <xsl:for-each select="esif:GoodsPackaging/catESAD_cu:CargoInfo">
                     <xsl:value-of select="catESAD_cu:PackingCode"/>
                     <br/>
                     <br/>
                  </xsl:for-each>
               </td>
            </xsl:if>
            <xsl:if test="../esif:GoodsList/esif:GoodsPackaging/catESAD_cu:CargoInfo/catESAD_cu:PakingQuantity">
               <td>
                  <xsl:for-each select="esif:GoodsPackaging/catESAD_cu:CargoInfo">
                     <xsl:choose>
                        <xsl:when test="catESAD_cu:PakingQuantity">
                           <xsl:value-of select="catESAD_cu:PakingQuantity"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                        </xsl:otherwise>
                     </xsl:choose>
                     <br/>
                     <br/>
                  </xsl:for-each>
               </td>
            </xsl:if>
         </xsl:if>
         <xsl:if test="../esif:GoodsList/esif:Container">
            <xsl:if test="../esif:GoodsList/esif:Container/catESAD_cu:ContainerQuantity">
               <td>
                  <xsl:value-of select="esif:Container/catESAD_cu:ContainerQuantity"/>
               </td>
            </xsl:if>
            <xsl:if test="../esif:GoodsList/esif:Container/catESAD_cu:ContainerKind">
               <td>
                  <xsl:value-of select="esif:Container/catESAD_cu:ContainerKind"/>
               </td>
            </xsl:if>
            <td>
               <xsl:for-each select="esif:Container/catESAD_cu:ContainerNumber">
                  <xsl:value-of select="catESAD_cu:ContainerIdentificaror"/>
                  <xsl:choose>
                     <xsl:when test="catESAD_cu:FullIndicator = 1">
                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								(весь контейнер)
							</xsl:when>
                     <xsl:when test="catESAD_cu:FullIndicator = 2">
                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								(часть контейнера)
							</xsl:when>
                  </xsl:choose>
                  <br/>
                  <br/>
               </xsl:for-each>
            </td>
         </xsl:if>
         <!--xsl:if test="../esif:GoodsList/esif:PrecedingDocument">
			<td>
				<xsl:if test="esif:PrecedingDocument/cat_ru:PrDocumentName">
					<xsl:value-of select="esif:PrecedingDocument/cat_ru:PrDocumentName"/>
				</xsl:if>
				<xsl:if test="esif:PrecedingDocument/cat_ru:PrDocumentNumber">
					<xsl:text> № </xsl:text>
					<xsl:value-of select="esif:PrecedingDocument/cat_ru:PrDocumentNumber"/>
				</xsl:if>
				<xsl:if test="esif:PrecedingDocument/cat_ru:PrDocumentDate">
					<xsl:text> от </xsl:text>
					<xsl:call-template name="russian_date"><xsl:with-param name="dateIn" select="esif:PrecedingDocument/cat_ru:PrDocumentDate"/> </xsl:call-template> 
				</xsl:if>
			</td>
         </xsl:if-->
      </tr>
   </xsl:template>
</xsl:stylesheet>
