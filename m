Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012063.outbound.protection.outlook.com [52.101.126.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AAF3A59A2;
	Wed, 29 Jul 2026 06:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305204; cv=fail; b=V3FLxDauE3D3x7n/Dx5LFglLET3qCw5kKYNskYqBPp/Jj/Lmx0z4DzqA3FcycLXYD2omQi46/s/7v4m5V/xXgk+Q1Vpi0c34LD+E2YJana+X0mWw5OQdw564jJb4NH0atIRLaGrzZMOLEgNAr2VgCCxQY1oMV7Y75v44EvZlX9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305204; c=relaxed/simple;
	bh=gmgz0AzhcGQMd5oEOHPDH6mxaJf5OFl8K4s/Cp7uC9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UFyJxUvaF8vN9bvzkzaLHbbF80p6ssS/k1HUaD5klnroX0NUMCjWakdzrN04x40PShveICzU5+E5iVhIznOjvDOwCcUlsflAB08fhSesToAggbXt3ww4CiL+uJPsEUWAlVnuuVliHyZsfPxwSeNuTOrsCHz0aGqR45apnzC9Ir4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=NTkkfsNp; arc=fail smtp.client-ip=52.101.126.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="NTkkfsNp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjJgYBy5pQLsvEcv2YuSXSApiIJdo3qbPLNcOR+KudHyvgXQhXSzm5vmjFLOCFwsuRooXlPv3I6LQjkVBPoSdg+qQEQd7L6LsQbrjv2bI3SXHUHCNsvZJ5qXdaA4beNnD7IfYJtnE7TBxswA4QanYJj8FiqmZqNG3GQOUXxezEFB63bMz70AoWUYIMrsqysrX/uD9ulWi1eCGarisPLZ1SuCkkq79telkle2F9mnu+7PwCrIPnO6/eyDg4fFJWCQfAXbj4P+q9ZJFKcbeIF3UYvX6EEo+cA2zlBfUgrW5kS94PS9M027iinekDAIX3nOgAeiArSFVdHYQoEA4c98lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKNcLBZaUPSsR268zeM1A14C09Q5UAN3KJeleCaoP1w=;
 b=NdEXo9fEsNKfbRl/+TMpBykrYNx/9gicZzxHht0J5GpNWTtQCkBcwUBuNWuDMcKTZh4JgyIsuQJSkXl8a+ZHLzYGJFCbXheCio0JZLL+XVrREMnACXMW9XLc3b73nzOU99HhHq1FvsRYrVvz7YQaK3SqrlmLkGd+jsLQYU4HmulX1HG0KRkoMxlqWgh/rWoIb65UXRiMw9txf+UBH+MCvqiT/WmE1XmRk2nsLLWPm5oiDQ7ObVj8Hk1pUL5/a0yLDvlr3N8kafGG4kvBEaljAfvlwU/IfFdSjfGHJWWMvG1L7kBGe2R/gP3JOeTVAZ09+tkC56Lu/mzE1vr6vtzw6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKNcLBZaUPSsR268zeM1A14C09Q5UAN3KJeleCaoP1w=;
 b=NTkkfsNpoMF3ElAXSLFctTj8pLO7QcPok4+omHiQ+HKIs/GoqQc0rQL9HEGSX7qax9fYJIxDvZe0YOVxKU4L5NfI049CwpJmF6aRqkVyabQoiKVU4sFj411UUsyd8u+/TO6EdvyseEAwvja7jX+4yYgrEwx/KwU20Hu5CeMJ1vg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEL0PF4D55A38B9.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::59b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:06:30 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 06:06:30 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	EddieSY.Lin@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v4 08/14] serial: 8250_mxpcie: speed up TX using memory-mapped FIFO window
Date: Wed, 29 Jul 2026 14:05:56 +0800
Message-ID: <20260729060602.492430-9-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
References: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEL0PF4D55A38B9:EE_
X-MS-Office365-Filtering-Correlation-Id: 3016862c-1bc2-477b-6434-08deed37884f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|23010399003|38350700014|18002099003|22082099003|6133799003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	20+BlsvQGVGe4KBLmkBZyAKYc9SypQK1wW97PAt+iRfKM2O8j6UE/sfw/WbnRLP1lOsnc4FmGPYtMgOubLwvgC/OXCTSrd8ik6JFWcx5uJhQjz2EYxTgl0b5WyCVpRaQGXyAplPZrKe80YonVSh8hd8El+gIRVOqrbNX+SBxJ9VlUxyJiQKlCZk/ca6ysi+8ZN1j7bsf2CM687l5aUfOJPaL80sTGZrCuFXIG2O778EzsYiGNKQfyHStlND2cvIepdKlxQ9CEFHXGwmJfpdgUH7NwOI++OJvTJYWMsBUpU4vN01rcWeIfQPS0nV9YVkYaZ2sso3aC7kdJ+3aWuaytgQGn9an7/30qZCo9+sHJBEnstj/OKRg+gap8olP1+0fngGqmnTXYl6s2C7Xh3MqGVhr/M9AmVy11TYRsYTZ+dgJXk6/XVoiuxfljCjpx7QidebKMJ6XjYPCvQ/EPV3yU4ggWtM/rPKlLybrQRMXJ6xNTDFnKvWM2XHuRPpAEM9lN0p5ke1BZhK1+LgkHZyFwMxzDTHGo/2mW9zX9eSxH/fTobFAhNFGotYRjafhjqWUntd1fDhGchGk3dN1Cwv6fIJzkj+9ECcaWcPzaloz0k02sKSgoU1HLCzggIoyHEs1iL6iqTQpys1gGrDx+MXSDvIkMDesWGWF30BwxdE2XDugsA1f0Y+7j0dpDgbfGmfLFKHAbIn3IKWU/wgNSyNbrrf9coSeXjgq1d9Z+YFbTRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(23010399003)(38350700014)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rxf6/5v/OVGP9VtdICMQHNnfwKiNDyy1mpp7IGJ2in/A2zyJivMcPdiQ5XNx?=
 =?us-ascii?Q?Rpk/dak+bFIMgQ6BQFhZBT5nnvaM1RpEdwMohP7aMSOMzUHrlUJHikSD3pLf?=
 =?us-ascii?Q?vq/+DVb3x9JSf2xYusLbljE22BFcQoY66zv2nLuj3sY8ghMHj/o+zE3XXzC8?=
 =?us-ascii?Q?vISyXhXCULPiAemAIdhNbPYeONkpw+8ggMhipyxzZjZINNeC0ZcBEDU4T3Ca?=
 =?us-ascii?Q?Y7rOW2JTTTc1AaTu4CmrSNNnT3981JOf8dMPsLD0qDUgyXnCvv7SWTvWFKcc?=
 =?us-ascii?Q?gNxVaOb0i2pCBXe9ygox+vOvIa5qUqLB0GuPPPu7vvDD3U5t4BEr++W6XJ0O?=
 =?us-ascii?Q?cjBgzOAWkpjJ4+zXD2+RNkrwLASrEVVPR3sOzrZClzFjJqawzLL7QNztj9sS?=
 =?us-ascii?Q?Ek6OhMV5GNOhip5bGYX1Rn1LlZAdcKxwz0iJnt+GTkPlK+6Tf9ZtxfjvO/Xf?=
 =?us-ascii?Q?1V2FdygoEp5ggE0wNWlPj1buknTA49KqCbN5RreRbBnR7piXEEAEYAMnn3Lp?=
 =?us-ascii?Q?TfbeAU9b78pQuNdhjv/08oWOZjPIxBFeSn2k43gTgKkHL56Sfk+5mOmfevzd?=
 =?us-ascii?Q?+/jd5xlQPmgbjIkrhreBXeUnff4Djd/4UoThNckDcImusA85rRtK1Wave4+Q?=
 =?us-ascii?Q?WyCAxY/ox9J66iyimHUpQdwqSBN0zP2ILwgAFrKnKCn4PehOKdqKHa5XIvv9?=
 =?us-ascii?Q?fjv4COURe7XDf5H0PDk8xZlDTUhtxXxRP6wEtb5wR9Y1GhR3DVsDqVmK+Gta?=
 =?us-ascii?Q?9h39BkvkIOQq63raes+ctfuGm3JxAXTWweNJJxRjGwZLI2gwJvSUzrzYoeex?=
 =?us-ascii?Q?DZe9wFOEXTyjIlqkaT8/8snj/B2LoBPKF4xzib3StgwQJq/ql4GPZ0Uo9zwy?=
 =?us-ascii?Q?pRmz87vZysu11BKSnsD+1F0ai8SzQJCWd9MrdzFSE7OTgU8/t6M1khfmrfYs?=
 =?us-ascii?Q?pds/gxrqIofdjSt5SAlYV3Llhdq6uCQ3ZhOthzI52FwSqcV95C6hSTQ+kN0l?=
 =?us-ascii?Q?RxL6ZTNNR6kqIH5YbU1oJXQci625CD0z/YdjTbAu+VYklnuW/YLtAn4DtOeK?=
 =?us-ascii?Q?yPU6bMlRfAKSwpM0GpjgiQFBRxqieZ8BKk3BoI9/aP2EEJvrqGAcGhbBEnZy?=
 =?us-ascii?Q?feBj4Rnv0ePpFZgDX2oSLPMhN8xtLj7OH6PbfYAwunP0zLtL1ucMUuCp6BS9?=
 =?us-ascii?Q?qWETDP0D1we262PHn/q25/3Mt++BmVyU7EXB8pmnr5z291OdOpo4EdgfomRY?=
 =?us-ascii?Q?63mQoRZIpLPzkbQGBYhlqkaFmHrsz+BlDVTxO9HPJkSUxAyZjseFfq8lfmEI?=
 =?us-ascii?Q?cV2C1oW86TqEfNNakROk7BQSipQI2+IDZVPMnjlIDg3mQXdbh+FH0GnllUH/?=
 =?us-ascii?Q?cK+JjJQQuDU22yqpxrD1p7jaZToZarvi9qKXmzTpAdn22QC6owj2hn1W7Cu+?=
 =?us-ascii?Q?Ozdlei+9h+LTBASN2iuJEVS1CaORDUXjIcEsXaxY0gqZ3afS69AYMBvbqgUx?=
 =?us-ascii?Q?HW8e5iEtaC5jng9EUwTDA/gniwWU5LreBtEYpw5H92rv27JRTVk8IR3DAXWQ?=
 =?us-ascii?Q?jY3SPkqtphlVtUVD3fNeEVgPxDLJTzLt0840vlzctdHKaIKLcBkaK44pielO?=
 =?us-ascii?Q?1lU72TXOQ6ufhFHqzfOqKNemgaFJ2uPFA2o1inXEs2HU/5W9Lb5UcMcpOFEs?=
 =?us-ascii?Q?tdKrMDIpSr50OPX/JARO5FxXgbOt9WjGCQ9R142pdk8joc6BrfeNiOlwSgHr?=
 =?us-ascii?Q?F18Lk0d78gDU/Oo7jmG6RIpK1Nr/Sbc=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3016862c-1bc2-477b-6434-08deed37884f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:06:30.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvSQgF/Rxbfaead4C9yhx05tFPy21csr9hAI/frg1DZv1+2RAjFqYmcUMVBNzkSYKL/ZKyeffLdZP8KQ+2xsvtluYkJllS+1L9/4SE/2WRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PF4D55A38B9

The MUEx50 UART provides a memory-mapped TX FIFO data window along with
a TX FIFO level counter.

Fill the TX FIFO in bulk via the MMIO FIFO window based on available
FIFO space, using uart_port_tx_limited() for the common serial-core TX
handling.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index cfef7eee81a8..53f304a17fef 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -81,8 +81,10 @@
 #define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
 #define MOXA_PUART_FCH		0x13	/* Flow Control High Trigger Level */
 #define MOXA_PUART_RX_FIFO_CNT	0x15	/* Rx FIFO Data Counter */
+#define MOXA_PUART_TX_FIFO_CNT	0x16	/* Tx FIFO Data Counter */
 
 #define MOXA_PUART_RX_FIFO_MEM	0x100	/* Memory Space to Rx FIFO Data Register */
+#define MOXA_PUART_TX_FIFO_MEM	0x100	/* Memory Space to Tx FIFO Data Register */
 
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
@@ -306,6 +308,18 @@ static bool mxpcie8250_should_rx(struct uart_8250_port *up, u16 lsr)
 	return false;
 }
 
+static void mxpcie8250_tx_chars(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+	unsigned int offset = 0;
+	unsigned char c;
+
+	uart_port_tx_limited(port, c, port->fifosize - serial_in(up, MOXA_PUART_TX_FIFO_CNT),
+			     true,
+			     serial_out(up, MOXA_PUART_TX_FIFO_MEM + offset++, c),
+			     ({}));
+}
+
 static int mxpcie8250_handle_irq(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -329,7 +343,7 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
 	serial8250_modem_status(up);
 
 	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
-		serial8250_tx_chars(up);
+		mxpcie8250_tx_chars(up);
 
 	return 1;
 }
-- 
2.45.2

