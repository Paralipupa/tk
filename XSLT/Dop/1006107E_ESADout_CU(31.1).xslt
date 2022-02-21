<?xml version="1.0" encoding="UTF-8"?>
<!-- учтены изменения, вносимые Решением Коллегии ЕЭК от 21.05.2019 № 83 -->
<!-- учтены изменения, вносимые Решением Коллегии ЕЭК от 17.12.2019 № 223 -->
<xsl:stylesheet exclude-result-prefixes="ESADout_CU cat_ru catESAD_cu" version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:catESAD_ru="urn:customs.ru:RUCommonAggregateTypes:5.17.0" xmlns:ESADout_CU="urn:customs.ru:Information:CustomsDocuments:ESADout_CU:5.17.0" xmlns:catESAD_cu="urn:customs.ru:CUESADCommonAggregateTypesCust:5.17.0" xmlns:cat_ru="urn:customs.ru:CommonAggregateTypes:5.10.0" xmlns:RUScat_ru="urn:customs.ru:RUSCommonAggregateTypes:5.16.0" xmlns:RUDECLcat="urn:customs.ru:RUDeclCommonAggregateTypesCust:5.17.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:goom="urn:customs.ru:Information:CustomsDocuments:GTDOutCustomsMark:5.17.0" xmlns:nGTDr="urn:customs.ru:Information:ExchangeDocuments:NotifGTDRegistration:5.16.0">
	<xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" encoding="utf-8" indent="yes" media-type="text/html" method="html" omit-xml-declaration="yes" version="1.0"/>
	<xsl:variable name="k" select="1"/>
	<xsl:template match="//*[local-name()='ESADout_CU']//*" priority="-1">
		<xsl:variable name="xpath">
			<xsl:call-template name="get_xpath">
				<xsl:with-param name="node" select="current()"/>
			</xsl:call-template>
		</xsl:variable>
		<element xml_node="{$xpath}">
			<xsl:apply-templates/>
		</element>
	</xsl:template>
	<xsl:template name="get_xpath">
		<xsl:param name="node" select="."/>
		<xsl:variable name="xpath">
			<xsl:for-each select="$node/ancestor-or-self::*">
				<xsl:variable name="name">
					<xsl:value-of select="name()"/>
				</xsl:variable>
				<xsl:variable name="pos">
					<xsl:value-of select="count(node()/parent::*/preceding-sibling::*[name()=$name])"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="position()=last()">
						<xsl:value-of select="concat($name,'[',$pos,']')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($name,'[',$pos,']','/')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>
		<xsl:value-of select="$xpath"/>
	</xsl:template>
	<xsl:template match="/">
		<html>
			<head>
				<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
				<title>Электронная копия декларации на товары и транзитной декларации. Внешний формат.</title>
				<style type="text/css">
              body {background: #CCCCCC; font-size: 9pt;}
              div.page {
              width: 210mm;
              margin: 10px auto;
              padding: 5mm 10mm;
              background: white;
              border: solid 1px black;
              page-break-before: always;
              }

              div.page_album {
              width: 297mm;
              margin: 10px auto;
              padding: 10mm;
              background: white;
              border: solid 1px black;
              page-break-before: always;
              }

              div.page.nobreak {
              page-break-before: avoid;
              }
              
              /*Стиль для удаления чёрной границы вокруг нарисованной "страницы" при печати*/
              @media print {div.page {border: none; margin: 0; padding: 0;}}
              div.goods {background: white;}
              .bordered {
              border: solid 1px black;
              padding-top: 4pt;
              padding-bottom: 4pt;
              font-family: Arial;
              font-size: 9pt;
              font-weight: bold;
              }
              .underlined {border-bottom: solid 0.8pt black;}
              p.NumberDate {font-weight: bold;}
              .graph {font-family: Arial; font-size: 7pt;}
              .graphColumn {font-family: Arial; font-size: 6.5pt;}
              .graphTitleIt {font-family: Arial; font-size: 7pt; font-style: italic;}
              .graphMain {font-family: Arial; font-size: 9pt; font-weight: bold; }
              .graphNum {font-family: Arial; font-size: 7pt; font-weight: bold;}
              .graphNo {font-size: 7pt; font-weight: bold;}
              h1{font-size: 12pt;}
              table.addInfo {border-collapse: collapse; vertical-align: top;}
              table.addInfo th {border: 1px solid black; background-color: LightGrey;}
              table.addInfo td {border: 1px solid black; vertical-align: top;}
              hr {border: 0; border-bottom: 1px solid black; margin: 0;}
              .tr {border-right: 1px solid black;}
              .tl {border-left: 1px solid black;}
              .tb {border-bottom: 1px solid black;}
              .tt {border-top: 1px solid black;}
              .br {border-right: 2px solid black;}
              .bl {border-left: 2px solid black;}
              .bb {border-bottom: 2px solid black;}
              .bt {border-top: 2px solid black;}
              .db {border-bottom: 1px dashed black;}
              .dl {border-left: 1px dashed black;}
              .number {
              text-align: center;
              color: black;
              font-size: 11pt;
              font-weight: bold;
              vertical-align: middle;
              }
                </style>
			</head>
			<body>
				<div class="page nobreak">
					<xsl:apply-templates select="//ESADout_CU:ESADout_CU/ESADout_CU:ESADout_CUGoodsShipment"/>
				</div>
				<!--Выводим товары 2 - ..., группируя их по 3 шт. на лист-->
				<xsl:for-each select="//ESADout_CU:ESADout_CUGoods">
					<xsl:if test="(position() - 1) mod 3 = 1">
						<xsl:variable name="firstEntryPos" select="position()"/>
						<div class="page">
							<xsl:call-template name="td4Head"/>
							<xsl:for-each select="//ESADout_CU:ESADout_CUGoods">
								<xsl:if test="position() >= $firstEntryPos and position() &lt;= $firstEntryPos + 2">
									<xsl:apply-templates select="."/>
								</xsl:if>
							</xsl:for-each>
							<table cellpadding="0" cellspacing="0" style="width: 100%; margin: 0;">
								<tr>
									<td class="bt" rowspan="2" style="width: 73px; vertical-align: top;">
										<span class="graphNo">47</span>
										<span class="graphColumn">Исчисление платежей</span>
									</td>
									<td style="width: 45%;">
										<xsl:apply-templates mode="payments" select="//ESADout_CU:ESADout_CUGoods[position() = $firstEntryPos]"/>
									</td>
									<td>
										<xsl:apply-templates mode="payments" select="//ESADout_CU:ESADout_CUGoods[position() = $firstEntryPos + 1]"/>
									</td>
								</tr>
								<tr>
									<td>
										<xsl:apply-templates mode="payments" select="//ESADout_CU:ESADout_CUGoods[position() = $firstEntryPos + 2]"/>
									</td>
									<td/>
								</tr>
							</table>
						</div>
					</xsl:if>
				</xsl:for-each>

				<!--xsl:if test="//ESADout_CU:ESADoutContractList">
                    <div class="page"><xsl:apply-templates select="//ESADout_CU:ESADout_CUGoods" mode="foreignTradeContracts"/></div>
                </xsl:if-->
				<xsl:if test="//ESADout_CU:GoodsAutomobile">
					<div class="page_album">
						<xsl:apply-templates mode="automobile" select="//ESADout_CU:ESADout_CUGoods"/>
					</div>
				</xsl:if>

				<!-- Оборотная сторона -->
				<xsl:call-template name="backSideTD"/>

			</body>
		</html>
	</xsl:template>
	<!--Верхняя часть листа ТД4-->
	<xsl:template name="td4Head">
		<table style="width: 100%; vertical-align: top; border-collapse: collapse; font-size: 7pt;">
			<xsl:choose>
				<xsl:when test="(..//..//ESADout_CU:CustomsProcedure = 'ТТ') or (..//..//ESADout_CU:CustomsProcedure = 'TT')">
					<tr>
						<td style="width: 71px;"/>
						<td class="header nowrap graphMain" colspan="5">ДОБАВОЧНЫЙ ЛИСТ К ТРАНЗИТНОЙ ДЕКЛАРАЦИИ</td>
						<td class="tl nowrap" colspan="6">
							<b>А</b>
						</td>
					</tr>
					<tr>
						<td/>
						<td class="tb">
							<table class="inline">
								<tr>
									<td class="header graphMain"/>
									<td class="number blankNumber" title="Номер бланка"/>
								</tr>
							</table>
						</td>
						<td class="bl bt br" colspan="4">
							<b>1</b> ДЕКЛАРАЦИЯ</td>
						<td colspan="6"/>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td style="width: 71px;"/>
						<td class="header nowrap graphMain" colspan="5">ДОБАВОЧНЫЙ ЛИСТ К ДЕКЛАРАЦИИ НА ТОВАРЫ</td>
						<td class="tl nowrap" colspan="6">
							<b>А</b>
						</td>
					</tr>
					<tr>
						<td/>
						<td class="tb">
							<table class="inline">
								<tr>
									<td class="header graphMain"/>
									<td class="number blankNumber" title="Номер бланка"/>
								</tr>
							</table>
						</td>
						<td class="bl bt br" colspan="4">
							<b>1</b> ДЕКЛАРАЦИЯ</td>
						<td colspan="6"/>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--td colspan="4" class="bl bt br">
					<b>1</b> ДЕКЛАРАЦИЯ</td>
				<td colspan="6"/>
			</tr-->
			<tr>
				<td/>
				<td class="tl green">
					<table class="inline">
						<tr>
							<td class="nowrap" style="width: 40%;">
								<b>2</b> Отправитель/<i>Экспортер</i>
							</td>
							<td class="nowrap" style="width: 40%;">
								<!--b>8</b> Получатель -->
							</td>
							<td>№</td>
						</tr>
					</table>
				</td>
				<td class="bl br" colspan="4"/>
				<td colspan="6"/>
			</tr>
			<tr>
				<td/>
				<td class="tl green br" rowspan="3" style="border-bottom:solid 0.8pt black;">
					<xsl:if test="//ESADout_CU:CustomsProcedure='ЭК' or 
									(//ESADout_CU:CustomsProcedure='ТТ' and //ESADout_CU:TransitDirectionCode!='ИМ')">
						<!-- Отправитель -->
						<xsl:for-each select="//ESADout_CU:ESADout_CUConsignor">
							<xsl:apply-templates select="."/>
						</xsl:for-each>
					</xsl:if>
					<hr/>
					<b>8</b> Получатель<br/>
					<xsl:if test="//ESADout_CU:CustomsProcedure='ИМ' or 
									(//ESADout_CU:CustomsProcedure='ТТ' and //ESADout_CU:TransitDirectionCode!='ЭК')">
						<!-- Получатель -->
						<xsl:for-each select="//ESADout_CU:ESADout_CUConsignee">
							<xsl:apply-templates select="."/>
						</xsl:for-each>
					</xsl:if>
				</td>
				<td class="bl bb br containTable" colspan="4" style="vertical-align: bottom;">
					<table class="inline">
						<tr>
							<td align="center" class="graph" rowspan="2" style="width:{8.8*$k}mm;border-right:solid 0.8pt black;background:#FFFFFF;">
								<xsl:apply-templates select="//ESADout_CU:CustomsProcedure"/>
							</td>
							<td align="center" class="graph" rowspan="2" style="width:{4.4*$k}mm;">
								<xsl:choose>
									<xsl:when test="(..//ESADout_CU:CustomsProcedure = 'ТТ') or (..//ESADout_CU:CustomsProcedure = 'TT')">
										<xsl:apply-templates select="//ESADout_CU:TransitFeature"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates select="//ESADout_CU:CustomsModeCode"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td align="center" class="graph" rowspan="2" style="width:{13.2*$k}mm;border-left:solid 0.8pt black;background:#FFFFFF;">
								<!--xsl:if test="//ESADout_CU:ElectronicDocumentSign">
									<xsl:value-of select="'ЭД '"/>
								</xsl:if-->
								<xsl:apply-templates select="//ESADout_CU:ElectronicDocumentSign"/>
								<xsl:apply-templates select="//ESADout_CU:TransitDirectionCode"/>
							</td>
						</tr>
					</table>
				</td>
				<td colspan="6"/>
			</tr>
			<tr>
				<td/>
				<td class="nowrap" colspan="2">
					<b>3</b> Формы
			<xsl:apply-templates select="catESAD_cu:AdditionalSheetCount"/>
					<xsl:text> | </xsl:text>
					<xsl:apply-templates select="//catESAD_cu:TotalSheetNumber"/>
				</td>
				<td class="br tb bl number" rowspan="2">1</td>
				<td class="br tb bl number" rowspan="2">6</td>
				<td colspan="4"/>
			</tr>
			<tr>
				<td class="tb"/>
				<td class="tb"/>
				<td class="tb"/>
				<td class="tb" colspan="6"/>
			</tr>
		</table>
	</xsl:template>
	<!--Дополнительные сведения по внешнеторговым контрактам. Заполняется при подаче ВГТД-->
	<xsl:template match="ESADout_CU:ESADout_CUGoods" mode="automobile">
		<xsl:if test="ESADout_CU:GoodsAutomobile">
			<h1>Данные по транспортному средству из товара № <xsl:apply-templates select="catESAD_cu:GoodsNumeric"/>
			</h1>
			<table class="addInfo">
				<tr>
					<th>Модель</th>
					<th style="width: 1%;">Марка</th>
					<th style="width: 1%;">Год изготовления</th>
					<th style="width: 1%;">Рабочий объем двигателя, куб. см</th>
					<th>Идентиф-й № кузова</th>
					<th>Двигатель</th>
					<th>Идентиф-й № шасси (рамы)</th>
					<th>№ удостоверения</th>
					<th>Стоимость</th>
					<th>Грузоподъемность/Мощность</th>
					<th>Пробег</th>
				</tr>
				<xsl:apply-templates select="ESADout_CU:GoodsAutomobile"/>
			</table>
		</xsl:if>
	</xsl:template>
	<!--Шаблон для типа catESAD_cu:CarCostInfoType-->
	<xsl:template match="catESAD_cu:CarCostInfo">
		<xsl:apply-templates select="catESAD_cu:CarCost"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="catESAD_cu:CarCostCurrencyCode"/>
	</xsl:template>
	<xsl:template match="ESADout_CU:GoodsAutomobile">
		<tr>
			<td>
				<xsl:apply-templates select="catESAD_cu:Model"/>
			</td>
			<td>
				<xsl:apply-templates select="catESAD_cu:Mark"/>
			</td>
			<td>
				<xsl:apply-templates select="catESAD_cu:OfftakeYear"/>
			</td>
			<td>
				<xsl:apply-templates select="catESAD_cu:EngineVolumeQuanity/catESAD_cu:MeasuredAmount"/>&#160;<xsl:apply-templates select="catESAD_cu:EngineVolumeQuanity/catESAD_cu:MeasureUnitQualifierName"/> (<xsl:apply-templates select="catESAD_cu:EngineVolumeQuanity/catESAD_cu:MeasureUnitQualifierCode"/>)</td>
			<td>
				<xsl:apply-templates select="catESAD_cu:VINID"/>
			</td>
			<td>
				<xsl:apply-templates select="catESAD_cu:EngineID"/>
			</td>
			<td>
				<xsl:apply-templates select="catESAD_cu:ChassisID"/>
			</td>
			<td>
				<xsl:apply-templates select="catESAD_cu:IdentityCardNumber"/>
			</td>
			<td>
				<xsl:apply-templates select="catESAD_cu:CarCostInfo"/>
			</td>
			<td>
				<xsl:for-each select="catESAD_cu:EngineMaxPowerMeasure">
					<xsl:apply-templates select="catESAD_cu:MeasuredAmount"/>&#160;<xsl:apply-templates select="catESAD_cu:MeasureUnitQualifierName"/> (<xsl:apply-templates select="catESAD_cu:MeasureUnitQualifierCode"/>)<xsl:if test="position()!=last()">
						<xsl:text> </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</td>
			<td>
				<xsl:for-each select="catESAD_cu:PassedKilometerQuantity">
					<xsl:apply-templates select="catESAD_cu:MeasuredAmount"/>&#160;<xsl:apply-templates select="catESAD_cu:MeasureUnitQualifierName"/> (<xsl:apply-templates select="catESAD_cu:MeasureUnitQualifierCode"/>)</xsl:for-each>
			</td>
		</tr>
	</xsl:template>
	<!--Дополнительные сведения по внешнеторговым контрактам. Заполняется при подаче ВГТД-->
	<xsl:template match="*" mode="commaSeparated">
		<xsl:if test="position() > 1">
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:apply-templates select="."/>
		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
	</xsl:template>
	<xsl:template match="*" mode="spaceSeparated">
		<xsl:if test="position() > 1">
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:apply-templates select="."/>
	</xsl:template>
	<xsl:template match="catESAD_cu:InvoicedCost">
		<i>Стоим. по счету: </i>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="catESAD_cu:ContractCurrencyCode">
		<i>Код валюты счета: </i>
		<xsl:variable name="xpath_date">
			<xsl:call-template name="get_xpath">
				<xsl:with-param name="node" select="."/>
			</xsl:call-template>
		</xsl:variable>
		<element xml_node="{$xpath_date}">
			<xsl:apply-templates/>
		</element>
	</xsl:template>
	<xsl:template match="catESAD_cu:CUESADDeliveryTerms">
		<br/>
		<xsl:if test="cat_ru:DeliveryTermsStringCode">
			<i>Код условий поставки по Инкотермс: </i>
			<xsl:apply-templates select="cat_ru:DeliveryTermsStringCode"/>
		</xsl:if>
		<xsl:if test="cat_ru:DeliveryPlace">
			<i> Описание / Название географического пункта</i>
			<xsl:apply-templates mode="spaceSeparated" select="cat_ru:DeliveryPlace"/>
		</xsl:if>
		<xsl:if test="cat_ru:TransferPlace">
			<i> Место передачи товара </i>
			<xsl:apply-templates mode="spaceSeparated" select="cat_ru:TransferPlace"/>
		</xsl:if>
		<xsl:if test="cat_ru:DeliveryTermsRBCode">
			<i> Код вида поставки товаров в соответствии с классификатором видов поставок товаров, подлежащих учету при осуществлении экспортных операций, применяемым в Республике Беларусь </i>
			<xsl:apply-templates mode="spaceSeparated" select="cat_ru:DeliveryTermsRBCode"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="cat_ru:PrDocumentNumber">
		<i> № </i>
		<xsl:variable name="xpath_date">
			<xsl:call-template name="get_xpath">
				<xsl:with-param name="node" select="."/>
			</xsl:call-template>
		</xsl:variable>
		<element xml_node="{$xpath_date}">
			<xsl:apply-templates/>
		</element>
	</xsl:template>
	<xsl:template match="cat_ru:PrDocumentDate">
		<i> дата: </i>
		<xsl:apply-templates mode="date"/>
	</xsl:template>
	<!-- Проверка на совпадение данных с гр.14 ДТ для отправителя и получателя-->
	<xsl:template match="ESADout_CU:ESADout_CUConsignor| ESADout_CU:ESADout_CUConsignee">
		<xsl:choose>
			<xsl:when test="RUDECLcat:EqualIndicator='1' or RUDECLcat:EqualIndicator='true' or RUDECLcat:EqualIndicator='True' or RUDECLcat:EqualIndicator='t'">СМ. ГРАФУ 14 ДТ</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates mode="org" select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Проверка на совпадение данных с гр.14 ДТ для лица, ответственного за финансовое урегулирование-->
	<xsl:template match="ESADout_CU:ESADout_CUFinancialAdjustingResponsiblePerson">
		<xsl:choose>
			<xsl:when test="ESADout_CU:DeclarantEqualFlag='1' or ESADout_CU:DeclarantEqualFlag='true' or ESADout_CU:DeclarantEqualFlag='True' or ESADout_CU:DeclarantEqualFlag='t'">СМ. ГРАФУ 14 ДТ</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates mode="org" select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Адрес -->
	<xsl:template match="*" mode="ru_address">
		<xsl:choose>
			<xsl:when test="RUScat_ru:AddressText">
				<xsl:if test="RUScat_ru:AddressKindCode">
					<xsl:choose>
						<xsl:when test="RUScat_ru:AddressKindCode='1'">Адрес регистрации: </xsl:when>
						<xsl:when test="RUScat_ru:AddressKindCode='2'">Фактический адрес: </xsl:when>
						<xsl:when test="RUScat_ru:AddressKindCode='3'">Почтовый адрес: </xsl:when>
					</xsl:choose>
				</xsl:if>
				<xsl:apply-templates select="RUScat_ru:AddressText"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="last">
					<!-- надо через переменную, т.к. смещение на невыводимые KLADR, AOGUID, AOID -->
					<xsl:choose>
						<xsl:when test="local-name(*[last()])='KLADR' or local-name(*[last()])='AOGUID' or local-name(*[last()])='AOID'">
							<xsl:choose>
								<xsl:when test="RUScat_ru:KLADR and RUScat_ru:AOGUID and RUScat_ru:AOID">
									<xsl:value-of select="count(*) - 3"/>
								</xsl:when>
								<xsl:when test="(not(RUScat_ru:KLADR) and RUScat_ru:AOGUID and RUScat_ru:AOID) or (RUScat_ru:KLADR and not(RUScat_ru:AOGUID) and RUScat_ru:AOID) or (RUScat_ru:KLADR and RUScat_ru:AOGUID and not(RUScat_ru:AOID)) ">
									<xsl:value-of select="count(*) - 2"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="count(*) - 1"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="count(*)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:for-each select="*">
					<xsl:if test="local-name()='OKTMO'">ОКТМО: </xsl:if>
					<xsl:if test="local-name()='OKATO'"> ОКАТО: </xsl:if>
					<!--xsl:if test="local-name()='KLADR'">Код КЛАДР: </xsl:if>
					<xsl:if test="local-name()='AOGUID'">Глобальный ИД по ФИАС: </xsl:if>
					<xsl:if test="local-name()='AOID'">Уникальный ИД по ФИАС: </xsl:if-->
					<xsl:if test="local-name()='TerritoryCode'">Код единицы административно - территориального деления: </xsl:if>
					<xsl:if test="local-name()='PostOfficeBoxId'">Номер а/я: </xsl:if>
					<xsl:choose>
						<xsl:when test="local-name()='AddressKindCode'">
							<xsl:choose>
								<xsl:when test=".='1'">Адрес регистрации: </xsl:when>
								<xsl:when test=".='2'">Фактический адрес: </xsl:when>
								<xsl:when test=".='3'">Почтовый адрес: </xsl:when>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="local-name()='CountryCode'">
							<xsl:if test="not(../RUScat_ru:CounryName)">
								<xsl:apply-templates select="."/>
								<xsl:if test="position()!=$last">, </xsl:if>
							</xsl:if>
						</xsl:when>
						<xsl:when test="local-name()='KLADR' or local-name()='AOGUID' or local-name()='AOID'">
							<!--в этом случае ничего не выводим-->
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="."/>
							<xsl:if test="position()!=$last">, </xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Реквизиты организации -->
	<xsl:template match="*" mode="org">
		<xsl:apply-templates select="cat_ru:OrganizationName"/>
		<xsl:if test="cat_ru:ShortName">
			<span class="graph">(</span>
			<xsl:apply-templates select="cat_ru:ShortName"/>
			<span class="graph">)</span>
		</xsl:if>
		<xsl:if test="RUDECLcat:SubjectAdditionalCode='1'"> 'контрагент'</xsl:if>
		<xsl:if test="RUDECLcat:SubjectAdditionalCode='2'"> 'РАЗНЫЕ ПО СПИСКУ'</xsl:if>
		<br/>
		<xsl:if test="cat_ru:RBOrganizationFeatures and (local-name(.)!='Declarant' or //ESADout_CU:RecipientCountryCode='BY')">
			<xsl:text>№ </xsl:text>
			<xsl:if test="cat_ru:RBOrganizationFeatures/cat_ru:UNP">
				<xsl:apply-templates select="cat_ru:RBOrganizationFeatures/cat_ru:UNP"/>
			</xsl:if>
			<br/>
		</xsl:if>
		<xsl:if test="cat_ru:RKOrganizationFeatures and (local-name(.)!='Declarant' or //ESADout_CU:RecipientCountryCode='KZ')">
			<xsl:text>№ </xsl:text>
			<xsl:if test="cat_ru:RKOrganizationFeatures/cat_ru:BIN">
				<xsl:apply-templates select="cat_ru:RKOrganizationFeatures/cat_ru:BIN"/>
			</xsl:if>
			<xsl:if test="cat_ru:RKOrganizationFeatures/cat_ru:IIN">
				<xsl:apply-templates select="cat_ru:RKOrganizationFeatures/cat_ru:IIN"/>
			</xsl:if>
			<br/>
		</xsl:if>
		<xsl:if test="cat_ru:RFOrganizationFeatures and (local-name(.)!='Declarant' or //ESADout_CU:RecipientCountryCode='RU')">
			<xsl:text>№ </xsl:text>
			<xsl:if test="cat_ru:RFOrganizationFeatures/cat_ru:INN">
				<xsl:apply-templates select="cat_ru:RFOrganizationFeatures/cat_ru:INN"/>
			</xsl:if>
			<xsl:if test="cat_ru:RFOrganizationFeatures/cat_ru:KPP">
				<xsl:text> / </xsl:text>
				<xsl:apply-templates select="cat_ru:RFOrganizationFeatures/cat_ru:KPP"/>
			</xsl:if>
			<br/>
		</xsl:if>
		<xsl:if test="RUScat_ru:SubjectAddressDetails">
			<xsl:for-each select="RUScat_ru:SubjectAddressDetails">
				<xsl:apply-templates mode="ru_address" select="."/>
				<xsl:if test="position()!=last()">; </xsl:if>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="RUScat_ru:CommunicationDetails/cat_ru:E_mail">
			<xsl:if test="RUScat_ru:SubjectAddressDetails">
				<xsl:text>; </xsl:text>
			</xsl:if>
			<xsl:for-each select="RUScat_ru:CommunicationDetails/cat_ru:E_mail">
				<xsl:apply-templates select="."/>
				<xsl:if test="position()!=last()">, </xsl:if>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="RUScat_ru:SubjectBranch">
			<br/>
			<xsl:apply-templates select="RUScat_ru:SubjectBranch/cat_ru:OrganizationName"/>
			<br/>
			<xsl:if test="RUScat_ru:SubjectBranch/RUScat_ru:SubjectAddressDetails">
				<xsl:apply-templates mode="ru_address" select="RUScat_ru:SubjectBranch/RUScat_ru:SubjectAddressDetails"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="(cat_ru:RFOrganizationFeatures) or (cat_ru:RBOrganizationFeatures) or (cat_ru:RKOrganizationFeatures)">
			<br/>
			<xsl:text>№ </xsl:text>
			<xsl:if test="cat_ru:RKOrganizationFeatures/cat_ru:ITN">
				<xsl:apply-templates select="cat_ru:RKOrganizationFeatures/cat_ru:ITN/cat_ru:CategoryCode"/>/
					<xsl:apply-templates select="cat_ru:RKOrganizationFeatures/cat_ru:ITN/cat_ru:KATOCode"/>/
					<xsl:apply-templates select="cat_ru:RKOrganizationFeatures/cat_ru:ITN/cat_ru:RNN"/>/
					<xsl:apply-templates select="cat_ru:RKOrganizationFeatures/cat_ru:ITN/cat_ru:ITNReserv"/>
			</xsl:if>
			<xsl:if test="cat_ru:RFOrganizationFeatures/cat_ru:OGRN">
				<xsl:apply-templates select="cat_ru:RFOrganizationFeatures/cat_ru:OGRN"/>
			</xsl:if>
		</xsl:if>
		<br/>
		<xsl:apply-templates mode="spaceSeparated" select="RUScat_ru:IdentityCard"/>
	</xsl:template>
	<!--Товарная партия-->
	<xsl:template match="ESADout_CU:ESADout_CUGoodsShipment">
		<table cellpadding="0" cellspacing="0" style="width:100%;border:solid 0pt black;">
			<xsl:choose>
				<xsl:when test="(..//ESADout_CU:CustomsProcedure = 'ТТ') or(..//ESADout_CU:CustomsProcedure = 'TT') ">
					<tr>
						<td class="graphMain" colspan="2" style="width:{103*$k}mm;">ТРАНЗИТНАЯ ДЕКЛАРАЦИЯ</td>
						<td class="graph" style="width:{26.4*$k}mm;border-top:solid 2pt black;border-left:solid 2pt black;border-right:solid 2pt black;">
							<span class="graphNo">1</span>
							<span class="graph">ДЕКЛАРАЦИЯ</span>
						</td>
						<td class="graph" rowspan="4" style="width:{60.6*$k}mm;border-left:solid 0.8pt black;border-bottom:solid 0.8pt black;" valign="top"/>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td class="graphMain" colspan="2" style="width:{103*$k}mm;">ДЕКЛАРАЦИЯ НА ТОВАРЫ</td>
						<td style="width:{26.4*$k}mm;"/>
						<td class="graph" style="width:{60.6*$k}mm;border-left:solid 0.8pt black;" valign="top">
                    А 
                    <br>
								<xsl:choose>
									<xsl:when test="//*[@DocumentModeID='1006078E']/goom:GTDID">
										<xsl:apply-templates select="//*[@DocumentModeID='1006078E']/goom:GTDID" mode="graf_A"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates select="//*[@DocumentModeID='1004051E']/nGTDr:GTDID" mode="graf_A"/>
									</xsl:otherwise>
								</xsl:choose>
							</br>
						</td>
					</tr>
					<tr>
						<td class="graphMain" colspan="2" style="width:{103*$k}mm;">
							<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
						</td>
						<td class="graph" style="width:{26.4*$k}mm;border-top:solid 2pt black;border-left:solid 2pt black;border-right:solid 2pt black;">
							<span class="graphNo">1</span>
							<span class="graph">ДЕКЛАРАЦИЯ</span>
						</td>
						<td class="graph" rowspan="3" style="width:{60.6*$k}mm;border-bottom:solid 0.8pt black;" valign="top">
							<xsl:if test="//*[@DocumentModeID='1006078E']/goom:GTDOutCommonMark/catESAD_ru:GRNumber='A' or //*[@DocumentModeID='1006078E']/goom:GTDOutCommonMark/catESAD_ru:GRNumber='А'">
								<xsl:for-each select="//*[@DocumentModeID='1006078E']/goom:GTDOutCommonMark[catESAD_ru:GRNumber='A' or catESAD_ru:GRNumber='А']">
									<xsl:if test="position()!=1">
										<br/>
									</xsl:if>
									<xsl:apply-templates select="catESAD_ru:StageMarkIdentifier"/>
									<xsl:text>.</xsl:text>
									<xsl:apply-templates select="catESAD_ru:NoteMarkIdentifier"/>
									<xsl:if test="catESAD_ru:MarkDescription">
										<xsl:text> </xsl:text>
										<xsl:apply-templates select="catESAD_ru:MarkDescription"/>
									</xsl:if>
									<xsl:if test="catESAD_ru:Deadline">
										<xsl:text> </xsl:text>
										<xsl:apply-templates select="catESAD_ru:Deadline" mode="date"/>
										<!--xsl:call-template name="russian_date">
											<xsl:with-param name="dateIn" select="catESAD_ru:Deadline"/>
										</xsl:call-template-->
									</xsl:if>
									<xsl:text> </xsl:text>
									<xsl:apply-templates select="catESAD_ru:PersonName"/>
								</xsl:for-each>
							</xsl:if>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<tr valign="top">
				<td align="center" class="graphNum" style="width:{17*$k}mm;border:solid 1.5pt black;">1</td>
				<td rowspan="3" style="width:{86*$k}mm;border:solid 0.8pt black;background:#FFFFFF;">
					<table cellpadding="0" cellspacing="0" width="100%">
						<tr valign="top">
							<td class="graph" style="width:{43*$k}mm;">
								<span class="graphNo">2</span>
								<span class="graph">Отправитель/</span>
								<span class="graphTitleIt">Экспортер</span>
							</td>
							<td class="graph" style="width:{43*$k}mm;">
								<xsl:for-each select="ESADout_CU:ESADout_CUConsignor">
									<xsl:choose>
										<xsl:when test="ESADout_CU:DeclarantEqualFlag='1' or ESADout_CU:DeclarantEqualFlag='True' or ESADout_CU:DeclarantEqualFlag='true' or ESADout_CU:DeclarantEqualFlag='t'"/>
										<xsl:otherwise>
											<!--xsl:text>№ </xsl:text>
											<xsl:if test="cat_ru:RBOrganizationFeatures/cat_ru:UNP">
												<xsl:value-of select="cat_ru:RBOrganizationFeatures/cat_ru:UNP"/>
											</xsl:if>
											<xsl:if test="cat_ru:RKOrganizationFeatures/cat_ru:BIN">
												<xsl:value-of select="cat_ru:RKOrganizationFeatures/cat_ru:BIN"/>
											</xsl:if>
											<xsl:if test="cat_ru:RKOrganizationFeatures/cat_ru:IIN">
												<xsl:value-of select="cat_ru:RKOrganizationFeatures/cat_ru:IIN"/>
											</xsl:if>
											<xsl:if test="cat_ru:RFOrganizationFeatures/cat_ru:INN">
												<xsl:value-of select="cat_ru:RFOrganizationFeatures/cat_ru:INN"/>
											</xsl:if>
											<xsl:if test="cat_ru:RFOrganizationFeatures/cat_ru:KPP">
												<xsl:text> / </xsl:text>
												<xsl:value-of select="cat_ru:RFOrganizationFeatures/cat_ru:KPP"/>
											</xsl:if-->
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
							</td>
						</tr>
						<tr>
							<td class="graph" colspan="2" style="width:{86*$k}mm;">
								<xsl:for-each select="ESADout_CU:ESADout_CUConsignor">
									<xsl:apply-templates select="."/>
								</xsl:for-each>
							</td>
						</tr>
					</table>
				</td>
				<td style="width:{26.4*$k}mm;border-left:solid 2pt black;border-right:solid 2pt black;border-bottom:solid 1.5pt black;">
					<table cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td align="center" class="graph" rowspan="2" style="width:{8.8*$k}mm;border-right:solid 0.8pt black;background:#FFFFFF;">
								<xsl:apply-templates select="//ESADout_CU:CustomsProcedure"/>
							</td>
							<td align="center" class="graph" rowspan="2" style="width:{4.4*$k}mm;">
								<xsl:choose>
									<xsl:when test="(..//ESADout_CU:CustomsProcedure = 'ТТ') or (..//ESADout_CU:CustomsProcedure = 'TT')">
										<xsl:apply-templates select="//ESADout_CU:TransitFeature"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates select="//ESADout_CU:CustomsModeCode"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td align="center" class="graph" rowspan="2" style="width:{13.2*$k}mm;border-left:solid 0.8pt black;background:#FFFFFF;">
								<!--xsl:if test="//ESADout_CU:ElectronicDocumentSign">
									<xsl:value-of select="'ЭД '"/>
								</xsl:if-->
								<xsl:apply-templates select="//ESADout_CU:ElectronicDocumentSign"/>
								<xsl:apply-templates select="//ESADout_CU:TransitDirectionCode"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td rowspan="9" style="width:{17*$k}mm;border-left:solid 1.5pt black;border-right:solid 1.5pt black;"/>
				<td style="width:{26.4*$k}mm;border:solid 0.8pt black;background:#FFFFFF;" valign="bottom">
					<table cellpadding="0" cellspacing="0" width="100%">
						<tr valign="top">
							<td class="graph" colspan="2" style="width:{13.2*$k}mm;border-right:solid 0.8pt black;">
								<span class="graphNo">3</span>
								<span class="graph">Формы</span>
							</td>
							<td class="graph" rowspan="2" style="width:{13.2*$k}mm;border-left:solid 0.8pt black;">
								<span class="graphNo">4</span>
								<span class="graph" style="white-space: nowrap;">Отгр. спец.</span>
								<br/>
								<xsl:apply-templates select="catESAD_cu:SpecificationNumber"/>
								<xsl:if test="catESAD_cu:SpecificationNumber and catESAD_cu:SpecificationListNumber">
									<xsl:text> / </xsl:text>
								</xsl:if>
								<xsl:apply-templates select="catESAD_cu:SpecificationListNumber"/>
							</td>
						</tr>
						<tr valign="top">
							<td align="center" class="graph" style="width:{6.6*$k}mm;border-right:solid 0.8pt black;">1</td>
							<td align="center" class="graph" style="width:{6.6*$k}mm;border-left:solid 0.8pt black;border-right:solid 0.8pt black;">
								<xsl:apply-templates select="catESAD_cu:TotalSheetNumber"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="width:{87*$k}mm;border:solid 0.8pt black;">
					<table cellpadding="0" cellspacing="0" width="100%">
						<tr valign="top">
							<td align="center" class="graph" style="width:{13.2*$k}mm;border-right:solid 0.8pt black;background:#FFFFFF;">
								<span class="graphNo">5</span>
								<span class="graph">Всего т-ов</span>
								<br/>
								<xsl:apply-templates select="catESAD_cu:TotalGoodsNumber"/>
							</td>
							<td align="center" class="graph" style="width:{18.4*$k}mm;border-left:solid 0.8pt black;border-right:solid 0.8pt black;background:#FFFFFF;">
								<span class="graphNo">6</span>
								<span class="graph">Всего мест</span>
								<br/>
								<xsl:choose>
									<xsl:when test="catESAD_cu:TotalPackageNumber!=''">
										<xsl:apply-templates select="catESAD_cu:TotalPackageNumber"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td class="graph" style="width:{45.4*$k}mm;border-left:solid 0.8pt black;">
								<span class="graphNo">7</span>
								<span class="graph">Справочный номер</span>
								<br/>
								<xsl:apply-templates select="//ESADout_CU:DeclarationKind"/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr valign="top">
				<td rowspan="2" style="width:{86*$k}mm;border:solid 0.8pt black;background:#FFFFFF;">
					<table cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td class="graph" style="width:{43*$k}mm;">
								<span class="graphNo">8</span>
								<span class="graph">Получатель</span>
							</td>
							<td class="graph" style="width:{43*$k}mm;">
								<xsl:for-each select="ESADout_CU:ESADout_CUConsignee">
									<xsl:choose>
										<xsl:when test="ESADout_CU:DeclarantEqualFlag='1' or ESADout_CU:DeclarantEqualFlag='True' or ESADout_CU:DeclarantEqualFlag='true' or ESADout_CU:DeclarantEqualFlag='t'"> </xsl:when>
										<!--xsl:otherwise>
											<xsl:text>№ </xsl:text>
											<xsl:if test="cat_ru:RBOrganizationFeatures/cat_ru:UNP">
												<xsl:value-of select="cat_ru:RBOrganizationFeatures/cat_ru:UNP"/>
											</xsl:if>
											<xsl:if test="cat_ru:RKOrganizationFeatures/cat_ru:BIN">
												<xsl:value-of select="cat_ru:RKOrganizationFeatures/cat_ru:BIN"/>
											</xsl:if>
											<xsl:if test="cat_ru:RKOrganizationFeatures/cat_ru:IIN">
												<xsl:value-of select="cat_ru:RKOrganizationFeatures/cat_ru:IIN"/>
											</xsl:if>
											<xsl:if test="cat_ru:RFOrganizationFeatures/cat_ru:INN">
												<xsl:value-of select="cat_ru:RFOrganizationFeatures/cat_ru:INN"/>
											</xsl:if>
											<xsl:if test="cat_ru:RFOrganizationFeatures/cat_ru:KPP">
												<xsl:text> / </xsl:text>
												<xsl:value-of select="cat_ru:RFOrganizationFeatures/cat_ru:KPP"/>
											</xsl:if>
										</xsl:otherwise-->
									</xsl:choose>
								</xsl:for-each>
							</td>
						</tr>
						<tr>
							<td class="graph" colspan="2" style="width:{86*$k}mm;">
								<xsl:for-each select="ESADout_CU:ESADout_CUConsignee">
									<xsl:apply-templates select="."/>
								</xsl:for-each>
							</td>
						</tr>
					</table>
				</td>
				<td class="graph" colspan="2" style="width:{87*$k}mm;border:solid 0.8pt black;" valign="top">
					<span class="graphNo">9</span>
					<span class="graph">Лицо, ответственное за финансовое урегулирование </span>
					<br/>
					<xsl:if test="ESADout_CU:ESADout_CUFinancialAdjustingResponsiblePerson">
						<xsl:for-each select="ESADout_CU:ESADout_CUFinancialAdjustingResponsiblePerson">
							<xsl:choose>
								<xsl:when test="ESADout_CU:DeclarantEqualFlag='1' or ESADout_CU:DeclarantEqualFlag='True' or ESADout_CU:DeclarantEqualFlag='true' or ESADout_CU:DeclarantEqualFlag='t'">
									<br/>СМ. ГРАФУ 14 ДТ</xsl:when>
								<xsl:otherwise>
									<!--xsl:if test="cat_ru:RBOrganizationFeatures/cat_ru:UNP">
										<xsl:value-of select="cat_ru:RBOrganizationFeatures/cat_ru:UNP"/>
									</xsl:if>
									<xsl:if test="cat_ru:RKOrganizationFeatures/cat_ru:BIN">
										<xsl:value-of select="cat_ru:RKOrganizationFeatures/cat_ru:BIN"/>
									</xsl:if>
									<xsl:if test="cat_ru:RKOrganizationFeatures/cat_ru:IIN">
										<xsl:value-of select="cat_ru:RKOrganizationFeatures/cat_ru:IIN"/>
									</xsl:if>
									<xsl:if test="cat_ru:RFOrganizationFeatures/cat_ru:INN">
										<xsl:value-of select="cat_ru:RFOrganizationFeatures/cat_ru:INN"/>
									</xsl:if>
									<xsl:if test="cat_ru:RFOrganizationFeatures/cat_ru:KPP">
										<xsl:text> / </xsl:text>
										<xsl:value-of select="cat_ru:RFOrganizationFeatures/cat_ru:KPP"/>
									</xsl:if>
									<br/-->
									<xsl:apply-templates mode="org" select="."/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:if>
				</td>
			</tr>
			<tr valign="top">
				<td colspan="2" style="width:{87*$k}mm;border:solid 0.8pt black;">
					<table cellpadding="0" cellspacing="0" style="width:100%;border:solid 0pt black;">
						<tr valign="top">
							<td class="graph" colspan="2" style="width:{15.4*$k}mm;">
								<span class="graphNo">10</span>
								<span class="graph">Стр.перв.назнач/</span>
							</td>
							<td class="graph" colspan="2" style="width:{16.2*$k}mm;border-left:solid 0.8pt black;border-right:solid 0.8pt black;">
								<span class="graphNo">11</span>
								<span class="graph">Торг.страна</span>
							</td>
							<td class="graph" rowspan="2" style="width:{43.6*$k}mm;border-left:solid 0.8pt black;border-right:solid 0.8pt black;">
								<span class="graphNo">12</span>
								<span class="graph">Общая таможенная стоимость</span>
								<br/>
								<br/>
								<xsl:if test="catESAD_cu:TotalCustCost">
									<xsl:apply-templates select="catESAD_cu:TotalCustCost" mode="format_number_2"/>
									<!--xsl:value-of select="format-number(catESAD_cu:TotalCustCost,'0.00')"/-->
								</xsl:if>
								<xsl:if test="catESAD_cu:TotalCustomsValueAmount"> / <xsl:apply-templates select="catESAD_cu:TotalCustomsValueAmount" mode="format_number_2"/>
									<!--xsl:value-of select="format-number(catESAD_cu:TotalCustomsValueAmount,'0.00')"/-->
								</xsl:if>
							</td>
							<td class="graph" rowspan="2" style="width:{11.8*$k}mm;border-left:solid 0.8pt black;word-break: break-all;">
								<span class="graphNo">13</span>
								<span class="graph"> </span>
							</td>
						</tr>
						<tr>
							<td align="center" class="graph" style="width:{8.8*$k}mm;border-left:solid 0.8pt black;border-right:solid 0.8pt black;border-bottom:solid 0.8pt black;">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
							<td align="center" class="graph" style="width:{8.8*$k}mm;border-right:solid 0.8pt black;border-bottom:solid 0.8pt black;">
								<span class="graph">посл.отп.</span>
							</td>
							<td align="center" class="graph" style="width:{8.8*$k}mm;border-left:solid 0.8pt black;border-right:solid 0.8pt black;">
								<xsl:choose>
									<xsl:when test="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:TradeCountryCode!=''">
										<xsl:apply-templates select="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:TradeCountryCode"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td align="center" class="graph" style="width:{8.8*$k}mm;border-left:solid 0.8pt black;border-right:solid 0.8pt black;">
								<xsl:choose>
									<xsl:when test="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:RBCountryCode!=''">
										<xsl:apply-templates select="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:RBCountryCode"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr valign="top">
				<td rowspan="2" style="width:{86*$k}mm;border:solid 0.8pt black;">
					<table cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td class="graph" style="width:{43*$k}mm;">
								<span class="graphNo">14</span>
								<span class="graph">Декларант</span>
							</td>
							<td class="graph" style="width:{43*$k}mm;">
								<xsl:if test="ESADout_CU:ESADout_CUDeclarant/RUDECLcat:AEORegistryIdDetails/catESAD_cu:DocId">
									<xsl:text>№ </xsl:text>
									<xsl:apply-templates select="ESADout_CU:ESADout_CUDeclarant/RUDECLcat:AEORegistryIdDetails/catESAD_cu:DocId"/>
								</xsl:if>
							</td>
						</tr>
						<tr valign="top">
							<td class="graph" colspan="2" style="width:{86*$k}mm;">
								<xsl:if test="ESADout_CU:ESADout_CUDeclarant">
									<xsl:apply-templates mode="org" select="ESADout_CU:ESADout_CUDeclarant"/>
								</xsl:if>
							</td>
						</tr>
					</table>
				</td>
				<td colspan="2" style="vertical-align: bottom;border-right:solid 0.8pt black;" valign="top">
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td class="graph" style="width:{43.5*$k}mm;background:#FFFFFF;">
								<span class="graphNo">15</span>
								<span class="graph">Страна отправления</span>
								<br/>
								<xsl:apply-templates select="ESADout_CU:ESADout_CUConsigment/catESAD_cu:DispatchCountryName"/>
							</td>
							<td style="vertical-align: bottom;border:solid 0.8pt black;">
								<table cellpadding="0" cellspacing="0" style="width:100%;">
									<tr>
										<td class="graph" colspan="4" style="width:{25.6*$k}mm;">
											<span class="graphNo">15</span>
											<span class="graph">Код страны отпр.</span>
										</td>
									</tr>
									<tr>
										<br/>
										<td class="graph" style="width:{2.2*$k}mm;border-right:solid 0.8pt black;">a
                                </td>
										<td align="center" class="graph" style="width:{9.6*$k}mm;border-right:solid 0.8pt black;">
											<xsl:choose>
												<xsl:when test="ESADout_CU:ESADout_CUConsigment/catESAD_cu:DispatchCountryCode!=''">
													<xsl:apply-templates select="ESADout_CU:ESADout_CUConsigment/catESAD_cu:DispatchCountryCode"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
										<td class="graph" style="width:{2.2*$k}mm;border-right:solid 0.8pt black;">b
                                    </td>
										<td align="center" class="graph" style="width:{7.6*$k}mm;">
											<xsl:choose>
												<xsl:when test="ESADout_CU:ESADout_CUConsigment/catESAD_cu:RBDispatchCountryCode!=''">
													<xsl:apply-templates select="ESADout_CU:ESADout_CUConsigment/catESAD_cu:RBDispatchCountryCode"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
									</tr>
								</table>
							</td>
							<td>
								<table cellpadding="0" cellspacing="0" style="width:100%;">
									<tr>
										<td class="graph" colspan="4" style="width:{21.7*$k}mm;">
											<span class="graphNo">17</span>
											<span class="graph">Код страны назнач.</span>
										</td>
									</tr>
									<tr>
										<br/>
										<td class="graph" style="width:{2.2*$k}mm;border-right:solid 0.8pt black;">a
                                </td>
										<td align="center" class="graph" style="width:{9.6*$k}mm;border-right:solid 0.8pt black;">
											<xsl:choose>
												<xsl:when test="ESADout_CU:ESADout_CUConsigment/catESAD_cu:DestinationCountryCode!=''">
													<xsl:apply-templates select="ESADout_CU:ESADout_CUConsigment/catESAD_cu:DestinationCountryCode"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
										<td class="graph" style="width:{2.2*$k}mm;border-right:solid 0.8pt black;">b
                                    </td>
										<td align="center" class="graph" style="width:{7.6*$k}mm;">
											<xsl:choose>
												<xsl:when test="ESADout_CU:ESADout_CUConsigment/catESAD_cu:RBDestinationCountryCode!=''">
													<xsl:apply-templates select="ESADout_CU:ESADout_CUConsigment/catESAD_cu:RBDestinationCountryCode"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="width:{87*$k}mm;border:solid 0.8pt black;" valign="top">
					<table cellpadding="0" cellspacing="0" width="100%">
						<tr valign="top">
							<td class="graph" style="width:{43.5*$k}mm; border-right: solid 0.8pt black; height: 100%;">
								<span class="graphNo">16</span>
								<span class="graph">Страна происхождения</span>
								<br/>
								<br/>
								<xsl:if test="catESAD_cu:OriginCountryName">
									<xsl:apply-templates select="catESAD_cu:OriginCountryName"/>
								</xsl:if>
								<xsl:if test="catESAD_cu:OriginCountryCode">
									<xsl:text> (</xsl:text>
									<xsl:apply-templates select="catESAD_cu:OriginCountryCode"/>
									<xsl:text>)</xsl:text>
								</xsl:if>
							</td>
							<td class="graph" style="width:{43.5*$k}mm;background:#FFFFFF;">
								<span class="graphNo">17</span>
								<span class="graph">Страна назначения</span>
								<br/>
								<xsl:apply-templates select="ESADout_CU:ESADout_CUConsigment/catESAD_cu:DestinationCountryName"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<table cellpadding="0" cellspacing="0" style="border-left:solid 0.8pt black;border-right:solid 0.8pt black;b" width="100%">
						<tr valign="top">
							<td class="graph" colspan="2" style="width:{60.4*$k}mm;background:#FFFFFF;">
								<span class="graphNo">18</span>
								<span class="graph">Идентификация и страна регистрации трансп.средства при отправлении/прибытии</span>
							</td>
							<td align="center" class="graph" style="width:{10*$k}mm;border-left:solid 2pt black;border-bottom:solid 0pt black;border-right:solid 2pt black;background:#FFFFFF;">
								<span class="graphNo">19</span>
								<span class="graph">Конт.</span>
							</td>
							<td class="graph" colspan="3" style="width:{91.1*$k}mm;border-left:solid 0pt black;">
								<span class="graphNo">20</span>
								<span class="graph">Условия поставки</span>
							</td>
						</tr>
						<tr>
							<td class="graph" style="width:{56.3*$k}mm;background:#FFFFFF;">
								<xsl:choose>
									<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUDepartureArrivalTransport">
										<xsl:apply-templates select="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUDepartureArrivalTransport/ESADout_CU:TransportMeansQuantity"/>
										<xsl:text>:</xsl:text>
										<xsl:for-each select="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUDepartureArrivalTransport/ESADout_CU:TransportMeans">
											<xsl:if test="position() &gt; 1">; </xsl:if>
											<xsl:apply-templates select="cat_ru:TransportIdentifier"/>
											<xsl:if test="catESAD_cu:FirstTrailerRegId">
												<xsl:text> / </xsl:text>
												<xsl:apply-templates select="catESAD_cu:FirstTrailerRegId"/>
											</xsl:if>
											<xsl:if test="catESAD_cu:SecondTrailerRegId">
												<xsl:text> / </xsl:text>
												<xsl:apply-templates select="catESAD_cu:SecondTrailerRegId"/>
											</xsl:if>
											<!--xsl:value-of select="cat_ru:TransportIdentifier[../cat_ru:ActiveTransportIdentifier=false()]"/>
											<xsl:variable name="ActiveTSNum" select="cat_ru:TransportIdentifier[../cat_ru:ActiveTransportIdentifier=false()]"/>
											<xsl:if test="following-sibling::ESADout_CU:TransportMeans/cat_ru:ActiveTransportIdentifier=./cat_ru:TransportIdentifier">
												<xsl:for-each select="following-sibling::ESADout_CU:TransportMeans/cat_ru:TransportIdentifier[../cat_ru:ActiveTransportIdentifier=$ActiveTSNum]">/<xsl:value-of select="."/>
												</xsl:for-each>
											</xsl:if>
											<xsl:variable name="count" select="count(../ESADout_CU:TransportMeans[cat_ru:ActiveTransportIdentifier=false()])"/>
											<xsl:if test="position() != $count and cat_ru:ActiveTransportIdentifier=false()">;&#032;</xsl:if-->
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								<xsl:choose>
									<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUDepartureArrivalTransport/ESADout_CU:MethodTransport=1">газопровод </xsl:when>
									<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUDepartureArrivalTransport/ESADout_CU:MethodTransport=2">нефтепровод </xsl:when>
									<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUDepartureArrivalTransport/ESADout_CU:MethodTransport=3">нефтепродуктопровод </xsl:when>
									<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUDepartureArrivalTransport/ESADout_CU:MethodTransport=4">линия электропередачи </xsl:when>
								</xsl:choose>
								<xsl:if test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUDepartureArrivalTransport/ESADout_CU:NameObject">
									<xsl:apply-templates select="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUDepartureArrivalTransport/ESADout_CU:NameObject"/>
								</xsl:if>
							</td>
							<td align="center" class="graph" style="width:{5.8*$k}mm;border-left:solid 2pt black;border-bottom:solid 1.5pt black;background:#FFFFFF;">
								<xsl:choose>
									<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUDepartureArrivalTransport/cat_ru:TransportNationalityCode!=''">
										<xsl:apply-templates select="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUDepartureArrivalTransport/cat_ru:TransportNationalityCode"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td align="center" class="graph" style="width:{10*$k}mm;border-left:solid 2pt black;border-bottom:solid 1.5pt black;border-right:solid 2pt black;" valign="bottom">
								<!--	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>-->
								<xsl:choose>
									<xsl:when test="(number(ESADout_CU:ESADout_CUConsigment/catESAD_cu:ContainerIndicator)=1) or (ESADout_CU:ESADout_CUConsigment/catESAD_cu:ContainerIndicator='t') or (ESADout_CU:ESADout_CUConsigment/catESAD_cu:ContainerIndicator='true')">
                                        1
                                    </xsl:when>
									<xsl:when test="(number(ESADout_CU:ESADout_CUConsigment/catESAD_cu:ContainerIndicator)=0) or (ESADout_CU:ESADout_CUConsigment/catESAD_cu:ContainerIndicator='f') or (ESADout_CU:ESADout_CUConsigment/catESAD_cu:ContainerIndicator='false')">
                                        0
                                    </xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td class="graph" style="width:{53.3*$k}mm;" valign="bottom">
								<table>
									<tbody>
										<tr>
											<td style="width:{10*$k}mm;border-right:solid 1pt black;">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</td>
											<td>
												<xsl:choose>
													<xsl:when test="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:CUESADDeliveryTerms/cat_ru:DeliveryTermsStringCode!=''">
														<xsl:apply-templates select="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:CUESADDeliveryTerms/cat_ru:DeliveryTermsStringCode"/>
													</xsl:when>
												</xsl:choose>
												<xsl:choose>
													<xsl:when test="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:CUESADDeliveryTerms/cat_ru:DeliveryPlace!=''">
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:for-each select="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:CUESADDeliveryTerms/cat_ru:DeliveryPlace">
															<xsl:apply-templates select="."/>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													</xsl:otherwise>
												</xsl:choose>
												<xsl:apply-templates select="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:CUESADDeliveryTerms/cat_ru:TransferPlace"/>
											</td>
										</tr>
									</tbody>
								</table>
							</td>
							<td class="graph" style="width:{12*$k}mm;border-bottom:solid 0pt black;border-left:solid 1pt black;">
								<xsl:apply-templates select="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:CUESADDeliveryTerms/cat_ru:DeliveryTermsRBCode"/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="3" style="width:{173*$k}mm;border:solid 0.8pt black;" valign="top">
					<table cellpadding="0" cellspacing="0" width="100%">
						<tr valign="top">
							<td class="graph" colspan="2" style="width:{88*$k}mm;border-right:solid 1pt black;background:#FFFFFF;">
								<span class="graphNo">21</span>
								<span class="graph">Идентификация и страна регистрации активного
                                    трансп.средства на границе
                                </span>
							</td>
							<td class="graph" colspan="2" style="width:{37.5*$k}mm;border-left:solid 1pt black;border-right:solid 0.8pt black;">
								<span class="graphNo">22</span>
								<span class="graph">Валюта и общая сумма по счету</span>
							</td>
							<td align="center" class="graph" rowspan="2" style="width:{19*$k}mm;border-left:solid 1pt black;border-right:solid 0.8pt black;">
								<span class="graphNo">23</span>
								<span class="graph">Курс валюты</span>
								<br/>
								<br/>
								<xsl:apply-templates select="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:ContractCurrencyRate"/>
							</td>
							<td class="graph" colspan="3" style="width:{28.5*$k}mm;">
								<span class="graphNo">24</span>
								<span class="graph">Характер сделки</span>
							</td>
						</tr>
						<tr>
							<td class="graph" style="width:{78*$k}mm;background:#FFFFFF;">
								<xsl:choose>
									<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport">
										<xsl:if test="//ESADout_CU:TransitDirectionCode='ИМ'">
											<xsl:choose>
												<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/cat_ru:TransportModeCode=10">Морской траспорт </xsl:when>
												<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/cat_ru:TransportModeCode=20">Железнодорожный транспорт </xsl:when>
												<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/cat_ru:TransportModeCode=30">Автодорожный траспорт </xsl:when>
												<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/cat_ru:TransportModeCode=40">Воздушный транспорт </xsl:when>
												<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/cat_ru:TransportModeCode=50">Почтовое отправление</xsl:when>
												<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/cat_ru:TransportModeCode=71">Трубопроводный траспорт</xsl:when>
												<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/cat_ru:TransportModeCode=72">Линии электропередачи</xsl:when>
												<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/cat_ru:TransportModeCode=80">Внутренний водный транспотр </xsl:when>
												<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/cat_ru:TransportModeCode=90">Транспортное средство, перемещающееся в качестве товара своим ходом</xsl:when>
												<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/cat_ru:TransportModeCode=99">Прочие </xsl:when>
											</xsl:choose>
										</xsl:if>
										<xsl:if test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/ESADout_CU:TransportMeansQuantity">
											<xsl:apply-templates select="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/ESADout_CU:TransportMeansQuantity"/>:</xsl:if>
										<xsl:for-each select="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/ESADout_CU:TransportMeans">
											<xsl:if test="position() &gt; 1">; </xsl:if>
											<xsl:if test="(cat_ru:ActiveTransportIdentifier) and not(cat_ru:TransportIdentifier) ">
												<xsl:apply-templates select="cat_ru:ActiveTransportIdentifier"/>
											</xsl:if>
											<xsl:if test="(cat_ru:TransportIdentifier)">
												<xsl:apply-templates select="cat_ru:TransportIdentifier"/>
											</xsl:if>
											<xsl:if test="(catESAD_cu:FirstTrailerRegId)">
												<xsl:text> / </xsl:text>
												<xsl:apply-templates select="catESAD_cu:FirstTrailerRegId"/>
											</xsl:if>
											<xsl:if test="(catESAD_cu:SecondTrailerRegId)">
												<xsl:text> / </xsl:text>
												<xsl:apply-templates select="catESAD_cu:SecondTrailerRegId"/>
											</xsl:if>
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								<xsl:choose>
									<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/ESADout_CU:MethodTransport=1">газопровод </xsl:when>
									<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/ESADout_CU:MethodTransport=2">нефтепровод </xsl:when>
									<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/ESADout_CU:MethodTransport=3">нефтепродуктопровод </xsl:when>
									<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/ESADout_CU:MethodTransport=4">линия электропередачи </xsl:when>
								</xsl:choose>
								<xsl:if test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/ESADout_CU:NameObject">
									<xsl:apply-templates select="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/ESADout_CU:NameObject"/>
								</xsl:if>
							</td>
							<td align="center" class="graph" style="width:{10*$k}mm;border-bottom:solid 1.5pt black;border-left:solid 2pt black;border-right:solid 1pt black;background:#FFFFFF;">
								<xsl:choose>
									<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/cat_ru:TransportNationalityCode!=''">
										<xsl:apply-templates select="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/cat_ru:TransportNationalityCode"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td align="center" class="graph" style="width:{7.8*$k}mm;border-left:solid 1pt black;border-bottom:solid 1.5pt black;border-right:solid 2pt black;">
								<xsl:choose>
									<xsl:when test="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:ContractCurrencyCode!=''">
										<xsl:apply-templates select="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:ContractCurrencyCode"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td align="center" class="graph" style="width:{29.7*$k}mm;border-right:solid 0.8pt black;">
								<xsl:if test="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:TotalInvoiceAmount!=''">
									<xsl:apply-templates select="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:TotalInvoiceAmount" mode="format_number_2"/>
									<!--xsl:value-of select="format-number(ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:TotalInvoiceAmount,'0.00')"/-->
								</xsl:if>
								<xsl:if test="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:TotalAmount!=''">
									<xsl:text> / </xsl:text>
									<xsl:apply-templates select="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:TotalAmount" mode="format_number_2"/>
									<!--xsl:value-of select="format-number(ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:TotalAmount,'0.00')"/-->
								</xsl:if>
							</td>
							<td align="center" class="graph" style="width:{10.4*$k}mm;border-right:solid 0.8pt black;">
								<xsl:apply-templates select="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:DealNatureCode"/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
							<td class="graph" style="width:{10.1*$k}mm;border-right:solid 0.8pt black;">
								<xsl:apply-templates select="ESADout_CU:ESADout_CUMainContractTerms/catESAD_cu:DealFeatureCode"/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
							<td class="graph" style="width:{9*$k}mm;">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td style="width:{86*$k}mm;border:solid 0.8pt black;">
					<table cellpadding="0" cellspacing="0" width="100%">
						<tr valign="top">
							<td class="graph" colspan="2" style="width:{18.8*$k}mm;background:#FFFFFF;">
								<span class="graphNo">25</span>
								<span class="graph">Вид транспорта</span>
							</td>
							<td class="graph" colspan="2" style="width:{18.8*$k}mm;border-left:solid 2pt black;border-right:solid 0.8pt black;">
								<span class="graphNo">26</span>
								<span class="graph">Вид транспорта</span>
							</td>
							<td class="graph" style="width:{48.4*$k}mm;border-left:solid 0.8pt black;background:#FFFFFF;">
								<span class="graphNo">27</span>
								<span class="graph">Место погрузки/разгрузки</span>
							</td>
						</tr>
						<tr>
							<!-- при транзите менять местами значения в 25 и 26 графах -->
							<td align="center" class="graph" style="width:{6.6*$k}mm;border-bottom:solid 1.5pt black;border-right:solid 2pt black;background:#FFFFFF;">
								<xsl:choose>
									<xsl:when test="..//ESADout_CU:CustomsProcedure = 'ТТ'">
										<xsl:for-each select="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUDepartureArrivalTransport/cat_ru:TransportModeCode">
											<xsl:apply-templates select="."/>
										</xsl:for-each>
									</xsl:when>
									<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/cat_ru:TransportModeCode!=''">
										<xsl:apply-templates select="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/cat_ru:TransportModeCode"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td class="graph" style="width:{12.2*$k}mm;background:#FFFFFF;">
								<span class="graph">на границе</span>
							</td>
							<td align="center" class="graph" style="width:{6.6*$k}mm;border-left:solid 2pt black;border-bottom:solid 1.5pt black;border-right:solid 2pt black;">
								<xsl:choose>
									<xsl:when test="..//ESADout_CU:CustomsProcedure = 'ТТ'">
										<xsl:apply-templates select="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUBorderTransport/cat_ru:TransportModeCode"/>
									</xsl:when>
									<xsl:when test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUDepartureArrivalTransport/cat_ru:TransportModeCode!=''">
										<xsl:for-each select="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUDepartureArrivalTransport/cat_ru:TransportModeCode">
											<xsl:apply-templates select="."/>
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td class="graph" style="width:{12.2*$k}mm;border-right:solid 0.8pt black;">
								<span class="graph">внутри страны</span>
							</td>
							<td class="graph" style="width:{48.4*$k}mm;border-left:solid 0.8pt black;background:#FFFFFF;">
								<!--xsl:apply-templates select="ESADout_CU:ESADoutConsigment/ESADout_CU:ESADoutLoadingPlace"/-->
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
						</tr>
					</table>
				</td>
				<td class="graph" colspan="2" rowspan="2" style="width:{87*$k}mm;border:solid 0.8pt black;" valign="top">
					<span class="graphNo">28</span>
					<span class="graph">Финансовые и банковские сведения</span>
					<br/>
				</td>
			</tr>
			<tr>
				<td align="center" class="graphNum" style="width:{17*$k}mm;border:solid 1.5pt black;">
                    1
                </td>
				<td style="width:{86*$k}mm;border:solid 0.8pt black;">
					<table cellpadding="0" cellspacing="0" width="100%">
						<tr valign="top">
							<td class="graph" style="width:{41.4*$k}mm;border-right:solid 0.8pt black;">
								<span class="graphNo">29</span>
								<span class="graph">Орган въезда/выезда</span>
								<br/>
								<xsl:for-each select="ESADout_CU:ESADout_CUConsigment/catESAD_cu:BorderCustomsOffice">
									<xsl:apply-templates select="cat_ru:Code"/>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:apply-templates select="cat_ru:OfficeName"/>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								</xsl:for-each>
							</td>
							<td class="graph" style="width:{44.6*$k}mm;border-left:solid 0.8pt black;">
								<span class="graphNo">30</span>
								<span class="graph">Местонахождение товаров</span>
								<br/>
								<xsl:for-each select="ESADout_CU:ESADout_CUGoodsLocation">
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:apply-templates select="ESADout_CU:InformationTypeCode"/>
									<xsl:if test="ESADout_CU:CustomsOffice">,
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:apply-templates select="ESADout_CU:CustomsOffice"/>,
									</xsl:if>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:if test="ESADout_CU:Address">
										<br/>
										<xsl:apply-templates mode="ru_address" select="ESADout_CU:Address"/>
										<br/>
									</xsl:if>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:if test="ESADout_CU:LocationName">
										<xsl:apply-templates select="ESADout_CU:LocationName"/>
									</xsl:if>,<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:if test="ESADout_CU:GoodsLocationWarehouse">
										<xsl:apply-templates select="ESADout_CU:GoodsLocationWarehouse/cat_ru:PrDocumentName"/>
										<!--N добавил,  как  в  примере pdp -->
										N<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:apply-templates select="ESADout_CU:GoodsLocationWarehouse/cat_ru:PrDocumentNumber"/>
										<xsl:if test="ESADout_CU:GoodsLocationWarehouse/cat_ru:PrDocumentDate">
										от<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates mode="date" select="ESADout_CU:GoodsLocationWarehouse/cat_ru:PrDocumentDate"/>
										</xsl:if>
									,</xsl:if>
									<xsl:if test="ESADout_CU:RegisterDocumentIdDetails/catESAD_cu:DocId">
										<xsl:text> св-во: </xsl:text>
										<xsl:apply-templates select="ESADout_CU:RegisterDocumentIdDetails/catESAD_cu:DocId"/>
									</xsl:if>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:if test="ESADout_CU:GoodsLocationPlace">
										<!--N добавил,  как  в  примере. pdp -->
										N<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:apply-templates select="ESADout_CU:GoodsLocationPlace/catESAD_cu:NumberCustomsZone"/>,
									</xsl:if>
									<xsl:if test="ESADout_CU:Transport">
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:apply-templates select="ESADout_CU:Transport/catESAD_cu:TransporKind"/>:<xsl:for-each select="ESADout_CU:Transport/catESAD_cu:TransporIdentifier">
											<xsl:apply-templates select="."/>
											<xsl:if test="position()!=last()">;</xsl:if>
										</xsl:for-each>
									</xsl:if>
									<br/>
								</xsl:for-each>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<xsl:apply-templates select="ESADout_CU:ESADout_CUGoods[position() = 1]"/>
		<table cellpadding="0" cellspacing="0" style="width:100%;">
			<tr valign="top">
				<td class="graph" style="border-right:solid 1px black; border-top: solid 1px black; border-bottom: solid 1px black; width: 73px;" valign="top">
					<span class="graphNo">47</span>
					<span class="graphColumn">Исчисление платежей</span>
				</td>
				<td class="graph" style="width: 45%;">
					<xsl:apply-templates mode="payments" select="ESADout_CU:ESADout_CUGoods[position() = 1]"/>
				</td>
				<td class="graph tl tr">
					<table cellpadding="1px" cellspacing="0" style="width: 100%">
						<tr>
							<td class="tb tr" style="width: 50%; vertical-align: top; min-height: 15pt;">
								<span class="graphNo">48</span>
								<span class="graph">Отсрочка платежей</span>
								<xsl:for-each select="//ESADout_CU:ESADout_CUPayments/ESADout_CU:CUDelayPayments">
									<br/>
									<xsl:apply-templates select="catESAD_cu:PaymentModeCode"/>
									<xsl:if test="catESAD_cu:EndDate">
										<xsl:text>-</xsl:text>
										<xsl:apply-templates select="catESAD_cu:EndDate" mode="date"/>
										<!--xsl:call-template name="russian_date">
											<xsl:with-param select="catESAD_cu:EndDate" name="dateIn"/>
										</xsl:call-template-->
									</xsl:if>
									<xsl:if test="catESAD_cu:PaymentSheduleDetails/catESAD_cu:EndDate">
										<xsl:text>-</xsl:text>
										<xsl:apply-templates select="catESAD_cu:PaymentSheduleDetails/catESAD_cu:EndDate" mode="date"/>
										<!--xsl:call-template name="russian_date">
											<xsl:with-param select="catESAD_cu:PaymentSheduleDetails/catESAD_cu:EndDate" name="dateIn"/>
										</xsl:call-template-->
									</xsl:if>
								</xsl:for-each>
							</td>
							<td class="tb" style="vertical-align: top;">
								<span class="graphNo">49</span>
								<span class="graph">Реквизиты склада</span>
							</td>
						</tr>
					</table>
					<span class="graphNo">B</span>
					<span class="graph">ПОДРОБНОСТИ ПОДСЧЕТА</span>
					<table cellpadding="1px" cellspacing="0" style="width:100%;">
						<tr>
							<td class="graph" style="width:{83*$k}mm;" valign="top">
								<xsl:for-each select="ESADout_CU:ESADout_CUPayments/ESADout_CU:ESADout_CUCustomsPayment">
									<xsl:if test="position() > 1">
										<br/>
									</xsl:if>
									<xsl:apply-templates select="catESAD_cu:PaymentModeCode"/>
									<span class="graph">-</span>
									<xsl:if test="catESAD_cu:PaymentAmount">
										<xsl:apply-templates select="catESAD_cu:PaymentAmount" mode="format_number_2"/>
										<!--xsl:value-of select="format-number(catESAD_cu:PaymentAmount,'0.00')"/-->
									</xsl:if>
									<xsl:if test="catESAD_cu:PaymentCurrencyCode">
										<span class="graph">-</span>
										<xsl:apply-templates select="catESAD_cu:PaymentCurrencyCode"/>
									</xsl:if>
									<!--  </xsl:for-each>
                     </td>
                     <td class="graph" style="width:{90*$k}mm;" valign="top">
                        <xsl:for-each select="ESADout_CU:ESADout_CUPayments/ESADout_CU:ESADout_CUCustomsPayment">-->
									<xsl:for-each select="ESADout_CU:PaymentDocument">-<xsl:apply-templates select="cat_ru:PrDocumentNumber"/>
										<xsl:if test="cat_ru:PrDocumentDate">
											<span class="graph">-</span>
											<xsl:apply-templates select="cat_ru:PrDocumentDate" mode="date"/>
											<!--xsl:call-template name="russian_date">
												<xsl:with-param name="dateIn" select="cat_ru:PrDocumentDate"/>
											</xsl:call-template-->
										</xsl:if>
									</xsl:for-each>
									<xsl:if test="ESADout_CU:PaymentWayCode">-<xsl:apply-templates select="ESADout_CU:PaymentWayCode"/>
									</xsl:if>
									<xsl:if test="ESADout_CU:RFOrganizationFeatures">
										<xsl:text>-</xsl:text>
										<xsl:apply-templates select="ESADout_CU:RFOrganizationFeatures/cat_ru:INN"/>
										<xsl:text> </xsl:text>
										<xsl:apply-templates select="ESADout_CU:RFOrganizationFeatures/cat_ru:KPP"/>
									</xsl:if>
									<xsl:if test="ESADout_CU:RKOrganizationFeatures">-<xsl:apply-templates select="ESADout_CU:RKOrganizationFeatures/cat_ru:BIN"/>
										<xsl:apply-templates select="ESADout_CU:RKOrganizationFeatures/cat_ru:IIN"/>
									</xsl:if>
									<xsl:if test="ESADout_CU:RBOrganizationFeatures">-<xsl:apply-templates select="ESADout_CU:RBOrganizationFeatures/cat_ru:UNP"/>
										<xsl:apply-templates select="ESADout_CU:RBOrganizationFeatures/cat_ru:RBIdentificationNumber"/>
									</xsl:if>
									<xsl:if test="ESADout_CU:UITN/RUScat_ru:UITNCode">
										<xsl:text>-</xsl:text>
										<xsl:apply-templates select="ESADout_CU:UITN/RUScat_ru:UITNCode"/>
									</xsl:if>
									<xsl:for-each select="ESADout_CU:IdentityCard">
										<xsl:text>-</xsl:text>
										<xsl:apply-templates select="RUScat_ru:IdentityCardSeries"/>
										<xsl:text> </xsl:text>
										<xsl:apply-templates select="RUScat_ru:IdentityCardNumber"/>
									</xsl:for-each>
									<br/>
								</xsl:for-each>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0" style="width:100%;">
			<xsl:if test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUReloadingInfo">
				<tr valign="top">
					<td class="graph" style="border-right: 1px solid black; border-bottom: solid 1px black; border-top: 1px solid black; width: 73px;" valign="top">
						<span class="graphNo">55</span>
						<span class="graphColumn">Перегрузки</span>
					</td>
					<td class="graph" colspan="5" style="background:#FFFFFF;">
						<table cellpadding="0" cellspacing="0" style="width:100%;">
							<tr>
								<xsl:for-each select="ESADout_CU:ESADout_CUConsigment/ESADout_CU:ESADout_CUReloadingInfo">
									<td>
										<table cellpadding="0" cellspacing="0" style="width:100%;">
											<tr>
												<td class="graph" colspan="3" style="width:{177*$k}mm;border:solid 0.8pt black;" valign="top">
													<span class="graph">Место и страна:</span>
													<xsl:value-of select="catESAD_cu:ReloadCountryCode"/>
													<xsl:apply-templates select="catESAD_cu:ReloadCountryName"/>
													<xsl:apply-templates select="catESAD_cu:ReloadingCustomsOffice/cat_ru:Code"/>
													<xsl:apply-templates select="catESAD_cu:ReloadingCustomsOffice/cat_ru:OfficeName"/>
												</td>
											</tr>
											<tr>
												<td class="graph" colspan="3" style="width:{177*$k}mm;border:solid 0.8pt black;" valign="top">
													<span class="graph">Идентификация и страна регистрации нового транспортного
                                        средства:
                                    </span>
													<xsl:apply-templates select="catESAD_cu:ReloadingTransportMeans/cat_ru:TransportKindCode"/>,
													<xsl:for-each select="catESAD_cu:ReloadingTransportMeans/cat_ru:TransportIdentifier">
														<xsl:apply-templates select="."/>,
													</xsl:for-each>
													<xsl:if test="catESAD_cu:ReloadingTransportMeans/cat_ru:VIN">
														<xsl:apply-templates select="catESAD_cu:ReloadingTransportMeans/cat_ru:VIN"/>,
													</xsl:if>
													<xsl:if test="catESAD_cu:ReloadingTransportMeans/cat_ru:TransportMeansNationalityCode">
														<xsl:apply-templates select="catESAD_cu:ReloadingTransportMeans/cat_ru:TransportMeansNationalityCode"/>
													</xsl:if>
												</td>
											</tr>
											<tr>
												<td class="graph" style="width:{20*$k}mm;border:solid 0.8pt black;" valign="top">
													<span class="graph">Конт</span>
												</td>
												<td align="center" class="graph" style="width:{10*$k}mm;border:solid 1.5pt black;" valign="top">
													<xsl:value-of select="number(boolean(catESAD_cu:ContainerIndicator))"/>
												</td>
												<td class="graph" style="width:{147*$k}mm;border:solid 0.8pt black;" valign="top">
													<span class="graph">(1) Номер нового контейнера </span>
													<xsl:for-each select="catESAD_cu:ReloadContainer/catESAD_cu:ContainerNumber">
														<xsl:apply-templates select="."/>, 
													</xsl:for-each>
												</td>
											</tr>
											<tr>
												<td class="graph" colspan="3" style="width:{177*$k}mm;border:solid 0.8pt black;" valign="top">
													<span class="graph">(1) Указывается 1, если ДА или 0, если НЕТ</span>
												</td>
											</tr>
										</table>
									</td>
								</xsl:for-each>
							</tr>
						</table>
					</td>
				</tr>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="(..//ESADout_CU:CustomsProcedure = 'ТТ') or (..//ESADout_CU:CustomsProcedure = 'TT')">
					<tr valign="top">
						<td class="graph" style="width:{13*$k}mm;border-right:solid 0.8pt black;" valign="top"/>
						<td class="graph" colspan="5" style="width:{177*$k}mm;border:solid 0.8pt black;">
							<table cellpadding="0" cellspacing="0" style="width:100%;">
								<tr>
									<td class="graph" style="width:{40*$k}mm;background:#FFFFFF;">
										<span class="graphNo">50</span>
										<span class="graph">Принципал</span>
									</td>
									<td class="graph" style="width:{60*$k}mm;background:#FFFFFF;">
										<span class="graph">№</span>
										<!--xsl:value-of select="ESADout_CU:ESADoutPrincipal/cat_ru:OGRN"/-->
									</td>
									<td class="graph" style="width:{20*$k}mm;background:#FFFFFF;">
										<span class="graph">Подпись:</span>
									</td>
									<td class="graph" rowspan="4" style="width:{57*$k}mm;border-left:solid 0.8pt black;" valign="top">
										<span class="graphNo">С</span>
										<span class="graph">ОРГАН ОТПРАВЛЕНИЯ</span>
										<br/>
										<!--xsl:if test="//*[@DocumentModeID='1006078E']/goom:GTDOutResolution">
											<xsl:for-each select="//*[@DocumentModeID='1006078E']/goom:GTDOutResolution">
												<xsl:for-each select="*[local-name()='DecisionCode' or local-name()='ResolutionDescription' or local-name()='DateInf']">
													<xsl:choose>
														<xsl:when test="local-name()='DateInf'">
															<xsl:call-template name="russian_date">
																<xsl:with-param name="dateIn" select="."/>
															</xsl:call-template>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="."/>
														</xsl:otherwise>
													</xsl:choose>
													<xsl:if test="position()!=last()"><xsl:text> </xsl:text></xsl:if>
													<xsl:if test="position()=last()"><br/></xsl:if>
												</xsl:for-each>
												<xsl:value-of select="catESAD_ru:LNP"/>
											</xsl:for-each>
										</xsl:if-->
									</td>
								</tr>
								<tr>
									<td class="graph" colspan="3" style="width:{120*$k}mm;background:#FFFFFF;">
									</td>
								</tr>
								<tr>
									<td class="graph" colspan="3" style="width:{120*$k}mm;background:#FFFFFF;">
										<span class="graph">представленный </span>
										<xsl:if test="(..//ESADout_CU:CustomsProcedure = 'ТТ') or(..//ESADout_CU:CustomsProcedure = 'TT') ">
											<xsl:for-each select="ESADout_CU:ESADout_CUDeclarant">
												<xsl:apply-templates select="cat_ru:OrganizationName"/>
												<xsl:if test="cat_ru:ShortName">
													<span class="graph">(</span>
													<xsl:apply-templates select="cat_ru:ShortName"/>
													<span class="graph">)</span>
													<xsl:text> </xsl:text>
												</xsl:if>
												<xsl:for-each select="RUScat_ru:SubjectAddressDetails">
													<xsl:apply-templates mode="ru_address" select="."/>
												</xsl:for-each>
											</xsl:for-each>
											<xsl:text> </xsl:text>
											<xsl:if test="ESADout_CU:ESADout_CUCarrier"> перевозчик
												<xsl:for-each select="ESADout_CU:ESADout_CUCarrier">
													<xsl:apply-templates select="cat_ru:OrganizationName"/>
													<xsl:if test="cat_ru:ShortName">
														<span class="graph">(</span>
														<xsl:apply-templates select="cat_ru:ShortName"/>
														<span class="graph">)</span>
													</xsl:if>
													<xsl:text> </xsl:text>
													<xsl:for-each select="RUScat_ru:SubjectAddressDetails">
														<xsl:apply-templates mode="ru_address" select="."/>
													</xsl:for-each>
												</xsl:for-each>
											</xsl:if>
										</xsl:if>
									</td>
								</tr>
								<tr>
									<td class="graph" colspan="3" style="width:{120*$k}mm;background:#FFFFFF;">
										<span class="graph">Место и дата:</span>
										<xsl:if test="(..//ESADout_CU:CustomsProcedure = 'ТТ') or(..//ESADout_CU:CustomsProcedure = 'TT') ">
											<xsl:apply-templates select="..//ESADout_CU:ExecutionPlace"/>
											<xsl:text> </xsl:text>
											<xsl:apply-templates select="..//ESADout_CU:EECEDocHeaderAddInfo/RUScat_ru:EDocDateTime" mode="date"/>
											<!--xsl:call-template name="russian_date">
												<xsl:with-param name="dateIn" select="..//ESADout_CU:EECEDocHeaderAddInfo/RUScat_ru:EDocDateTime"/>
											</xsl:call-template-->
										</xsl:if>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</xsl:when>
				<xsl:when test="//*[@DocumentModeID='1006078E']/goom:GTDOutResolution">
					<tr valign="top">
						<td class="graph" style="width:{13*$k}mm;border-right:solid 0.8pt black;" valign="top"/>
						<td class="graph" colspan="5" style="width:{177*$k}mm;border:solid 0.8pt black;">
							<table cellpadding="0" cellspacing="0" style="width:100%;">
								<tr>
									<td class="graph" style="width:{40*$k}mm;background:#FFFFFF;"/>
									<td class="graph" style="width:{60*$k}mm;background:#FFFFFF;"/>
									<td class="graph" style="width:{20*$k}mm;background:#FFFFFF;"/>
									<td class="graph" rowspan="4" style="width:{57*$k}mm;border-left:solid 0.8pt black;" valign="top">
										<span class="graphNo">С</span>
										<br/>
										<xsl:text>2-</xsl:text>
										<xsl:for-each select="//*[@DocumentModeID='1006078E']/goom:GTDOutResolution">
											<xsl:apply-templates select="catESAD_ru:DecisionCode"/>
											<xsl:text> </xsl:text>
											<xsl:apply-templates select="goom:ResolutionDescription"/>
											<xsl:text> </xsl:text>
											<xsl:apply-templates select="catESAD_ru:DateInf" mode="russian_date_gtd"/>
											<br/>
											<br/>
											<!--xsl:apply-templates select="catESAD_ru:LNP"/-->
										</xsl:for-each>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="not(ESADout_CU:ESADout_CUCarrier)">
				<tr valign="top">
					<td class="graph" colspan="6">
						<table cellpadding="0" cellspacing="0" style="width:100%;border-bottom:solid 0.8pt black;">
							<tr>
								<td class="graph" style="width:{13*$k}mm;border-right:solid 0.8pt black;border-top:solid 0.8pt black;black;border-bottom:solid 0.8pt black;" valign="top">
									<span class="graphNo">51</span>
									<span class="graphColumn">Предполагаемые органы  (и страна) транзита</span>
								</td>
								<td class="graph" colspan="5" style="border-right:solid 0.8pt black;border-top:solid 0.8pt black;black;border-bottom:solid 0.8pt black;">
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</xsl:if>
			<tr valign="top">
				<td class="graph" colspan="6">
					<table border="0" cellpadding="0" cellspacing="0" style="width:100%;">
						<tr>
							<xsl:choose>
								<xsl:when test="(..//ESADout_CU:CustomsProcedure = 'ТТ') or (..//ESADout_CU:CustomsProcedure = 'TT')">
									<td class="graph" rowspan="2" style="width:{13*$k}mm;border-bottom:solid 0.8pt black;border-top:solid 0.8pt black;" valign="top">
										<span class="graphNo">52</span>
										<span class="graphColumn">Гарантия</span>
									</td>
									<td class="graph" rowspan="2" style="width:{110*$k}mm;border-top:solid 0.8pt black;border-bottom:solid 0.8pt black;background:#FFFFFF;" valign="top">
										<xsl:choose>
											<xsl:when test="ESADout_CU:TDGuarantee">
												<xsl:if test="ESADout_CU:TDGuarantee/catESAD_cu:DocNumber"> № 
											<xsl:apply-templates select="ESADout_CU:TDGuarantee/catESAD_cu:DocNumber"/>
												</xsl:if>
												<!--xsl:value-of select="ESADout_CU:TDGuarantee/catESAD_cu:DocDate"/--> от
											<xsl:apply-templates select="ESADout_CU:TDGuarantee/catESAD_cu:DocDate" mode="date"/>
												<!--xsl:call-template name="russian_date">
													<xsl:with-param name="dateIn" select="ESADout_CU:TDGuarantee/catESAD_cu:DocDate"/>
												</xsl:call-template-->
												<xsl:if test="ESADout_CU:TDGuarantee/catESAD_cu:GuaranteeName">
											БИК <xsl:apply-templates select="ESADout_CU:TDGuarantee/catESAD_cu:GuaranteeName"/>, 
										</xsl:if>
												<xsl:if test="ESADout_CU:TDGuarantee/catESAD_cu:UNP">
											 УНП <xsl:apply-templates select="ESADout_CU:TDGuarantee/catESAD_cu:UNP"/>, 
										</xsl:if>
												<xsl:if test="ESADout_CU:TDGuarantee/catESAD_cu:BIC">
											БИК <xsl:apply-templates select="ESADout_CU:TDGuarantee/catESAD_cu:BIC"/>, 
										</xsl:if>
												<xsl:if test="ESADout_CU:TDGuarantee/catESAD_cu:GuaranteeAmount">
													<xsl:text>, сумма: </xsl:text>
													<xsl:apply-templates select="ESADout_CU:TDGuarantee/catESAD_cu:GuaranteeAmount"/>
												</xsl:if>
											</xsl:when>
										</xsl:choose>
									</td>
								</xsl:when>
								<xsl:otherwise>
									<td class="graph" rowspan="2" style="width:{13*$k}mm;border-top:solid 0.8pt " valign="top">
										<span class="graphNo">52</span>
										<span class="graphColumn">Гарантия недействительна для</span>
									</td>
									<td class="graph" rowspan="2" style="width:{110*$k}mm;border-top:solid 0.8pt black;border-bottom:solid 0.8pt black;background:#FFFFFF;" valign="top">
										<xsl:choose>
											<xsl:when test="ESADout_CU:Guarantee">
												<xsl:for-each select="ESADout_CU:Guarantee">
													<xsl:if test="catESAD_cu:PaymentWayCode">
														<xsl:apply-templates select="catESAD_cu:PaymentWayCode"/>, 
													</xsl:if>
													<xsl:apply-templates select="catESAD_cu:Amount"/>, 
													<xsl:if test="catESAD_cu:GuaranteeDocDetails">
														<xsl:for-each select="catESAD_cu:GuaranteeDocDetails">
															<xsl:if test="cat_ru:PrDocumentNumber">
																<xsl:text> № </xsl:text>
																<xsl:apply-templates select="cat_ru:PrDocumentNumber"/>
															</xsl:if>
															<xsl:if test="cat_ru:PrDocumentDate">
																<xsl:text> от </xsl:text>
																<xsl:apply-templates select="cat_ru:PrDocumentNumber" mode="date"/>
																<!--xsl:call-template name="russian_date">
																	<xsl:with-param name="dateIn" select="cat_ru:PrDocumentNumber"/>
																</xsl:call-template-->
															</xsl:if>
															<xsl:if test="position()!=last()">, </xsl:if>
														</xsl:for-each>
													</xsl:if>
													<xsl:if test="catESAD_cu:UNP">
														<xsl:text> УНП </xsl:text>
														<xsl:apply-templates select="catESAD_cu:UNP"/>, 
													</xsl:if>
													<xsl:if test="catESAD_cu:BIC">
														<xsl:text> БИК </xsl:text>
														<xsl:apply-templates select="catESAD_cu:BIC"/>, 
													</xsl:if>
													<xsl:if test="position()!=last()">; </xsl:if>
												</xsl:for-each>
											</xsl:when>
										</xsl:choose>
									</td>
								</xsl:otherwise>
							</xsl:choose>
							<td class="graph" style="width:{10*$k}mm;border-right:solid 1pt black;background:#FFFFFF;vertical-align: bottom;">
								<span class="graph">Код</span>
								<br/>
							</td>
							<td class="graph" rowspan="2" style="width:{60*$k}mm;border-right:solid 0.8pt black;border-bottom:solid 0.8pt black;background:#FFFFFF;" valign="top">
								<span class="graphNo">53</span>
								<span class="graph">Орган (и страна) назначения</span>
								<br/>
								<xsl:if test="ESADout_CU:ESADout_CUConsigment/ESADout_CU:TDDeliveryPlace/ESADout_CU:DeliveryCustomsOffice">
									<xsl:for-each select="ESADout_CU:ESADout_CUConsigment/ESADout_CU:TDDeliveryPlace/ESADout_CU:DeliveryCustomsOffice/*">
										<xsl:apply-templates select="."/>
										<xsl:if test="position()!=last()">, </xsl:if>
									</xsl:for-each>
								</xsl:if>
							</td>
						</tr>
						<tr>
							<td class="graph" style="width:{10*$k}mm;border-left:solid 1.5pt black;border-right:solid 0.8pt black;border-bottom:solid 0.8pt black;background:#FFFFFF;vertical-align: bottom;">
								<xsl:apply-templates select="ESADout_CU:TDGuarantee/catESAD_cu:MeasureCode"/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr valign="top">
				<td valign="top" class="graph" colspan="6" style="width:{190*$k}mm;border-top:solid 0.8pt black;">
					<table cellpadding="0" cellspacing="0" style="width:100%;">
						<tr>
							<xsl:choose>
								<xsl:when test="//*[@DocumentModeID='1006078E']/goom:GTDOutCommonMark/catESAD_ru:GRNumber='D'">
									<td valign="top" class="graph" style="width:{103*$k}mm;" colspan="2">
										<span class="graphNo">D</span>
										<!--span class="graph">ОТМЕТКИ ТАМОЖЕННОГО ОРГАНА ОТПРАВЛЕНИЯ/НАЗНАЧЕНИЯ</span-->
										<xsl:for-each select="//*[@DocumentModeID='1006078E']/goom:GTDOutCommonMark[catESAD_ru:GRNumber='D']">
											<br/>
											<xsl:apply-templates select="catESAD_ru:StageMarkIdentifier"/>
											<xsl:text>.</xsl:text>
											<xsl:apply-templates select="catESAD_ru:NoteMarkIdentifier"/>
											<xsl:if test="catESAD_ru:MarkDescription">
												<xsl:text> </xsl:text>
												<xsl:apply-templates select="catESAD_ru:MarkDescription"/>
											</xsl:if>
											<xsl:if test="catESAD_ru:Deadline">
												<xsl:text> </xsl:text>
												<xsl:apply-templates select="catESAD_ru:Deadline" mode="date"/>
												<!--xsl:call-template name="russian_date">
													<xsl:with-param name="dateIn" select="catESAD_ru:Deadline"/>
												</xsl:call-template-->
											</xsl:if>
											<xsl:if test="catESAD_ru:DocumentInfo/cat_ru:PrDocumentNumber">
												<xsl:text> </xsl:text>
												<xsl:apply-templates select="catESAD_ru:DocumentInfo/cat_ru:PrDocumentNumber"/>
											</xsl:if>
											<xsl:if test="catESAD_ru:DocumentInfo/cat_ru:PrDocumentDate">
												<xsl:text> </xsl:text>
												<xsl:apply-templates select="catESAD_ru:DocumentInfo/cat_ru:PrDocumentDate" mode="date"/>
												<!--xsl:call-template name="russian_date">
													<xsl:with-param name="dateIn" select="catESAD_ru:DocumentInfo/cat_ru:PrDocumentDate"/>
												</xsl:call-template-->
											</xsl:if>
											<xsl:text> </xsl:text>
											<xsl:apply-templates select="catESAD_ru:PersonName"/>
										</xsl:for-each>
									</td>
								</xsl:when>
								<xsl:otherwise>
									<td valign="top" class="graph" style="width:{43*$k}mm;">
										<span class="graphNo">D</span>
										<!--span class="graph">ОТМЕТКИ ТАМОЖЕННОГО ОРГАНА ОТПРАВЛЕНИЯ/НАЗНАЧЕНИЯ</span-->
									</td>
									<td class="graph" style="width:{60*$k}mm;"/>
								</xsl:otherwise>
							</xsl:choose>
							<td valign="top" class="graph" style="width:{20*$k}mm;border-right:solid 0.8pt black;">
								<br/>
								<span class="graph">Печать:</span>
							</td>
							<td class="graph" rowspan="6" style="width:{67*$k}mm;border-left:solid 0.8pt black;">
								<span class="graphNo">54</span>
								<span class="graph">Место и дата</span>
								<br/>
								<!--xsl:for-each select="ESADout_CU:ESADout_CUFilledPerson"-->
								<xsl:for-each select="//ESADout_CU:CUESADCustomsRepresentative">
									<!--Пункт 1)-->
									<span class="graph">1) </span>
										Свид. о включении в Реестр таможенных представителей № <xsl:apply-templates select="RUDECLcat:BrokerRegistryDocDetails/RUDECLcat:RegisterDocumentDetails/RUScat_ru:RegistrationNumberId"/>;<br/>
									<xsl:for-each select="RUDECLcat:RepresentativeContractDetails">
											Договор таможенного представителя с декларантом № 
											 <xsl:apply-templates select="cat_ru:PrDocumentNumber"/>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:if test="cat_ru:PrDocumentDate">
											от 
											<xsl:apply-templates select="cat_ru:PrDocumentDate" mode="date"/>
											<!--xsl:call-template name="russian_date">
												<xsl:with-param name="dateIn" select="cat_ru:PrDocumentDate"/>
											</xsl:call-template-->
										</xsl:if>; <br/>
									</xsl:for-each>
									<br/>
								</xsl:for-each>
								<br/>
								<span class="graph">Подпись и фамилия декларанта/представителя</span>
								<br/>
								<!--xsl:apply-templates select="//ESADout_CU:FilledPerson" mode="per"/-->
								<xsl:for-each select="//ESADout_CU:FilledPerson">
									<!--Пункт 2)-->
									<span class="graph">2)</span>
									<xsl:apply-templates select="RUDECLcat:SigningDetails/cat_ru:PersonSurname"/>
									<xsl:text> </xsl:text>
									<xsl:apply-templates select="RUDECLcat:SigningDetails/cat_ru:PersonName"/>
									<xsl:text> </xsl:text>
									<xsl:apply-templates select="RUDECLcat:SigningDetails/cat_ru:PersonMiddleName"/>
									<xsl:text> </xsl:text>
									<br/>
									<xsl:for-each select="RUDECLcat:SignatoryPersonIdentityDetails">
										<xsl:text> </xsl:text>
										<xsl:apply-templates select="RUScat_ru:IdentityCardName"/>
										<xsl:if test="not(RUScat_ru:IdentityCardName)">
											<xsl:apply-templates select="RUScat_ru:FullIdentityCardName"/>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:apply-templates select="RUScat_ru:IdentityCardSeries"/>
										<xsl:text> </xsl:text>
										<xsl:apply-templates select="RUScat_ru:IdentityCardNumber"/>
										<xsl:text> </xsl:text>
										<xsl:apply-templates select="RUScat_ru:IdentityCardDate" mode="date"/>
										<!--xsl:call-template name="russian_date">
											<xsl:with-param name="dateIn" select="RUScat_ru:IdentityCardDate"/>
										</xsl:call-template-->
										<xsl:text> </xsl:text>
										<xsl:apply-templates select="RUScat_ru:OrganizationName"/>
										<br/>
									</xsl:for-each>
									<xsl:if test="RUDECLcat:SigningDetails/cat_ru:PersonPost">
										<xsl:apply-templates select="RUDECLcat:SigningDetails/cat_ru:PersonPost"/>
										<br/>
									</xsl:if>
									<xsl:for-each select="RUDECLcat:SigningDetails/RUScat_ru:CommunicationDetails">
											Телефон <xsl:for-each select="cat_ru:Phone">
											<xsl:apply-templates select="."/>
											<xsl:if test="position()!=last()">, </xsl:if>
										</xsl:for-each>
										<br/>
									</xsl:for-each>
									<!--Графа 3)-->
									<xsl:for-each select="RUDECLcat:PowerOfAttorneyDetails">
										<span class="graph">3)</span>
										<xsl:if test="cat_ru:PrDocumentName">
											<xsl:apply-templates select="cat_ru:PrDocumentName"/>, 
											</xsl:if>
										<xsl:apply-templates select="cat_ru:PrDocumentNumber"/>, 
											<xsl:if test="cat_ru:PrDocumentDate">
											<xsl:apply-templates select="cat_ru:PrDocumentDate" mode="date"/>
											<!--xsl:call-template name="russian_date">
												<xsl:with-param name="dateIn" select="cat_ru:PrDocumentDate"/>
											</xsl:call-template-->
										</xsl:if>
										<xsl:if test="RUScat_ru:DocValidityDate">
											<span class="graph">до </span>
											<xsl:apply-templates select="RUScat_ru:DocValidityDate" mode="date"/>
											<!--xsl:call-template name="russian_date">
												<xsl:with-param name="dateIn" select="RUScat_ru:DocValidityDate"/>
											</xsl:call-template-->
										</xsl:if>
										<br/>
									</xsl:for-each>
								</xsl:for-each>
								<!--Графа 4)-->
								<xsl:if test="//ESADout_CU:RegNumberDoc">
									<span class="graph">4)  Исходящий номер регистрации документов</span>
									<br/>
								</xsl:if>
								<xsl:apply-templates select="//ESADout_CU:RegNumberDoc"/>
								<xsl:text> </xsl:text>
								<br/>
								<xsl:if test="//ESADout_CU:SecurityLabelCode"> Код защитной наклейки
										<xsl:apply-templates select="//ESADout_CU:SecurityLabelCode"/>
								</xsl:if>
								<p align="right">
									<xsl:choose>
										<xsl:when test="(//ESADout_CU:CustomsProcedure ='TT') or (//ESADout_CU:CustomsProcedure ='ТТ')">
											<xsl:text> </xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:choose>
												<xsl:when test="//ESADout_CU:FilledPerson/RUDECLcat:SigningDetails/RUScat_ru:SigningDate">
													<xsl:apply-templates select="//ESADout_CU:FilledPerson/RUDECLcat:SigningDetails/RUScat_ru:SigningDate" mode="date"/>
													<!--xsl:call-template name="russian_date">
														<xsl:with-param name="dateIn" select="//ESADout_CU:FilledPerson/RUDECLcat:SigningDetails/RUScat_ru:SigningDate"/>
													</xsl:call-template-->
												</xsl:when>
												<xsl:otherwise>
													<xsl:apply-templates select="//ESADout_CU:EECEDocHeaderAddInfo/RUScat_ru:EDocDateTime" mode="date"/>
													<!--xsl:call-template name="russian_date">
														<xsl:with-param name="dateIn" select="//ESADout_CU:EECEDocHeaderAddInfo/RUScat_ru:EDocDateTime"/>
													</xsl:call-template-->
												</xsl:otherwise>
											</xsl:choose>
										</xsl:otherwise>
									</xsl:choose>
								</p>
								<br/>
								<!--/xsl:for-each-->
							</td>
						</tr>
						<xsl:if test="not(//*[@DocumentModeID='1006078E']/goom:GTDOutCommonMark/catESAD_ru:GRNumber='D')">
							<tr>
								<td class="graph" colspan="3" style="width:{123*$k}mm; border-right:solid 0.8pt black;">
									<span class="graph">Результат:</span>
								</td>
							</tr>
							<tr>
								<td class="graph" colspan="3" style="width:{43*$k}mm; border-right:solid 0.8pt black;">
									<span class="graph">Наложенные пломбы:</span>
								</td>
								<td/>
							</tr>
							<tr>
								<td class="graph" colspan="3" style="width:{123*$k}mm; border-right:solid 0.8pt black;">
									<span class="graph">Номер:</span>
								</td>
							</tr>
							<tr>
								<td class="graph" colspan="3" style="width:{123*$k}mm; border-right:solid 0.8pt black;">
									<span class="graph">Срок доставки (дата):</span>
								</td>
							</tr>
							<tr>
								<td class="graph" colspan="3" style="width:{123*$k}mm; border-right:solid 0.8pt black;">
									<span class="graph">Подпись:</span>
								</td>
							</tr>
						</xsl:if>
					</table>
				</td>
			</tr>
		</table>
	</xsl:template>
	<!--Товар-->
	<xsl:template match="ESADout_CU:ESADout_CUGoods">
		<div class="goods">
			<xsl:attribute name="id"><xsl:text>generate-id(.)</xsl:text></xsl:attribute>
			<table cellpadding="0" cellspacing="0" style="width:100%;border:solid 0pt black;">
				<tr>
					<td class="graph" rowspan="3" style="width:68px; border-right:solid 0.8pt black;border-top:solid 0.8pt black;" valign="top">
						<span class="graphNo">31</span>
						<span class="graphColumn">Грузовые места<br/>и описание<br/>товаров</span>
					</td>
					<td class="graph" style="width:{98.8*$k}mm;border-top:solid 0.8pt black;background:#FFFFFF;" valign="top">
						<span class="graph">Маркировка и количество - Номера контейнеров - Количество и отличительные особенности</span>
					</td>
					<td class="graph" style="width:{11*$k}mm; border-top:solid 0.8pt black; background:#FFFFFF;">
						<table cellpadding="0" cellspacing="0" style="width:100%;">
							<tr>
								<td class="graph" colspan="2" style="width:{11*$k}mm; border-left:solid 2pt black;">
									<span class="graphNo">32</span>
									<span class="graph">Товар</span>
									<br/>
								</td>
							</tr>
							<tr>
								<td align="center" class="graph" style="width:{6.6*$k}mm;border-left:solid 2pt black;border-bottom:solid 2pt black;border-right:solid 2pt black;">
									<xsl:choose>
										<xsl:when test="catESAD_cu:GoodsNumeric!=''">
											<xsl:apply-templates select="catESAD_cu:GoodsNumeric"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</td>
								<td style="width:{4.4*$k}mm;border-bottom:solid 0.8pt black;">
									<span class="graph">
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>№
                                       <xsl:apply-templates select="catESAD_cu:GoodFeatures"/>
									</span>
								</td>
							</tr>
						</table>
					</td>
					<td align="left" class="graph" style="width:{20.6*$k}mm;border-top:solid 0.8pt black;border-left:solid 0.8pt black;border-bottom:solid 0.8pt black;background:#FFFFFF;">
						<span class="graphNo">33</span>
						<span class="graph">Код товара</span>
						<br/>
						<xsl:apply-templates select="catESAD_cu:GoodsTNVEDCode"/>
					</td>
					<td class="graph" colspan="2" style="border:solid 0.8pt black; vertical-align: bottom;">
						<table cellpadding="0" cellspacing="0" style="width:100%; vertical-align:bottom;">
							<tr class="graph" align="center">
								<td colspan="2" style="width:{23.8*$k}mm; border-right:solid 0.8pt black;">
									<br/>
								</td>
								<td style="width:{7*$k}mm; border-right:solid 0.8pt black; ">
									<br/>
								</td>
								<td style="width:{15.8*$k}mm; border-right:solid 0.8pt black;">
									<br/>
								</td>
							</tr>
							<tr class="graph" align="center">
								<td style="width:{7*$k}mm; border-right:solid 0.8pt black;">
									<xsl:if test="catESAD_cu:AdditionalSign">
										<xsl:apply-templates select="catESAD_cu:AdditionalSign"/>
									</xsl:if>
								</td>
								<td style="width:{17.8*$k}mm; border-right:solid 0.8pt black;">
									<xsl:choose>
										<xsl:when test="catESAD_cu:IntellectPropertySign">
											<xsl:apply-templates select="catESAD_cu:IntellectPropertySign"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="catESAD_cu:CIMSign">
											<xsl:text> </xsl:text>
											<xsl:apply-templates select="catESAD_cu:CIMSign"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="catESAD_cu:GoodsTraceabilityCode">
											<xsl:text> </xsl:text>
											<xsl:apply-templates select="catESAD_cu:GoodsTraceabilityCode"/> <!-- П -->
										</xsl:when>
										<xsl:otherwise>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</td>
								<td style="width:{7*$k}mm; border-right:solid 0.8pt black; ">
									<xsl:choose>
										<xsl:when test="catESAD_cu:GoodsClassificationCode=1">О</xsl:when>
										<xsl:otherwise>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</td>
								<td style="width:{15.8*$k}mm; border-right:solid 0.8pt black;">
									<xsl:choose>
										<xsl:when test="catESAD_cu:GoodsAddTNVEDCode!=''">
											<xsl:apply-templates select="catESAD_cu:GoodsAddTNVEDCode"/>
										</xsl:when>
										<xsl:when test="catESAD_cu:LicenseGoodsKindCode">
											<xsl:apply-templates select="catESAD_cu:LicenseGoodsKindCode"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="graph" colspan="2" rowspan="2" style="width:{122.8*$k}mm; border-bottom:solid 0.8pt black; background:#FFFFFF;word-break: break-all;" valign="top">
						<!-- Polaris Графа 31 Начало -->
						<xsl:call-template name="graf_31">
							<xsl:with-param name="backSide" select="0"/>
						</xsl:call-template>
						<!-- Polaris Графа 31 Окончание -->
					</td>
					<td colspan="3" style="width:{67.2*$k}mm; vertical-align: top; border-right:solid 0.8pt black;">
						<table cellpadding="0" cellspacing="0" style="width:100%;">
							<tr class="graph" align="left" style="vertical-align: top">
								<td width="3%"/>
								<td width="14%"/>
								<td width="3%"/>
								<td width="11%"/>
								<td width="46%"/>
								<td width="23%"/>
							</tr>
							<tr class="graph" align="left" style="vertical-align: top">
								<!--td colspan="4" style="width:{20.6*$k}mm; border-left:solid 1.5pt black; border-right:solid 1.5pt black;"-->
								<td colspan="4" style="border-left:solid 1.5pt black; border-right:solid 1.5pt black;">
									<span class="graphNo">34</span>
									<span class="graph">Код страны происх.</span>
								</td>
								<!--td style="width:{30.8*$k}mm; border-right:solid 0.8pt black;"-->
								<td style="border-right:solid 0.8pt black;word-break: break-all;">
									<span class="graphNo">35</span>
									<span class="graph">Вес брутто (кг)</span>
								</td>
								<!--td style="width:{15.8*$k}mm; border-right:solid 0.8pt black;"-->
								<td style="border-right:solid 0.8pt black;word-break: break-all;">
									<span class="graphNo">36</span>
									<span class="graph">Преференция</span>
								</td>
							</tr>
							<tr class="graph" align="center" style="vertical-align: bottom">
								<!--td style="width:{2.2*$k}mm;border-left:solid 1.5pt black;border-right:solid 0.8pt black;border-bottom:solid 1.5pt black;">a</td-->
								<td style="border-left:solid 1.5pt black;border-right:solid 0.8pt black;border-bottom:solid 1.5pt black;word-break: break-all;">a</td>
								<!--td style="width:{9.6*$k}mm; border-right:solid 0.8pt black; border-bottom:solid 1.5pt black;"-->
								<td style="border-right:solid 0.8pt black; border-bottom:solid 1.5pt black;word-break: break-all;">
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:choose>
										<xsl:when test="catESAD_cu:OriginCountryCode!=''">
											<xsl:apply-templates select="catESAD_cu:OriginCountryCode"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</td>
								<!--td style="width:{2.2*$k}mm;border-right:solid 0.8pt black; border-bottom:solid 1.5pt black;">b</td-->
								<td style="border-right:solid 0.8pt black; border-bottom:solid 1.5pt black;word-break: break-all;">b</td>
								<!--td style="width:{6.6*$k}mm;border-right:solid 1.5pt black; border-bottom:solid 1.5pt black;"-->
								<td style="border-right:solid 1.5pt black; border-bottom:solid 1.5pt black;word-break: break-all;">
									<xsl:apply-templates select="catESAD_cu:PrefOriginCountry/catESAD_cu:CountryCode"/>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								</td>
								<!--td align="left" style="width:{30.8*$k}mm; border-right:solid 0.8pt black; border-bottom:solid 0.8pt black"-->
								<td align="left" style="border-right:solid 0.8pt black; border-bottom:solid 0.8pt black;word-break: break-all;">
									<xsl:if test="catESAD_cu:GrossWeightQuantity">
										<xsl:apply-templates select="catESAD_cu:GrossWeightQuantity"/>
									</xsl:if>
									<xsl:if test="ESADout_CU:TotalGrossMassMeasure"> / <xsl:apply-templates select="ESADout_CU:TotalGrossMassMeasure/cat_ru:GoodsQuantity"/>
									</xsl:if>
								</td>
								<!--td align="left" style="width:{15.8*$k}mm; border-right:solid 0.8pt black;border-bottom:solid 0.8pt black;"-->
								<td align="left" style="border-right:solid 0.8pt black;border-bottom:solid 0.8pt black;word-break: break-all;">
									<xsl:choose>
										<xsl:when test="catESAD_cu:Preferencii">
											<xsl:apply-templates select="catESAD_cu:Preferencii/catESAD_cu:CustomsTax"/>
											<xsl:apply-templates select="catESAD_cu:Preferencii/catESAD_cu:CustomsDuty"/>
											<xsl:apply-templates select="catESAD_cu:Preferencii/catESAD_cu:Excise"/>
											<xsl:apply-templates select="catESAD_cu:Preferencii/catESAD_cu:Rate"/>
										</xsl:when>
										<xsl:otherwise>
											<br/>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<tr class="graph" align="left" style="vertical-align: top">
								<!--td colspan="4" style="width:{20.6*$k}mm;border-left:solid 1.5pt black;border-right:solid 1.5pt black;"-->
								<td colspan="4" style="border-left:solid 1.5pt black;border-right:solid 1.5pt black;word-break: break-all;">
									<span class="graphNo">37</span>
									<span class="graph">Процедура</span>
								</td>
								<!--td style="width:{30.8*$k}mm; border-right:solid 0.8pt black;"-->
								<td style="border-right:solid 0.8pt black;word-break: break-all;">
									<span class="graphNo">38</span>
									<span class="graph">Вес нетто (кг)</span>
								</td>
								<!--td style="width:{15.8*$k}mm; border-right:solid 0.8pt black;"-->
								<td style="border-right:solid 0.8pt black;word-break: break-all;">
									<span class="graphNo">39</span>
									<span class="graphTitleIt">Квота</span>
								</td>
							</tr>
							<tr class="graph" align="left" style="vertical-align: bottom">
								<!--td colspan="2" align="center" style="width:{11.8*$k}mm; border-left:solid 1.5pt black; border-right:solid 0.8pt black; border-bottom:solid 1.5pt black;"-->
								<td colspan="2" align="center" style="border-left:solid 1.5pt black; border-right:solid 0.8pt black; border-bottom:solid 1.5pt black;word-break: break-all;">
									<xsl:choose>
										<xsl:when test="ESADout_CU:ESADCustomsProcedure">
											<xsl:apply-templates select="ESADout_CU:ESADCustomsProcedure/catESAD_cu:MainCustomsModeCode"/>
											<xsl:apply-templates select="ESADout_CU:ESADCustomsProcedure/catESAD_cu:PrecedingCustomsModeCode"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</td>
								<!--td colspan="2" align="center" style="width:{8.8*$k}mm;border-right:solid 1.5pt black;border-bottom:solid 1.5pt black;"-->
								<td colspan="2" align="center" style="border-right:solid 1.5pt black;border-bottom:solid 1.5pt black;word-break: break-all;">
									<xsl:choose>
										<xsl:when test="ESADout_CU:ESADCustomsProcedure">
											<xsl:apply-templates select="ESADout_CU:ESADCustomsProcedure/catESAD_cu:GoodsTransferFeature"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</td>
								<!--td style="width:{30.8*$k}mm; border-right:solid 0.8pt black;border-bottom:solid 0.8pt black"-->
								<td style="border-right:solid 0.8pt black;border-bottom:solid 0.8pt black;word-break: break-all;">
									<xsl:apply-templates select="catESAD_cu:NetWeightQuantity"/>
									<xsl:if test="catESAD_cu:NetWeightQuantity2">/<xsl:apply-templates select="catESAD_cu:NetWeightQuantity2"/>
									</xsl:if>
									<xsl:if test="ESADout_CU:TotalNetMassMeasure"> / <xsl:apply-templates select="ESADout_CU:TotalNetMassMeasure/cat_ru:GoodsQuantity"/>
									</xsl:if>
								</td>
								<!--td style="width:{15.8*$k}mm; border-right:solid 0.8pt black; border-bottom:solid 0.8pt black;"-->
								<td style="border-right:solid 0.8pt black; border-bottom:solid 0.8pt black;word-break: break-all;">
									<xsl:for-each select="ESADout_CU:ESADGoodsQuota">
										<xsl:if test="catESAD_cu:ESADCurrencyQuota">
											<xsl:for-each select="catESAD_cu:ESADCurrencyQuota">
												<xsl:apply-templates select="catESAD_cu:QuotaCurrencyQuantity"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="catESAD_cu:QuotaCurrencyName"/>
												(<xsl:apply-templates select="catESAD_cu:QuotaCurrencyCode"/>)
											</xsl:for-each>
										</xsl:if>
										<br/>
										<xsl:if test="catESAD_cu:ESADProductQuantityQuota">
											<xsl:for-each select="catESAD_cu:ESADProductQuantityQuota">
												<xsl:apply-templates select="cat_ru:GoodsQuantity"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="cat_ru:MeasureUnitQualifierName"/>
												(<xsl:apply-templates select="cat_ru:MeasureUnitQualifierCode"/>)
											</xsl:for-each>
										</xsl:if>
									</xsl:for-each>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr class="graph" style="vertical-align: bottom;">
					<td colspan="3" style="width:{67.2*$k}mm; border-right:solid 0.8pt black; border-bottom:solid 0.8pt black; background:#FFFFFF;word-break: break-all;">
						<table cellpadding="0" cellspacing="0" style="width:100%;">
							<tr class="graph" align="left" style="vertical-align: top">
								<td style="width:{67.2*$k}mm; border-left:solid 0.8pt black; border-top:solid 0.8pt black;word-break: break-all;">
									<span class="graphNo">40</span>
									<span class="graph">Общая декларация/Предшествующий документ</span>
								</td>
							</tr>
							<tr class="graph" align="left" style="vertical-align: bottom">
								<td style="width:{67.2*$k}mm; border-left:solid 0.8pt black;word-break: break-all;">
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:for-each select="ESADout_CU:ESADout_CUPrecedingDocument">
										<xsl:if test="catESAD_cu:PrecedingDocumentID">
											<xsl:apply-templates select="catESAD_cu:PrecedingDocumentID"/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:if>
										<xsl:if test="catESAD_cu:PrecedingDocumentName">
											<xsl:apply-templates select="catESAD_cu:PrecedingDocumentName"/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:if>
										<xsl:if test="catESAD_cu:PrecedingDocumentCustomsCode">
											<xsl:apply-templates select="catESAD_cu:PrecedingDocumentCustomsCode"/>
											<xsl:text>/</xsl:text>
										</xsl:if>
										<xsl:apply-templates select="catESAD_cu:PrecedingDocumentDate" mode="russian_date_gtd"/>
										<!--xsl:call-template name="russian_date_gtd">
											<xsl:with-param name="dateIn" select="catESAD_cu:PrecedingDocumentDate"/>
										</xsl:call-template-->
										<xsl:text>/</xsl:text>
										<xsl:if test="catESAD_cu:AddNumberPart">
											<xsl:choose>
												<xsl:when test="catESAD_cu:AddNumberPart = 'ЗВ'">В</xsl:when>
												<xsl:otherwise>
													<xsl:apply-templates select="catESAD_cu:AddNumberPart"/>
												</xsl:otherwise>
											</xsl:choose>
											<!--xsl:value-of select="catESAD_cu:AddNumberPart"/-->
										</xsl:if>
										<xsl:apply-templates select="catESAD_cu:PrecedingDocumentNumber"/>
										<xsl:if test="catESAD_cu:PrecedingDocumentGoodsNumeric">
											<xsl:text>/</xsl:text>
											<xsl:apply-templates select="catESAD_cu:PrecedingDocumentGoodsNumeric"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:PrcDocGoodsTNVEDCode">
											<xsl:text>/</xsl:text>
											<xsl:apply-templates select="catESAD_cu:PrcDocGoodsTNVEDCode"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:DTMDocDetails">
											<xsl:text>/</xsl:text>
											<xsl:apply-templates select="catESAD_cu:DTMDocDetails"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:TIRIdDetails">
											<xsl:text>/</xsl:text>
											<xsl:apply-templates select="catESAD_cu:TIRIdDetails"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:OtherPrDocumentNumber">
											<xsl:text>/</xsl:text>
											<xsl:apply-templates select="catESAD_cu:OtherPrDocumentNumber"/>
											<xsl:if test="catESAD_cu:OtherPrDocumentDate">
												<xsl:text> от </xsl:text>
												<xsl:apply-templates select="catESAD_cu:OtherPrDocumentDate" mode="date"/>
												<!--xsl:call-template name="russian_date">
													<xsl:with-param name="dateIn" select="catESAD_cu:OtherPrDocumentDate"/>
												</xsl:call-template-->
											</xsl:if>
										</xsl:if>
										<xsl:if test="catESAD_cu:PIDocumentNumber">
											<xsl:text>/Рег.№ ПИ </xsl:text>
											<xsl:apply-templates select="catESAD_cu:PIDocumentNumber"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:CustomsCost">
											<xsl:text>/</xsl:text>
											<xsl:apply-templates select="catESAD_cu:CustomsCost" mode="format_number_2"/>
											<!--xsl:value-of select="format-number(catESAD_cu:CustomsCost,'0.00')"/-->
										</xsl:if>
										<xsl:if test="catESAD_cu:NetWeight">
											<xsl:text>/</xsl:text>
											<xsl:apply-templates select="catESAD_cu:NetWeight"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:NetWeightQuantity">
											<xsl:text>/</xsl:text>
											<xsl:apply-templates select="catESAD_cu:NetWeightQuantity"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:SupplementaryGoodsQuantity">
											<xsl:text> / </xsl:text>
											<!--xsl:apply-templates select="catESAD_cu:NetWeightQuantity"/-->
											<xsl:for-each select="catESAD_cu:SupplementaryGoodsQuantity">
												<xsl:text>, </xsl:text>
												<xsl:apply-templates select="cat_ru:GoodsQuantity"/>
												<xsl:if test="cat_ru:MeasureUnitQualifierCode">
													(<xsl:apply-templates select="cat_ru:MeasureUnitQualifierCode"/>)
												</xsl:if>
											</xsl:for-each>
										</xsl:if>
										<br/>
									</xsl:for-each>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr valign="top">
					<td class="graph" style="width:{13*$k}mm;border-right:solid 0.8pt black;border-top:solid 0.4pt black;border-bottom:solid 0.8pt black;word-break: break-all;" valign="top">
						<span class="graphNo">44</span>
						<span class="graphColumn">Дополнит. информация/ Представл. документы</span>
					</td>
					<!-- Polaris Графа 44 Начало -->
					<td class="graph" colspan="2" style="width:{122.8*$k}mm;border-bottom:solid 0.8pt black; background:#FFFFFF;word-break: break-all;">
						<xsl:call-template name="graf_44">
							<xsl:with-param name="backSide" select="0"/>
						</xsl:call-template>
					</td>
					<!-- Polaris Графа 44 Окончание -->
					<td class="graph" colspan="3" style="border-bottom:solid 0.8pt black; border-right:solid 0.8pt black;word-break: break-all;">
						<table cellpadding="0" cellspacing="0" style="width:100%;">
							<tr>
								<td class="graph" style="width:{27.2*$k}mm; vertical-align: top; border:solid 0.8pt black;word-break: break-all;">
									<span class="graphNo">41</span>
									<span class="graph">Дополнит.единицы</span>
									<br/>
									<xsl:for-each select="ESADout_CU:SupplementaryGoodsQuantity">
										<xsl:apply-templates select="cat_ru:GoodsQuantity"/>
										<xsl:if test="cat_ru:MeasureUnitQualifierName">
											<xsl:text disable-output-escaping="yes">/</xsl:text>
											<xsl:apply-templates select="cat_ru:MeasureUnitQualifierName"/>
										</xsl:if>
										<xsl:if test="cat_ru:MeasureUnitQualifierCode">
											<xsl:text disable-output-escaping="yes">/</xsl:text>
											<xsl:apply-templates select="cat_ru:MeasureUnitQualifierCode"/>
										</xsl:if>
									</xsl:for-each>
								</td>
								<td class="graph" style="width:{28*$k}mm; vertical-align: top; border-top:solid 0.8pt black; border-bottom:solid 0.8pt black;word-break: break-all;">
									<span class="graphNo">42</span>
									<span class="graph">Цена товара</span>
									<br/>
									<xsl:if test="catESAD_cu:InvoicedCost">
										<xsl:apply-templates select="catESAD_cu:InvoicedCost" mode="format_number_2"/>
										<!--xsl:value-of select="format-number(catESAD_cu:InvoicedCost,'0.00')"/-->
									</xsl:if>
									<xsl:if test="catESAD_cu:InvoicedCurrencyCode">/<xsl:apply-templates select="catESAD_cu:InvoicedCurrencyCode"/>
									</xsl:if>
									<xsl:if test="catESAD_cu:InvoicedCurrencyRate">/<xsl:apply-templates select="catESAD_cu:InvoicedCurrencyRate" mode="format_number_4"/>
										<!--xsl:value-of select="format-number(catESAD_cu:InvoicedCurrencyRate,'0.0000')"/-->
									</xsl:if>
								</td>
								<td style="vertical-align: bottom; border:solid 0.8pt black; border-left:solid 1.5pt black;word-break: break-all;">
									<table cellpadding="0" cellspacing="0" style="width:100%;">
										<tr>
											<td align="left" class="graph" colspan="2" style="width:{15.8*$k}mm;word-break: break-all;">
												<span class="graphNo">43</span>
												<span class="graph">Код МОС</span>
											</td>
										</tr>
										<tr>
											<td align="center" class="graph" style="width:{8.8*$k}mm; border-bottom:solid 1.5pt black; border-right:solid 1.5pt black;word-break: break-all;">
												<xsl:choose>
													<xsl:when test="catESAD_cu:CustomsCostCorrectMethod">
														<xsl:apply-templates select="catESAD_cu:CustomsCostCorrectMethod"/>
													</xsl:when>
													<xsl:otherwise>
														<br/>
													</xsl:otherwise>
												</xsl:choose>
											</td>
											<td align="left" class="graph" style="width:{7*$k}mm;word-break: break-all;">
												<br/>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<table cellpadding="0" cellspacing="0" style="width:100%">
							<tr class="graph">
								<td rowspan="2" style="width:{27.2*$k}mm;background:#FFFFFF;word-break: break-all;">
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								</td>
								<td style="width:{10*$k}mm;border-right:solid 1.5pt black;background:#FFFFFF;word-break: break-all;">
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								</td>
								<td rowspan="2" style="width:{30*$k}mm; border-top:solid 0.8pt black;word-break: break-all;" valign="top">
									<span class="graphNo">45</span>
									<span class="graph">Таможенная стоимость</span>
									<br/>
									<xsl:if test="catESAD_cu:CustomsCost">
										<xsl:apply-templates select="catESAD_cu:CustomsCost" mode="format_number_2"/>
										<!--xsl:value-of select="format-number(catESAD_cu:CustomsCost,'0.00')"/-->
									</xsl:if>
								</td>
							</tr>
							<tr>
								<td class="graph" style="width:{10*$k}mm;border-right:solid 1.5pt black;border-bottom:solid 1.5pt black;border-left:solid 1.5pt black;background:#FFFFFF;word-break: break-all;">
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								</td>
							</tr>
						</table>
						<table cellpadding="0" cellspacing="0" style="width:100%;">
							<tr>
								<td class="graph" style="width:{27.2*$k}mm; border-bottom:solid 0.4pt silver; border-top:solid 0.4pt silver; border-left:solid 0.4pt silver; background:#FFFFFF;word-break: break-all;">
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								</td>
								<td class="graph" style="width:{40*$k}mm; border:solid 0.8pt black;word-break: break-all;">
									<span class="graphNo">46</span>
									<span class="graph">Статистическая стоимость</span>
									<br/>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:if test="catESAD_cu:StatisticalCost">
										<xsl:apply-templates select="catESAD_cu:StatisticalCost" mode="format_number_2"/>
										<!--xsl:value-of select="format-number(catESAD_cu:StatisticalCost,'0.00')"/-->
									</xsl:if>
									<xsl:if test="catESAD_cu:TotalStatisticValueAmount"> / <xsl:apply-templates select="catESAD_cu:TotalStatisticValueAmount" mode="format_number_2"/>
										<!--xsl:value-of select="format-number(catESAD_cu:TotalStatisticValueAmount,'0.00')"/-->
									</xsl:if>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</xsl:template>

	<!-- Шаблон для номера в гр.А -->
	<xsl:template match="*" mode="graf_A">
		<xsl:apply-templates select="cat_ru:CustomsCode"/>
		<xsl:text>/</xsl:text>
		<xsl:apply-templates select="cat_ru:RegistrationDate" mode="russian_date_gtd"/>
		<xsl:text>/</xsl:text>
		<xsl:apply-templates select="cat_ru:GTDNumber"/>
	</xsl:template>
	
	<!-- Шаблон для типа RUDECLcat:CustomDocIDType -->
	<xsl:template match="RUDECLcat:CustomsDocIdDetails">
		<xsl:text>ДТ: </xsl:text>
		<xsl:apply-templates select="cat_ru:CustomsCode"/>
		<xsl:text>/</xsl:text>
		<xsl:apply-templates select="cat_ru:RegistrationDate" mode="russian_date_gtd"/>
		<!--xsl:call-template name="russian_date_gtd">
			<xsl:with-param name="dateIn" select="cat_ru:RegistrationDate"/>
		</xsl:call-template-->
		<xsl:text>/</xsl:text>
		<xsl:apply-templates select="cat_ru:GTDNumber"/>
		<xsl:if test="RUDECLcat:Code">
			<xsl:text>, </xsl:text>
			<span class="normal">, № изм. и(или) доп.: </span>
			<xsl:apply-templates select="RUDECLcat:Code"/>
		</xsl:if>
	</xsl:template>
	<!-- Шаблон для типа RUDECLcat:PlaceDetailsType -->
	<xsl:template match="RUDECLcat:ProcessingPlaceDetails">
		<xsl:apply-templates select="RUDECLcat:PlaceName"/>
		<xsl:if test="RUDECLcat:PlaceName and RUDECLcat:AddressDetails">
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:apply-templates mode="ru_address" select="RUDECLcat:AddressDetails"/>
	</xsl:template>
	<!-- Шаблон для типа RUDECLcat:DTMDocDetailsType -->
	<xsl:template match="RUDECLcat:DTMDocDetails|catESAD_cu:DTMDocDetails">
		<xsl:text>ТДТС: </xsl:text>
		<xsl:apply-templates select="cat_ru:CustomsCode"/>
		<xsl:text>/</xsl:text>
		<xsl:apply-templates select="cat_ru:RegistrationDate" mode="russian_date_gtd"/>
		<!--xsl:call-template name="russian_date_gtd">
			<xsl:with-param name="dateIn" select="cat_ru:RegistrationDate"/>
		</xsl:call-template-->
		<xsl:text>/</xsl:text>
		<xsl:apply-templates select="cat_ru:GTDNumber"/>
		<xsl:for-each select="*">
			<xsl:if test="local-name()='TransportModeCode'">
				<xsl:text>, код вида ТС: </xsl:text>
				<xsl:apply-templates select="."/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- Шаблон для типа RUDECLcat:TIRIdDetailsType -->
	<xsl:template match="RUDECLcat:TIRIdDetails|catESAD_cu:TIRIdDetails">
		<xsl:for-each select="*">
			<xsl:if test="local-name()='TIRSeries'">
				<xsl:text>МДП: серия </xsl:text>
				<xsl:apply-templates select="."/>
			</xsl:if>
			<xsl:if test="local-name()='TIRID'">
				<xsl:text> № </xsl:text>
				<xsl:apply-templates select="."/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template mode="SupplementaryQuantity" match="*">
		<xsl:apply-templates select="cat_ru:GoodsQuantity"/>
		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
		<xsl:apply-templates select="cat_ru:MeasureUnitQualifierName"/>
		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
		<!-- Polaris
		<xsl:if test="cat_ru:MeasureUnitQualifierCode">(<xsl:apply-templates select="cat_ru:MeasureUnitQualifierCode"/>)</xsl:if>
		-->
	</xsl:template>
	<!-- Шаблон для типа catESAD_cu:DimensionType -->
	<xsl:template match="catESAD_cu:Dimensions|catESAD_cu:AllowanceDetails|catESAD_cu:DeviationDetails">
		<xsl:apply-templates select="catESAD_cu:LengthMeasure/catESAD_cu:MeasuredAmount"/>&#160;<xsl:apply-templates select="catESAD_cu:LengthMeasure/catESAD_cu:MeasureUnitQualifierName"/>
		<!-- Polaris
		(<xsl:apply-templates select="catESAD_cu:LengthMeasure/catESAD_cu:MeasureUnitQualifierCode"/>)
		-->
		<xsl:if test="catESAD_cu:WidthMeasure">
			<xsl:if test="catESAD_cu:LengthMeasure">
				<xsl:text> x </xsl:text>
			</xsl:if>
			<xsl:apply-templates select="catESAD_cu:WidthMeasure/catESAD_cu:MeasuredAmount"/>&#160;<xsl:apply-templates select="catESAD_cu:WidthMeasure/catESAD_cu:MeasureUnitQualifierName"/>
			<!-- Polaris
			(<xsl:apply-templates select="catESAD_cu:WidthMeasure/catESAD_cu:MeasureUnitQualifierCode"/>)
			-->
		</xsl:if>
		<xsl:if test="catESAD_cu:HeightMeasure">
			<xsl:if test="catESAD_cu:LengthMeasure or catESAD_cu:WidthMeasure">
				<xsl:text> x </xsl:text>
			</xsl:if>
			<xsl:apply-templates select="catESAD_cu:HeightMeasure/catESAD_cu:MeasuredAmount"/>&#160;<xsl:apply-templates select="catESAD_cu:HeightMeasure/catESAD_cu:MeasureUnitQualifierName"/>
			<!-- Polaris
			(<xsl:apply-templates select="catESAD_cu:HeightMeasure/catESAD_cu:MeasureUnitQualifierCode"/>)
			-->
		</xsl:if>
	</xsl:template>
	<xsl:template match="cat_ru:IdentityCard|RUScat_ru:IdentityCard">
		<xsl:for-each select="*">
			<xsl:choose>
				<xsl:when test="local-name()='IdentityCardDate'">
					<xsl:apply-templates select="." mode="date"/>
					<!--xsl:call-template name="russian_date">
						<xsl:with-param name="dateIn" select="."/>
					</xsl:call-template-->
				</xsl:when>
				<xsl:when test="local-name()='DocValidityDate'">
					<xsl:text>(окончание срока действия: </xsl:text>
					<xsl:apply-templates select="." mode="date"/>
					<!--xsl:call-template name="russian_date">
						<xsl:with-param name="dateIn" select="."/>
					</xsl:call-template-->
					<xsl:text>)</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="."/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="position()!=last()">
				<xsl:text> </xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!--Платежи по товару-->
	<xsl:template match="ESADout_CU:ESADout_CUGoods" mode="payments">
		<table class="addInfo" style="width: 100%;">
			<tr>
				<td class="graph">Вид</td>
				<td class="graph">Основа начисления</td>
				<td class="graph">Ставка</td>
				<td class="graph">Сумма</td>
				<td class="graph">СП</td>
			</tr>
			<xsl:apply-templates select="ESADout_CU:ESADout_CUCustomsPaymentCalculation"/>
			<tr>
				<td class="graph" colspan="2"/>
				<td class="graph">Всего:</td>
				<td class="graph">
					<xsl:variable name="Sum47G" select="sum(ESADout_CU:ESADout_CUCustomsPaymentCalculation[catESAD_cu:PaymentCode!='УН' and catESAD_cu:PaymentCode!='УР']/catESAD_cu:PaymentAmount)"/>
					<xsl:value-of select="format-number($Sum47G,'#.##')"/>
				</td>
				<td/>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="ESADout_CU:ESADout_CUCustomsPaymentCalculation">
		<tr>
			<td class="graph">
				<xsl:apply-templates select="catESAD_cu:PaymentModeCode"/>
			</td>
			<td class="graph">
				<xsl:if test="catESAD_cu:TaxBase">
					<xsl:apply-templates select="catESAD_cu:TaxBase"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:apply-templates select="catESAD_cu:NumberGroup"/>
			</td>
			<td class="graph">
				<xsl:apply-templates select="catESAD_cu:Rate"/>
				<xsl:if test="catESAD_cu:PaymentModeCode != 10">
					<xsl:text> </xsl:text>
					<xsl:choose>
						<xsl:when test="catESAD_cu:RateTypeCode = '*'">
							<xsl:apply-templates select="catESAD_cu:RateTNVEDQualifierCode"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="catESAD_cu:Rate">%</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="catESAD_cu:NumberDays">
					<xsl:text>x</xsl:text>
					<xsl:apply-templates select="catESAD_cu:NumberDays"/>
				</xsl:if>
			</td>
			<td class="graph">
				<xsl:if test="catESAD_cu:PaymentAmount">
					<xsl:apply-templates select="catESAD_cu:PaymentAmount" mode="format_number_2"/>
					<!--xsl:value-of select="format-number(catESAD_cu:PaymentAmount,'0.00')"/-->
				</xsl:if>
			</td>
			<td class="graph">
				<xsl:apply-templates select="catESAD_cu:PaymentCode"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="*" mode="date">
		<xsl:variable name="xpath_date">
			<xsl:call-template name="get_xpath">
				<xsl:with-param name="node" select="."/>
			</xsl:call-template>
		</xsl:variable>
		<element xml_node="{$xpath_date}">
			<xsl:call-template name="russian_date">
				<xsl:with-param name="dateIn" select="."/>
			</xsl:call-template>
		</element>
	</xsl:template>
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
	<xsl:template match="*" mode="russian_date_gtd">
		<xsl:variable name="xpath_date">
			<xsl:call-template name="get_xpath">
				<xsl:with-param name="node" select="."/>
			</xsl:call-template>
		</xsl:variable>
		<element xml_node="{$xpath_date}">
			<xsl:call-template name="russian_date_gtd">
				<xsl:with-param name="dateIn" select="."/>
			</xsl:call-template>
		</element>
	</xsl:template>
	<xsl:template name="russian_date_gtd">
		<xsl:param name="dateIn"/>
		<xsl:choose>
			<xsl:when test="substring($dateIn,5,1)='-' and substring($dateIn,8,1)='-'">
				<xsl:value-of select="substring($dateIn,9,2)"/>
				<xsl:value-of select="substring($dateIn,6,2)"/>
				<xsl:value-of select="substring($dateIn,3,2)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$dateIn"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="*" mode="format_number_2">
		<xsl:variable name="xpath_date">
			<xsl:call-template name="get_xpath">
				<xsl:with-param name="node" select="."/>
			</xsl:call-template>
		</xsl:variable>
		<element xml_node="{$xpath_date}">
			<xsl:value-of select="format-number(.,'0.00')"/>
		</element>
	</xsl:template>
	<xsl:template match="*" mode="format_number_4">
		<xsl:variable name="xpath_date">
			<xsl:call-template name="get_xpath">
				<xsl:with-param name="node" select="."/>
			</xsl:call-template>
		</xsl:variable>
		<element xml_node="{$xpath_date}">
			<xsl:value-of select="format-number(.,'0.0000')"/>
		</element>
	</xsl:template>
	<xsl:template match="catESAD_cu:RFOrganizationFeatures">
		<xsl:if test="cat_ru:OGRN">
			<span>ОГРН: <xsl:apply-templates select="cat_ru:OGRN"/>
			</span>
			<br/>
		</xsl:if>
		<xsl:if test="cat_ru:INN">
			<span>ИНН: <xsl:apply-templates select="cat_ru:INN"/>
			</span>
			<br/>
		</xsl:if>
		<xsl:if test="cat_ru:KPP">
			<span>КПП: <xsl:apply-templates select="cat_ru:KPP"/>
			</span>
			<br/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="catESAD_cu:RBOrganizationFeatures">
		<xsl:if test="cat_ru:UNP">
			<span>УНП: <xsl:apply-templates select="cat_ru:UNP"/>
			</span>
			<br/>
		</xsl:if>
		<xsl:if test="cat_ru:RBIdentificationNumber">
			<span>Идентификационный номер: 
         <xsl:apply-templates select="cat_ru:RBIdentificationNumber"/>
			</span>
			<br/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="catESAD_cu:RKOrganizationFeatures">
		<xsl:if test="cat_ru:BIN">
			<span>БИН: <xsl:apply-templates select="cat_ru:BIN"/>
			</span>
			<br/>
		</xsl:if>
		<xsl:if test="cat_ru:IIN">
			<span>ИИН: <xsl:apply-templates select="cat_ru:IIN"/>
			</span>
			<br/>
		</xsl:if>
		<xsl:for-each select="cat_ru:ITN">
			<span>
         ИТН: 
         <xsl:apply-templates select="cat_ru:CategoryCode"/>/
         <xsl:apply-templates select="cat_ru:KATOCode"/>/
         <xsl:apply-templates select="cat_ru:RNN"/>
				<xsl:if test="cat_ru:ITNReserv">
            /<xsl:apply-templates select="cat_ru:ITNReserv"/>
				</xsl:if>
			</span>
			<br/>
		</xsl:for-each>
	</xsl:template>

	
	<xsl:template name="graf_31">
		<xsl:param name="backSide" select="0" />
  					<!-- Polaris Графа 31 Начало -->
						
						<!-- Переменные начало--> <!-- Polaris -->
						<xsl:variable name="max_row_description" select="2"/> <!-- Polaris для ограничения вывода записей общего описания товара -->
						<xsl:variable name="row_description" select="count(catESAD_cu:GoodsDescription)"/> <!-- Polaris кол-во записей в общем описании -->
						<xsl:variable name="max_row_group_description" select="$max_row_description - $row_description"/> <!-- Polaris для ограничения вывода записей группы товаров -->
						<xsl:variable name="row_group_description" select="count(catESAD_cu:GoodsGroupDescription/catESAD_cu:GoodsDescription)"/> <!-- Polaris кол-во записей в группе -->
						<xsl:variable name="row_oif" select="count(catESAD_cu:OilField)"/> <!-- Polaris месторождение товара -->
						<xsl:variable name="row_country" select="count(catESAD_cu:OriginCountryName)"/> <!-- Polaris страна происхождения -->
						<xsl:variable name="row_supp_quentity" select="count(//ESADout_CU:SupplementaryGoodsQuantity)"/> <!-- Polaris кол-во в доп.единицах -->
						<xsl:variable name="row_supp_quentity1" select="count(ESADout_CU:SupplementaryGoodsQuantity1/cat_ru:GoodsQuantity)"/> <!-- Polaris кол-во в доп.единицах -->
						<xsl:variable name="row_period" select="count(catESAD_cu:BeginPeriodDate)"/> <!-- Polaris период -->
						<xsl:variable name="row_package" select="count(ESADout_CU:ESADGoodsPackaging/catESAD_cu:PakageQuantity)"/> <!-- Polaris кол-во упаковок -->						
						<xsl:variable name="row_poddon" select="count(ESADout_CU:ESADGoodsPackaging/catESAD_cu:PackagePalleteInformation[catESAD_cu:InfoKindCode='3'])"/> <!-- Polaris кол-во поддонов -->
						<xsl:variable name="row_container" select="count(ESADout_CU:ESADContainer/catESAD_cu:ContainerQuantity)"/> <!-- Polaris кол-во контейнеров -->
						<xsl:variable name="row_akcis" select="count(ESADout_CU:ESADExcise/catESAD_cu:ExciseSerieses)"/> <!-- Polaris кол-во контейнеров -->
						<xsl:variable name="row_delivery" select="count(catESAD_cu:CUESADDeliveryTerms/cat_ru:DeliveryTermsStringCode)"/> <!-- Polaris условия доставки -->
						<xsl:variable name="row_custom_cond" select="count(ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:RateOutputGoods)"/> <!-- Polaris продукты переработки -->
						<xsl:variable name="row_delivery_time" select="count(catESAD_cu:DeliveryTime) + count(catESAD_cu:DeliveryEnd)"/> <!-- Polaris срок поставки-->
						<xsl:variable name="row_quant_fact" select="count(catESAD_cu:QuantityFact/cat_ru:GoodsQuantity)"/> <!-- Polaris фактическая поставка-->
						<xsl:variable name="row_electr" select="count(ESADout_CU:ElectricalEnergReceived)"/> <!-- Polaris электричество -->						
						<xsl:variable name="row_cim" select="count(catESAD_cu:CIMIdDetails/catESAD_cu:CIMIdDetails)"/> <!-- Polaris контрольные значки -->						
						<xsl:variable name="row_ct3" select="count(catESAD_cu:GoodsSTZ)"/> <!-- Polaris свободный склад -->						
						<xsl:variable name="row_mark" select="count(catESAD_cu:DTIdentificationMeansDetails/catESAD_cu:CIMQuantity)"/> <!-- Polaris свободный склад -->
						<xsl:variable name="max_row_other" select="3"/> <!-- Polaris для ограничения вывода после описания товара-->						
						<!-- Переменные окончание --> <!-- Polaris -->						
						<xsl:if test="$backSide=0"><!-- Polaris -->
						<span class="graph">1)</span>
						</xsl:if><!-- Polaris -->

						<xsl:if test="ESADout_CU:MilitaryProducts ='true' or ESADout_CU:MilitaryProducts ='t' or ESADout_CU:MilitaryProducts ='1'">
                               Продукция военного назначения
                        </xsl:if>
						
						<xsl:for-each select="catESAD_cu:GoodsDescription">
							<xsl:if test="position() = 1 and $backSide=0"> <!-- Polaris -->
								<xsl:apply-templates select="."/> 
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</xsl:if>  <!-- Polaris -->
							<xsl:if test="position() = 2 and $backSide=0"> <!-- Polaris -->
								СМ.ДОПОЛНЕНИЕ								
							</xsl:if>  <!-- Polaris -->							
							<xsl:if test="position() >= 2 and $backSide!=0"> <!-- Polaris -->
								<xsl:if test="position() = 2">
								Графа 31 <br/>
								</xsl:if>
								<xsl:apply-templates select="."/> 
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>								
							</xsl:if>  <!-- Polaris -->
						</xsl:for-each>
						<!--xsl:if test="catESAD_cu:GoodsDescription and catESAD_cu:GoodsGroupDescription"><br/></xsl:if-->
						<xsl:if test="catESAD_cu:GoodsGroupDescription">
							<xsl:if test="$backSide=0">
								СМ.ДОПОЛНЕНИЕ
							</xsl:if>
							<xsl:if test="false">
  						    <!-- Сначала описание без характеристик групп -->
							<xsl:for-each select="catESAD_cu:GoodsGroupDescription[not (catESAD_cu:GoodsGroupInformation)]">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								<xsl:for-each select="catESAD_cu:GoodsDescription">
									<xsl:apply-templates select="."/>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								</xsl:for-each>
							</xsl:for-each>
							<xsl:for-each select="catESAD_cu:GoodsGroupDescription[catESAD_cu:GoodsGroupInformation]">
								<xsl:variable name="len_description" select="(position()-1) * string-length(catESAD_cu:GoodsDescription[position()])"/> <!-- Polaris кол-во знаков в описании группы  -->
								<xsl:if test="(position() &lt;= $max_row_group_description) and ($row_description &lt;= 1) and ($len_description &lt; 100)"> <!-- Polaris -->
									
									<!-- Polaris br/  &#160;-->
									
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:if test="//ESADout_CU:DeclarationKind='ОКТ'">
										<xsl:if test="position()=1">1.1 </xsl:if>
									</xsl:if>
									<xsl:for-each select="catESAD_cu:GoodsDescription">
										<xsl:apply-templates select="."/>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:for-each>
									<xsl:if test="catESAD_cu:ObjectOrdinal"> / <xsl:apply-templates select="catESAD_cu:ObjectOrdinal"/>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:if>
									<xsl:if test="catESAD_cu:RKTNVED">
										<xsl:apply-templates select="catESAD_cu:RKTNVED"/>
									</xsl:if>
									<xsl:for-each select="catESAD_cu:GoodsGroupInformation">
										
										<xsl:if test="catESAD_cu:Manufacturer">
											<xsl:text> Производитель </xsl:text>
											<xsl:apply-templates select="catESAD_cu:Manufacturer"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:TradeMark">
											<xsl:text> Тов.знак </xsl:text>
											<xsl:apply-templates select="catESAD_cu:TradeMark"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:GoodsMark">
											<xsl:text> Торг. знак, марка </xsl:text>
											<xsl:apply-templates select="catESAD_cu:GoodsMark"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:GoodsModel">
											<xsl:text> Модель </xsl:text>
											<xsl:apply-templates select="catESAD_cu:GoodsModel"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:GoodsMarking">
											<xsl:text> Артикул</xsl:text>
											<xsl:apply-templates select="catESAD_cu:GoodsMarking"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:GoodsStandard">
											<xsl:text> Стандарт </xsl:text>
											<xsl:apply-templates select="catESAD_cu:GoodsStandard"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:GoodsSort">
											<xsl:text> Сорт: </xsl:text>
											<xsl:apply-templates select="catESAD_cu:GoodsSort"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:WoodDescriptionDetails">
											<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:WoodSortiment">
												<xsl:text> Наим.сортимента: </xsl:text>
												<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:WoodSortiment"/>
											</xsl:if>
											<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:WoodKind">
												<xsl:text> Порода древесины: </xsl:text>
												<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:WoodKind"/>
											</xsl:if>
											<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:ProductSortName">
												<xsl:text> Наименование сорта:</xsl:text>
												<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:ProductSortName"/>
											</xsl:if>
											<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:AllowanceDetails">
												<xsl:text> Припуск по длине, ширине, высоте: </xsl:text>
												<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:AllowanceDetails"/>
											</xsl:if>
											<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DeviationDetails">
												<!-- Polaris xsl:text> Отклонения по длине, ширине, высоте: </xsl:text> -->
												<xsl:text> Отклонения: </xsl:text> <!-- Polaris -->
												<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DeviationDetails"/>
											</xsl:if>
											<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails">
												<xsl:text> Диапазон диаметров: </xsl:text>
												<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails/catESAD_cu:MinRangeMeasure" mode="SupplementaryQuantity"/>
												<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails/catESAD_cu:MaxRangeMeasure"> - <xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails/catESAD_cu:MaxRangeMeasure" mode="SupplementaryQuantity"/>
												</xsl:if>
											</xsl:if>
											<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:ContractVolumeMeasure">
												<!-- Polaris xsl:text> Объем товара в соответствии с контрактом: </xsl:text> -->
												<xsl:text> Объем по контракту: </xsl:text> <!-- Polaris -->
												<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:ContractVolumeMeasure" mode="SupplementaryQuantity"/>
											</xsl:if>
											<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:FactVolumeMeasure">
												<!-- Polaris xsl:text> Фактический объем товара: </xsl:text> -->
												<xsl:text> Фактический объем: </xsl:text> <!-- Polaris -->
												<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:FactVolumeMeasure" mode="SupplementaryQuantity"/>
											</xsl:if>
										</xsl:if>
										<xsl:if test="catESAD_cu:Dimensions">
											<xsl:text> Размеры </xsl:text>
											<xsl:apply-templates select="catESAD_cu:Dimensions"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:DateIssue">
											<xsl:text> Дата выпуска </xsl:text>
											<xsl:apply-templates select="catESAD_cu:DateIssue" mode="date"/>
											<!--xsl:call-template name="russian_date">
												<xsl:with-param name="dateIn" select="catESAD_cu:DateIssue"/>
											</xsl:call-template-->
										</xsl:if>
										<xsl:if test="catESAD_cu:SerialNumber">
											<xsl:text> Серийный номер: </xsl:text>
											<xsl:for-each select="catESAD_cu:SerialNumber">
												<xsl:apply-templates select="."/>
												<xsl:if test="position()!=last()">
													<xsl:text>, </xsl:text>
												</xsl:if>
											</xsl:for-each>
										</xsl:if>
										<xsl:if test="catESAD_cu:GoodsGroupQuantity">
											<xsl:if test="catESAD_cu:GoodsQuantity > 0"> <!-- Polaris -->										
												<xsl:text> Кол-во </xsl:text>
											</xsl:if>  <!-- Polaris -->
											<xsl:for-each select="catESAD_cu:GoodsGroupQuantity">
												<xsl:if test="catESAD_cu:GoodsQuantity > 0">  <!-- Polaris -->
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="catESAD_cu:GoodsQuantity"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:if>  <!-- Polaris -->											
												<xsl:apply-templates select="catESAD_cu:MeasureUnitQualifierName"/>
												<!-- Polaris
												<xsl:if test="catESAD_cu:MeasureUnitQualifierCode">
													<xsl:text> (</xsl:text>
													<xsl:apply-templates select="catESAD_cu:MeasureUnitQualifierCode"/>
													<xsl:text>)</xsl:text>
												</xsl:if>
												-->
												
											</xsl:for-each>
										</xsl:if>
									</xsl:for-each>
									<xsl:if test="//ESADout_CU:DeclarationKind='ОКТ'">
										<xsl:if test="position()!=last()">, </xsl:if>
									</xsl:if>
								</xsl:if> <!-- Polaris -->
								<xsl:if test="(position()=($max_row_group_description+1)) and ($row_description &lt;= 1) "> <!-- Polaris -->
									<xsl:if test="$backSide=0">
										СМ.ДОПОЛНЕНИЕ
									</xsl:if>
								</xsl:if>
							</xsl:for-each>
							</xsl:if>
						</xsl:if>
						
						<!-- Polaris br/  -->
						<xsl:if test="catESAD_cu:OilField">
							<xsl:if test="$backSide=0">  <!-- Polaris -->
								&#160; Месторождения товара:
								<xsl:apply-templates select="catESAD_cu:OilField"/>
							</xsl:if>
						</xsl:if>
						<xsl:if test="catESAD_cu:OriginCountryName">
							<!-- Polaris br/  --> 
							&#160; 
							<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							<xsl:apply-templates select="catESAD_cu:OriginCountryName"/>
						</xsl:if>
						<xsl:if test="ESADout_CU:SupplementaryGoodsQuantity"> <!-- кол-во товара в дополнительных единицах измерения -->
							<!-- Polaris br/  -->
							<xsl:if test="$backSide=0">  <!-- Polaris -->
								&#160;Всего: 
								<xsl:apply-templates select="ESADout_CU:SupplementaryGoodsQuantity/cat_ru:GoodsQuantity"/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								<xsl:apply-templates select="ESADout_CU:SupplementaryGoodsQuantity/cat_ru:MeasureUnitQualifierName"/>
							</xsl:if> <!-- Polaris -->
							<!-- Polaris
							<xsl:if test="ESADout_CU:SupplementaryGoodsQuantity/cat_ru:MeasureUnitQualifierCode"> (<xsl:apply-templates select="ESADout_CU:SupplementaryGoodsQuantity/cat_ru:MeasureUnitQualifierCode"/>) </xsl:if>
							-->
						</xsl:if>
						<xsl:for-each select="ESADout_CU:SupplementaryGoodsQuantity1"> <!-- кол-во товара в дополнительных единицах измерения -->
							<!-- Polaris br/  -->
							<xsl:if test="$backSide=0">  <!-- Polaris -->
								&#160;
								<xsl:apply-templates select="cat_ru:GoodsQuantity"/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								<xsl:apply-templates select="cat_ru:MeasureUnitQualifierName"/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</xsl:if>
							<!-- Polaris
							<xsl:if test="cat_ru:MeasureUnitQualifierCode"> (<xsl:apply-templates select="cat_ru:MeasureUnitQualifierCode"/>)</xsl:if>
							-->
						</xsl:for-each>
						<xsl:if test="(catESAD_cu:BeginPeriodDate!='') or (catESAD_cu:EndPeriodDate!='')">
							<!-- Polaris br/  -->
							<xsl:if test="$backSide=0">  <!-- Polaris -->
								<xsl:if test="catESAD_cu:BeginPeriodDate">
									<span class="graph">&#160; Начало периода</span>
									<xsl:apply-templates select="catESAD_cu:BeginPeriodDate" mode="date"/>
									<!--xsl:call-template name="russian_date">
										<xsl:with-param name="dateIn" select="catESAD_cu:BeginPeriodDate"/>
									</xsl:call-template-->
								</xsl:if>
								<xsl:if test="catESAD_cu:EndPeriodDate">
									<span class="graph">&#160;Окончание периода</span>
									<xsl:apply-templates select="catESAD_cu:EndPeriodDate" mode="date"/>
									<!--xsl:call-template name="russian_date">
										<xsl:with-param name="dateIn" select="catESAD_cu:EndPeriodDate"/>
									</xsl:call-template-->
								</xsl:if>
							</xsl:if><!-- Polaris -->
						</xsl:if>
						<xsl:if test="catESAD_cu:IPObjectRegistryNum">
							<xsl:if test="$backSide=0">  <!-- Polaris -->
								<xsl:if test="count(catESAD_cu:IPObjectRegistryNum[catESAD_cu:DocumentModeCode='1']) &gt; 0">
									<!-- Polaris br/  -->
									&#160; 
									<span class="graph">Единый ТРОИС ЕАЭС: </span>
									<xsl:for-each select="catESAD_cu:IPObjectRegistryNum[catESAD_cu:DocumentModeCode='1']">
										<xsl:if test="catESAD_cu:CountryCode">
											<span class="graph">(</span>
											<xsl:apply-templates select="catESAD_cu:CountryCode"/>
											<span class="graph">) </span>
										</xsl:if>
										<xsl:apply-templates select="catESAD_cu:IPORegistryNumber"/>
										<xsl:if test="position()!=last()">, </xsl:if>
									</xsl:for-each>
								</xsl:if>
								<xsl:if test="count(catESAD_cu:IPObjectRegistryNum[catESAD_cu:DocumentModeCode='2']) &gt; 0">
									<!-- Polaris br/  -->
									&#160;
									<span class="graph">Национальный ТРОИС: </span>
									<xsl:for-each select="catESAD_cu:IPObjectRegistryNum[catESAD_cu:DocumentModeCode='2']">
										<xsl:if test="catESAD_cu:CountryCode">
											<span class="graph">(</span>
											<xsl:apply-templates select="catESAD_cu:CountryCode"/>
											<span class="graph">) </span>
										</xsl:if>
										<xsl:apply-templates select="catESAD_cu:IPORegistryNumber"/>
										<xsl:if test="position()!=last()">, </xsl:if>
									</xsl:for-each>
								</xsl:if>
							</xsl:if><!-- Polaris -->
						</xsl:if>
						<xsl:if test="ESADout_CU:ESADGoodsPackaging">
							<!-- Polaris
								<br/>
								<span class="graph">2)</span> 
							-->								
							<!--xsl:if test="ESADout_CU:ESADGoodsPackaging/catESAD_cu:PakageTypeCode=1"-->
							<xsl:if test="$backSide=0">  <!-- Polaris -->
								<xsl:if test="ESADout_CU:ESADGoodsPackaging/catESAD_cu:PakageQuantity!=''">
									<br/> <!-- Polaris -->
									<span class="graph">2)</span> <!-- Polaris -->
									<xsl:apply-templates select="ESADout_CU:ESADGoodsPackaging/catESAD_cu:PakageQuantity"/>&#160;
								<xsl:if test="ESADout_CU:ESADGoodsPackaging/catESAD_cu:PakagePartQuantity">
											(<xsl:apply-templates select="ESADout_CU:ESADGoodsPackaging/catESAD_cu:PakagePartQuantity"/>-часть
											места)
							
							
						   </xsl:if><!-- Polaris -->
						   <!--/xsl:if-->
                                    ,
                                </xsl:if>
								<xsl:if test="ESADout_CU:ESADGoodsPackaging/catESAD_cu:PackagePalleteInformation[catESAD_cu:InfoKindCode='0' or catESAD_cu:InfoKindCode='1' or catESAD_cu:InfoKindCode='2']">
									<xsl:for-each select="ESADout_CU:ESADGoodsPackaging/catESAD_cu:PackagePalleteInformation[catESAD_cu:InfoKindCode='0' or catESAD_cu:InfoKindCode='1' or catESAD_cu:InfoKindCode='2']">
										<xsl:apply-templates select="catESAD_cu:PalleteCode"/>
										<xsl:if test="catESAD_cu:PalleteQuantity">
											<span class="graph">-</span>
											<xsl:apply-templates select="catESAD_cu:PalleteQuantity"/>
										</xsl:if>
										<span class="graph">,</span>
									</xsl:for-each>
								</xsl:if>
								<xsl:if test="ESADout_CU:ESADGoodsPackaging/catESAD_cu:PackagePalleteInformation[catESAD_cu:InfoKindCode='3']">
                                    Поддоны:
									<xsl:for-each select="ESADout_CU:ESADGoodsPackaging/catESAD_cu:PackagePalleteInformation[catESAD_cu:InfoKindCode='3']">
										<xsl:if test="catESAD_cu:CargoDescriptionText">
											<xsl:apply-templates select="catESAD_cu:CargoDescriptionText"/>
										</xsl:if>
										<span class="graph">,</span>
										<xsl:apply-templates select="catESAD_cu:PalleteQuantity"/> /
										<xsl:apply-templates select="catESAD_cu:PalleteCode"/>
									</xsl:for-each>
								</xsl:if>
								<xsl:if test="ESADout_CU:ESADGoodsPackaging/catESAD_cu:PackagePalleteInformation[catESAD_cu:InfoKindCode='4']">
									<br/>2.1
									<xsl:for-each select="ESADout_CU:ESADGoodsPackaging/catESAD_cu:PackagePalleteInformation[catESAD_cu:InfoKindCode='4']">
										<xsl:apply-templates select="catESAD_cu:PalleteCode"/>
										<xsl:if test="catESAD_cu:PalleteQuantity">
											<span class="graph">-</span>
											<xsl:apply-templates select="catESAD_cu:PalleteQuantity"/>
										</xsl:if>
										<span class="graph">,</span>
									</xsl:for-each>
								</xsl:if>
							</xsl:if>
							<xsl:if test="ESADout_CU:ESADGoodsPackaging/catESAD_cu:PakageTypeCode=0">
                                без упаковки
                            </xsl:if>
							<xsl:if test="ESADout_CU:ESADGoodsPackaging/catESAD_cu:PakageTypeCode=2">
                                без упаковки/
								<xsl:for-each select="ESADout_CU:ESADGoodsPackaging/catESAD_cu:PackagePalleteInformation[catESAD_cu:InfoKindCode='2']">
									<xsl:apply-templates select="catESAD_cu:PalleteCode"/>
									<span class="graph">,</span>
								</xsl:for-each>
							</xsl:if>
						</xsl:if>
						<xsl:if test="ESADout_CU:ESADContainer">
							<br/>							
							<span class="graph">3) </span>
							<xsl:variable name="max_count" select="5"/> <!-- Polaris максимальное кол-во контейнеров -->
							<xsl:variable name="row_count" select="count(//catESAD_cu:ContainerNumber)"/> <!-- Polaris кол-во кнтейнеров -->
							
								<xsl:for-each select="ESADout_CU:ESADContainer">
									<xsl:if test="$backSide=0">
										<xsl:apply-templates select="catESAD_cu:ContainerQuantity"/>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:apply-templates select="catESAD_cu:ContainerKind"/>:
									</xsl:if>
									<xsl:if test="($row_count &lt;= $max_count and $backSide=0) or ($row_count > $max_count and $backSide!=0)"> <!-- Polaris -->
										<xsl:for-each select="catESAD_cu:ContainerNumber">
											<xsl:apply-templates select="catESAD_cu:ContainerIdentificaror"/>
											<xsl:if test="catESAD_cu:FullIndicator='2'">
												<span class="graph">(часть)</span>
											</xsl:if>
											<xsl:if test="position()!=last()">
												<span class="graph">, </span>
											</xsl:if>
										</xsl:for-each>
										<xsl:if test="position()!=last()">
											<span class="graph">; </span>
										</xsl:if>
									</xsl:if>
									<xsl:if test="$row_count > $max_count"> <!-- Polaris -->
										<xsl:if test="$backSide=0">
										СМ.ДОПОЛНЕНИЕ
										</xsl:if>
									</xsl:if>
								</xsl:for-each>
							
						</xsl:if>
						<xsl:if test="ESADout_CU:ESADExcise">
							<xsl:if test="$backSide=0">  <!-- Polaris -->
								<xsl:if test="$max_row_other > $row_container + $row_package + 1 "> <!-- Polaris -->
									<br/>
									<span class="graph">4) </span>
								</xsl:if>
								<xsl:for-each select="ESADout_CU:ESADExcise">
									<xsl:if test="position() &lt; $max_row_other - $row_container - $row_package"> <!-- Polaris -->
										<xsl:variable name="max_count" select="5"/> <!-- Polaris максимальное кол-во -->
										<xsl:variable name="row_count" select="count(//catESAD_cu:ExciseNumber)"/> <!-- Polaris кол-во акцизных марок -->
										
										<xsl:apply-templates select="catESAD_cu:ExciseSerieses"/>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:if test="$row_count &lt;= $max_count"> <!-- Polaris -->
											<xsl:for-each select="catESAD_cu:ExciseList">
												<xsl:for-each select="catESAD_cu:ExciseNumber">
													<xsl:apply-templates select="."/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:for-each>
											</xsl:for-each>
											<xsl:for-each select="catESAD_cu:ExciseRange">
												<xsl:apply-templates select="catESAD_cu:ExciseFirstNumber"/>
												<xsl:text disable-output-escaping="yes">-</xsl:text>
												<xsl:apply-templates select="catESAD_cu:ExciseLastNumber"/>
												<xsl:if test="position()!=last()">
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:if>
											</xsl:for-each>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="catESAD_cu:ExciseQuantity"/>
											<span class="graph">;</span>
										</xsl:if>
										<xsl:if test="$row_count > $max_count"> <!-- Polaris -->
											СМ.ДОПОЛНЕНИЕ
										</xsl:if>
									</xsl:if>
								</xsl:for-each>
							</xsl:if>
						</xsl:if>
						<xsl:if test="catESAD_cu:CUESADDeliveryTerms">
							<xsl:if test="$backSide=0">  <!-- Polaris -->
								<xsl:if test="$max_row_other > $row_container + $row_package + $row_akcis + 1"> <!-- Polaris -->
									<br/>
									<span class="graph">5) </span>
								</xsl:if>							
								<xsl:for-each select="catESAD_cu:CUESADDeliveryTerms">
									<xsl:if test="position() &lt; $max_row_other - $row_container - $row_package - $row_akcis"> <!-- Polaris -->
										<xsl:apply-templates select="cat_ru:DeliveryTermsStringCode"/>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:for-each select="cat_ru:DeliveryPlace"> - 
										<xsl:apply-templates select="."/>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:for-each>
									<xsl:if test="cat_ru:TransferPlace">
										<xsl:apply-templates select="cat_ru:TransferPlace"/>
									</xsl:if>
									</xsl:if>
								</xsl:for-each>
							</xsl:if> <!-- Polaris -->
						</xsl:if>
						<xsl:if test="ESADout_CU:ESADout_CUCustomsConditions">
							<xsl:if test="$backSide=0">  <!-- Polaris -->
								<xsl:if test="$max_row_other > $row_container + $row_package + $row_akcis + $row_delivery + 1"> <!-- Polaris -->
									<br/>
									<span class="graph">6) </span>
								</xsl:if>							
								
								<xsl:for-each select="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:RateOutputGoods">
									<xsl:if test="position() &lt; $max_row_other - $row_container - $row_package - $row_akcis - $row_delivery"> <!-- Polaris -->
										<xsl:apply-templates select="."/>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:if> <!-- Polaris -->
								</xsl:for-each>
								<!-- Polaris br/  -->
								<xsl:if test="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:ProcessingProduct">
									<xsl:if test="$max_row_other > $row_container + $row_package + $row_akcis + $row_delivery + 1"> <!-- Polaris -->
										&#160;Продукт переработки:
									</xsl:if>
								<xsl:apply-templates select="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:ProcessingProduct/catESAD_cu:GoodsTNVEDCode"/>
									<xsl:for-each select="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:ProcessingProduct/catESAD_cu:GoodsDescription">
										<xsl:if test="position() &lt; $max_row_other - $row_container - $row_package - $row_akcis - $row_delivery"> <!-- Polaris -->
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="."/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:if>
									</xsl:for-each>
									<xsl:if test="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:ProcessingProduct/catESAD_cu:ProcessingGoodsQuantity">
										<xsl:for-each select="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:ProcessingProduct/catESAD_cu:ProcessingGoodsQuantity">
											<xsl:if test="position() &lt; $max_row_other - $row_container - $row_package - $row_akcis - $row_delivery"> <!-- Polaris -->
												<xsl:apply-templates select="cat_ru:GoodsQuantity"/>
												<xsl:apply-templates select="cat_ru:MeasureUnitQualifierName"/>
												<xsl:if test="cat_ru:MeasureUnitQualifierCode">
												(<xsl:apply-templates select="cat_ru:MeasureUnitQualifierCode"/>) 
												</xsl:if>
												<xsl:if test="position()!=last()">, </xsl:if>
											</xsl:if>
										</xsl:for-each>
									</xsl:if>
								</xsl:if>
								<!-- Polaris br/  -->
								<xsl:if test="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:WasteProducts">
									<xsl:if test="$max_row_other > $row_container + $row_package + $row_akcis + $row_delivery + 1"> <!-- Polaris -->
									&#160;Отходы:
									</xsl:if>
								<xsl:apply-templates select="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:WasteProducts/catESAD_cu:GoodsTNVEDCode"/>
									<xsl:for-each select="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:WasteProducts/catESAD_cu:GoodsDescription">
										<xsl:if test="position() &lt; $max_row_other - $row_container - $row_package - $row_akcis - $row_delivery"> <!-- Polaris -->
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:apply-templates select="."/>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:if>
									</xsl:for-each>
									<xsl:if test="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:WasteProducts/catESAD_cu:ProcessingGoodsQuantity">
										<xsl:for-each select="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:WasteProducts/catESAD_cu:ProcessingGoodsQuantity">
											<xsl:if test="position() &lt; $max_row_other - $row_container - $row_package - $row_akcis - $row_delivery"> <!-- Polaris -->
											<xsl:apply-templates select="cat_ru:GoodsQuantity"/>
											<xsl:apply-templates select="cat_ru:MeasureUnitQualifierName"/>
											<xsl:if test="cat_ru:MeasureUnitQualifierCode">
												(<xsl:apply-templates select="cat_ru:MeasureUnitQualifierCode"/>) 
											</xsl:if>
											<xsl:if test="position()!=last()">, </xsl:if>
											</xsl:if>
										</xsl:for-each>
									</xsl:if>
								</xsl:if>
								<!-- Polaris br/  -->
								<xsl:if test="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:Heels">
									<xsl:if test="$max_row_other > $row_container + $row_package + $row_akcis + $row_delivery + 1"> <!-- Polaris -->
									&#160;Остатки:
									</xsl:if>
								<xsl:apply-templates select="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:Heels/catESAD_cu:GoodsTNVEDCode"/>
									<xsl:for-each select="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:Heels/catESAD_cu:GoodsDescription">
										<xsl:if test="position() &lt; $max_row_other - $row_container - $row_package - $row_akcis - $row_delivery"> <!-- Polaris -->
										<xsl:for-each select="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:WasteProducts/catESAD_cu:ProcessingGoodsQuantity">
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:apply-templates select="."/>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:for-each>
										</xsl:if>
									</xsl:for-each>
									<xsl:if test="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:Heels/catESAD_cu:ProcessingGoodsQuantity">
										<xsl:for-each select="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:Heels/catESAD_cu:ProcessingGoodsQuantity">
											<xsl:if test="position() &lt; $max_row_other - $row_container - $row_package - $row_akcis - $row_delivery"> <!-- Polaris -->
											<xsl:for-each select="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:WasteProducts/catESAD_cu:ProcessingGoodsQuantity">
											<xsl:apply-templates select="cat_ru:GoodsQuantity"/>
											<xsl:apply-templates select="cat_ru:MeasureUnitQualifierName"/>
											<xsl:if test="cat_ru:MeasureUnitQualifierCode">
												(<xsl:apply-templates select="cat_ru:MeasureUnitQualifierCode"/>) 
											</xsl:if>
											<xsl:if test="position()!=last()">, </xsl:if>
											</xsl:for-each>
											</xsl:if>
										</xsl:for-each>
									</xsl:if>
								</xsl:if>
								<!-- Polaris br/  -->
								<xsl:for-each select="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:GoodsIdentificationMethod">
									<xsl:if test="position() &lt; $max_row_other - $row_container - $row_package - $row_akcis - $row_delivery"> <!-- Polaris -->
										<xsl:if test="$max_row_other > $row_container + $row_package + $row_akcis + $row_delivery"> <!-- Polaris -->
											&#160;Способ идентификации:
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="."/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:if>
									</xsl:if>
								</xsl:for-each>
								<!-- Polaris br/  -->
								<xsl:if test="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:Substitute">
									<xsl:if test="$max_row_other > $row_container + $row_package + $row_akcis + $row_delivery + 1"> <!-- Polaris -->
									&#160;Сведения о замене иностранных товаров эквивалентными товарами:
									</xsl:if>
								<xsl:for-each select="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:Substitute">
									<xsl:if test="position() &lt; $max_row_other - $row_container - $row_package - $row_akcis - $row_delivery"> <!-- Polaris -->
										<xsl:apply-templates select="."/>
									</xsl:if>
									</xsl:for-each>
								</xsl:if>
							</xsl:if> <!-- Polaris -->
						</xsl:if>
						<xsl:if test="(catESAD_cu:DeliveryTime) or (catESAD_cu:DeliveryTimeEND)">
							<xsl:if test="$backSide=0">  <!-- Polaris -->
								<xsl:if test="$max_row_other > $row_container + $row_package + $row_akcis + $row_delivery + $row_custom_cond + 1"> <!-- Polaris -->
									<br/>
									<span class="graph">7) Поставка в период</span> с
									<xsl:apply-templates select="catESAD_cu:DeliveryTime" mode="date"/>							
									<!--xsl:call-template name="russian_date">
										<xsl:with-param name="dateIn" select="catESAD_cu:DeliveryTime"/>
									</xsl:call-template-->
									<xsl:if test="catESAD_cu:DeliveryTimeEND">
										по <xsl:apply-templates select="catESAD_cu:DeliveryTimeEND" mode="date"/>
										<!--xsl:call-template name="russian_date">
											<xsl:with-param name="dateIn" select="catESAD_cu:DeliveryTimeEND"/>
										</xsl:call-template-->
									</xsl:if>
								</xsl:if>							
							</xsl:if>
						</xsl:if>
						<xsl:if test="catESAD_cu:QuantityFact/cat_ru:GoodsQuantity">
							<xsl:if test="$backSide=0">  <!-- Polaris -->
								<xsl:if test="$max_row_other > $row_container + $row_package + $row_akcis + $row_delivery + $row_custom_cond + $row_delivery + 1"> <!-- Polaris -->
									<br/>
									<span class="graph">8) </span>
									<xsl:apply-templates select="catESAD_cu:QuantityFact/cat_ru:GoodsQuantity"/>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:apply-templates select="catESAD_cu:QuantityFact/cat_ru:MeasureUnitQualifierName"/>
									<xsl:if test="catESAD_cu:QuantityFact/cat_ru:MeasureUnitQualifierCode">
										<xsl:text> (</xsl:text>
										<xsl:apply-templates select="catESAD_cu:QuantityFact/cat_ru:MeasureUnitQualifierCode"/>
										<xsl:text>)</xsl:text>
									</xsl:if>
								</xsl:if>	
							</xsl:if>
						</xsl:if>
						<xsl:if test="(ESADout_CU:ElectricalEnergReceived) or (ESADout_CU:ElectricalEnergGiven)">
							<xsl:if test="$backSide=0">  <!-- Polaris -->
								<xsl:if test="$max_row_other > $row_container + $row_package + $row_akcis + $row_delivery + $row_custom_cond + $row_delivery + 1"> <!-- Polaris -->
									<xsl:if test="$max_row_other > $row_container + $row_package + $row_akcis + $row_delivery + $row_custom_cond + $row_delivery + $row_quant_fact"> <!-- Polaris -->
										<br/>
										<span class="graph">9) </span>
										<xsl:for-each select="ESADout_CU:ElectricalEnergReceived">
											принято <xsl:apply-templates select="catESAD_cu:ElectricalEnergyQuantity"/> тыс. кВт.ч
											<xsl:if test="catESAD_cu:QualifierCode">
												(<xsl:apply-templates select="catESAD_cu:QualifierCode"/>)
											</xsl:if>, 
										</xsl:for-each>
										<xsl:for-each select="ESADout_CU:ElectricalEnergGiven">
											отдано <xsl:apply-templates select="catESAD_cu:ElectricalEnergyQuantity"/> тыс. кВт.ч
											<xsl:if test="catESAD_cu:QualifierCode">
												(<xsl:apply-templates select="catESAD_cu:QualifierCode"/>)
											</xsl:if>, 
										</xsl:for-each>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:if>
						<xsl:if test="catESAD_cu:CIMIdDetails">
							<xsl:if test="$backSide=0">  <!-- Polaris -->
								<xsl:if test="$max_row_other > $row_container + $row_package + $row_akcis + $row_delivery + $row_custom_cond + $row_delivery + $row_quant_fact + $row_electr + 1"> <!-- Polaris -->
									<br/>
									<xsl:for-each select="catESAD_cu:CIMIdDetails">
										<span class="graph">10) </span>
										<xsl:apply-templates select="catESAD_cu:CIMQuantity"/>
										<xsl:text>:</xsl:text>
										<xsl:for-each select="catESAD_cu:CIMList">
											<xsl:apply-templates select="catESAD_cu:CIMID"/>
											<xsl:if test="position()!=last()">
												<xsl:text>,</xsl:text>
											</xsl:if>
										</xsl:for-each>
										<xsl:if test="catESAD_cu:CIMList and catESAD_cu:CIMRange">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:for-each select="catESAD_cu:CIMRange">
											<xsl:apply-templates select="catESAD_cu:FirstCIMID"/>
											<xsl:text>-</xsl:text>
											<xsl:apply-templates select="catESAD_cu:LastCIMID"/>
											<xsl:if test="position()!=last()">,</xsl:if>
										</xsl:for-each>
									</xsl:for-each>
								</xsl:if>
							</xsl:if>
						</xsl:if>
						<xsl:if test="$backSide=0">  <!-- Polaris -->
							<xsl:for-each select="catESAD_cu:GoodsSTZ">
								<xsl:if test="position() &lt; $max_row_other - ($row_container + $row_package + $row_akcis + $row_delivery + $row_custom_cond + $row_delivery + $row_quant_fact + $row_electr + $row_cim + 1)"> <!-- Polaris -->									
									<br/>
									<span class="graph">11) </span>
									<br/>
									Номер строки в гр 40 <xsl:apply-templates select="catESAD_cu:LineNumber"/>
									<br/>
									<xsl:for-each select="catESAD_cu:GoodsDescription">
										<xsl:apply-templates select="."/>
									</xsl:for-each>
									Кол-во
									<xsl:for-each select="catESAD_cu:SupplementaryQuantity">
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:apply-templates select="cat_ru:GoodsQuantity"/>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:apply-templates select="cat_ru:MeasureUnitQualifierName"/>
										<!-- Polaris
										<xsl:if test="cat_ru:MeasureUnitQualifierCode">
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>(
											<xsl:apply-templates select="cat_ru:MeasureUnitQualifierCode"/>)
										</xsl:if>
										-->
									</xsl:for-each>
									<!-- Сначала описание без характеристик групп -->
									<xsl:for-each select="catESAD_cu:GoodsGroupDescription[not (catESAD_cu:GoodsGroupInformation)]">
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:for-each select="catESAD_cu:GoodsDescription">
											<xsl:apply-templates select="."/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:for-each>
									</xsl:for-each>
									<xsl:for-each select="catESAD_cu:GoodsGroupDescription[catESAD_cu:GoodsGroupInformation]">
										<br/>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:for-each select="catESAD_cu:GoodsDescription">
											<xsl:apply-templates select="."/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:for-each>
										<xsl:if test="catESAD_cu:ObjectOrdinal"> / <xsl:apply-templates select="catESAD_cu:ObjectOrdinal"/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:if>
										<xsl:if test="catESAD_cu:RKTNVED">
											<xsl:apply-templates select="catESAD_cu:RKTNVED"/>
										</xsl:if>
										<xsl:for-each select="catESAD_cu:GoodsGroupInformation">
											<xsl:if test="catESAD_cu:Manufacturer">
												<xsl:text> Производитель </xsl:text>
												<xsl:apply-templates select="catESAD_cu:Manufacturer"/>
											</xsl:if>
											<xsl:if test="catESAD_cu:TradeMark">
												<xsl:text> Тов.знак </xsl:text>
												<xsl:apply-templates select="catESAD_cu:TradeMark"/>
											</xsl:if>
											<xsl:if test="catESAD_cu:GoodsMark">
												<xsl:text> Торг. знак, марка </xsl:text>
												<xsl:apply-templates select="catESAD_cu:GoodsMark"/>
											</xsl:if>
											<xsl:if test="catESAD_cu:GoodsModel">
												<xsl:text> Модель </xsl:text>
												<xsl:apply-templates select="catESAD_cu:GoodsModel"/>
											</xsl:if>
											<xsl:if test="catESAD_cu:GoodsMarking">
												<xsl:text> Артикул</xsl:text>
												<xsl:apply-templates select="catESAD_cu:GoodsMarking"/>
											</xsl:if>
											<xsl:if test="catESAD_cu:GoodsStandard">
												<xsl:text> Стандарт </xsl:text>
												<xsl:apply-templates select="catESAD_cu:GoodsStandard"/>
											</xsl:if>
											<xsl:if test="catESAD_cu:GoodsSort">
												<xsl:text> Сорт: </xsl:text>
												<xsl:apply-templates select="catESAD_cu:GoodsSort"/>
											</xsl:if>
											<xsl:if test="catESAD_cu:WoodDescriptionDetails">
												<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:WoodSortiment">
													<xsl:text> Наим.сортимента: </xsl:text>
													<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:WoodSortiment"/>
												</xsl:if>
												<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:WoodKind">
													<xsl:text> Порода древесины: </xsl:text>
													<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:WoodKind"/>
												</xsl:if>
												<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:ProductSortName">
													<xsl:text> Наименование сорта:</xsl:text>
													<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:ProductSortName"/>
												</xsl:if>
												<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:AllowanceDetails">
													<xsl:text> Припуск по длине, ширине, высоте: </xsl:text>
													<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:AllowanceDetails"/>
												</xsl:if>
												<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DeviationDetails">
													<!-- Polaris xsl:text> Отклонения по длине, ширине, высоте: </xsl:text> -->
													<xsl:text> Отклонения: </xsl:text> <!-- Polaris -->
													<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DeviationDetails"/>
												</xsl:if>
												<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails">
													<xsl:text> Диапазон диаметров: </xsl:text>
													<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails/catESAD_cu:MinRangeMeasure" mode="SupplementaryQuantity"/>
													<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails/catESAD_cu:MaxRangeMeasure"> - <xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails/catESAD_cu:MaxRangeMeasure" mode="SupplementaryQuantity"/>
													</xsl:if>
												</xsl:if>
												<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:ContractVolumeMeasure">
													<!-- Polaris xsl:text> Объем товара в соответствии с контрактом: </xsl:text> -->
													<xsl:text> Объем по контракту: </xsl:text> <!-- Polaris -->
													<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:ContractVolumeMeasure" mode="SupplementaryQuantity"/>
												</xsl:if>
												<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:FactVolumeMeasure">
													<!-- Polaris xsl:text> Фактический объем товара: </xsl:text> -->
													<xsl:text> Фактический объем: </xsl:text> <!-- Polaris -->
													<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:FactVolumeMeasure" mode="SupplementaryQuantity"/>
												</xsl:if>
											</xsl:if>
											<xsl:if test="catESAD_cu:Dimensions">
												<xsl:text> Размеры </xsl:text>
												<xsl:apply-templates select="catESAD_cu:Dimensions"/>
											</xsl:if>
											<xsl:if test="catESAD_cu:DateIssue">
												<xsl:text> Дата выпуска </xsl:text>
												<xsl:apply-templates select="catESAD_cu:DateIssue" mode="date"/>
												<!--xsl:call-template name="russian_date">
													<xsl:with-param name="dateIn" select="catESAD_cu:DateIssue"/>
												</xsl:call-template-->
											</xsl:if>
											<xsl:if test="catESAD_cu:SerialNumber">
												<xsl:text> Серийный номер: </xsl:text>
												<xsl:for-each select="catESAD_cu:SerialNumber">
													<xsl:apply-templates select="."/>
													<xsl:if test="position()!=last()">
														<xsl:text>, </xsl:text>
													</xsl:if>
												</xsl:for-each>
											</xsl:if>
											<xsl:if test="catESAD_cu:GoodsGroupQuantity">
												<xsl:text> Кол-во </xsl:text>
												<xsl:for-each select="catESAD_cu:GoodsGroupQuantity">
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="catESAD_cu:GoodsQuantity"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="catESAD_cu:MeasureUnitQualifierName"/>
													<!-- Polaris
													<xsl:if test="catESAD_cu:MeasureUnitQualifierCode">
														<xsl:text> (</xsl:text>
														<xsl:apply-templates select="catESAD_cu:MeasureUnitQualifierCode"/>
														<xsl:text>)</xsl:text>
													</xsl:if>
													-->
												</xsl:for-each>
											</xsl:if>
										</xsl:for-each>
									</xsl:for-each>
								</xsl:if>
							</xsl:for-each>
						</xsl:if> <!-- Polaris -->
						<xsl:if test="catESAD_cu:DTIdentificationMeansDetails">
							<xsl:if test="$backSide=0">  <!-- Polaris -->
								<xsl:if test="$max_row_other > $row_container + $row_package + $row_akcis + $row_delivery + $row_custom_cond + $row_delivery + $row_quant_fact + $row_cim + $row_electr + 1"> <!-- Polaris -->
									<br/>
									<xsl:for-each select="catESAD_cu:DTIdentificationMeansDetails">
										<span class="graph">13) </span>
										<xsl:apply-templates select="catESAD_cu:CIMQuantity"/>
										<xsl:text>:</xsl:text>
										<xsl:for-each select="catESAD_cu:IdentificationMeansDetails">
											<xsl:apply-templates select="catESAD_cu:AggregationKindCode"/>
											<xsl:text>/</xsl:text>
											<xsl:for-each select="catESAD_cu:IdentificationMeansListDetails">
												<xsl:for-each select="catESAD_cu:IdentificationMeansItemDetails[position() &lt; 11]">
													<!--[<xsl:value-of select="position()"/>]-->
													<xsl:for-each select="catESAD_cu:IdentificationMeansDataUnitDetails">
														<xsl:apply-templates select="catESAD_cu:IdentifacationMeansUnitCharacterValueId"/>
														<xsl:if test="position()!=last()">,</xsl:if>
													</xsl:for-each>
													<xsl:if test="position()!=last()">,</xsl:if>
												</xsl:for-each>
												<xsl:if test="count(catESAD_cu:IdentificationMeansItemDetails) &gt; 10">
													<xsl:text> - список средств идентификации сокращен </xsl:text>
												</xsl:if>
											</xsl:for-each>
											<xsl:if test="catESAD_cu:IdentificationMeansListDetails and catESAD_cu:IdentificationMeansRangeDetails">
												<xsl:text>,</xsl:text>
											</xsl:if>
											<xsl:for-each select="catESAD_cu:IdentificationMeansRangeDetails">
												<xsl:for-each select="catESAD_cu:FirstIdentificationMeansItemDetails">
													<xsl:apply-templates select="catESAD_cu:IdentificationMeansDataUnitDetails/catESAD_cu:IdentifacationMeansUnitCharacterValueId"/>
												</xsl:for-each>
												<xsl:text> - </xsl:text>
												<xsl:for-each select="catESAD_cu:LastIdentificationMeansItemDetails">
													<xsl:apply-templates select="catESAD_cu:IdentificationMeansDataUnitDetails/catESAD_cu:IdentifacationMeansUnitCharacterValueId"/>
												</xsl:for-each>
												<xsl:if test="position()!=last()">,</xsl:if>
											</xsl:for-each>
											<xsl:if test="position()!=last()">;</xsl:if>
										</xsl:for-each>
									</xsl:for-each>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					<!-- Polaris Графа 31 Окончание -->					
	</xsl:template>

	<xsl:template name="graf_44">
		<xsl:param name="backSide" select="0" />
		<xsl:variable name="max_row_count" select="8"/> <!-- Polaris для ограничения вывода записей -->
		<xsl:variable name="row_count" select="count(ESADout_CU:ESADout_CUPresentedDocument)"/> <!-- Polaris кол-во записей -->
		<!-- Polaris start debug  -->
		<!-- (<xsl:value-of select="$max_row_count" />-<xsl:value-of select="$row_count" />) -->
		<!-- -->
						<xsl:if test="ESADout_CU:ESADout_CUPresentedDocument">
							<xsl:if test="$row_count > $max_row_count and $backSide!=0" >
								Графа 44 <br/>
							</xsl:if>
							<xsl:for-each select="ESADout_CU:ESADout_CUPresentedDocument">
								<!--xsl:variable name="condPrint" select="(position() &lt; $max_row_count) or (position() = $max_row_count and $row_count &lt;= $max_row_count )"/-->
								<xsl:variable name="condPrint" select="row_count &lt;= $max_row_count"/>
								<xsl:if test="($condPrint and $backSide=0) or ($condPrint=false and $backSide!=0)" > <!-- Polaris -->

									<!-- (<xsl:value-of select="position()"/>-<xsl:value-of select="$condPrint"/>-<xsl:value-of select="$backSide"/>) -->
									
									<xsl:apply-templates select="catESAD_cu:PresentedDocumentModeCode"/>
									<xsl:if test="RUDECLcat:DocumentPresentingDetails/RUDECLcat:DocPresentKindCode">
										<xsl:text>/</xsl:text>
										<xsl:apply-templates select="RUDECLcat:DocumentPresentingDetails/RUDECLcat:DocPresentKindCode"/>
									</xsl:if>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:choose>
										<xsl:when test="contains(cat_ru:PrDocumentNumber,'ОБЯЗУЮСЬ ПРЕДОСТАВИТЬ ДО')">
											<xsl:apply-templates select="cat_ru:PrDocumentNumber"/>
											<xsl:text> </xsl:text>
											<xsl:apply-templates select="RUDECLcat:DocumentPresentingDetails/RUDECLcat:DocPresentDate" mode="date"/>
											<!--xsl:call-template name="russian_date">
												<xsl:with-param name="dateIn" select="RUDECLcat:DocumentPresentingDetails/RUDECLcat:DocPresentDate"/>
											</xsl:call-template-->
										</xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates select="cat_ru:PrDocumentNumber"/>
											<xsl:if test="RUDECLcat:DocumentPresentingDetails/RUDECLcat:DocPresentDate and RUDECLcat:DocumentPresentingDetails/RUDECLcat:DocPresentKindCode='3'">
												<xsl:text> ОБЯЗУЮСЬ ПРЕДОСТАВИТЬ ДО </xsl:text>
												<xsl:apply-templates select="RUDECLcat:DocumentPresentingDetails/RUDECLcat:DocPresentDate" mode="date"/>
												<!--xsl:call-template name="russian_date">
													<xsl:with-param name="dateIn" select="RUDECLcat:DocumentPresentingDetails/RUDECLcat:DocPresentDate"/>
												</xsl:call-template-->
											</xsl:if>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:if test="catESAD_cu:LicenseGoods">/<xsl:if test="catESAD_cu:LicenseGoods/catESAD_cu:AppNumber">
										<xsl:apply-templates select="catESAD_cu:LicenseGoods/catESAD_cu:AppNumber"/>/</xsl:if>
										<xsl:apply-templates select="catESAD_cu:LicenseGoods/catESAD_cu:GoodsNumericLic"/>
									</xsl:if>
									<xsl:if test="cat_ru:PrDocumentDate">
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:apply-templates select="cat_ru:PrDocumentDate" mode="date"/>
										<!--xsl:call-template name="russian_date">
											<xsl:with-param name="dateIn" select="cat_ru:PrDocumentDate"/>
										</xsl:call-template-->
									</xsl:if>
									<!--xsl:if test="cat_ru:PrDocumentName">
									   <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									   <xsl:value-of select="cat_ru:PrDocumentName"/>
									</xsl:if-->
									<xsl:if test="catESAD_cu:DocumentBeginActionsDate">
										<xsl:text> с </xsl:text>
										<xsl:apply-templates select="catESAD_cu:DocumentBeginActionsDate" mode="date"/>
										<!--xsl:call-template name="russian_date">
											<xsl:with-param name="dateIn" select="catESAD_cu:DocumentBeginActionsDate"/>
										</xsl:call-template-->
									</xsl:if>
									<xsl:if test="catESAD_cu:DocumentEndActionsDate">
										<xsl:text> по </xsl:text>
										<xsl:apply-templates select="catESAD_cu:DocumentEndActionsDate" mode="date"/>
										<!--xsl:call-template name="russian_date">
											<xsl:with-param name="dateIn" select="catESAD_cu:DocumentEndActionsDate"/>
										</xsl:call-template-->
									</xsl:if>
									<xsl:if test=" (RUDECLcat:DocumentPresentingDetails/RUDECLcat:CustomsDocIdDetails or RUDECLcat:DocumentPresentingDetails/RUDECLcat:DTMDocDetails or RUDECLcat:DocumentPresentingDetails/RUDECLcat:TIRIdDetails or RUDECLcat:DocumentPresentingDetails/RUDECLcat:OtherPrecedingDocId) and RUDECLcat:DocumentPresentingDetails/RUDECLcat:DocPresentKindCode='2'">
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:choose>
											<xsl:when test="RUDECLcat:DocumentPresentingDetails/RUDECLcat:CustomsDocIdDetails">
												<xsl:apply-templates select="RUDECLcat:DocumentPresentingDetails/RUDECLcat:CustomsDocIdDetails"/>
											</xsl:when>
											<xsl:when test="RUDECLcat:DocumentPresentingDetails/RUDECLcat:DTMDocDetails">
												<xsl:apply-templates select="RUDECLcat:DocumentPresentingDetails/RUDECLcat:DTMDocDetails"/>
											</xsl:when>
											<xsl:when test="RUDECLcat:DocumentPresentingDetails/RUDECLcat:TIRIdDetails">
												<xsl:apply-templates select="RUDECLcat:DocumentPresentingDetails/RUDECLcat:TIRIdDetails"/>
											</xsl:when>
											<xsl:when test="RUDECLcat:DocumentPresentingDetails/RUDECLcat:OtherPrecedingDocId">
												<xsl:text>№ </xsl:text>
												<xsl:apply-templates select="RUDECLcat:DocumentPresentingDetails/RUDECLcat:OtherPrecedingDocId"/>
												<xsl:if test="RUDECLcat:DocumentPresentingDetails/RUDECLcat:OtherPrecedingDocDate">
													<xsl:text> от </xsl:text>
													<xsl:apply-templates select="RUDECLcat:DocumentPresentingDetails/RUDECLcat:OtherPrecedingDocDate" mode="date"/>
													<!--xsl:call-template name="russian_date">
														<xsl:with-param name="dateIn" select="RUDECLcat:DocumentPresentingDetails/RUDECLcat:OtherPrecedingDocDate"/>
													</xsl:call-template-->
													<xsl:apply-templates select="RUDECLcat:DocumentPresentingDetails/RUDECLcat:OtherPrecedingDocDate"/>
												</xsl:if>
											</xsl:when>
										</xsl:choose>
									</xsl:if>
									<xsl:if test="catESAD_cu:CountryCode">
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:apply-templates select="catESAD_cu:CountryCode"/>
									</xsl:if>
									<xsl:if test="catESAD_cu:CustomsPaymentModeCodeType">
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:apply-templates select="catESAD_cu:CustomsPaymentModeCodeType"/>
									</xsl:if>
									<xsl:if test="catESAD_cu:TemporaryStorageImportDate">
										<!--<xsl:text> Срок временного ввоза </xsl:text>-->
										<xsl:text> </xsl:text>
										<xsl:apply-templates select="catESAD_cu:TemporaryStorageImportDate" mode="date"/>
										<!--xsl:call-template name="russian_date">
											<xsl:with-param name="dateIn" select="catESAD_cu:TemporaryStorageImportDate"/>
										</xsl:call-template-->
									</xsl:if>
									<xsl:if test="catESAD_cu:TemporaryImportCode">
										<xsl:text> /</xsl:text>
										<!--<xsl:value-of select="catESAD_cu:TemporaryStorageImportDate"/>-->
										<xsl:apply-templates select="catESAD_cu:TemporaryImportCode"/>
									</xsl:if>
									<xsl:if test="catESAD_cu:SupplyStatus">
										<xsl:text> /Опережающая поставка </xsl:text>
									</xsl:if>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:apply-templates select="ancestor::node()/ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:ProcessingDoc/cat_ru:PrDocumentDate" mode="date"/>
									<!--xsl:call-template name="russian_date">
										<xsl:with-param name="dateIn" select="ancestor::node()/ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:ProcessingDoc/cat_ru:PrDocumentDate"/>
									</xsl:call-template-->
									<br/>
								</xsl:if>
								<xsl:if test="(position() = $max_row_count and $row_count > $max_row_count and $backSide=0)" > <!-- Polaris -->
									<!-- (<xsl:value-of select="position()"/>-<xsl:value-of select="$condPrint"/>-<xsl:value-of select="$backSide"/>) -->
									СМ.ДОПОЛНЕНИЕ 
									<!-- (<xsl:value-of select="position()" />-<xsl:value-of select="$max_row_count" />-<xsl:value-of select="$row_count" />) -->
								</xsl:if>
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="ESADout_CU:ESADout_CUCustomsConditions">
							<xsl:for-each select="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:Organization">
								<xsl:apply-templates select="cat_ru:OrganizationName"/>
								<xsl:text> </xsl:text>
							</xsl:for-each>
							<xsl:for-each select="ESADout_CU:ESADout_CUCustomsConditions/RUDECLcat:ProcessingPlaceDetails">
								<xsl:apply-templates select="."/>
								<xsl:if test="position()!=last()">; </xsl:if>
							</xsl:for-each>
							<xsl:text> </xsl:text>
						</xsl:if>
	</xsl:template>

	<xsl:template name="backSideTD">
		<xsl:for-each select="//ESADout_CU:ESADout_CUGoods">
			<div class="page" style="height:297mm">
			<xsl:call-template name="td4g31_1_table"/>
			</div>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="td4g31_1_table">

	<!-- Сначала описание без характеристик групп -->
	<xsl:for-each select="catESAD_cu:GoodsGroupDescription[not (catESAD_cu:GoodsGroupInformation)]">
		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
		<xsl:for-each select="catESAD_cu:GoodsDescription">
			<xsl:apply-templates select="."/>
			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
		</xsl:for-each>
	</xsl:for-each>
	<table>
		<xsl:for-each select="catESAD_cu:GoodsGroupDescription[catESAD_cu:GoodsGroupInformation]">
			<xsl:variable name="posGroup" select="position()" />
			<xsl:if test="$posGroup=1">
				<tr class="tb tt graph">
					<td class="tl tt tb">Гр</td>			
					<td class="tl tt tb">Наименование</td>					
					<xsl:if test="catESAD_cu:GoodsGroupInformation/catESAD_cu:Manufacturer">
					<td class="tl tt tb">Производитель</td>
					</xsl:if>
					<xsl:if test="catESAD_cu:GoodsGroupInformation/catESAD_cu:GoodsMark">
					<td class="tl tt tb">Марка</td>
					</xsl:if>
					<xsl:if test="catESAD_cu:GoodsGroupInformation/catESAD_cu:GoodsModel">
					<td class="tl tt tb">Модель</td>
					</xsl:if>
					<xsl:if test="catESAD_cu:GoodsGroupInformation/catESAD_cu:TradeMark">
					<td class="tl tt tb">Тов.знак</td>
					</xsl:if>
					<xsl:if test="catESAD_cu:GoodsGroupInformation/catESAD_cu:GoodsGroupQuantity">
					<td class="tl tt tb">Кол-во</td>
					</xsl:if>
					<xsl:if test="catESAD_cu:GoodsGroupInformation/catESAD_cu:GoodsGroupQuantity">
					<td class="tl tt tb">Ед.изм.</td>
					</xsl:if>
					<xsl:if test="catESAD_cu:GoodsGroupInformation/catESAD_cu:GoodsMarking">
					<td class="tl tt tb">Артикул</td>
					</xsl:if>
					<xsl:if test="catESAD_cu:GoodsGroupInformation/catESAD_cu:GoodsStandard">
					<td class="tl tt tb"></td>
					</xsl:if>					
					<td class="tl"></td>
				</tr>
			</xsl:if>

			<xsl:for-each select="catESAD_cu:GoodsGroupInformation">
			<xsl:variable name="posInfo" select="position()" />
			<tr class="tb graph">
			
				<td class="tl tb">
				<xsl:if test="$posInfo=1">
				<xsl:value-of select="$posGroup"/>
				</xsl:if>
				</td>
				<td class="tl tb"><!-- Наименование -->
					<xsl:if test="$posInfo=1">
						<xsl:for-each select="../catESAD_cu:GoodsDescription">
							<xsl:apply-templates select="."/>
						</xsl:for-each>
						<xsl:if test="../catESAD_cu:ObjectOrdinal"> 
							/ <xsl:apply-templates select="."/>
						</xsl:if>
						<xsl:if test="../catESAD_cu:RKTNVED">
							<xsl:apply-templates select="."/>
						</xsl:if>
					</xsl:if>
				</td>
				<xsl:if test="catESAD_cu:Manufacturer"><!-- Производитель -->
					<td class="tl tb">
						<xsl:if test="catESAD_cu:Manufacturer">
							<xsl:apply-templates select="catESAD_cu:Manufacturer"/>
						</xsl:if>
					</td>
				</xsl:if>
				<xsl:if test="catESAD_cu:GoodsMark"><!-- Марка -->
					<td class="tl tb">
						<!-- <xsl:text> Торг. знак, марка </xsl:text> -->
						<xsl:apply-templates select="catESAD_cu:GoodsMark"/>
					</td>
				</xsl:if>
				<xsl:if test="catESAD_cu:GoodsModel"><!-- Модель -->
					<td class="tl tb">
						<xsl:apply-templates select="catESAD_cu:GoodsModel"/>
					</td>
				</xsl:if>
				<xsl:if test="catESAD_cu:TradeMark"><!-- Тов.знак -->
					<td class="tl tb">
						<xsl:apply-templates select="catESAD_cu:TradeMark"/>
					</td>
				</xsl:if>
				<xsl:if test="catESAD_cu:GoodsGroupQuantity"><!-- Количество  -->
						<td class="tl tb">
						<xsl:for-each select="catESAD_cu:GoodsGroupQuantity">
							<xsl:apply-templates select="catESAD_cu:GoodsQuantity"/>
						</xsl:for-each>
						</td>
						<td class="tl tb">
						<xsl:for-each select="catESAD_cu:GoodsGroupQuantity">
							<xsl:apply-templates select="catESAD_cu:MeasureUnitQualifierName"/>
						</xsl:for-each>
						</td>
				</xsl:if>
				<xsl:if test="catESAD_cu:GoodsMarking"><!-- Артикул -->
					<td class="tl tb">
						<xsl:text> Артикул</xsl:text>
						<xsl:apply-templates select="catESAD_cu:GoodsMarking"/>
					</td>
				</xsl:if>
				<xsl:if test="catESAD_cu:GoodsStandard">
				<td class="tl tb">
					<xsl:if test="catESAD_cu:GoodsStandard"><!-- ГОСТ основной -->
						<xsl:text> Стандарт </xsl:text>
						<xsl:apply-templates select="catESAD_cu:GoodsStandard"/>
					</xsl:if>
					<xsl:if test="catESAD_cu:GoodsSort"><!-- ГОСТ сорт -->
						<xsl:text> Сорт: </xsl:text>
						<xsl:apply-templates select="catESAD_cu:GoodsSort"/>
					</xsl:if>
					<xsl:if test="catESAD_cu:WoodDescriptionDetails"><!-- Намименование сортмента -->
						<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:WoodSortiment">
							<xsl:text> Наим.сортимента: </xsl:text>
							<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:WoodSortiment"/>
						</xsl:if>
						<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:WoodKind"><!-- Порода древесины -->
							<xsl:text> Порода древесины: </xsl:text>
							<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:WoodKind"/>
						</xsl:if>
						<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:ProductSortName"><!-- Сорт -->
							<xsl:text> Наименование сорта:</xsl:text>
							<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:ProductSortName"/>
						</xsl:if>
						<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:AllowanceDetails"><!-- Припуски -->
							<xsl:text> Припуск по длине, ширине, высоте: </xsl:text>
							<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:AllowanceDetails"/>
						</xsl:if>
						<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DeviationDetails"><!-- Отклонения -->
							<!-- Polaris xsl:text> Отклонения по длине, ширине, высоте: </xsl:text> -->
							<xsl:text> Отклонения: </xsl:text> <!-- Polaris -->
							<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DeviationDetails"/>
						</xsl:if>
						<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails"><!-- Диапазон  -->
							<xsl:text> Диапазон диаметров: </xsl:text>
							<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails/catESAD_cu:MinRangeMeasure" mode="SupplementaryQuantity"/>
							<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails/catESAD_cu:MaxRangeMeasure"> - <xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails/catESAD_cu:MaxRangeMeasure" mode="SupplementaryQuantity"/>
							</xsl:if>
						</xsl:if>
						<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:ContractVolumeMeasure"><!-- Объем по контракту  -->
							<!-- Polaris xsl:text> Объем товара в соответствии с контрактом: </xsl:text> -->
							<xsl:text> Объем по контракту: </xsl:text> <!-- Polaris -->
							<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:ContractVolumeMeasure" mode="SupplementaryQuantity"/>
						</xsl:if>
						<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:FactVolumeMeasure"><!-- Фактический объем -->
							<!-- Polaris xsl:text> Фактический объем товара: </xsl:text> -->
							<xsl:text> Фактический объем: </xsl:text> <!-- Polaris -->
							<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:FactVolumeMeasure" mode="SupplementaryQuantity"/>
						</xsl:if>
					</xsl:if>
					<xsl:if test="catESAD_cu:Dimensions">
						<xsl:text> Размеры </xsl:text>
						<xsl:apply-templates select="catESAD_cu:Dimensions"/>
					</xsl:if>
					<xsl:if test="catESAD_cu:DateIssue">
						<xsl:text> Дата выпуска </xsl:text>
						<xsl:apply-templates select="catESAD_cu:DateIssue" mode="date"/>
						<!--xsl:call-template name="russian_date">
							<xsl:with-param name="dateIn" select="catESAD_cu:DateIssue"/>
						</xsl:call-template-->
					</xsl:if>
					<xsl:if test="catESAD_cu:SerialNumber">
						<xsl:text> Серийный номер: </xsl:text>
						<xsl:for-each select="catESAD_cu:SerialNumber">
							<xsl:apply-templates select="."/>
							<xsl:if test="position()!=last()">
								<xsl:text>, </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
				</td>
				</xsl:if>
				<td class="tl"></td>
			</tr>
			</xsl:for-each>
		</xsl:for-each>
	</table>
	</xsl:template>


</xsl:stylesheet>
