<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:KDTout="urn:customs.ru:Information:CustomsDocuments:KDTout:5.17.0" xmlns:catESAD_cu="urn:customs.ru:CUESADCommonAggregateTypesCust:5.17.0" xmlns:cat_ru="urn:customs.ru:CommonAggregateTypes:5.10.0" xmlns:RUScat_ru="urn:customs.ru:RUSCommonAggregateTypes:5.16.0" xmlns:RUDECLcat="urn:customs.ru:RUDeclCommonAggregateTypesCust:5.17.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" encoding="utf-8" indent="yes" media-type="text/html" method="html" omit-xml-declaration="yes" version="1.0"/>
	<xsl:variable name="k" select="1"/>
	<xsl:variable name="moneyNumberFormat" select="'0.00'"/>
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
	<xsl:template match="//*[local-name()='KDTout_CU']//*" priority="-1">
		<xsl:variable name="xpath">
			<xsl:call-template name="get_xpath">
				<xsl:with-param name="node" select="current()"/>
			</xsl:call-template>
		</xsl:variable>
		<element xml_node="{$xpath}">
			<xsl:apply-templates/>
		</element>
	</xsl:template>
	<xsl:template match="*" mode="russian_date">
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
   <xsl:template match="*" mode="format_number_2">
	   <xsl:variable name="xpath_fm2">
			   <xsl:call-template name="get_xpath">
					   <xsl:with-param name="node" select="."/>
			   </xsl:call-template>
	   </xsl:variable>
	   <element xml_node="{$xpath_fm2}">
			   <!--xsl:value-of select="format-number(.,$moneyNumberFormat)"/-->
			   <xsl:value-of select="format-number(.,'0.00')"/>
	   </element>
   </xsl:template>
   <xsl:template match="*" mode="format_number_4">
		   <xsl:variable name="xpath_fm4">
				   <xsl:call-template name="get_xpath">
						   <xsl:with-param name="node" select="."/>
				   </xsl:call-template>
		   </xsl:variable>
		   <element xml_node="{$xpath_fm4}">
				   <xsl:value-of select="format-number(.,'0.0000')"/>
		   </element>
   </xsl:template>
	<xsl:template match="KDTout:GtdRegistryNumber">
		<xsl:apply-templates select="cat_ru:CustomsCode"/>
		<xsl:text> / </xsl:text>
		<xsl:apply-templates mode="dateGtdNumber" select="cat_ru:RegistrationDate"/>
		<xsl:text> / </xsl:text>
		<xsl:apply-templates select="cat_ru:GTDNumber"/>
	</xsl:template>
	<!--Графа B-->
	<xsl:template name="PaymentDetails">
		<b>B</b> ПОДРОБНОСТИ ПОДСЧЁТА<br/>
		<table style="width: 100%; border-collapse: collapse;">
			<tr>
				<th class="tt tb tr">Вид</th>
				<th class="tt tb tr">Сумма</th>
				<th class="tt tb tr">Предыдущая сумма</th>
				<th class="tt tb tr">Изменения</th>
				<th class="tt tb" style="width:45mm;">Номер и дата платёжного поручения</th>
				<th class="tt tb" style="border-left: 1pt solid #000000;width:5mm;">СУ</th>
			</tr>
			<xsl:variable name="paymentDetails" select="//KDTout:KDToutPayments/KDTout:KDToutCustomsPayment"/>
			<xsl:choose>
				<xsl:when test="count($paymentDetails) > 0">
					<xsl:apply-templates select="$paymentDetails"/>
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td class="tb tr" style="height: 8px;"/>
						<td class="tb tr"/>
						<td class="tb tr"/>
						<td class="tb tr"/>
						<td class="tb tr"/>
						<td class="tb tr" style="border-right:0pt;"/>
					</tr>
					<tr>
						<td class="tb tr" style="height: 8px;"/>
						<td class="tb tr"/>
						<td class="tb tr"/>
						<td class="tb tr"/>
						<td class="tb tr"/>
						<td class="tb tr" style="border-right:0pt;"/>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<tr>
				<td colspan="5">
					<!--xsl:text>Общая сумма, взысканных (излишне уплаченных) платежей.</xsl:text-->
					<xsl:text>Общая сумма, подлежащая уплате (взысканию) или возврату</xsl:text>
					<!-- Решение Коллегии ЕЭК № 289 от 10 декабря 2013 года-->
					<xsl:variable name="paymentAmounts" select="$paymentDetails/catESAD_cu:PaymentAmount"/>
					<xsl:variable name="paymentPrevious" select="$paymentDetails/KDTout:PaymentPrevious"/>
					<xsl:if test="count($paymentAmounts | $paymentPrevious) > 0">
						<xsl:text>: </xsl:text>
						<xsl:value-of select="format-number(sum($paymentAmounts) - sum($paymentPrevious), $moneyNumberFormat)"/>
					</xsl:if>
				</td>
			</tr>
		</table>
	</xsl:template>
	<!--Информация о подробностях таможенных плажетей для графы B-->
	<xsl:template match="KDTout:KDToutPayments/KDTout:KDToutCustomsPayment">
		<tr>
			<td class="t">
				<xsl:apply-templates select="catESAD_cu:PaymentModeCode"/>
			</td>
			<td class="t">
				<xsl:apply-templates select="catESAD_cu:PaymentAmount"/>
			</td>
			<td class="t">
				<xsl:apply-templates select="KDTout:PaymentPrevious"/>
			</td>
			<td class="t">
				<xsl:if test="KDTout:ChangeAmount">
					<xsl:apply-templates select="KDTout:ChangeAmount" mode="format_number_2"/>
				</xsl:if>
			</td>
			<td class="t" colspan="2">
				<!-- <xsl:apply-templates select="KDTout:PaymentDocument/cat_ru:PrDocumentNumber | KDTout:PaymentDocument/cat_ru:PrDocumentDate"/>-->
				<xsl:for-each select="KDTout:PaymentDocument">
					<xsl:apply-templates select="."/>
				</xsl:for-each>
			</td>
		</tr>
	</xsl:template>
	<!--Дата платёжного поручения-->
	<xsl:template match="catESAD_cu:DelayPremitDate">
		<xsl:text> от </xsl:text>
		<xsl:apply-templates mode="date" select="."/>
		<xsl:text> г.</xsl:text>
	</xsl:template>
	<xsl:template match="/">
		<html>
			<head>
				<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
				<title>Корректировка декларации на товары. Внешний формат</title>
				<style type="text/css">
							body {background: #CCCCCC; font-size: 7pt;}
							div.page {
							width: 210mm;
							margin: 10px auto;
							padding: 5mm 10mm;
							background: white;
							border: solid 1px black;
							page-break-after: always;
							}
							/*Стиль для удаления чёрной границы вокруг нарисованной "страницы" при печати*/
							@media print {div.page {border: none; margin: 0; padding: 0;}}

							//.nowrap {white-space: nowrap;}
							h1{font-size: 12pt;}
							table {width: 100%; margin: 0; border: 0; border-spacing: 0; border-collapse: collapse;}
							td, th {padding: 0; vertical-align: top; height: 8px;}
							table.addInfo {border-collapse: collapse;}
							table.addInfo th {border: 1px solid black; background-color: LightGrey;}
							table.addInfo td {border: 1px solid black;}
							hr {border: 0; border-bottom: 1px solid black; margin: 0;}
							.t {border: 1px solid black;}
							.tr, table.paymentInfo .tr {border-right: 1px solid black;}
							.tl {border-left: 1px solid black;}
							.tb, table.paymentInfo .tb {border-bottom: 1px solid black;}
							.tt {border-top: 1px solid black;}
							.b {border: 2px solid black;}
							.br {border-right: 2px solid black;}
							.bl {border-left: 2px solid black;}
							.bb {border-bottom: 2px solid black;}
							.bt {border-top: 2px solid black;}
							.db {border-bottom: 1px dashed black;}
							.dl {border-left: 1px dashed black;}
							.nopadding {padding: 0;}
							.green {background: #FFFFFF;}
							.firstCol {width: 70px; max-width: 70px;}
							table.paymentInfo {border-collapse: collapse; border: 0; width: 100%;}
							table.paymentInfo td.t {border: 1px solid black;}
							table.paymentInfo td, table.paymentInfo th {border: 0;}
							.number {text-align: center; font-size: 11pt; font-weight: bold; vertical-align: middle;}
						</style>
			</head>
			<body>
				<div class="page">
					<xsl:apply-templates select="KDTout:KDTout_CU//KDTout:KDToutGoodsShipment"/>
				</div>
				<!--Выводим товары 2 - ..., группируя их по 3 шт. на лист-->
				<xsl:variable name="allGoods" select="//KDTout:KDToutGoods"/>
				<xsl:for-each select="$allGoods">
					<xsl:if test="(position() - 1) mod 3 = 1">
						<xsl:variable name="firstEntryPos" select="position()"/>
						<div class="page">
							<xsl:call-template name="td4Head"/>
							<xsl:variable name="firstGoods" select="$allGoods[position() = $firstEntryPos]"/>
							<xsl:variable name="secondGoods" select="$allGoods[position() = $firstEntryPos + 1]"/>
							<xsl:variable name="thirdGoods" select="$allGoods[position() = $firstEntryPos + 2]"/>
							<xsl:call-template name="Goods">
								<xsl:with-param name="goods" select="$firstGoods"/>
							</xsl:call-template>
							<xsl:call-template name="Goods">
								<xsl:with-param name="goods" select="$secondGoods"/>
							</xsl:call-template>
							<xsl:call-template name="Goods">
								<xsl:with-param name="goods" select="$thirdGoods"/>
							</xsl:call-template>
							<table style="margin: 0;">
								<tr>
									<td class="tt tr" style="width: 72px;">
										<b>47</b>Исчисление платежей</td>
									<td class="tt tb tr" style="width: 45%;">
										<xsl:call-template name="GoodsPayments">
											<xsl:with-param name="goods" select="$firstGoods"/>
											<xsl:with-param name="GoodsNumberDescription"> по первому товару</xsl:with-param>
										</xsl:call-template>
									</td>
									<td class="tt tl tb tr">
										<xsl:call-template name="GoodsPayments">
											<xsl:with-param name="goods" select="$secondGoods"/>
											<xsl:with-param name="GoodsNumberDescription"> по второму товару</xsl:with-param>
										</xsl:call-template>
									</td>
								</tr>
								<tr>
									<td class="tr tt"/>
									<td class="tr bb tt">
										<xsl:call-template name="GoodsPayments">
											<xsl:with-param name="goods" select="$thirdGoods"/>
											<xsl:with-param name="GoodsNumberDescription"> по третьему товару</xsl:with-param>
										</xsl:call-template>
									</td>
									<td class="tl tt"/>
								</tr>
							</table>
						</div>
					</xsl:if>
				</xsl:for-each>
				<xsl:if test="//KDTout:GoodsAutomobile">
					<div class="page">
						<xsl:apply-templates mode="automobile" select="$allGoods"/>
					</div>
				</xsl:if>
			</body>
		</html>
	</xsl:template>
	<!--Верхняя часть листа КТД-->
	<xsl:template name="td4Head">
		<table border="0" style="width: 100%; border-collapse: collapse; font-size: 7pt;">
			<tr>
				<td class="firstCol tb" rowspan="7"/>
				<td class="header nowrap" colspan="5">ДОПОЛНИТЕЛЬНЫЙ ЛИСТ К ФОРМЕ КОРРЕКТИРОВКИ</td>
				<td class="tl nowrap" colspan="6">
					<b>А</b>
					<xsl:apply-templates select="//KDTout:GtdRegistryNumber"/>
				</td>
			</tr>
			<tr>
				<td class="tb">
					<table class="inline">
						<tr>
							<td class="header">ДЕКЛАРАЦИИ НА ТОВАРЫ (КДТ-2)</td>
							<td class="blankNumber" title="Номер бланка"/>
						</tr>
					</table>
				</td>
				<td class="bl bt br" colspan="4">
					<b>1</b> ДЕКЛАРАЦИЯ</td>
				<td colspan="6"/>
			</tr>
			<tr>
				<td class="tl green">
					<table class="inline">
						<tr>
							<td class="nowrap" style="width: 40%;">
								<b>2</b> Отправитель/<i>Экспортер</i>
							</td>
							<td class="nowrap" style="width: 40%;">
								<!--b>8</b> Получатель-->
							</td>
							<td>№</td>
						</tr>
					</table>
				</td>
				<td class="bl br" colspan="4"/>
				<td class="bl" colspan="6"/>
			</tr>
			<tr>
				<td class="tl green br tb" rowspan="3">
					<xsl:if test="//KDTout:CustomsProcedure='ЭК'">
						<!-- Отправитель -->
						<xsl:for-each select="//KDTout:KTDoutConsignor">
							<xsl:apply-templates select="."/>
						</xsl:for-each>
					</xsl:if>
					<!--xsl:apply-templates mode="org" select="//KDTout:KTDoutConsignor"/>
               <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text-->
					<hr/>
					<b>8</b> Получатель<br/>
					<xsl:if test="//KDTout:CustomsProcedure='ИМ'">
						<!-- Получатель -->
						<xsl:for-each select="//KDTout:KTDoutConsignee">
							<xsl:apply-templates select="."/>
						</xsl:for-each>
					</xsl:if>
					<!--xsl:apply-templates mode="org" select="//KDTout:KTDoutConsignee"/>
               <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text-->
				</td>
				<td colspan="4" style="vertical-align: bottom;">
					<table class="inline">
						<tr>
							<td style="width: 30%;"/>
							<td style="width: 2%; ">
								<b>C</b>
							</td>
							<td class="tr"/>
							<td style="width: 52.9%;">
								<b>BIS</b>
							</td>
						</tr>
					</table>
				</td>
				<td class="bl" colspan="6"/>
			</tr>
			<tr>
				<td colspan="2" rowspan="2" style="border-top:solid 0.8pt black;border-right:solid 0.8pt black;border-bottom:solid 1.5pt black;">
					<b>3</b> Формы</td>
				<td colspan="2" rowspan="2" style="border-top:solid 0.8pt black;border-right:solid 1.5pt black;border-bottom:solid 1.5pt black;"/>
			</tr>
		</table>
	</xsl:template>
	<!--Дополнительные сведения по внешнеторговым контрактам. Заполняется при подаче ВГТД-->
	<xsl:template match="KDTout:KDToutGoods" mode="automobile">
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
			<xsl:apply-templates select="KDTout:GoodsAutomobile"/>
		</table>
	</xsl:template>
	<!--Шаблон для типа catESAD_cu:CarCostInfoType-->
	<xsl:template match="catESAD_cu:CarCostInfo">
		<xsl:apply-templates select="catESAD_cu:CarCost"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="catESAD_cu:CarCostCurrencyCode"/>
	</xsl:template>
	<xsl:template match="KDTout:GoodsAutomobile">
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
	<xsl:template match="*" mode="commaSeparated">
		<xsl:if test="position() > 1">
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:apply-templates select="."/>
	</xsl:template>
	<xsl:template match="*" mode="spaceSeparated">
		<xsl:if test="position() > 1">
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:apply-templates select="."/>
	</xsl:template>
	<xsl:template match="cat_ru:MeasureUnitQualifierCode">
		<xsl:text>(</xsl:text>
		<xsl:variable name="xpath_MeasureUnitQualifierCode">
			<xsl:call-template name="get_xpath">
				<xsl:with-param name="node" select="."/>
			</xsl:call-template>
		</xsl:variable>
		<element xml_node="{$xpath_MeasureUnitQualifierCode}">
			<xsl:apply-templates/>
		</element>
		<xsl:text>)</xsl:text>
	</xsl:template>
	<xsl:template match="catESAD_cu:DeliveryTerms">
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
		<xsl:variable name="xpath_PrDocumentNumber">
			<xsl:call-template name="get_xpath">
				<xsl:with-param name="node" select="."/>
			</xsl:call-template>
		</xsl:variable>
		<element xml_node="{$xpath_PrDocumentNumber}">
			<xsl:apply-templates/>
		</element>
	</xsl:template>
	<xsl:template match="cat_ru:PrDocumentDate">
		<i> дата: </i><xsl:apply-templates select="." mode="russian_date"/>
	</xsl:template>
	<!-- Проверка на совпадение данных с гр.14 ДТ для отправителя и получателя-->
	<xsl:template match="KDTout:KTDoutConsignor| KDTout:KTDoutConsignee">
		<xsl:choose>
			<xsl:when test="RUDECLcat:EqualIndicator='1' or RUDECLcat:EqualIndicator='true' or RUDECLcat:EqualIndicator='True' or RUDECLcat:EqualIndicator='t'">
               <xsl:variable name="xpath_EqualIndicator">
                       <xsl:call-template name="get_xpath">
                               <xsl:with-param name="node" select="RUDECLcat:EqualIndicator"/>
                       </xsl:call-template>
               </xsl:variable>
               <element xml_node="{$xpath_EqualIndicator}">
                       <xsl:text>СМ. ГРАФУ 14 КДТ</xsl:text>
               </element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates mode="org" select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Проверка на совпадение данных с гр.14 ДТ для лица, ответственного за финансовое урегулирование-->
	<xsl:template match="KDTout:KTDoutFinancialAdjustingResponsiblePerson">
		<xsl:choose>
			<xsl:when test="KDTout:DeclarantEqualFlag='1' or KDTout:DeclarantEqualFlag='true' or KDTout:DeclarantEqualFlag='True' or KDTout:DeclarantEqualFlag='t'">
               <xsl:variable name="xpath_DeclarantEqualFlag">
                       <xsl:call-template name="get_xpath">
                               <xsl:with-param name="node" select="KDTout:DeclarantEqualFlag"/>
                       </xsl:call-template>
               </xsl:variable>
               <element xml_node="{$xpath_DeclarantEqualFlag}">
                       <xsl:text>СМ. ГРАФУ 14 КДТ</xsl:text>
               </element>
			</xsl:when>
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
				   <xsl:variable name="xpath_AddressKindCode">
						   <xsl:call-template name="get_xpath">
								   <xsl:with-param name="node" select="RUScat_ru:AddressKindCode"/>
						   </xsl:call-template>
				   </xsl:variable>
				   <element xml_node="{$xpath_AddressKindCode}">
						<xsl:choose>
							<xsl:when test="RUScat_ru:AddressKindCode='1'">Адрес регистрации: </xsl:when>
							<xsl:when test="RUScat_ru:AddressKindCode='2'">Фактический адрес: </xsl:when>
							<xsl:when test="RUScat_ru:AddressKindCode='3'">Почтовый адрес: </xsl:when>
						</xsl:choose>
				   </element>
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
						   <xsl:variable name="xpath_AddressKindCode1">
								   <xsl:call-template name="get_xpath">
										   <xsl:with-param name="node" select="."/>
								   </xsl:call-template>
						   </xsl:variable>
						   <element xml_node="{$xpath_AddressKindCode1}">
								<xsl:choose>
									<xsl:when test=".='1'">Адрес регистрации: </xsl:when>
									<xsl:when test=".='2'">Фактический адрес: </xsl:when>
									<xsl:when test=".='3'">Почтовый адрес: </xsl:when>
								</xsl:choose>
						   </element>
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
	<xsl:template match="KDTout:KDToutGoodsShipment">
		<table>
			<tr>
				<td class="graphMain" colspan="2" style="width:{103*$k}mm;">ФОРМА КОРРЕКТИРОВКИ ДЕКЛАРАЦИИ НА ТОВАРЫ</td>
				<td style="width:{26.4*$k}mm;"/>
				<td class="tl" style="width:{60.6*$k}mm;border-left:solid 0.8pt black;" valign="top">
					<b>А </b>
					<xsl:apply-templates select="/KDTout:KDTout_CU/KDTout:GtdRegistryNumber"/>
				</td>
			</tr>
			<tr>
				<td align="center" class="firstCol b">1</td>
				<td rowspan="3" style="border:solid 0.8pt black;background:#FFFFFF;">
					<table width="100%">
						<tr>
							<td>
								<b>2</b> Отправитель/<i>Экспортер</i>
							</td>
							<td>
								<xsl:text>№ </xsl:text>
								<xsl:if test="KDTout:KTDoutConsignor/cat_ru:RBOrganizationFeatures/cat_ru:UNP">
									<xsl:apply-templates select="KDTout:KTDoutConsignor/cat_ru:RBOrganizationFeatures/cat_ru:UNP"/>
								</xsl:if>
								<xsl:if test="KDTout:KTDoutConsignor/cat_ru:RKOrganizationFeatures/cat_ru:BIN">
									<xsl:apply-templates select="KDTout:KTDoutConsignor/cat_ru:RKOrganizationFeatures/cat_ru:BIN"/>
									<xsl:if test="KDTout:KTDoutConsignor/cat_ru:RKOrganizationFeatures/cat_ru:IIN">
									/
								</xsl:if>
								</xsl:if>
								<xsl:if test="KDTout:KTDoutConsignor/cat_ru:RKOrganizationFeatures/cat_ru:IIN">
									<xsl:apply-templates select="KDTout:KTDoutConsignor/cat_ru:RKOrganizationFeatures/cat_ru:IIN"/>
								</xsl:if>
								<xsl:if test="KDTout:KTDoutConsignor/cat_ru:RFOrganizationFeatures/cat_ru:INN">
									<xsl:apply-templates select="KDTout:KTDoutConsignor/cat_ru:RFOrganizationFeatures/cat_ru:INN"/>
									<xsl:if test="KDTout:KTDoutConsignor/cat_ru:RFOrganizationFeatures/cat_ru:KPP">
									/
								</xsl:if>
								</xsl:if>
								<xsl:if test="KDTout:KTDoutConsignor/cat_ru:RFOrganizationFeatures/cat_ru:KPP">
									<xsl:apply-templates select="KDTout:KTDoutConsignor/cat_ru:RFOrganizationFeatures/cat_ru:KPP"/>
								</xsl:if>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<xsl:apply-templates select="KDTout:KTDoutConsignor"/>
							</td>
						</tr>
					</table>
				</td>
				<td class="b green">
					<b>1</b> ДЕКЛАРАЦИЯ
                    <table width="100%">
						<tr>
							<td align="center" class="tr" rowspan="2">
								<xsl:apply-templates select="parent::node()/KDTout:CustomsProcedure"/>
							</td>
							<td align="center" class="tr" rowspan="2">
								<xsl:apply-templates select="parent::node()/KDTout:CustomsModeCode"/>
							</td>
							<td align="center" rowspan="2">
								<xsl:apply-templates select="parent::node()/KDTout:ElectronicDocumentSign"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="b" rowspan="9"/>
				<td class="t green">
					<table width="100%">
						<tr>
							<td colspan="2" style="border-right:solid 0.8pt black;">
								<b>3</b> Формы</td>
							<td rowspan="2">
								<b>4</b> Отгр. спец. <br/>
								<xsl:apply-templates select="catESAD_cu:SpecificationNumber"/>
								<xsl:if test="catESAD_cu:SpecificationNumber and catESAD_cu:SpecificationListNumber">
									<xsl:text> / </xsl:text>
								</xsl:if>
								<xsl:apply-templates select="catESAD_cu:SpecificationListNumber"/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
						</tr>
						<tr>
							<td align="center" style="border-right:solid 0.8pt black; width:3mm"/>
							<td align="center" style="border-left:solid 0.8pt black;border-right:solid 0.8pt black;">
								<xsl:apply-templates select="catESAD_cu:TotalSheetNumber"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="green nopadding" colspan="2">
					<table width="100%">
						<tr>
							<td class="t">
								<b>5</b>
                                Всего т-ов
                                <br/>
								<xsl:if test="catESAD_cu:TotalGoodsNumber != '0'">
									<xsl:apply-templates select="catESAD_cu:TotalGoodsNumber"/>
								</xsl:if>
							</td>
							<td class="t">
								<b>6</b>
                                Всего мест
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
							<td class="t">
								<b>7</b>
                                Справочный номер
                                <br/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								<xsl:apply-templates select="parent::node()/KDTout:DeclarationKind"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td rowspan="2" style="border:solid 0.8pt black;background:#FFFFFF;">
					<table width="100%">
						<tr>
							<td>
								<b>8</b>
                                Получатель
                            </td>
							<td>
								<xsl:text>№ </xsl:text>
								<xsl:if test="KDTout:KTDoutConsignee/cat_ru:RBOrganizationFeatures/cat_ru:UNP">
									<xsl:apply-templates select="KDTout:KTDoutConsignee/cat_ru:RBOrganizationFeatures/cat_ru:UNP"/>
								</xsl:if>
								<xsl:if test="KDTout:KTDoutConsignee/cat_ru:RKOrganizationFeatures/cat_ru:BIN">
									<xsl:apply-templates select="KDTout:KTDoutConsignee/cat_ru:RKOrganizationFeatures/cat_ru:BIN"/>/
								</xsl:if>
								<xsl:if test="KDTout:KTDoutConsignee/cat_ru:RKOrganizationFeatures/cat_ru:IIN">
									<xsl:apply-templates select="KDTout:KTDoutConsignee/cat_ru:RKOrganizationFeatures/cat_ru:IIN"/>
								</xsl:if>
								<xsl:if test="KDTout:KTDoutConsignee/cat_ru:RFOrganizationFeatures/cat_ru:INN">
									<xsl:apply-templates select="KDTout:KTDoutConsignee/cat_ru:RFOrganizationFeatures/cat_ru:INN"/>
								</xsl:if>
								<xsl:if test="KDTout:KTDoutConsignee/cat_ru:RFOrganizationFeatures/cat_ru:KPP">
									<xsl:text> / </xsl:text>
									<xsl:apply-templates select="KDTout:KTDoutConsignee/cat_ru:RFOrganizationFeatures/cat_ru:KPP"/>
								</xsl:if>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<xsl:apply-templates select="KDTout:KTDoutConsignee"/>
							</td>
						</tr>
					</table>
				</td>
				<td class="t" colspan="2" style="height: 25px;">
					<b>9</b>
                    Лицо, ответственное за финансовое урегулирование<br/>
					<xsl:if test="KDTout:KTDoutFinancialAdjustingResponsiblePerson">
						<xsl:for-each select="KDTout:KTDoutFinancialAdjustingResponsiblePerson">
							<xsl:choose>
								<xsl:when test="KDTout:DeclarantEqualFlag='1' or KDTout:DeclarantEqualFlag='true' or KDTout:DeclarantEqualFlag='True' or KDTout:DeclarantEqualFlag='t'">
									<br/>СМ. ГРАФУ 14 КДТ
							</xsl:when>
								<xsl:otherwise>
									<xsl:if test="cat_ru:RBOrganizationFeatures/cat_ru:UNP">
										<xsl:apply-templates select="cat_ru:RBOrganizationFeatures/cat_ru:UNP"/>
									</xsl:if>
									<xsl:if test="cat_ru:RKOrganizationFeatures/cat_ru:BIN">
										<xsl:apply-templates select="cat_ru:RKOrganizationFeatures/cat_ru:BIN"/>
									</xsl:if>
									<xsl:if test="cat_ru:RKOrganizationFeatures/cat_ru:IIN">
										<xsl:apply-templates select="cat_ru:RKOrganizationFeatures/cat_ru:IIN"/>
									</xsl:if>
									<xsl:if test="cat_ru:RFOrganizationFeatures/cat_ru:INN">
										<xsl:apply-templates select="cat_ru:RFOrganizationFeatures/cat_ru:INN"/>
									</xsl:if>
									<xsl:if test="cat_ru:RFOrganizationFeatures/cat_ru:KPP">
										<xsl:text> / </xsl:text>
										<xsl:apply-templates select="cat_ru:RFOrganizationFeatures/cat_ru:KPP"/>
									</xsl:if>
									<br/>
									<xsl:apply-templates mode="org" select="."/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:if>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="border:solid 0.8pt black;">
					<table style="width:100%;">
						<tr>
							<td colspan="2" style="border-left:solid 1.5pt black;">
								<b>10</b>
                                Стр.перв.назнач/<br/>  послед.отправл
                            </td>
							<td colspan="2" style="border-left:solid 2pt black;border-right:solid 0.8pt black;">
								<b>11</b>
                                Торг. страна
                            </td>
							<td colspan="2" style="border-left:solid 0.8pt black;border-right:solid 0.8pt black;">
								<b>12</b>
                                Общая таможенная стоимость
                                <!--<br/>
                        <xsl:apply-templates select="catESAD_cu:TotalCustCost"/>-->
							</td>
							<td class="graph" rowspan="2" style="width:{11.8*$k}mm;border-left:solid 0.8pt black;">
								<span class="graphNo">13</span>
								<span class="graph"/>
							</td>
						</tr>
						<tr>
							<td align="center" style="border-left:solid 1.5pt black;border-right:solid 2pt black;border-bottom:solid 1.5pt black;">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
							<td/>
							<td align="center" style="border-bottom:solid 1.5pt black;border-left:solid 2pt black;border-right:solid 2pt black;">
								<xsl:choose>
									<xsl:when test="KDTout:KDToutMainContractTerms/catESAD_cu:TradeCountryCode!=''">
										<xsl:apply-templates select="KDTout:KDToutMainContractTerms/catESAD_cu:TradeCountryCode"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td style="border-right:solid 0.8pt black;">
								<xsl:choose>
									<xsl:when test="KDTout:KDToutMainContractTerms/catESAD_cu:RBCountryCode!=''">
										<xsl:apply-templates select="KDTout:KDToutMainContractTerms/catESAD_cu:RBCountryCode"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td style="border-bottom:solid 0pt black;border-left:solid 0pt black;border-right:solid 1.5pt black;" align="center">
								<xsl:if test="catESAD_cu:TotalCustCost">
									<xsl:apply-templates select="catESAD_cu:TotalCustCost" mode="format_number_2"/>
								</xsl:if>
								<xsl:if test="catESAD_cu:TotalCustomsValueAmount"> / <xsl:apply-templates select="catESAD_cu:TotalCustomsValueAmount" mode="format_number_2"/>
								</xsl:if>
							</td>
							<td style="border-bottom:solid 0pt black;border-left:solid 0pt black;border-right:solid 0pt black;" align="center">
								<xsl:if test="KDTout:PreviousTotalCustomsAmount">
									<xsl:apply-templates select="KDTout:PreviousTotalCustomsAmount" mode="format_number_2"/>
								</xsl:if>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td rowspan="2" style="border:solid 0.8pt black;">
					<table width="100%">
						<tr>
							<td>
								<b>14</b>
                                Декларант
                            </td>
							<td>
								<xsl:text>№ </xsl:text>
								<!--xsl:apply-templates select="KDTout:KTDoutDeclarant/cat_ru:OGRN"/-->
								<xsl:if test="KDTout:KTDoutDeclarant/cat_ru:RBOrganizationFeatures/cat_ru:UNP">
									<xsl:apply-templates select="KDTout:KTDoutDeclarant/cat_ru:RBOrganizationFeatures/cat_ru:UNP"/>
								</xsl:if>
								<xsl:if test="KDTout:KTDoutDeclarant/cat_ru:RKOrganizationFeatures/cat_ru:BIN">
									<xsl:apply-templates select="KDTout:KTDoutDeclarant/cat_ru:RKOrganizationFeatures/cat_ru:BIN"/>
								</xsl:if>
								<xsl:if test="KDTout:KTDoutDeclarant/cat_ru:RKOrganizationFeatures/cat_ru:IIN">
									<xsl:apply-templates select="KDTout:KTDoutDeclarant/cat_ru:RKOrganizationFeatures/cat_ru:IIN"/>
								</xsl:if>
								<xsl:if test="KDTout:KTDoutDeclarant/cat_ru:RFOrganizationFeatures/cat_ru:INN">
									<xsl:apply-templates select="KDTout:KTDoutDeclarant/cat_ru:RFOrganizationFeatures/cat_ru:INN"/>
								</xsl:if>
								<xsl:if test="KDTout:KTDoutDeclarant/cat_ru:RFOrganizationFeatures/cat_ru:KPP">
									<xsl:text> / </xsl:text>
									<xsl:apply-templates select="KDTout:KTDoutDeclarant/cat_ru:RFOrganizationFeatures/cat_ru:KPP"/>
								</xsl:if>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<xsl:if test="KDTout:KTDoutDeclarant">
									<xsl:apply-templates mode="org" select="KDTout:KTDoutDeclarant"/>
								</xsl:if>
							</td>
						</tr>
					</table>
				</td>
				<td colspan="2" style="border:solid 0.8pt black;">
					<table width="100%">
						<tr>
							<td style="height: 25px;border-bottom:solid 1pt black;">
								<b>15</b> Страна отправления
								<br/>
								<xsl:apply-templates select="KDTout:KTDoutConsigment/catESAD_cu:DispatchCountryName"/>
							</td>
							<td style="width:{23.7*$k}mm;vertical-align: bottom;border-left:solid 0.8pt black;">
								<table cellpadding="0" cellspacing="0" style="width:100%;">
									<tr>
										<td class="graph" colspan="4" style="width:{25.6*$k}mm;" valign="top">
											<span class="graphNo">15</span>
											<span class="graph">Код страны <br/>отпр.</span>
										</td>
									</tr>
									<tr>
										<br/>
										<td class="graph" style="width:{2.2*$k}mm;border-right:solid 0.8pt black;border-bottom:solid 0.8pt black;">a
                                </td>
										<td align="center" class="graph" style="width:{9.6*$k}mm;border-right:solid 0.8pt black;border-bottom:solid 0.8pt black;">
											<xsl:choose>
												<xsl:when test="KDTout:KTDoutConsigment/catESAD_cu:DispatchCountryCode!=''">
													<xsl:apply-templates select="KDTout:KTDoutConsigment/catESAD_cu:DispatchCountryCode"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
										<td class="graph" style="width:{2.2*$k}mm;border-right:solid 0.8pt black;border-bottom:solid 0.8pt black;">b
                                    </td>
										<td align="center" class="graph" style="width:{7.6*$k}mm;border-bottom:solid 0.8pt black;">
											<xsl:choose>
												<xsl:when test="KDTout:KTDoutConsigment/catESAD_cu:RBDispatchCountryCode!=''">
													<xsl:apply-templates select="KDTout:KTDoutConsigment/catESAD_cu:RBDispatchCountryCode"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
									</tr>
								</table>
							</td>
							<td style="width:{22.7*$k}mm;vertical-align: bottom;border-left:solid 0.8pt black;">
								<table cellpadding="0" cellspacing="0" style="width:100%;">
									<tr>
										<td class="graph" colspan="4" style="width:{25.6*$k}mm;">
											<span class="graphNo">17</span>
											<span class="graph">Код страны назнач.</span>
										</td>
									</tr>
									<tr>
										<br/>
										<td class="graph" style="width:{2.2*$k}mm;border-right:solid 0.8pt black;border-bottom:solid 0.8pt black;">a
                                </td>
										<td align="center" class="graph" style="width:{9.6*$k}mm;border-right:solid 0.8pt black;border-bottom:solid 0.8pt black;">
											<xsl:choose>
												<xsl:when test="KDTout:KTDoutConsigment/catESAD_cu:DestinationCountryCode!=''">
													<xsl:apply-templates select="KDTout:KTDoutConsigment/catESAD_cu:DestinationCountryCode"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
										<td class="graph" style="width:{2.2*$k}mm;border-right:solid 0.8pt black;border-bottom:solid 0.8pt black;">b
                                    </td>
										<td align="center" class="graph" style="width:{7.6*$k}mm;border-bottom:solid 0.8pt black;">
											<xsl:choose>
												<xsl:when test="KDTout:KTDoutConsigment/catESAD_cu:RBDestinationCountryCode!=''">
													<xsl:apply-templates select="KDTout:KTDoutConsigment/catESAD_cu:RBDestinationCountryCode"/>
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
				<td colspan="2" style="border-right:solid 0.8pt black;border-top:solid 1pt #FFFFFF;border-left:solid 0.8pt black;border-bottom:solid 0.8pt black;">
					<table width="100%" style="border-right:solid 0pt black;border-top:solid 0pt black;border-left:solid 0pt black;border-bottom:solid 0pt black;">
						<tr>
							<td class="tr" style="height: 25px;border:solid 0pt black;" width="46%">
								<b>16</b> Страна происхождения<br/>
								<xsl:choose>
									<xsl:when test="catESAD_cu:OriginCountryName">
										<xsl:apply-templates select="catESAD_cu:OriginCountryName"/>
									</xsl:when>
									<xsl:when test="catESAD_cu:OriginCountryCode">
										<xsl:apply-templates select="catESAD_cu:OriginCountryCode"/>
									</xsl:when>
								</xsl:choose>
							</td>
							<td style="border-left:solid 0.8pt black;border-top:solid 0pt black;background:#FFFFFF;" width="54%">
								<b>17</b> Страна назначения<br/>
								<xsl:apply-templates select="KDTout:KTDoutConsigment/catESAD_cu:DestinationCountryName"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="t" colspan="3">
					<table width="100%">
						<tr>
							<td class="green" colspan="2" width="44.9%">
								<b>18</b> Идентификация и страна регистрации трансп.средства при отправлении
                            </td>
							<td rowspan="2" style="border-left:solid 2pt black;border-bottom:solid 1.5pt black;border-right:solid 1pt black;background:#FFFFFF;" width="10%">
								<b>19</b> Конт.<br/>
								   <xsl:variable name="xpath_ContainerIndicator">
										   <xsl:call-template name="get_xpath">
												   <xsl:with-param name="node" select="KDTout:KTDoutConsigment/catESAD_cu:ContainerIndicator"/>
										   </xsl:call-template>
								   </xsl:variable>
								   <element xml_node="{$xpath_ContainerIndicator}">
										<xsl:choose>
											<xsl:when test="(number(KDTout:KTDoutConsigment/catESAD_cu:ContainerIndicator)=1) or (KDTout:KTDoutConsigment/catESAD_cu:ContainerIndicator='t') or (KDTout:KTDoutConsigment/catESAD_cu:ContainerIndicator='true')">
												1
											</xsl:when>
											<xsl:when test="(number(KDTout:KTDoutConsigment/catESAD_cu:ContainerIndicator)=0) or (KDTout:KTDoutConsigment/catESAD_cu:ContainerIndicator='f') or (KDTout:KTDoutConsigment/catESAD_cu:ContainerIndicator='false')">
												0
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
								   </element>
							</td>
							<td colspan="3" style="border-left:solid 1pt black;" width="45%">
								<b>20</b>
                                Условия поставки
                            </td>
						</tr>
						<tr>
							<td class="green" width="34.9%">
								<xsl:choose>
									<xsl:when test="KDTout:KTDoutConsigment/KDTout:KDToutDepartureArrivalTransport">
										<xsl:apply-templates select="KDTout:KTDoutConsigment/KDTout:KDToutDepartureArrivalTransport/KDTout:TransportMeansQuantity"/>:
								<!--xsl:for-each select="KDTout:KTDoutConsigment/KDTout:KDToutDepartureArrivalTransport/KDTout:TransportMeans[not(cat_ru:ActiveTransportIdentifier)]"-->
										<xsl:for-each select="KDTout:KTDoutConsigment/KDTout:KDToutDepartureArrivalTransport/KDTout:TransportMeans">
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
											<xsl:text> </xsl:text>
											<!--xsl:variable name="ActiveTSNum" select="cat_ru:TransportIdentifier"/>
											<xsl:apply-templates select="$ActiveTSNum"/>
											<xsl:for-each select="../KDTout:TransportMeans[cat_ru:ActiveTransportIdentifier=$ActiveTSNum]">
												<xsl:text>/</xsl:text>
												<xsl:apply-templates select="cat_ru:TransportIdentifier"/>
											</xsl:for-each>
											<xsl:if test="position()!=last()">; </xsl:if-->
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								   <xsl:variable name="xpath_MethodTransport">
										   <xsl:call-template name="get_xpath">
												   <xsl:with-param name="node" select="KDTout:KTDoutConsigment/KDTout:KDToutDepartureArrivalTransport/KDTout:MethodTransport"/>
										   </xsl:call-template>
								   </xsl:variable>
								   <element xml_node="{$xpath_MethodTransport}">
										<xsl:choose>
											<xsl:when test="KDTout:KTDoutConsigment/KDTout:KDToutDepartureArrivalTransport/KDTout:MethodTransport=1">газопровод:</xsl:when>
											<xsl:when test="KDTout:KTDoutConsigment/KDTout:KDToutDepartureArrivalTransport/KDTout:MethodTransport=2">нефтепровод:</xsl:when>
											<xsl:when test="KDTout:KTDoutConsigment/KDTout:KDToutDepartureArrivalTransport/KDTout:MethodTransport=3">нефтепродуктопровод:</xsl:when>
											<xsl:when test="KDTout:KTDoutConsigment/KDTout:KDToutDepartureArrivalTransport/KDTout:MethodTransport=4">линия электропередач:</xsl:when>
										</xsl:choose>
								   </element>
								<xsl:if test="KDTout:KTDoutConsigment/KDTout:KDToutDepartureArrivalTransport/KDTout:NameObject">
									<xsl:apply-templates select="KDTout:KTDoutConsigment/KDTout:KDToutDepartureArrivalTransport/KDTout:NameObject"/>
								</xsl:if>
							</td>
							<td align="center" style="border-left:solid 2pt black;border-bottom:solid 1.5pt black;background:#FFFFFF;" width="10%">
								<xsl:choose>
									<xsl:when test="KDTout:KTDoutConsigment/KDTout:KDToutDepartureArrivalTransport/cat_ru:TransportNationalityCode">
										<xsl:apply-templates select="KDTout:KTDoutConsigment/KDTout:KDToutDepartureArrivalTransport/cat_ru:TransportNationalityCode"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td align="center" style="border-left:solid 1pt black;border-bottom:solid 1.5pt black;border-right:solid 2pt black;" width="15%">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
							<td width="15%">
								<xsl:choose>
									<xsl:when test="KDTout:KDToutMainContractTerms/catESAD_cu:CUESADDeliveryTerms/cat_ru:DeliveryTermsStringCode!=''">
										<xsl:apply-templates select="KDTout:KDToutMainContractTerms/catESAD_cu:CUESADDeliveryTerms/cat_ru:DeliveryTermsStringCode"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="KDTout:KDToutMainContractTerms/catESAD_cu:CUESADDeliveryTerms/cat_ru:DeliveryPlace!=''">
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:for-each select="KDTout:KDToutMainContractTerms/catESAD_cu:CUESADDeliveryTerms/cat_ru:DeliveryPlace">
											<xsl:apply-templates select="."/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:apply-templates select="KDTout:KDToutMainContractTerms/catESAD_cu:CUESADDeliveryTerms/cat_ru:TransferPlace"/>
							</td>
							<td style="border-bottom:solid 1.5pt black;border-left:solid 2pt black;" width="15%">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="green" colspan="3">
					<table width="100%">
						<tr>
							<td colspan="2" style="border-right:solid 1pt black;background:#FFFFFF;" width="54.5%">
								<b>21</b>
                                Идентификация и страна регистрации активного
                                    трансп.средства на границе
                                
                            </td>
							<td colspan="2" style="border-left:solid 1pt black;border-right:solid 0.8pt black;" width="20%">
								<b>22</b>
                                Валюта и общая сумма по счету
                            </td>
							<td align="center" rowspan="2" style="border-left:solid 1pt black;border-right:solid 0.8pt black;" width="10%">
								<b>23</b>
                                Курс валюты
                                <br/>
								<br/>
								<xsl:apply-templates select="KDTout:KDToutMainContractTerms/catESAD_cu:ContractCurrencyRate"/>
							</td>
							<td colspan="3" style="border-left:solid 2pt black;" width="25%">
								<b>24</b>
                                Характер сделки
                            </td>
						</tr>
						<tr>
							<td class="green" width="44.5%">
								<xsl:choose>
									<xsl:when test="KDTout:KTDoutConsigment/KDTout:KDToutBorderTransport">
										<xsl:apply-templates select="KDTout:KTDoutConsigment/KDTout:KDToutBorderTransport/KDTout:TransportMeansQuantity"/>: 
										<xsl:for-each select="KDTout:KTDoutConsigment/KDTout:KDToutBorderTransport/KDTout:TransportMeans">
											<xsl:if test="position() &gt; 1">; </xsl:if>
											<xsl:if test="(cat_ru:ActiveTransportIdentifier) and not(cat_ru:TransportIdentifier) ">
												<xsl:apply-templates select="cat_ru:ActiveTransportIdentifier"/>
											</xsl:if>
											<xsl:if test="(cat_ru:TransportIdentifier)  ">
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
								   <xsl:variable name="xpath_MethodTransport1">
										   <xsl:call-template name="get_xpath">
												   <xsl:with-param name="node" select="KDTout:KTDoutConsigment/KDTout:KDToutBorderTransport/KDTout:MethodTransport"/>
										   </xsl:call-template>
								   </xsl:variable>
								   <element xml_node="{$xpath_MethodTransport1}">
										<xsl:choose>
											<xsl:when test="KDTout:KTDoutConsigment/KDTout:KDToutBorderTransport/KDTout:MethodTransport=1">газопровод </xsl:when>
											<xsl:when test="KDTout:KTDoutConsigment/KDTout:KDToutBorderTransport/KDTout:MethodTransport=2">нефтепровод </xsl:when>
											<xsl:when test="KDTout:KTDoutConsigment/KDTout:KDToutBorderTransport/KDTout:MethodTransport=3">нефтепродуктопровод </xsl:when>
											<xsl:when test="KDTout:KTDoutConsigment/KDTout:KDToutBorderTransport/KDTout:MethodTransport=4">линия электропередачи </xsl:when>
										</xsl:choose>
								   </element>
								<xsl:if test="KDTout:KTDoutConsigment/KDTout:KDToutBorderTransport/KDTout:NameObject">
									<xsl:apply-templates select="KDTout:KTDoutConsigment/KDTout:KDToutBorderTransport/KDTout:NameObject"/>
								</xsl:if>	
							</td>
							<td align="center" style="border-bottom:solid 1.5pt black;border-left:solid 2pt black;border-right:solid 1pt black;background:#FFFFFF;" width="10%">
								<xsl:choose>
									<xsl:when test="KDTout:KTDoutConsigment/KDTout:KDToutBorderTransport/cat_ru:TransportNationalityCode!=''">
										<xsl:apply-templates select="KDTout:KTDoutConsigment/KDTout:KDToutBorderTransport/cat_ru:TransportNationalityCode"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td align="center" style="border-left:solid 1pt black;border-bottom:solid 1.5pt black;border-right:solid 2pt black;" width="5%">
								<xsl:choose>
									<xsl:when test="KDTout:KDToutMainContractTerms/catESAD_cu:ContractCurrencyCode!=''">
										<xsl:apply-templates select="KDTout:KDToutMainContractTerms/catESAD_cu:ContractCurrencyCode"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td align="center" style="border-right:solid 0.8pt black;" width="10%">
								<xsl:if test="KDTout:KDToutMainContractTerms/catESAD_cu:TotalInvoiceAmount!=''">
									<xsl:apply-templates select="KDTout:KDToutMainContractTerms/catESAD_cu:TotalInvoiceAmount" mode="format_number_2"/>
								</xsl:if>
								<xsl:if test="KDTout:KDToutMainContractTerms/catESAD_cu:TotalAmount!=''">
									<xsl:text> / </xsl:text>
									<xsl:apply-templates select="KDTout:KDToutMainContractTerms/catESAD_cu:TotalAmount" mode="format_number_2"/>
								</xsl:if>
							</td>
							<td align="center" style="border-left:solid 2pt black;border-bottom:solid 1.5pt black;border-right:solid 0.8pt black;" width="5%">
								<xsl:apply-templates select="KDTout:KDToutMainContractTerms/catESAD_cu:DealNatureCode"/>
							</td>
							<td style="border-bottom:solid 1.5pt black;border-right:solid 2pt black;" width="5%">
								<xsl:apply-templates select="KDTout:KDToutMainContractTerms/catESAD_cu:DealFeatureCode"/>
							</td>
							<td width="10%">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td style="border:solid 0.8pt black;">
					<table width="100%">
						<tr>
							<td class="green" colspan="2">
								<b>25</b>
                                Вид транспорта
                            </td>
							<td colspan="2" style="border-left:solid 2pt black;border-right:solid 0.8pt black;">
								<b>26</b>
                                Вид транспорта
                            </td>
							<td style="border-left:solid 0.8pt black;background:#FFFFFF;">
								<b>27</b>
                                Место погрузки
                            </td>
						</tr>
						<tr>
							<td align="center" style="border-bottom:solid 1.5pt black;border-right:solid 2pt black;background:#FFFFFF;">
								<xsl:choose>
									<xsl:when test="KDTout:KTDoutConsigment/KDTout:KDToutBorderTransport/cat_ru:TransportModeCode!=''">
										<xsl:apply-templates select="KDTout:KTDoutConsigment/KDTout:KDToutBorderTransport/cat_ru:TransportModeCode"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td class="green">
                                на границе
                            </td>
							<td align="center" style="border-left:solid 2pt black;border-bottom:solid 1.5pt black;border-right:solid 2pt black;">
								<xsl:choose>
									<xsl:when test="KDTout:KTDoutConsigment/KDTout:KDToutDepartureArrivalTransport/cat_ru:TransportModeCode!=''">
										<xsl:for-each select="KDTout:KTDoutConsigment/KDTout:KDToutDepartureArrivalTransport/cat_ru:TransportModeCode">
											<xsl:apply-templates select="."/>
                                            ,
                                        </xsl:for-each>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td style="border-right:solid 0.8pt black;">
                                внутри страны
                            </td>
							<td style="border-left:solid 0.8pt black;background:#FFFFFF;">
								<!--xsl:apply-templates select="KDTout:KTDoutConsigment/KDTout:KDToutLoadingPlace"/-->
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
						</tr>
					</table>
				</td>
				<td colspan="2" rowspan="2" style="border:solid 0.8pt black;">
					<b>28</b>
                    Финансовые и банковские сведения
                    <br/>
				</td>
			</tr>
			<tr>
				<td align="center" style="border:solid 1.5pt black;">
                    1
                </td>
				<td style="border:solid 0.8pt black;">
					<table width="100%">
						<tr>
							<td style="border-right:solid 0.8pt black;">
								<b>29</b>
                                Орган выезда/выезда
                                <br/>
								<xsl:for-each select="KDTout:KTDoutConsigment/catESAD_cu:BorderCustomsOffice">
									<xsl:apply-templates select="cat_ru:Code"/>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:apply-templates select="cat_ru:OfficeName"/>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								</xsl:for-each>
							</td>
							<td style="border-left:solid 0.8pt black;">
								<b>30</b>
                                Местонахождение товаров
                                <br/>
								<xsl:for-each select="KDTout:KDTGoodsLocation">
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:apply-templates select="KDTout:InformationTypeCode"/>
									<xsl:if test="KDTout:CustomsOffice">,
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:apply-templates select="KDTout:CustomsOffice"/>,
									</xsl:if>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:if test="KDTout:Address">
										<br/>
										<xsl:apply-templates mode="ru_address" select="KDTout:Address"/>
									</xsl:if>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:if test="KDTout:LocationName">
										<xsl:apply-templates select="KDTout:LocationName"/>
									</xsl:if>,
                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:if test="KDTout:GoodsLocationWarehouse">
										<xsl:apply-templates select="KDTout:GoodsLocationWarehouse/cat_ru:PrDocumentName"/>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:apply-templates select="KDTout:GoodsLocationWarehouse/cat_ru:PrDocumentNumber"/>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:if test="KDTout:GoodsLocationWarehouse/cat_ru:PrDocumentDate">
										от<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates mode="date" select="KDTout:GoodsLocationWarehouse/cat_ru:PrDocumentDate"/>
										</xsl:if>
									</xsl:if>
									<xsl:if test="KDTout:RegisterDocumentIdDetails/catESAD_cu:DocId">
										<xsl:text> св-во: </xsl:text>
										<xsl:apply-templates select="KDTout:RegisterDocumentIdDetails/catESAD_cu:DocId"/>
									</xsl:if>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:choose>
										<xsl:when test="KDTout:GoodsLocationPlace">
											<!-- pdp-->
											<xsl:if test="KDTout:GoodsLocationPlace/catESAD_cu:NumberCustomsZone">
                                    N<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="KDTout:GoodsLocationPlace/catESAD_cu:NumberCustomsZone"/>
											</xsl:if>
										</xsl:when>
									</xsl:choose>
									<xsl:if test="KDTout:Transport">, <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:apply-templates select="KDTout:Transport/catESAD_cu:TransporKind"/>:<xsl:for-each select="KDTout:Transport/catESAD_cu:TransporIdentifier">
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
		<xsl:if test="KDTout:KDToutGoods">
			<xsl:call-template name="Goods">
				<xsl:with-param name="goods" select="KDTout:KDToutGoods[position() = 1]"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(KDTout:KDToutGoods)">
			<xsl:call-template name="EmptyGoods">
				<xsl:with-param name="EmpGoods" select="//KDTout:KDTout_CU"/>
			</xsl:call-template>
		</xsl:if>
		<table>
			<tr>
				<td class="firstCol" rowspan="2" style="border-right:solid 1px black; border-top: solid 1px black; border-bottom: solid 1px black;">
					<b>47</b> Исчисление платежей
                </td>
				<td style="width: 45%;">
					<xsl:call-template name="GoodsPayments">
						<xsl:with-param name="goods" select="KDTout:KDToutGoods[position() = 1]"/>
					</xsl:call-template>
				</td>
				<td class=" tl tr">
					<table cellpadding="1px" cellspacing="0" style="width: 100%">
						<tr>
							<td class="t" style="width: 50%; min-height: 15pt;">
								<b>48</b>
                                Отсрочка платежей
                                <xsl:for-each select="//KDTout:CUDelayPayments">
									<br/>
									<xsl:apply-templates select="catESAD_cu:PaymentModeCode"/>
									<xsl:if test="catESAD_cu:EndDate">
										<xsl:text>-</xsl:text>
										<xsl:apply-templates select="catESAD_cu:EndDate" mode="russian_date"/>
									</xsl:if>
									<xsl:if test="catESAD_cu:PaymentSheduleDetails/catESAD_cu:EndDate">
										<xsl:text>-</xsl:text>
										<xsl:apply-templates select="catESAD_cu:PaymentSheduleDetails/catESAD_cu:EndDate" mode="russian_date"/>
									</xsl:if>
								</xsl:for-each>
							</td>
							<td class="tb" style="vertical-align: top;">
								<b>49</b>
                                Реквизиты склада
                            </td>
						</tr>
					</table>
					<xsl:call-template name="PaymentDetails"/>
				</td>
			</tr>
		</table>
		<table>
			<tr>
				<td class="firstCol tr tb" style="width: 16px;"/>
				<td class="green tt tr">
					<table style="width: 100%;">
						<tr>
							<td style="width: 30%;">
								<b>50</b> Принципал</td>
							<td style="width: 10%;">№ 
                     </td>
							<td style="width: 20%;">Подпись:</td>
							<td class="dl" rowspan="4" style="width: 40%;">
								<b>С</b>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								<br/>
							</td>
						</tr>
						<tr>
							<td class="green" colspan="3">
                     </td>
						</tr>
						<tr>
							<td class="green" colspan="3">
                                представленный
                     </td>
						</tr>
						<tr>
							<td class="green" colspan="3">
                                Место и дата:
                            </td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="6">
					<table>
						<tr>
							<td class="firstCol tr">
								<b>51</b> Предпола-<br/>гаемые органы<br/>(и страна<br/>транзита</td>
							<td class="t green"/>
							<td class="t green"/>
							<td class="t green"/>
							<td class="t green"/>
							<td class="t green"/>
							<td class="t green"/>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="6">
					<table>
						<tr>
							<td rowspan="2" style="border-top:solid 0.8pt black;border-bottom:solid 0.8pt black;">
								<b>52</b> Гарантия недействительна для
                            </td>
							<td rowspan="2" style="border-top:solid 0.8pt black;border-bottom:solid 0.8pt black;background:#FFFFFF;">
								<xsl:choose>
									<xsl:when test="KDTout:Guarantee">
										<xsl:for-each select="KDTout:Guarantee">
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
														<xsl:apply-templates select="cat_ru:PrDocumentDate" mode="russian_date"/>
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
										</xsl:for-each>
										<xsl:if test="position()!=last()">; </xsl:if>
									</xsl:when>
									<xsl:otherwise/>
								</xsl:choose>
							</td>
							<td style="border-right:solid 2pt black;border-top:solid 0.8pt black;background:#FFFFFF;">
                                Код
                            </td>
							<td rowspan="2" style="border-top:solid 0.8pt black;border-bottom:solid 0.8pt black;background:#FFFFFF;">
								<b>53</b>
                                Орган (и страна) назначения
                                <br/>
							</td>
						</tr>
						<tr>
							<td style="border-left:solid 2pt black;border-bottom:solid 1.5pt black;border-right:solid 2pt black;background:#FFFFFF;"/>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="6" style="border-top:solid 0.8pt black;">
					<table>
						<tr>
							<td>
								<b>D</b>
							</td>
							<td/>
							<td style="border-right:solid 0.8pt black;">
                                Печать:
                            </td>
							<td rowspan="6" style="border-left:solid 0.8pt black;">
								<b>54</b>
                                Место и дата
                                <br/>
								<xsl:if test="/KDTout:KDTout_CU/KDTout:KDTFilledInfo/KDTout:ExecutionDate">
                                Дата ДТ: <xsl:apply-templates select="/KDTout:KDTout_CU/KDTout:KDTFilledInfo/KDTout:ExecutionDate" mode="russian_date"/>
									<br/>
								</xsl:if>
								<span class="graph">Подпись и фамилия лица, заполнившего декларацию:</span>
								<br/>
								<xsl:for-each select="/KDTout:KDTout_CU/KDTout:KDTFilledInfo/KDTout:CustomsRepresentative">
									<!--Пункт 1)-->
									<span class="graph">1) </span>
										Свид. о включении в Реестр таможенных представителей № <xsl:apply-templates select="RUDECLcat:BrokerRegistryDocDetails/RUDECLcat:RegisterDocumentDetails/RUScat_ru:RegistrationNumberId"/>;<br/>
									<xsl:for-each select="RUDECLcat:RepresentativeContractDetails">
											Договор таможенного представителя с декларантом № 
											 <xsl:apply-templates select="cat_ru:PrDocumentNumber"/>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<xsl:if test="cat_ru:PrDocumentDate">
											от 
											<xsl:apply-templates select="cat_ru:PrDocumentDate" mode="russian_date"/>
										</xsl:if>; <br/>
										<xsl:choose>
											<xsl:when test="RUDECLcat:RFOrganizationFeatures">
												<xsl:for-each select="RUDECLcat:RFOrganizationFeatures">
													<xsl:if test="cat_ru:OGRN">
														<xsl:apply-templates select="cat_ru:OGRN"/>
														<xsl:if test="cat_ru:INN">/</xsl:if>
													</xsl:if>
													<xsl:if test="cat_ru:INN">
														<xsl:apply-templates select="cat_ru:INN"/>
														<xsl:if test="cat_ru:KPP"/>
													</xsl:if>
													<xsl:if test="cat_ru:KPP">
														/ <xsl:apply-templates select="cat_ru:KPP"/>
													</xsl:if>
												</xsl:for-each>
											</xsl:when>
											<xsl:when test="RUDECLcat:RKOrganizationFeatures">
												<xsl:for-each select="RUDECLcat:RKOrganizationFeatures">
													<xsl:if test="cat_ru:BIN">
														<xsl:apply-templates select="cat_ru:BIN"/>
														<xsl:if test="cat_ru:IIN">/</xsl:if>
													</xsl:if>
													<xsl:if test="cat_ru:IIN">
														<xsl:apply-templates select="cat_ru:IIN"/>
														<xsl:if test="cat_ru:ITN">/</xsl:if>
													</xsl:if>
													<xsl:for-each select="cat_ru:ITN">
														<xsl:apply-templates select="cat_ru:CategoryCode"/>/
														<xsl:apply-templates select="cat_ru:KATOCode"/>/
														<xsl:apply-templates select="cat_ru:RNN"/>
														<xsl:if test="cat_ru:ITNReserv">
															/<xsl:apply-templates select="cat_ru:ITNReserv"/>
														</xsl:if>
													</xsl:for-each>
												</xsl:for-each>
											</xsl:when>
											<xsl:when test="RUDECLcat:RBOrganizationFeatures">
												<xsl:for-each select="RUDECLcat:RBOrganizationFeatures">
													<xsl:if test="cat_ru:UNP">
														<xsl:apply-templates select="cat_ru:UNP"/>
														<xsl:if test="cat_ru:RBIdentificationNumber">/</xsl:if>
													</xsl:if>
													<xsl:if test="cat_ru:RBIdentificationNumber">
														<xsl:apply-templates select="cat_ru:RBIdentificationNumber"/>
													</xsl:if>
												</xsl:for-each>
											</xsl:when>
										</xsl:choose>
									</xsl:for-each>
							; <br/>
								</xsl:for-each>
								<br/>
								<xsl:for-each select="/KDTout:KDTout_CU/KDTout:KDTFilledInfo/KDTout:FilledPerson">
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
										<xsl:text> </xsl:text>
										<xsl:apply-templates select="RUScat_ru:IdentityCardSeries"/>
										<xsl:text> </xsl:text>
										<xsl:apply-templates select="RUScat_ru:IdentityCardNumber"/>
										<xsl:text> </xsl:text>
										<xsl:apply-templates select="RUScat_ru:IdentityCardDate" mode="russian_date"/>
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
											<xsl:apply-templates select="cat_ru:PrDocumentDate" mode="russian_date"/>
										</xsl:if>
										<xsl:if test="RUScat_ru:DocValidityDate">
											<span class="graph">до </span>
											<xsl:apply-templates select="RUScat_ru:DocValidityDate" mode="russian_date"/>
										</xsl:if>
										<br/>
									</xsl:for-each>
								</xsl:for-each>
								<!--Графа 4)-->
								<xsl:if test="//KDTout:RegNumberDoc">
									<span class="graph">4)  Исходящий номер регистрации документов</span>
									<br/>
									<xsl:apply-templates select="//KDTout:RegNumberDoc"/>
									<xsl:text> </xsl:text>
								</xsl:if>
								<br/>
								<xsl:apply-templates select="//KDTout:SecurityLabelCode"/>
								<br/>
								<p align="right">
									<xsl:choose>
										<xsl:when test="//KDTout:KDTFilledInfo/KDTout:FilledPerson/RUDECLcat:SigningDetails/RUScat_ru:SigningDate">
											<xsl:apply-templates select="//KDTout:KDTFilledInfo/KDTout:FilledPerson/RUDECLcat:SigningDetails/RUScat_ru:SigningDate" mode="russian_date"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates select="//KDTout:EECEDocHeaderAddInfo/RUScat_ru:EDocDateTime" mode="russian_date"/>
										</xsl:otherwise>
									</xsl:choose>
								</p>
								<br/>
							</td>
						</tr>
						<tr>
							<td colspan="3" style="border-right:solid 0.8pt black;">
                                Результат:
                            </td>
						</tr>
						<tr>
							<td>
                                Наложенные пломбы:
                            </td>
							<td colspan="2" style="border-right:solid 0.8pt black;"/>
						</tr>
						<tr>
							<td colspan="3" style="border-right:solid 0.8pt black;">
                                Номер:
                            </td>
						</tr>
						<tr>
							<td colspan="3" style="border-right:solid 0.8pt black;">
                                Срок доставки (дата):
                            </td>
						</tr>
						<tr>
							<td colspan="3" style="border-right:solid 0.8pt black;">
                                Подпись:
                            </td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</xsl:template>
	<!--Товар-->
	<xsl:template name="Goods">
		<xsl:param name="goods"/>
		<table width="100%">
			<tr>
				<td class=" tr tb" rowspan="4" style="width:68px;">
					<b>31</b> Грузовые места<br/>и описание<br/>товаров</td>
				<td class=" green nowrap">Маркировка и количество - Номера контейнеров - Количество и отличительные особенности</td>
				<td class=" green">
					<table>
						<tr>
							<td class=" bl nowrap" colspan="2">
								<b>32</b> Товар</td>
						</tr>
						<tr>
							<td align="center" class="bl bb br">
								<xsl:apply-templates select="$goods/catESAD_cu:GoodsNumeric"/>
							</td>
							<td align="center" class=" tb">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>№
								<xsl:apply-templates select="$goods/catESAD_cu:GoodFeatures"/>
							</td>
						</tr>
					</table>
				</td>
				<td class=" tl tb tr nowrap">
					<b>33</b> Код товара<br/>
					   <xsl:variable name="xpath_GoodsTNVEDCode">
						   <xsl:call-template name="get_xpath">
								   <xsl:with-param name="node" select="$goods/catESAD_cu:GoodsTNVEDCode"/>
						   </xsl:call-template>
					   </xsl:variable>
					   <element xml_node="{$xpath_GoodsTNVEDCode}">
						   <xsl:value-of select="substring($goods/catESAD_cu:GoodsTNVEDCode,1,10)"/>
					   </element>
				</td>
				<td colspan="2" style="border:solid 0.8pt black;">
					<br/>
					<table>
						<tr>
							<td style="border-right:solid 0.8pt black;"/>
							<td style="border-right:solid 0.8pt black;"/>
						</tr>
						<tr>
							<td align="center" style=" border-right:solid 0.8pt black;">
								<xsl:if test="$goods/catESAD_cu:AdditionalSign">
									<xsl:apply-templates select="$goods/catESAD_cu:AdditionalSign"/>
								</xsl:if>
								<xsl:if test="$goods/catESAD_cu:IntellectPropertySign">
									<xsl:apply-templates select="$goods/catESAD_cu:IntellectPropertySign"/>
								</xsl:if>
								<xsl:choose>
									<xsl:when test="$goods/catESAD_cu:GoodsClassificationCode=1">
										<xsl:variable name="xpath_GoodsClassificationCode">
											<xsl:call-template name="get_xpath">
												<xsl:with-param name="node" select="$goods/catESAD_cu:GoodsClassificationCode"/>
											</xsl:call-template>
										</xsl:variable>
										<element xml_node="{$xpath_GoodsClassificationCode}">
											<xsl:text>О</xsl:text>
										</element>
									</xsl:when>
								</xsl:choose>
							</td>
							<td align="center" style=" border-right:solid 0.8pt black;">
								<xsl:choose>
									<xsl:when test="$goods/catESAD_cu:GoodsAddTNVEDCode">
										<xsl:apply-templates select="$goods/catESAD_cu:GoodsAddTNVEDCode"/>
									</xsl:when>
									<xsl:when test="$goods/catESAD_cu:LicenseGoodsKindCode">
										<xsl:apply-templates select="$goods/catESAD_cu:LicenseGoodsKindCode"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td align="center" style=" border-right:solid 0.8pt black;" width="25mm">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
							<td align="center" style=" border: 0" width="25mm">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2" rowspan="3" style="border-bottom:solid 0.8pt black;background:#FFFFFF;">
					<xsl:for-each select="$goods/catESAD_cu:GoodsDescription">
						<xsl:apply-templates select="."/>
						<xsl:text disable-output-escaping="yes"> </xsl:text>
					</xsl:for-each>
					<!--xsl:for-each select="$goods/catESAD_cu:ESADElectricalEnergyQuantity">
                  <xsl:apply-templates select="catESAD_cu:TariffZoneName"/>
                  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                  <xsl:apply-templates select="catESAD_cu:TextID"/>
                  <xsl:if test="catESAD_cu:Description">
                     <xsl:text>/</xsl:text>
                     <xsl:apply-templates select="catESAD_cu:Description"/>
                  </xsl:if>
                  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                  <xsl:apply-templates select="catESAD_cu:TransferEnergyQuantity"/>
                  <xsl:if test="catESAD_cu:QualifierCode">
                     <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                     <xsl:apply-templates select="catESAD_cu:QualifierCode"/>
                  </xsl:if>
                  <xsl:if test="catESAD_cu:QualifierName">
                     <xsl:text>/</xsl:text>
                     <xsl:apply-templates select="catESAD_cu:QualifierName"/>
                  </xsl:if>
                  <xsl:text>, </xsl:text>
               </xsl:for-each-->
					<!--xsl:if test="$goods/catESAD_cu:GoodsDescription and $goods/catESAD_cu:GoodsGroupDescription"><br/></xsl:if-->
					<!-- Сначала описание без характеристик групп -->
					<xsl:for-each select="$goods/catESAD_cu:GoodsGroupDescription[not (catESAD_cu:GoodsGroupInformation)]">
						<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
						<xsl:for-each select="catESAD_cu:GoodsDescription">
							<xsl:apply-templates select="."/>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
						</xsl:for-each>
					</xsl:for-each>
					<xsl:for-each select="$goods/catESAD_cu:GoodsGroupDescription[catESAD_cu:GoodsGroupInformation]">
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
							<xsl:if test="catESAD_cu:ManufacturerINN">
								<xsl:text> ИНН производителя </xsl:text>
								<xsl:apply-templates select="catESAD_cu:ManufacturerINN"/>
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
									<xsl:text> Отклонения по длине, ширине, высоте: </xsl:text>
									<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DeviationDetails"/>
								</xsl:if>
								<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails">
									<xsl:text> Диапазон диаметров: </xsl:text>
									<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails/catESAD_cu:MinRangeMeasure" mode="SupplementaryQuantity"/>
									<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails/catESAD_cu:MaxRangeMeasure"> - <xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails/catESAD_cu:MaxRangeMeasure" mode="SupplementaryQuantity"/>
									</xsl:if>
								</xsl:if>
								<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:ContractVolumeMeasure">
									<xsl:text> Объем товара в соответствии с контрактом: </xsl:text>
									<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:ContractVolumeMeasure" mode="SupplementaryQuantity"/>
								</xsl:if>
								<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:FactVolumeMeasure">
									<xsl:text> Фактический объем товара: </xsl:text>
									<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:FactVolumeMeasure" mode="SupplementaryQuantity"/>
								</xsl:if>
							</xsl:if>
							<xsl:if test="catESAD_cu:Dimensions">
								<xsl:text> Размеры </xsl:text>
								<xsl:apply-templates select="catESAD_cu:Dimensions"/>
							</xsl:if>
							<xsl:if test="catESAD_cu:DateIssue">
								<xsl:text> Дата выпуска </xsl:text>
								<xsl:apply-templates select="catESAD_cu:DateIssue" mode="russian_date"/>
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
									<xsl:if test="catESAD_cu:MeasureUnitQualifierCode">
										<xsl:text> (</xsl:text>
										<xsl:apply-templates select="catESAD_cu:MeasureUnitQualifierCode"/>
										<xsl:text>)</xsl:text>
									</xsl:if>
								</xsl:for-each>
							</xsl:if>
						</xsl:for-each>
					</xsl:for-each>
					<xsl:if test="$goods/catESAD_cu:OriginCountryName">
						<br/>
						<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
						<xsl:apply-templates select="$goods/catESAD_cu:OriginCountryName"/>
					</xsl:if>
					<!--xsl:if test="$goods/KDTout:SupplementaryGoodsQuantity">
                  <br/>
                  <xsl:apply-templates select="$goods/KDTout:SupplementaryGoodsQuantity/cat_ru:GoodsQuantity"/>
                  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                  <xsl:apply-templates select="$goods/KDTout:SupplementaryGoodsQuantity/cat_ru:MeasureUnitQualifierName"/>
                  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                  <xsl:apply-templates select="$goods/KDTout:SupplementaryGoodsQuantity/cat_ru:MeasureUnitQualifierCode"/>
               </xsl:if-->
					<xsl:for-each select="$goods/KDTout:SupplementaryGoodsQuantity1">
						<br/>
						<xsl:apply-templates select="cat_ru:GoodsQuantity"/>
						<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
						<xsl:apply-templates select="cat_ru:MeasureUnitQualifierName"/>
						<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
						<xsl:apply-templates select="cat_ru:MeasureUnitQualifierCode"/>
					</xsl:for-each>
					<xsl:if test="$goods/catESAD_cu:BeginPeriodDate or $goods/catESAD_cu:EndPeriodDate">
						<br/>
						<xsl:if test="$goods/catESAD_cu:BeginPeriodDate">
                            Начало периода <xsl:apply-templates select="$goods/catESAD_cu:BeginPeriodDate" mode="russian_date"/>
						</xsl:if>
						<xsl:if test="$goods/catESAD_cu:EndPeriodDate">
                            Окончание периода <xsl:apply-templates select="$goods/catESAD_cu:EndPeriodDate" mode="russian_date"/>
						</xsl:if>
					</xsl:if>
					<xsl:if test="$goods/catESAD_cu:IPObjectRegistryNum">
						<xsl:if test="count($goods/catESAD_cu:IPObjectRegistryNum[catESAD_cu:DocumentModeCode='1']) &gt; 0">
							<br/>
							<span class="graph">Единый ТРОИС ЕАЭС: </span>
							<xsl:for-each select="$goods/catESAD_cu:IPObjectRegistryNum[catESAD_cu:DocumentModeCode='1']">
								<xsl:if test="catESAD_cu:CountryCode">
									<span class="graph">(</span>
									<xsl:apply-templates select="catESAD_cu:CountryCode"/>
									<span class="graph">) </span>
								</xsl:if>
								<xsl:apply-templates select="catESAD_cu:IPORegistryNumber"/>
								<xsl:if test="position()!=last()">, </xsl:if>
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="count($goods/catESAD_cu:IPObjectRegistryNum[catESAD_cu:DocumentModeCode='2']) &gt; 0">
							<br/>
							<span class="graph">Национальный ТРОИС: </span>
							<xsl:for-each select="$goods/catESAD_cu:IPObjectRegistryNum[catESAD_cu:DocumentModeCode='2']">
								<xsl:if test="catESAD_cu:CountryCode">
									<span class="graph">(</span>
									<xsl:apply-templates select="catESAD_cu:CountryCode"/>
									<span class="graph">) </span>
								</xsl:if>
								<xsl:apply-templates select="catESAD_cu:IPORegistryNumber"/>
								<xsl:if test="position()!=last()">, </xsl:if>
							</xsl:for-each>
						</xsl:if>
					</xsl:if>
					<xsl:if test="$goods/KDTout:ESADGoodsPackaging">
						<br/>
                        2)
                        <xsl:if test="$goods/KDTout:ESADGoodsPackaging/catESAD_cu:PakageTypeCode = 1">
							<xsl:if test="$goods/KDTout:ESADGoodsPackaging/catESAD_cu:PakageQuantity">
								<xsl:apply-templates select="$goods/KDTout:ESADGoodsPackaging/catESAD_cu:PakageQuantity"/>
								<xsl:if test="$goods/KDTout:ESADGoodsPackaging/catESAD_cu:PakagePartQuantity">
                                    (<xsl:apply-templates select="$goods/KDTout:ESADGoodsPackaging/catESAD_cu:PakagePartQuantity"/>-часть
                                    места)
                                </xsl:if>
                                ,
                            </xsl:if>
							<xsl:if test="$goods/KDTout:ESADGoodsPackaging/catESAD_cu:PackagePalleteInformation[catESAD_cu:InfoKindCode='0']">
								<xsl:for-each select="$goods/KDTout:ESADGoodsPackaging/catESAD_cu:PackagePalleteInformation[catESAD_cu:InfoKindCode='0']">
									<xsl:apply-templates select="catESAD_cu:PalleteCode"/>
									<xsl:if test="catESAD_cu:PalleteQuantity">
										<span class="graph">-</span>
										<xsl:apply-templates select="catESAD_cu:PalleteQuantity"/>
									</xsl:if>
									<span class="graph">,</span>
								</xsl:for-each>
							</xsl:if>
							<xsl:if test="$goods/KDTout:ESADGoodsPackaging/catESAD_cu:PackagePalleteInformation[catESAD_cu:InfoKindCode='3']">
                                    Поддоны:
									<xsl:for-each select="$goods/KDTout:ESADGoodsPackaging/catESAD_cu:PackagePalleteInformation[catESAD_cu:InfoKindCode='3']">
									<xsl:if test="catESAD_cu:CargoDescriptionText">
										<xsl:apply-templates select="catESAD_cu:CargoDescriptionText"/>
									</xsl:if>
									<span class="graph">,</span>
									<xsl:apply-templates select="catESAD_cu:PalleteQuantity"/> /
										<xsl:apply-templates select="catESAD_cu:PalleteCode"/>
								</xsl:for-each>
							</xsl:if>
							<xsl:if test="$goods/KDTout:ESADGoodsPackaging/catESAD_cu:PackagePalleteInformation[catESAD_cu:InfoKindCode='4']">
								<br/>2.1
									<xsl:for-each select="$goods/KDTout:ESADGoodsPackaging/catESAD_cu:PackagePalleteInformation[catESAD_cu:InfoKindCode='4']">
									<xsl:apply-templates select="catESAD_cu:PalleteCode"/>
									<xsl:if test="catESAD_cu:PalleteQuantity">
										<span class="graph">-</span>
										<xsl:apply-templates select="catESAD_cu:PalleteQuantity"/>
									</xsl:if>
									<span class="graph">,</span>
								</xsl:for-each>
							</xsl:if>
						</xsl:if>
						<xsl:if test="$goods/KDTout:ESADGoodsPackaging/catESAD_cu:PakageTypeCode=0">
                            без упаковки
                        </xsl:if>
						<xsl:if test="$goods/KDTout:ESADGoodsPackaging/catESAD_cu:PakageTypeCode=2">
                            без упаковки/
								<xsl:for-each select="$goods/KDTout:ESADGoodsPackaging/catESAD_cu:PackagePalleteInformation[catESAD_cu:InfoKindCode='2']">
								<xsl:apply-templates select="catESAD_cu:PalleteCode"/>
								<span class="graph">,</span>
							</xsl:for-each>
						</xsl:if>
					</xsl:if>
					<xsl:if test="$goods/KDTout:ESADContainer">
						<br/>
                        3)
							<xsl:for-each select="$goods/KDTout:ESADContainer">
							<xsl:apply-templates select="catESAD_cu:ContainerQuantity"/>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							<xsl:for-each select="catESAD_cu:ContainerNumber">
								<xsl:apply-templates select="catESAD_cu:ContainerIdentificaror"/>
								<xsl:if test="catESAD_cu:FullIndicator='2'">
									<span class="graph">часть</span>
								</xsl:if>
								<span class="graph">,</span>
							</xsl:for-each>
							<xsl:if test="position()!=last()">
								<span class="graph">; </span>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="$goods/KDTout:ESADExcise">
						<br/>
                        4)
							<xsl:for-each select="$goods/KDTout:ESADExcise">
							<xsl:apply-templates select="catESAD_cu:ExciseSerieses"/>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
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
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="$goods/catESAD_cu:CUESADDeliveryTerms">
						<br/>
                        5)
                        <xsl:for-each select="$goods/catESAD_cu:CUESADDeliveryTerms">
							<xsl:apply-templates select="cat_ru:DeliveryTermsStringCode"/>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							<xsl:for-each select="cat_ru:DeliveryPlace"> - 
									<xsl:apply-templates select="."/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</xsl:for-each>
							<xsl:if test="cat_ru:TransferPlace">
								<xsl:apply-templates select="cat_ru:TransferPlace"/>
							</xsl:if>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="$goods/KDTout:KDToutCustomsConditions">
						<br/>
						<span class="graph">6) </span>
						1
						<xsl:for-each select="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:RateOutputGoods">
							Норма:<xsl:apply-templates select="."/>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
						</xsl:for-each>
						<br/>
						<xsl:if test="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:ProcessingProduct">
							Продукт переработки:
							<xsl:apply-templates select="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:ProcessingProduct/catESAD_cu:GoodsTNVEDCode"/>
							<xsl:for-each select="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:ProcessingProduct/catESAD_cu:GoodsDescription">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								<xsl:apply-templates select="."/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</xsl:for-each>
							<xsl:if test="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:ProcessingProduct/catESAD_cu:ProcessingGoodsQuantity">
								<xsl:for-each select="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:ProcessingProduct/catESAD_cu:ProcessingGoodsQuantity">
									<xsl:apply-templates select="cat_ru:GoodsQuantity"/>
									<xsl:apply-templates select="cat_ru:MeasureUnitQualifierName"/>
									<xsl:if test="cat_ru:MeasureUnitQualifierCode">
											(<xsl:apply-templates select="cat_ru:MeasureUnitQualifierCode"/>) 
										</xsl:if>
								</xsl:for-each>
							</xsl:if>
						</xsl:if>
						<br/>
						<xsl:if test="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:WasteProducts">
							Отходы:
							<xsl:apply-templates select="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:WasteProducts/catESAD_cu:GoodsTNVEDCode"/>
							<xsl:for-each select="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:WasteProducts/catESAD_cu:GoodsDescription">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								<xsl:apply-templates select="."/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</xsl:for-each>
							<xsl:if test="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:WasteProducts/catESAD_cu:ProcessingGoodsQuantity">
								<xsl:for-each select="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:WasteProducts/catESAD_cu:ProcessingGoodsQuantity">
									<xsl:apply-templates select="cat_ru:GoodsQuantity"/>
									<xsl:apply-templates select="cat_ru:MeasureUnitQualifierName"/>
									<xsl:if test="cat_ru:MeasureUnitQualifierCode">
											(<xsl:apply-templates select="cat_ru:MeasureUnitQualifierCode"/>) 
										</xsl:if>
								</xsl:for-each>
							</xsl:if>
						</xsl:if>
						<br/>
						<xsl:if test="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:Heels">
							Остатки:
							<xsl:apply-templates select="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:Heels/catESAD_cu:GoodsTNVEDCode"/>
							<xsl:for-each select="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:Heels/catESAD_cu:GoodsDescription">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								<xsl:apply-templates select="."/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</xsl:for-each>
							<xsl:if test="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:Heels/catESAD_cu:ProcessingGoodsQuantity">
								<xsl:for-each select="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:Heels/catESAD_cu:ProcessingGoodsQuantity">
									<xsl:apply-templates select="cat_ru:GoodsQuantity"/>
									<xsl:apply-templates select="cat_ru:MeasureUnitQualifierName"/>
									<xsl:if test="cat_ru:MeasureUnitQualifierCode">
											(<xsl:apply-templates select="cat_ru:MeasureUnitQualifierCode"/>) 
										</xsl:if>
								</xsl:for-each>
							</xsl:if>
						</xsl:if>
						<br/>
						<xsl:for-each select="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:GoodsIdentificationMethod">
							<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							<xsl:apply-templates select="."/>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
						</xsl:for-each>
						<br/>
					</xsl:if>
					<xsl:if test="($goods/catESAD_cu:DeliveryTime) or ($goods/catESAD_cu:DeliveryTimeEND)">
						<br/>
						<span class="graph">7) Поставка в течение </span>
						<xsl:apply-templates select="$goods/catESAD_cu:DeliveryTime" mode="russian_date"/>
						<xsl:if test="$goods/catESAD_cu:DeliveryTimeEND">
								- <xsl:apply-templates select="$goods/catESAD_cu:DeliveryTimeEND" mode="russian_date"/>
						</xsl:if>
					</xsl:if>
					<xsl:if test="$goods/catESAD_cu:QuantityFact/cat_ru:GoodsQuantity">
						<br/>
						<span class="graph">8) </span>
						<xsl:apply-templates select="$goods/catESAD_cu:QuantityFact/cat_ru:GoodsQuantity"/>
						<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
						<xsl:apply-templates select="$goods/catESAD_cu:QuantityFact/cat_ru:MeasureUnitQualifierName"/>
						<xsl:if test="$goods/catESAD_cu:QuantityFact/cat_ru:MeasureUnitQualifierCode">
							<xsl:text> (</xsl:text>
							<xsl:apply-templates select="$goods/catESAD_cu:QuantityFact/cat_ru:MeasureUnitQualifierCode"/>
							<xsl:text>)</xsl:text>
						</xsl:if>
					</xsl:if>
					<xsl:if test="($goods/KDTout:ElectricalEnergReceived) or ($goods/KDTout:ElectricalEnergGiven)">
						<br/>
						<span class="graph">9) </span>
						<xsl:for-each select="$goods/KDTout:ElectricalEnergReceived">
								принято <xsl:apply-templates select="catESAD_cu:ElectricalEnergyQuantity"/> тыс. кВт.ч
								<xsl:if test="catESAD_cu:QualifierCode">
									(<xsl:apply-templates select="catESAD_cu:QualifierCode"/>)
								</xsl:if>, 
							</xsl:for-each>
						<xsl:for-each select="$goods/KDTout:ElectricalEnergGiven">
								отдано <xsl:apply-templates select="catESAD_cu:ElectricalEnergyQuantity"/> тыс. кВт.ч
								<xsl:if test="catESAD_cu:QualifierCode">
									(<xsl:apply-templates select="catESAD_cu:QualifierCode"/>)
								</xsl:if>, 
							</xsl:for-each>
					</xsl:if>
					<xsl:if test="$goods/catESAD_cu:CIMIdDetails">
						<br/>
						<xsl:for-each select="$goods/catESAD_cu:CIMIdDetails">
							<span class="graph">10) </span>
							<xsl:apply-templates select="catESAD_cu:CIMQuantity"/>
							<xsl:text>:</xsl:text>
							<xsl:for-each select="catESAD_cu:CIMList">
								<xsl:apply-templates select="catESAD_cu:CIMID"/>
								<xsl:if test="position()!=last()"><xsl:text>,</xsl:text></xsl:if>
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
					<!--xsl:if test="$goods/catESAD_cu:CIMIdDetails or $goods/catESAD_cu:DTIdentificationMeansDetails">
						<br/>
						<span class="graph">10) </span>
						<xsl:for-each select="$goods/catESAD_cu:CIMIdDetails">
						Контрольные знаки
						<xsl:if test="catESAD_cu:CIMMarkingFlag">
							Признак: <xsl:apply-templates select="catESAD_cu:CIMMarkingFlag"/>
							</xsl:if>
							<xsl:if test="catESAD_cu:CIMQuantity">
							Количество: <xsl:apply-templates select="catESAD_cu:CIMQuantity"/>
							</xsl:if>
							<xsl:if test="catESAD_cu:CIMList">
							Идентификаторы: 
							<xsl:for-each select="catESAD_cu:CIMList/catESAD_cu:CIMID">
									<xsl:apply-templates select="."/>
									<xsl:if test="position()!=last()">, </xsl:if>
								</xsl:for-each>
							</xsl:if>
							<xsl:if test="catESAD_cu:CIMRange">
							 Диапазоны: 
							 <xsl:for-each select="catESAD_cu:CIMRange">
									<xsl:apply-templates select="catESAD_cu:FirstCIMID"/> - <xsl:apply-templates select="catESAD_cu:LastCIMID"/>
									<xsl:if test="position()!=last()">, </xsl:if>
								</xsl:for-each>
							</xsl:if>
						</xsl:for-each>
						<xsl:if test="$goods/catESAD_cu:DTIdentificationMeansDetails">
							<xsl:if test="$goods/catESAD_cu:CIMIdDetails">
								<br/>
							</xsl:if>
							<xsl:for-each select="$goods/catESAD_cu:DTIdentificationMeansDetails">
								<xsl:apply-templates select="." mode="DTIdentificationMeansDetails"/>
							</xsl:for-each>
						</xsl:if>
					</xsl:if-->
					<xsl:if test="$goods/catESAD_cu:GoodsSTZ">
						<br/>
						<span class="graph">11) </span>
						<xsl:for-each select="$goods/catESAD_cu:GoodsSTZ">
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
								<xsl:if test="cat_ru:MeasureUnitQualifierCode">
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>(
                                    <xsl:apply-templates select="cat_ru:MeasureUnitQualifierCode"/>)
                                </xsl:if>
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
									<xsl:if test="catESAD_cu:ManufacturerINN">
										<xsl:text> ИНН производителя </xsl:text>
										<xsl:apply-templates select="catESAD_cu:ManufacturerINN"/>
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
											<xsl:text> Отклонения по длине, ширине, высоте: </xsl:text>
											<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DeviationDetails"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails">
											<xsl:text> Диапазон диаметров: </xsl:text>
											<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails/catESAD_cu:MinRangeMeasure" mode="SupplementaryQuantity"/>
											<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails/catESAD_cu:MaxRangeMeasure"> - <xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:DiameterRangeDetails/catESAD_cu:MaxRangeMeasure" mode="SupplementaryQuantity"/>
											</xsl:if>
										</xsl:if>
										<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:ContractVolumeMeasure">
											<xsl:text> Объем товара в соответствии с контрактом: </xsl:text>
											<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:ContractVolumeMeasure" mode="SupplementaryQuantity"/>
										</xsl:if>
										<xsl:if test="catESAD_cu:WoodDescriptionDetails/catESAD_cu:FactVolumeMeasure">
											<xsl:text> Фактический объем товара: </xsl:text>
											<xsl:apply-templates select="catESAD_cu:WoodDescriptionDetails/catESAD_cu:FactVolumeMeasure" mode="SupplementaryQuantity"/>
										</xsl:if>
									</xsl:if>
									<xsl:if test="catESAD_cu:Dimensions">
										<xsl:text> Размеры </xsl:text>
										<xsl:apply-templates select="catESAD_cu:Dimensions"/>
									</xsl:if>
									<xsl:if test="catESAD_cu:DateIssue">
										<xsl:text> Дата выпуска </xsl:text>
										<xsl:apply-templates select="catESAD_cu:DateIssue" mode="russian_date"/>
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
											<xsl:if test="catESAD_cu:MeasureUnitQualifierCode">
												<xsl:text> (</xsl:text>
												<xsl:apply-templates select="catESAD_cu:MeasureUnitQualifierCode"/>
												<xsl:text>)</xsl:text>
											</xsl:if>
										</xsl:for-each>
									</xsl:if>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="$goods/catESAD_cu:DTIdentificationMeansDetails">
						<br/>
						<xsl:for-each select="$goods/catESAD_cu:DTIdentificationMeansDetails">
							<span class="graph">13) </span>
							<xsl:apply-templates select="catESAD_cu:CIMQuantity"/>
							<xsl:text>:</xsl:text>
							<xsl:for-each select="catESAD_cu:IdentificationMeansDetails">
								<xsl:apply-templates select="catESAD_cu:AggregationKindCode"/>
								<xsl:text>/</xsl:text>
								<xsl:for-each select="catESAD_cu:IdentificationMeansListDetails">
									<xsl:for-each select="catESAD_cu:IdentificationMeansItemDetails">
										<xsl:for-each select="catESAD_cu:IdentificationMeansDataUnitDetails">
											<xsl:apply-templates select="catESAD_cu:IdentifacationMeansUnitCharacterValueId"/>
											<xsl:if test="position()!=last()">,</xsl:if>
										</xsl:for-each>
										<xsl:if test="position()!=last()">,</xsl:if>
									</xsl:for-each>
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
				</td>
				<td>
					<table>
						<tr>
							<td class="nowrap" colspan="4" style="border-left:solid 1.5pt black;border-right:solid 1.5pt black;">
								<b>34</b>
                                Код страны происх.
                            </td>
						</tr>
						<tr>
							<td style="border-left:solid 1.5pt black;border-right:solid 0.8pt black;border-bottom:solid 1.5pt black;">a
                            </td>
							<td align="center" style="border-right:solid 0.8pt black;border-bottom:solid 1.5pt black;">
								<xsl:apply-templates select="$goods/catESAD_cu:OriginCountryCode"/>
							</td>
							<td style="border-right:solid 0.8pt black;border-bottom:solid 1.5pt black;">b
                            </td>
							<td style="border-right:solid 1.5pt black;border-bottom:solid 1.5pt black;">
								<xsl:apply-templates select="$goods/catESAD_cu:PrefOriginCountry/catESAD_cu:CountryCode"/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
						</tr>
					</table>
				</td>
				<td style="border:solid 0.8pt black;background:#FFFFFF;">
					<b>35</b>
                    Вес брутто (кг)
                    <br/>
					<xsl:apply-templates select="$goods/catESAD_cu:GrossWeightQuantity"/>
					<xsl:if test="$goods/KDTout:TotalGrossMassMeasure"> / <xsl:apply-templates select="$goods/KDTout:TotalGrossMassMeasure/cat_ru:GoodsQuantity"/>
					</xsl:if>
				</td>
				<td class=" nowrap" style="border:solid 0.8pt black;">
					<b>36</b>
                    Преференция
                    <br/>
					<xsl:apply-templates select="$goods/catESAD_cu:Preferencii/catESAD_cu:CustomsTax"/>
					<xsl:apply-templates select="$goods/catESAD_cu:Preferencii/catESAD_cu:CustomsDuty"/>
					<xsl:apply-templates select="$goods/catESAD_cu:Preferencii/catESAD_cu:Excise"/>
					<xsl:apply-templates select="$goods/catESAD_cu:Preferencii/catESAD_cu:Rate"/>
				</td>
			</tr>
			<tr>
				<td>
					<table>
						<tr>
							<td colspan="2" style="border-left:solid 1.5pt black;border-right:solid 1.5pt black;border-top:solid 0.8pt black;">
								<b>37</b>
                                Процедура
                            </td>
						</tr>
						<tr>
							<td align="center" style="border-left:solid 1.5pt black;border-right:solid 0.8pt black;border-bottom:solid 1.5pt black;">
								<xsl:apply-templates select="$goods/KDTout:CustomsProcedure/catESAD_cu:MainCustomsModeCode"/>
								<xsl:apply-templates select="$goods/KDTout:CustomsProcedure/catESAD_cu:PrecedingCustomsModeCode"/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp</xsl:text>
							</td>
							<td align="center" style="border-right:solid 1.5pt black;border-bottom:solid 1.5pt black;">
								<xsl:apply-templates select="$goods/KDTout:CustomsProcedure/catESAD_cu:GoodsTransferFeature"/>
							</td>
						</tr>
					</table>
				</td>
				<td style="border:solid 0.8pt black;background:#FFFFFF;">
					<b>38</b>
                    Вес нетто (кг)
                    <br/>
					<xsl:apply-templates select="$goods/catESAD_cu:NetWeightQuantity"/>
					<xsl:if test="$goods/catESAD_cu:NetWeightQuantity2">
						/<xsl:apply-templates select="$goods/catESAD_cu:NetWeightQuantity2"/>
					</xsl:if>
					<xsl:if test="$goods/KDTout:TotalNetMassMeasure"> / <xsl:apply-templates select="$goods/KDTout:TotalNetMassMeasure/cat_ru:GoodsQuantity"/>
					</xsl:if>
				</td>
				<td style="border:solid 0.8pt black;">
					<b>39</b>
					<i> Квота</i>
					<br/>
					<xsl:if test="$goods/KDTout:ESADGoodsQuota/catESAD_cu:ESADCurrencyQuota">
						<xsl:apply-templates select="$goods/KDTout:ESADGoodsQuota/catESAD_cu:ESADCurrencyQuota/catESAD_cu:QuotaCurrencyQuantity"/>
						<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
						<xsl:apply-templates select="$goods/KDTout:ESADGoodsQuota/catESAD_cu:ESADCurrencyQuota/catESAD_cu:QuotaCurrencyName"/>
								(<xsl:apply-templates select="$goods/KDTout:ESADGoodsQuota/catESAD_cu:ESADCurrencyQuota/catESAD_cu:QuotaCurrencyCode"/>)
						
						</xsl:if>
					<br/>
					<xsl:if test="$goods/KDTout:ESADGoodsQuota/catESAD_cu:ESADProductQuantityQuota">
						<xsl:for-each select="$goods/KDTout:ESADGoodsQuota/catESAD_cu:ESADProductQuantityQuota">
							<xsl:apply-templates select="cat_ru:QuotaQuantity"/>
							<!-- <xsl:apply-templates select="$goods/KDTout:ESADGoodsQuotaa/catESAD_cu:ESADProductQuantityQuota/catESAD_cu:QuotaQuantity"/>-->
							<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							<xsl:apply-templates select="$goods/KDTout:ESADGoodsQuota/catESAD_cu:ESADProductQuantityQuota/cat_ru:QuotaMeasurementName"/>
								(<xsl:apply-templates select="$goods/KDTout:ESADGoodsQuota/catESAD_cu:ESADProductQuantityQuota/cat_ru:QuotaMeasureUnitQualifierCode"/>)
						</xsl:for-each>
					</xsl:if>
					<!--xsl:choose>
						<xsl:when test="$goods/KDTout:ESADGoodsQuota/catESAD_cu:ESADCurrencyQuota">
							<xsl:apply-templates select="$goods/KDTout:ESADGoodsQuota/catESAD_cu:ESADCurrencyQuota/catESAD_cu:QuotaCurrencyQuantity"/>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							<xsl:apply-templates select="$goods/KDTout:ESADGoodsQuota/catESAD_cu:ESADCurrencyQuota/catESAD_cu:QuotaCurrencyName"/>
								(<xsl:apply-templates select="$goods/KDTout:ESADGoodsQuota/catESAD_cu:ESADCurrencyQuota/catESAD_cu:QuotaCurrencyCode"/>)
							</xsl:when>
						<xsl:when test="$goods/KDTout:ESADGoodsQuota/catESAD_cu:ESADProductQuantityQuota">
							<xsl:apply-templates select="$goods/KDTout:ESADGoodsQuota/catESAD_cu:ESADProductQuantityQuota/catESAD_cu:QuotaQuantity"/>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							<xsl:apply-templates select="$goods/KDTout:ESADGoodsQuota/catESAD_cu:ESADProductQuantityQuota/catESAD_cu:QuotaMeasurementName"/>
								(<xsl:apply-templates select="$goods/KDTout:ESADGoodsQuota/catESAD_cu:ESADProductQuantityQuota/catESAD_cu:QuotaMeasureUnitQualifierCode"/>)
							</xsl:when>
					</xsl:choose-->
				</td>
			</tr>
			<tr>
				<td class=" nowrap" colspan="3" style="border:solid 0.8pt black;background:#FFFFFF;">
					<b>40</b>
                    Общая декларация/Предшествующий документ
                    <br/>
					<xsl:for-each select="$goods/KDTout:KDToutPrecedingDocument">
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
							<xsl:text> / </xsl:text>
						</xsl:if>
						<xsl:apply-templates select="catESAD_cu:PrecedingDocumentDate" mode="russian_date_gtd"/>
						<xsl:text> / </xsl:text>
						<xsl:if test="catESAD_cu:AddNumberPart">
							<xsl:choose>
								<xsl:when test="catESAD_cu:AddNumberPart = 'ЗВ'">
									<xsl:variable name="xpath_AddNumberPart">
										<xsl:call-template name="get_xpath">
											<xsl:with-param name="node" select="catESAD_cu:AddNumberPart"/>
										</xsl:call-template>
									</xsl:variable>
									<element xml_node="{$xpath_AddNumberPart}">
										<xsl:text>В</xsl:text>
									</element>
								</xsl:when>
								<xsl:otherwise><xsl:apply-templates select="catESAD_cu:AddNumberPart"/></xsl:otherwise>
							</xsl:choose>
							<!--xsl:apply-templates select="catESAD_cu:AddNumberPart"/-->
						</xsl:if>
						<xsl:apply-templates select="catESAD_cu:PrecedingDocumentNumber"/>
						<xsl:if test="catESAD_cu:DTMDocDetails">
							<xsl:text> / </xsl:text>
							<xsl:apply-templates select="catESAD_cu:DTMDocDetails"/>
						</xsl:if>
						<xsl:if test="catESAD_cu:TIRIdDetails">
							<xsl:text> / </xsl:text>
							<xsl:apply-templates select="catESAD_cu:TIRIdDetails"/>
						</xsl:if>
						<xsl:if test="catESAD_cu:OtherPrDocumentNumber">
							<xsl:text> / </xsl:text>
							<xsl:apply-templates select="catESAD_cu:OtherPrDocumentNumber"/>
							<xsl:if test="catESAD_cu:OtherPrDocumentDate">
								<xsl:text> от </xsl:text>
								<xsl:apply-templates select="catESAD_cu:OtherPrDocumentDate" mode="russian_date"/>
							</xsl:if>
						</xsl:if>
						<xsl:if test="catESAD_cu:PIDocumentNumber">
							<xsl:text> / Рег.№ ПИ </xsl:text>
							<xsl:apply-templates select="catESAD_cu:PIDocumentNumber"/>
						</xsl:if>
						<xsl:if test="catESAD_cu:PrecedingDocumentGoodsNumeric">
							<xsl:text> / </xsl:text>
							<xsl:apply-templates select="catESAD_cu:PrecedingDocumentGoodsNumeric"/>
						</xsl:if>
						<xsl:if test="catESAD_cu:CustomsCost">
							<xsl:text> / </xsl:text>
							<xsl:apply-templates select="catESAD_cu:CustomsCost"/>
						</xsl:if>
						<xsl:if test="catESAD_cu:NetWeight">
							<xsl:text> / </xsl:text>
							<xsl:apply-templates select="catESAD_cu:NetWeight"/>
						</xsl:if>
						<xsl:if test="catESAD_cu:NetWeightQuantity">
							<xsl:text> / </xsl:text>
							<xsl:apply-templates select="catESAD_cu:NetWeightQuantity"/>
						</xsl:if>
						<xsl:if test="(catESAD_cu:NetWeightQuantity) or (catESAD_cu:SupplementaryGoodsQuantity)">
							<xsl:text> / </xsl:text>
							<xsl:apply-templates select="catESAD_cu:NetWeightQuantity"/>
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
			<tr>
				<td class="firstCol tr" rowspan="3">
					<b>44</b> Дополнит. информация/ Представл. документы
                </td>
				<td colspan="2" rowspan="3" style="border-bottom:solid 0.8pt black;border-top:solid 0.8pt black;background:#FFFFFF;">
					<xsl:if test="$goods/KDTout:KDToutPresentedDocument">
						<xsl:for-each select="$goods/KDTout:KDToutPresentedDocument">
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
									<xsl:apply-templates select="RUDECLcat:DocumentPresentingDetails/RUDECLcat:DocPresentDate" mode="russian_date"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="cat_ru:PrDocumentNumber"/>
									<xsl:if test="RUDECLcat:DocumentPresentingDetails/RUDECLcat:DocPresentDate and RUDECLcat:DocumentPresentingDetails/RUDECLcat:DocPresentKindCode='3'">
										<xsl:variable name="xpath_DocPresentKindCode">
											<xsl:call-template name="get_xpath">
												<xsl:with-param name="node" select="RUDECLcat:DocumentPresentingDetails/RUDECLcat:DocPresentKindCode"/>
											</xsl:call-template>
										</xsl:variable>
										<element xml_node="{$xpath_DocPresentKindCode}">
											<xsl:text> ОБЯЗУЮСЬ ПРЕДОСТАВИТЬ ДО </xsl:text>
										</element>
										<xsl:apply-templates select="RUDECLcat:DocumentPresentingDetails/RUDECLcat:DocPresentDate" mode="russian_date"/>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="catESAD_cu:LicenseGoods">/<xsl:if test="catESAD_cu:LicenseGoods/catESAD_cu:AppNumber">
									<xsl:apply-templates select="catESAD_cu:LicenseGoods/catESAD_cu:AppNumber"/>/</xsl:if>
								<xsl:apply-templates select="catESAD_cu:LicenseGoods/catESAD_cu:GoodsNumericLic"/>
							</xsl:if>
							<xsl:if test="cat_ru:PrDocumentDate">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								<xsl:apply-templates select="cat_ru:PrDocumentDate" mode="russian_date"/>
							</xsl:if>
							<xsl:if test="catESAD_cu:DocumentBeginActionsDate">
								<xsl:text> с </xsl:text>
								<xsl:apply-templates select="catESAD_cu:DocumentBeginActionsDate" mode="russian_date"/>
							</xsl:if>
							<xsl:if test="catESAD_cu:DocumentEndActionsDate">
								<xsl:text> по </xsl:text>
								<xsl:apply-templates select="catESAD_cu:DocumentEndActionsDate" mode="russian_date"/>
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
											<xsl:apply-templates select="RUDECLcat:DocumentPresentingDetails/RUDECLcat:OtherPrecedingDocDate" mode="russian_date"/>
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
								<!--xsl:text> Срок временного ввоза </xsl:text-->
								<xsl:apply-templates select="catESAD_cu:TemporaryStorageImportDate" mode="russian_date"/>
							</xsl:if>
							<xsl:if test="catESAD_cu:TemporaryImportCode">
								<xsl:text> /</xsl:text>
								<xsl:apply-templates select="catESAD_cu:TemporaryImportCode"/>
							</xsl:if>
							<xsl:if test="catESAD_cu:SupplyStatus">
								<xsl:text> /Опережающая поставка </xsl:text>
							</xsl:if>
							<xsl:if test="catESAD_cu:SpecialSimplifiedCode">
								<xsl:text> /</xsl:text>
								<xsl:for-each select="catESAD_cu:SpecialSimplifiedCode">
									<xsl:apply-templates select="."/>
									<xsl:if test="position()!=last()">
										<xsl:text>; </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</xsl:if>
							<br/>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="$goods/KDTout:KDToutCustomsConditions">
						<xsl:for-each select="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:ProcessingPlaceDetails">
							<xsl:apply-templates select="."/>
							<xsl:if test="position()!=last()">; </xsl:if>
						</xsl:for-each>
						<xsl:if test="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:Organization">
							<xsl:for-each select="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:Organization">
								<xsl:apply-templates mode="org" select="."/>
								<br/>
							</xsl:for-each>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:if test="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:Substitute">
							Заменители:
							<xsl:for-each select="$goods/KDTout:KDToutCustomsConditions/RUDECLcat:Substitute">
								<xsl:apply-templates select="."/> 
							</xsl:for-each>
						</xsl:if>
						<br/>
					</xsl:if>
				</td>
				<td colspan="3">
					<table>
						<tr>
							<td style="border:solid 0.8pt black;">
								<b>41</b>
                                Дополнит.единицы
                                <br/>
								<xsl:choose>
									<xsl:when test="$goods/KDTout:SupplementaryGoodsQuantity">
										<xsl:apply-templates select="$goods/KDTout:SupplementaryGoodsQuantity/cat_ru:GoodsQuantity"/>
										<xsl:text disable-output-escaping="yes">/</xsl:text>
										<xsl:apply-templates select="$goods/KDTout:SupplementaryGoodsQuantity/cat_ru:MeasureUnitQualifierName"/>/
										<xsl:apply-templates select="$goods/KDTout:SupplementaryGoodsQuantity/cat_ru:MeasureUnitQualifierCode"/>
									</xsl:when>
								</xsl:choose>
							</td>
							<td style="border:solid 0.8pt black;">
								<b>42</b>
                                Цена товара
                                <br/>
								<xsl:apply-templates select="$goods/catESAD_cu:InvoicedCost" mode="format_number_2"/>
								<xsl:if test="$goods/catESAD_cu:InvoicedCurrencyCode"> / <xsl:apply-templates select="$goods/catESAD_cu:InvoicedCurrencyCode"/>
								</xsl:if>
								<xsl:if test="$goods/catESAD_cu:InvoicedCurrencyRate"> / <xsl:apply-templates select="$goods/catESAD_cu:InvoicedCurrencyRate" mode="format_number_4"/>
								</xsl:if>
							</td>
							<td class="tb tr nowrap" style="vertical-align: top;">
								<b>43</b> Код МОС<br/>
								<span>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<xsl:apply-templates select="$goods/catESAD_cu:CustomsCostCorrectMethod"/>
								</span>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="green" colspan="3">
					<table>
						<tr>
							<td rowspan="2"/>
							<td class="br nowrap">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
							<td colspan="2" style="border-top:solid 0.8pt black;border-bottom:solid 0pt black;border-left:solid 0.8pt black;border-right:solid 0.8pt black;">
								<b>45</b>
                                Таможенная стоимость
                                <!--<br/>
                        <xsl:apply-templates select="$goods/catESAD_cu:CustomsCost"/>
                        <xsl:if test="$goods/catESAD_cu:CustomsCostCorrectMethod">
                                    /<xsl:apply-templates select="$goods/catESAD_cu:CustomsCostCorrectMethod"/>
                        </xsl:if>-->
							</td>
						</tr>
						<tr>
							<td class="br bb bl" style="width: 15px;"/>
							<td style="border-bottom:solid 0pt black;border-left:solid 0pt black;border-right:solid 1.5pt black;width:25mm;" align="center">
								<xsl:apply-templates select="$goods/catESAD_cu:CustomsCost" mode="format_number_2"/>
							</td>
							<td style="border-bottom:solid 0pt black;border-left:solid 0pt black;border-right:solid 0.8pt black;width:35mm;" align="center">
								<xsl:apply-templates select="$goods/KDTout:PreviousCustomsCost" mode="format_number_2"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<table>
						<tr>
							<td class="green tb" width="20px"/>
							<td style="border:solid 0.8pt black;width:25mm;">
								<b>45а</b>
                                Код изменений
                                <br/>
								<xsl:choose>
									<xsl:when test="$goods/KDTout:ChangeCode">
										<xsl:for-each select="$goods/KDTout:ChangeCode">
											<xsl:apply-templates select="KDTout:PhaseChanges"/>/<xsl:apply-templates select="KDTout:BasisCompilation"/>/<xsl:apply-templates select="KDTout:QuantityChanges"/>/<xsl:apply-templates select="KDTout:CountryChanges"/>/<xsl:apply-templates select="KDTout:TNVEDChanges"/>/<xsl:apply-templates select="KDTout:CustCostChanges"/>/<xsl:apply-templates select="KDTout:CustomsPaymentChanges"/>/<xsl:apply-templates select="KDTout:OtherChanges"/>
										</xsl:for-each>
									</xsl:when>
								</xsl:choose>
							</td>
							<td style="border:solid 0.8pt black;width:35mm;">
								<b>46</b>
                                Статистическая стоимость
                                <br/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								<xsl:if test="$goods/catESAD_cu:StatisticalCost">
									<xsl:apply-templates select="$goods/catESAD_cu:StatisticalCost" mode="format_number_2"/>
								</xsl:if>
								<xsl:if test="$goods/catESAD_cu:TotalStatisticValueAmount"> / <xsl:apply-templates select="$goods/catESAD_cu:TotalStatisticValueAmount" mode="format_number_2"/>
								</xsl:if>
								<!--xsl:choose>
									<xsl:when test="$goods/catESAD_cu:ConformityStatCostIndicator = 1  or catESAD_cu:ConformityStatCostIndicator = 'true'">
                                        1
                                    </xsl:when>
									<xsl:otherwise>0</xsl:otherwise>
								</xsl:choose-->
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</xsl:template>
	<!-- Шаблон для типа RUDECLcat:CustomDocIDType -->
	<xsl:template match="RUDECLcat:CustomsDocIdDetails">
		<xsl:text>ДТ: </xsl:text>
		<xsl:apply-templates select="cat_ru:CustomsCode"/>
		<xsl:text>/</xsl:text>
		<xsl:apply-templates select="cat_ru:RegistrationDate" mode="russian_date_gtd"/>
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
		Место переработки: <xsl:apply-templates select="RUDECLcat:PlaceName"/>
		<xsl:if test="RUDECLcat:PlaceName and RUDECLcat:AddressDetails">
			<xsl:text>, </xsl:text>
		</xsl:if>
		Адрес переработки: <xsl:apply-templates mode="ru_address" select="RUDECLcat:AddressDetails"/>
	</xsl:template>
	<!-- Шаблон для типа RUDECLcat:DTMDocDetailsType -->
	<xsl:template match="RUDECLcat:DTMDocDetails|catESAD_cu:DTMDocDetails">
		<xsl:text>ТДТС: </xsl:text>
		<xsl:apply-templates select="cat_ru:CustomsCode"/>
		<xsl:text>/</xsl:text>
		<xsl:apply-templates select="cat_ru:RegistrationDate" mode="russian_date_gtd"/>
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
		<xsl:if test="cat_ru:MeasureUnitQualifierCode">(<xsl:apply-templates select="cat_ru:MeasureUnitQualifierCode"/>)</xsl:if>
	</xsl:template>
	<!-- Шаблон для типа catESAD_cu:DimensionType -->
	<xsl:template match="catESAD_cu:Dimensions|catESAD_cu:AllowanceDetails|catESAD_cu:DeviationDetails">
		<xsl:apply-templates select="catESAD_cu:LengthMeasure/catESAD_cu:MeasuredAmount"/>&#160;<xsl:apply-templates select="catESAD_cu:LengthMeasure/catESAD_cu:MeasureUnitQualifierName"/> (<xsl:apply-templates select="catESAD_cu:LengthMeasure/catESAD_cu:MeasureUnitQualifierCode"/>)<xsl:if test="catESAD_cu:WidthMeasure">
			<xsl:if test="catESAD_cu:LengthMeasure">
				<xsl:text> x </xsl:text>
			</xsl:if>
			<xsl:apply-templates select="catESAD_cu:WidthMeasure/catESAD_cu:MeasuredAmount"/>&#160;<xsl:apply-templates select="catESAD_cu:WidthMeasure/catESAD_cu:MeasureUnitQualifierName"/> (<xsl:apply-templates select="catESAD_cu:WidthMeasure/catESAD_cu:MeasureUnitQualifierCode"/>)</xsl:if>
		<xsl:if test="catESAD_cu:HeightMeasure">
			<xsl:if test="catESAD_cu:LengthMeasure or catESAD_cu:WidthMeasure">
				<xsl:text> x </xsl:text>
			</xsl:if>
			<xsl:apply-templates select="catESAD_cu:HeightMeasure/catESAD_cu:MeasuredAmount"/>&#160;<xsl:apply-templates select="catESAD_cu:HeightMeasure/catESAD_cu:MeasureUnitQualifierName"/> (<xsl:apply-templates select="catESAD_cu:HeightMeasure/catESAD_cu:MeasureUnitQualifierCode"/>)</xsl:if>
	</xsl:template>
	<xsl:template match="cat_ru:IdentityCard|RUScat_ru:IdentityCard">
		<xsl:for-each select="*">
			<xsl:choose>
				<xsl:when test="local-name()='IdentityCardDate'">
					<xsl:apply-templates select="." mode="russian_date"/>
				</xsl:when>
				<xsl:when test="local-name()='DocValidityDate'">
					<xsl:text>(окончание срока действия: </xsl:text>
					<xsl:apply-templates select="." mode="russian_date"/>
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
	<xsl:template name="GoodsPayments">
		<xsl:param name="goods"/>
		<xsl:param name="GoodsNumberDescription" select="''"/>
		<table class="paymentInfo">
			<tr>
				<td class="t">Вид</td>
				<td class="t">Основа начисления</td>
				<td class="t">Ставка</td>
				<td class="t">Сумма</td>
				<td class="t" style="border-right:0pt;">СП</td>
				<!--<td class="tb">Предыдущая сумма</td>-->
			</tr>
			<xsl:variable name="paymentDetails" select="$goods/KDTout:KDToutCustomsPaymentCalculation"/>
			<xsl:choose>
				<xsl:when test="count($paymentDetails) > 0">
					<xsl:apply-templates select="$paymentDetails"/>
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td class="t"/>
						<td class="t"/>
						<td class="t"/>
						<td class="t"/>
						<td class="t"/>
						<!--<td class="tb"/>-->
					</tr>
					<tr>
						<td class="t"/>
						<td class="t"/>
						<td class="t"/>
						<td class="t"/>
						<td class="t"/>
						<!--<td class="tb"/>-->
					</tr>
					<tr>
						<td class="t"/>
						<td class="t"/>
						<td class="t"/>
						<td class="t"/>
						<td class="t"/>
						<!--<td class="tb"/>-->
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<tr>
				<td colspan="6">
					<br/>
					<!--xsl:text>Общая сумма, подлежащая взысканию (возврату)</xsl:text>
               <xsl:apply-templates select="$GoodsNumberDescription"/>
               <xsl:text>, руб.</xsl:text>
               <xsl:variable name="paymentAmounts" select="$goods/../KDTout:KDToutPayments/KDTout:KDToutCustomsPayment/catESAD_cu:PaymentAmount"/>
               <xsl:variable name="paymentPrevious" select="$goods/../KDTout:KDToutPayments/KDTout:KDToutCustomsPayment/KDTout:PaymentPrevious"/>
               <xsl:if test="count($paymentAmounts | $paymentPrevious) > 0">
                  <xsl:text>: </xsl:text>
                  <xsl:value-of select="format-number(sum($paymentAmounts) - sum($paymentPrevious), $moneyNumberFormat)"/>
               </xsl:if-->
					<!-- вышестояший текст закомментирован на основании того, что в бланке нет 
					бланк - Решение Коллегии Евразийской экономической комиссии № 289 от 10 декабря 2013 года
					(раньше было по:
					Решению Комиссии Таможенного союза от 20 мая 2010 г. N 255 (в редакции Решения Комиссии Таможенного союза от 19 мая 2011 г. N 639),
					Приказу ФТС России № 976 от 12 мая 2011 года "О форме заявления таможенному органу уточненных сведений о товарах, заявленных в периодической таможенной декларации",
					но они отменены Решением Коллегии ЕЭК № 289 от 10 декабря 2013 года)
				-->
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="KDTout:KDToutCustomsPaymentCalculation">
		<tr>
			<td class="t">
				<xsl:apply-templates select="catESAD_cu:PaymentModeCode"/>
			</td>
			<td class="t">
				<xsl:if test="catESAD_cu:TaxBase">
					<xsl:apply-templates select="catESAD_cu:TaxBase"/>
				</xsl:if>
			</td>
			<td class="t">
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
			<td class="t">
				<xsl:apply-templates select="catESAD_cu:PaymentAmount"/>
			</td>
			<td class="t" style="border-right:0pt;">
				<!--<xsl:apply-templates select="catESAD_cu:PaymentWayCode"/>-->
				<xsl:apply-templates select="catESAD_cu:PaymentCode"/>
			</td>
			<!-- <td class="tb">
            <xsl:apply-templates select="KDTout:PaymentPrevious"/>
         </td>-->
		</tr>
	</xsl:template>
	<xsl:template match="cat_ru:IdentityCard">
		<xsl:apply-templates select="cat_ru:IdentityCardCode"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="cat_ru:IdentityCardName"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="cat_ru:IdentityCardSeries"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="cat_ru:IdentityCardNumber"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="cat_ru:RBIdentificationNumber"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="cat_ru:IdentityCardDate" mode="russian_date"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="cat_ru:OrganizationName"/>
	</xsl:template>
	<xsl:template match="catESAD_cu:IdentityCard/*">
		<xsl:if test="preceding-sibling::*[1]">,</xsl:if>
		<xsl:apply-templates select="."/>
	</xsl:template>
	<xsl:template match="*" mode="date">
		<xsl:apply-templates select="." mode="russian_date"/>
	</xsl:template>
	<xsl:template match="*" mode="dateGtdNumber">
		<xsl:apply-templates select="." mode="russian_date_gtd"/>
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
	<xsl:template match="cat_ru:Address">
		<xsl:if test="cat_ru:PostalCode">
			<xsl:apply-templates select="cat_ru:PostalCode"/>,
		</xsl:if>
		<xsl:if test="cat_ru:CounryName">
			<xsl:apply-templates select="cat_ru:CounryName"/>
		</xsl:if> 
		<xsl:apply-templates select="cat_ru:CountryCode"/>,
		<xsl:if test="cat_ru:Region">
			<xsl:apply-templates select="cat_ru:Region"/>,
		</xsl:if>
		<xsl:if test="cat_ru:City">
			<xsl:apply-templates select="cat_ru:City"/>,
		</xsl:if>
		<xsl:apply-templates select="cat_ru:StreetHouse"/>
	</xsl:template>
	<xsl:template match="KDTout:PaymentDocument">
		<table>
			<tbody>
				<tr>
					<td style="width:45mm;">
						<xsl:if test="cat_ru:PrDocumentNumber">№ <xsl:apply-templates select="cat_ru:PrDocumentNumber"/>
						</xsl:if>
						<xsl:if test="cat_ru:PrDocumentDate"> от <xsl:apply-templates select="cat_ru:PrDocumentDate" mode="russian_date"/>
						</xsl:if>
				Сумма уплаты / возврата 
					<xsl:if test="KDTout:DocPaymentAmount">
							<xsl:apply-templates select="KDTout:DocPaymentAmount" mode="format_number_2"/>
						</xsl:if>
					</td>
					<td style="border-left: solid 1pt #000000;width:5mm;">
						<xsl:apply-templates select="KDTout:PaymentWayCode"/>
					</td>
					<xsl:if test="KDTout:IdentityCard">
						<xsl:text> - </xsl:text>
						<xsl:for-each select="KDTout:IdentityCard">
							<xsl:apply-templates select="RUScat_ru:IdentityCardSeries"/>
							<xsl:text> </xsl:text>
							<xsl:apply-templates select="RUScat_ru:IdentityCardNumber"/>
						</xsl:for-each>
					</xsl:if>
				</tr>
			</tbody>
		</table>
	</xsl:template>
	<!--Шаблон для типа catESAD_cu:DTIdentificationMeansDetailsType-->
	<xsl:template mode="DTIdentificationMeansDetails" match="*">
		<xsl:text>Средства идентификации: </xsl:text>
		<xsl:apply-templates select="catESAD_cu:CIMQuantity"/>
		<br>
			<xsl:for-each select="catESAD_cu:IdentificationMeansDetails">
				<xsl:if test="catESAD_cu:AggregationKindCode">
					<xsl:text> код уровня маркировки: </xsl:text>
					<xsl:apply-templates select="catESAD_cu:AggregationKindCode"/>
					<xsl:for-each select="catESAD_cu:IdentificationMeansListDetails/catESAD_cu:IdentificationMeansItemDetails">
						<xsl:if test="catESAD_cu:IdentificationMeansKindCode">
							<xsl:if test="../../catESAD_cu:AggregationKindCode">
								<xsl:text>,</xsl:text>
							</xsl:if>
							<xsl:text> код вида средства идентификации: </xsl:text>
							<xsl:apply-templates select="catESAD_cu:IdentificationMeansKindCode"/>
						</xsl:if>
						<xsl:for-each select="catESAD_cu:IdentificationMeansDataUnitDetails">
							<xsl:if test="catESAD_cu:AIId">
								<xsl:if test="../catESAD_cu:IdentificationMeansKindCode">
									<xsl:text>,</xsl:text>
								</xsl:if>
								<xsl:text> цифровой ID: </xsl:text>
								<xsl:apply-templates select="catESAD_cu:AIId"/>
							</xsl:if>
							<xsl:if test="catESAD_cu:IdentifacationMeansUnitCharacterValueId">
								<xsl:if test="catESAD_cu:AIId">
									<xsl:text>,</xsl:text>
								</xsl:if>
								<xsl:text> значение: </xsl:text>
								<xsl:apply-templates select="catESAD_cu:IdentifacationMeansUnitCharacterValueId"/>
							</xsl:if>
						</xsl:for-each>
					</xsl:for-each>
					<br>
						<xsl:if test="catESAD_cu:IdentificationMeansRangeDetails">
							<xsl:text> Диапазоны: </xsl:text>
							<xsl:for-each select="catESAD_cu:IdentificationMeansRangeDetails">
								<xsl:if test="catESAD_cu:FirstIdentificationMeansItemDetails/catESAD_cu:IdentificationMeansKindCode">
									<xsl:text> код вида средства идентификации: </xsl:text>
									<xsl:apply-templates select="catESAD_cu:FirstIdentificationMeansItemDetails/catESAD_cu:IdentificationMeansKindCode"/>
								</xsl:if>
								<xsl:for-each select="catESAD_cu:FirstIdentificationMeansItemDetails/catESAD_cu:IdentificationMeansDataUnitDetails">
									<xsl:if test="catESAD_cu:AIId">
										<xsl:if test="../catESAD_cu:IdentificationMeansKindCode">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> цифровой ID: </xsl:text>
										<xsl:apply-templates select="catESAD_cu:AIId"/>
									</xsl:if>
									<xsl:if test="catESAD_cu:IdentifacationMeansUnitCharacterValueId">
										<xsl:if test="catESAD_cu:AIId">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> значение: </xsl:text>
										<xsl:apply-templates select="catESAD_cu:IdentifacationMeansUnitCharacterValueId"/>
									</xsl:if>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:if>
					</br>
				</xsl:if>
			</xsl:for-each>
		</br>
	</xsl:template>
	<xsl:template name="EmptyGoods">
		<xsl:param name="EmpGoods"/>
		<table width="100%">
			<tr>
				<td rowspan="4" style="width:68px;" class=" tr tb">
					<b>31</b> Грузовые места<br/>и описание<br/>товаров</td>
				<td class=" green nowrap">Маркировка и количество - Номера контейнеров - Количество и отличительные особенности</td>
				<td class=" green">
					<table>
						<tr>
							<td colspan="2" class=" bl nowrap">
								<b>32</b> Товар</td>
						</tr>
						<tr>
							<td class="bl bb br" align="center">
								<!--<xsl:apply-templates select="$goods/catESAD_cu:GoodsNumeric"/>-->
							</td>
							<td class=" tb" align="center">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>№
								<!--<xsl:apply-templates select="$goods/catESAD_cu:GoodFeatures"/>-->
							</td>
						</tr>
					</table>
				</td>
				<td class=" tl tb tr nowrap">
					<b>33</b> Код товара<br/>
					<!--<xsl:value-of select="substring($goods/catESAD_cu:GoodsTNVEDCode,1,10)"/>-->
				</td>
				<td colspan="2" style="border:solid 0.8pt black;">
					<br/>
					<table>
						<tr>
							<td style="border-right:solid 0.8pt black;"/>
							<td style="border-right:solid 0.8pt black;"/>
						</tr>
						<tr>
							<td style=" border-right:solid 0.8pt black;" align="center">
								<!--<xsl:if test="$goods/catESAD_cu:AdditionalSign">
									<xsl:apply-templates select="$goods/catESAD_cu:AdditionalSign"/>
								</xsl:if>
								<xsl:if test="$goods/catESAD_cu:IntellectPropertySign">
									<xsl:apply-templates select="$goods/catESAD_cu:IntellectPropertySign"/>
								</xsl:if>
								<xsl:choose>
									<xsl:when test="$goods/catESAD_cu:GoodsClassificationCode=1">О</xsl:when>
								</xsl:choose>-->
							</td>
							<td style=" border-right:solid 0.8pt black;" align="center">
								<!--<xsl:apply-templates select="$goods/catESAD_cu:GoodsAddTNVEDCode"/>-->
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
							<td style=" border-right:solid 0.8pt black;" align="center" width="25mm">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
							<td style=" border: 0" align="center" width="25mm">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td rowspan="3" colspan="2" style="border-bottom:solid 0.8pt black;background:#FFFFFF;">
					<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
				</td>
				<td>
					<table>
						<tr>
							<td colspan="4" style="border-left:solid 1.5pt black;border-right:solid 1.5pt black;" class="nowrap">
								<b>34</b>
                                Код страны происх.
                            </td>
						</tr>
						<tr>
							<td style="border-left:solid 1.5pt black;border-right:solid 0.8pt black;border-bottom:solid 1.5pt black;">a
                            </td>
							<td style="border-right:solid 0.8pt black;border-bottom:solid 1.5pt black;" align="center">
								<!--<xsl:apply-templates select="$goods/catESAD_cu:OriginCountryCode"/>-->
							</td>
							<td style="border-right:solid 0.8pt black;border-bottom:solid 1.5pt black;">b
                            </td>
							<td style="border-right:solid 1.5pt black;border-bottom:solid 1.5pt black;"/>
						</tr>
					</table>
				</td>
				<td style="border:solid 0.8pt black;background:#FFFFFF;">
					<b>35</b>
                    Вес брутто (кг)
                    <br/>
					<!--<xsl:apply-templates select="$goods/catESAD_cu:GrossWeightQuantity"/>-->
				</td>
				<td style="border:solid 0.8pt black;" class=" nowrap">
					<b>36</b>
                    Преференция
                    <br/>
					<!--<xsl:apply-templates select="$goods/catESAD_cu:Preferencii/catESAD_cu:CustomsTax"/>
					<xsl:apply-templates select="$goods/catESAD_cu:Preferencii/catESAD_cu:CustomsDuty"/>
					<xsl:apply-templates select="$goods/catESAD_cu:Preferencii/catESAD_cu:Excise"/>
					<xsl:apply-templates select="$goods/catESAD_cu:Preferencii/catESAD_cu:Rate"/>-->
				</td>
			</tr>
			<tr>
				<td>
					<table>
						<tr>
							<td colspan="2" style="border-left:solid 1.5pt black;border-right:solid 1.5pt black;border-top:solid 0.8pt black;">
								<b>37</b>
                                Процедура
                            </td>
						</tr>
						<tr>
							<td style="border-left:solid 1.5pt black;border-right:solid 0.8pt black;border-bottom:solid 1.5pt black;" align="center">
								<!--<xsl:apply-templates select="$goods/KDTout:CustomsProcedure/catESAD_cu:MainCustomsModeCode"/>
								<xsl:apply-templates select="$goods/KDTout:CustomsProcedure/catESAD_cu:PrecedingCustomsModeCode"/>-->
								<xsl:text disable-output-escaping="yes">&amp;nbsp</xsl:text>
							</td>
							<td style="border-right:solid 1.5pt black;border-bottom:solid 1.5pt black;" align="center">
								<!--<xsl:apply-templates select="$goods/KDTout:CustomsProcedure/catESAD_cu:GoodsTransferFeature"/>-->
							</td>
						</tr>
					</table>
				</td>
				<td style="border:solid 0.8pt black;background:#FFFFFF;">
					<b>38</b>
                    Вес нетто (кг)
                    <br/>
					<!--<xsl:apply-templates select="$goods/catESAD_cu:NetWeightQuantity"/>
					<xsl:if test="$goods/catESAD_cu:NetWeightQuantity2">
						/<xsl:apply-templates select="$goods/catESAD_cu:NetWeightQuantity2"/>
					</xsl:if>-->
				</td>
				<td style="border:solid 0.8pt black;">
					<b>39</b>
					 Квота
					<br/>
				</td>
			</tr>
			<tr>
				<td colspan="3" style="border:solid 0.8pt black;background:#FFFFFF;" class=" nowrap">
					<b>40</b>
                    Общая декларация/Предшествующий документ
                    <br/>
				</td>
			</tr>
			<tr>
				<td rowspan="3" class="firstCol tr">
					<b>44</b> Дополнит. информация/ Представл. документы
                </td>
				<td rowspan="3" colspan="2" style="border-bottom:solid 0.8pt black;border-top:solid 0.8pt black;background:#FFFFFF;">
					
				</td>
				<td colspan="3">
					<table>
						<tr>
							<td style="border:solid 0.8pt black;">
								<b>41</b>
                                Дополнит.единицы
                                <br/>
								<!--<xsl:choose>
									<xsl:when test="$goods/KDTout:SupplementaryGoodsQuantity">
										<xsl:apply-templates select="$goods/KDTout:SupplementaryGoodsQuantity/cat_ru:GoodsQuantity"/>
										<xsl:text disable-output-escaping="yes">/</xsl:text>
										<xsl:apply-templates select="$goods/KDTout:SupplementaryGoodsQuantity/cat_ru:MeasureUnitQualifierName"/>/
										<xsl:apply-templates select="$goods/KDTout:SupplementaryGoodsQuantity/cat_ru:MeasureUnitQualifierCode"/>
									</xsl:when>
								</xsl:choose>-->
							</td>
							<td style="border:solid 0.8pt black;">
								<b>42</b>
                                Цена товара
                                <br/>
								<!--	<xsl:apply-templates select="$goods/catESAD_cu:InvoicedCost"/>-->
							</td>
							<td class="tb tr nowrap" style="vertical-align: top;">
								<b>43</b> Код МОС<br/>
								<span>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
									<!--<xsl:apply-templates select="$goods/catESAD_cu:CustomsCostCorrectMethod"/>-->
								</span>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="3" class="green">
					<table>
						<tr>
							<td rowspan="2"/>
							<td class="br nowrap">
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							</td>
							<td colspan="2" style="border-top:solid 0.8pt black;border-bottom:solid 0pt black;border-left:solid 0.8pt black;border-right:solid 0.8pt black;">
								<b>45</b>
                                Таможенная стоимость
                               <!-- <br/>
								<xsl:apply-templates select="$goods/catESAD_cu:CustomsCost"/>
								<xsl:if test="$goods/catESAD_cu:CustomsCostCorrectMethod">
                                    /<xsl:apply-templates select="$goods/catESAD_cu:CustomsCostCorrectMethod"/>
								</xsl:if>-->
							</td>
						</tr>
						<tr>
							<td style="width: 15px;" class="br bb bl"/>
							<td style="border-bottom:solid 0pt black;border-left:solid 0pt black;border-right:solid 1.5pt black;width:25mm;" align="center">
								<!--<xsl:apply-templates select="$goods/catESAD_cu:CustomsCost"/>-->
							</td>
							<td style="border-bottom:solid 0pt black;border-left:solid 0pt black;border-right:solid 0.8pt black;width:35mm;" align="center">
								<!--<xsl:apply-templates select="$goods/KDTout:PreviousCustomsCost"/>-->
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<table>
						<tr>
							<td class="green tb" width="20px"/>
							<td style="border:solid 0.8pt black;width:25mm;">
								<b>45а</b>
                                Код изменений
                                <br/>
								<!--<xsl:choose>
									<xsl:when test="$goods/KDTout:ChangeCode"><xsl:for-each select="$goods/KDTout:ChangeCode">
								<xsl:apply-templates select="KDTout:PhaseChanges"/>/<xsl:apply-templates select="KDTout:BasisCompilation"/>/<xsl:apply-templates select="KDTout:QuantityChanges"/>/<xsl:apply-templates select="KDTout:CountryChanges"/>/<xsl:apply-templates select="KDTout:TNVEDChanges"/>/<xsl:apply-templates select="KDTout:CustCostChanges"/>/<xsl:apply-templates select="KDTout:CustomsPaymentChanges"/>/<xsl:apply-templates select="KDTout:OtherChanges"/></xsl:for-each></xsl:when>
								<xsl:when test="$goods[not(KDTout:ChangeCode)]">
								<xsl:for-each select="/KDTout:KDTout_CU/KDTout:ChangeCode">
								<xsl:apply-templates select="KDTout:PhaseChanges"/>/<xsl:apply-templates select="KDTout:BasisCompilation"/>/<xsl:apply-templates select="KDTout:QuantityChanges"/>/<xsl:apply-templates select="KDTout:CountryChanges"/>/<xsl:apply-templates select="KDTout:TNVEDChanges"/>/<xsl:apply-templates select="KDTout:CustCostChanges"/>/<xsl:apply-templates select="KDTout:CustomsPaymentChanges"/>/<xsl:apply-templates select="KDTout:OtherChanges"/></xsl:for-each></xsl:when>
								</xsl:choose>-->
								<xsl:for-each select="$EmpGoods/KDTout:ChangeCode">
									<xsl:apply-templates select="KDTout:PhaseChanges"/>/<xsl:apply-templates select="KDTout:BasisCompilation"/>/<xsl:apply-templates select="KDTout:QuantityChanges"/>/<xsl:apply-templates select="KDTout:CountryChanges"/>/<xsl:apply-templates select="KDTout:TNVEDChanges"/>/<xsl:apply-templates select="KDTout:CustCostChanges"/>/<xsl:apply-templates select="KDTout:CustomsPaymentChanges"/>/<xsl:apply-templates select="KDTout:OtherChanges"/>
								</xsl:for-each>
							</td>
							<td style="border:solid 0.8pt black;width:35mm;">
								<b>46</b>
                                Статистическая стоимость
                                <br/>
								<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
								<!--<xsl:if test="$goods/catESAD_cu:StatisticalCost">
									<xsl:apply-templates select="$goods/catESAD_cu:StatisticalCost"/>
									<xsl:text>/</xsl:text>
								</xsl:if>-->
								<!--xsl:choose>
									<xsl:when test="$goods/catESAD_cu:ConformityStatCostIndicator = 1  or catESAD_cu:ConformityStatCostIndicator = 'true'">
                                        1
                                    </xsl:when>
									<xsl:otherwise>0</xsl:otherwise>
								</xsl:choose-->
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>
