Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012011.outbound.protection.outlook.com [52.101.126.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3E3A75A6;
	Thu,  9 Jul 2026 05:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575241; cv=fail; b=D1XTXjwo0rWSApcl6dk8VpoWhSnHFTJ/YLlJXfxVFtStt3lGKpRnqMMGr//oCrMPI39lnDdn7/KEzPph7WQ8d3Y3lrF0BAsvM31OXdcDZkLtIW3+JdZBNXMGavcVJ/nec9gonl/OtCwc8a4/KJ59LVIJeC5zGDeGTdY6Ye6JSzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575241; c=relaxed/simple;
	bh=m3ATS/x9Z5vMo6XBuX8dFwAYYQs8GzLZd6UJNlIkz+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VodVANt+6aYR/Pal/CRVrcSYZN/KA1PkcA6Ogp1Rjq2HSpFc7N/DN8BgAtqcqjXA6W0C2OP+3WGAiE4ZDa19vNo/Zij9NMMP95iJ/mh+7pPJJ+eo1jfKxNabFycigYGmFJegh3JiRSxWblT6FrHNeqLOrZdXSBs6GioZ1vcVQ8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=AQvy5V+g; arc=fail smtp.client-ip=52.101.126.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="AQvy5V+g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahzuuJJeD+RKkKoGbSKzwKjaTkQmQKM+hgOrkXZBjFu0tPiMsIBmNnHvsOXdqOJnAw/w1iMcbChvGhiuqoDtsLaMa7M7rRe/iMm/jIcHV1GthXtP0WmHc1hVdH3oBmw76e2If3nQf3bOTw0pKf/pOGtg5Jo0GtM2rdwu7hqaP8xGyFy0fo1w+aGwO9c5mcNszv4DzvpMq7mASvL3D33uMlncgNqjhGKyuhrTy7wtkzzSTGvehbYVzfahUNNrWNIyrTEpy3KWozo922vI52zCQcChBYHvAJW1AaooFyJ0mWH9rCfu6HLjg1Ng8AC9USUr1KcW7SDrKrzVA4iwcvem4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU/sBmrlscrGTopEH13k7qrfGgDFgoNJaHPqWeoZxk0=;
 b=jMKGqjmo4tdrZXOb/0N1F4yYCsCU0UBVRB3HDWCaxnbb+v0OCxs6MH0Uoyeyp2UniZAIfDYcGEwJrHYkXuVqNMYlm36OInU4v7gn0RdYzKCkd7lCM8pbZb6a6sELh94i28mqV6WGi33lgnQyY3YRg3Em0sRNRc5siqF8ABETlZeYC5b1q5th2Un0Q/6C1S6dM0O7uoqXtos9b5qEbtwUuafYKQQx2qGDTaxZcPygiNlhu2DJhtNzHESt03pdUlJl2EZo1kX8aX319sP8zW0+TGihAKn+1yBhJnrO+TksUE+dEJfloBW7R0IflpsXKFho2iWPSR5U/pb40qf1iv1wig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU/sBmrlscrGTopEH13k7qrfGgDFgoNJaHPqWeoZxk0=;
 b=AQvy5V+g+zxePwNxM0csbYkppHrPqtA3RetohzJmSDiDz0KSI8mG/xJyXnDctTAdqMXA/YeUGBR38w+Nq4arD3aPWxXCoFmgnKsh7XrJrWVqy8GBSWI7AkeTkRbMMIc1OCf3iWKLvJICzq/wkuVlPoppISw7p0zkVdwQPH8gawY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4610.apcprd01.prod.exchangelabs.com
 (2603:1096:400:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:33:53 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:33:53 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 03/15] serial: 8250_mxpcie: enable enhanced mode and program FIFO trigger levels
Date: Thu,  9 Jul 2026 13:33:02 +0800
Message-ID: <20260709053314.435629-4-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
References: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To SEYPR01MB5387.apcprd01.prod.exchangelabs.com (2603:1096:101:d8::6)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5387:EE_|TYZPR01MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 7451c8d2-a907-4c74-c917-08dedd7ba91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|3023799007|22082099003|18002099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	ymGHfBW/WR/51HWQl7ydRE3oXIzCQtdjum8LFlLaXTTAs+0Qr8ceY93idhkkpFhjYUV6XeVXKxOCb69pc9kuNl2i+e79Jf/wyX1m2INoJFzJcSZbv5n6RplbIMkfJ9HOk93w1NEUT8vVqnFMJqNcQRwOHvhaexyfTntLqAKptoFiXfawbvkd33lTfKAnLewyyTXektllqqpdrtfe0knuw4KyVIKnNtg8QCPiUDut9BLKsraJ0vwGMiJm7pq7mgMWXHbp+padVgNsot7SOcquokIu+9DXtMDPpF3t3WBtl+Ee3Nc6OtLcQNpPN+UeMGOpRyC1WiW4XKx9altYKuX0d6oUf2eWH2KZMdAvTT2LTsE7p6t+3z7htVIcXbMpjWy0sDIGW4CDH6DCbokrd6RIrAFSE7GUwiIlIx7NIwy2r9Jjkb9mPAZleEoQtbervfNM+bU4OGmmxUuHZaIYPQMugEHqc83rC9IJCkQeeWT4B7zSRilfonTYvI9E/DPrp+cJPHAlRuQFCQ4u9ko8VVEbnoe2Uaa9Y2cqM0+DC3vRsbcrlP4AdJfIcN8alfMuXRkM4dh41R5tWai+Iyi9r/tvhf9S7Piw0rz2kGJbLQhHb8IatDdaoAf4tVo3y0fvlROtGYfcVSsWl8hOqRTEsuKW/gg+aJCHLuCR/JPR13PkpqOhqRsLaH2m/DIzCXIco7Kg0oD8TI8oHaFAxQ+H6yU1DTlSyJlcWU2NcvEBrZhJvgk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(3023799007)(22082099003)(18002099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0X0uGyNX2Dqa+NxLV+JBHaL+Vjq9rXxSqJhRgUPG/wJvubaJbUnnnDjZVJTb?=
 =?us-ascii?Q?Oq1bM8FbbLJyaM0XpkgYoA4ybn3wjstGOp1LTPQoq4uVMgupHFG32X9wecYf?=
 =?us-ascii?Q?xnTLG83UmSM4Sjr2ZbGI7gjQiwIZOxyvBm1iJW7/DMMZrBlNQh73Ts3aWOd8?=
 =?us-ascii?Q?kfWSSNSm1aARFGr1NI5RJQJuR+2R++du0N0ZXg6ktnzUzeqflPBAQsypD7cR?=
 =?us-ascii?Q?YDQ5R+oMeUncXjamdMpewBUFt79UrsBXpt69tn4I1uYtZZhyHsStjE0zUL2T?=
 =?us-ascii?Q?qjzP0//bMWcYWT4GIjEALwj2mmtAySkV/a+wglXbiNrmgint92y1IzHgAAEZ?=
 =?us-ascii?Q?t5YV/hVNYKrEMoXmdjLx5hxJYF7hQrhRH5Dsxo+j149bA6AzVgoxaZBh0H8E?=
 =?us-ascii?Q?j8YyzDMoD3WqBxLpYIgnCOYhTEksokxLv839FakfZ5fjkVyGkLhvo6btpGR6?=
 =?us-ascii?Q?/RLsWiQnor6ny4tBovOz42SWCPXiTxbU24g9bj1GO4I8lRfVQcSuzP3WdeZ+?=
 =?us-ascii?Q?WAcuu/DT3esvY4u6kgRRsixoE6VoqVkTDNO2WNxLEpJmOsbwY9nlp/Ro1RWB?=
 =?us-ascii?Q?cZmRCie5aDYznyI1ukil48LW2Aq9yfwou78q6GDtC0No4UWy0Ie6bcDinR7O?=
 =?us-ascii?Q?KQFrGlilwd9sG191HTH02J4NhY7crDT+7hl3L7/g/5v6q7bo/bH1bo9YoH09?=
 =?us-ascii?Q?dXVv59LlHef0H5rjf/cfRtzqigvN/ZPOh0zi2YQXrkRaCQZC35VdGuWnqXYj?=
 =?us-ascii?Q?aXkldalxBFN1aW9vgvvI6jOKuZjgIh3slF/CZlU8zJ/3c9m8qYisyn6tl1WS?=
 =?us-ascii?Q?V/j+XGVMAOjW6rroATYPgXyLbEMXv2NdNPcXHuM2jV/hH1hXSGu3IQSBfCEb?=
 =?us-ascii?Q?82FIpLAm9jOws/BJnEKZ3KOKQDGHAooiYZhqT9DeypeW/OOkQGv14ej7W6uc?=
 =?us-ascii?Q?zYApP62CTyln05Txguslb4ixpQv7u7EzZqLS1f1k9QLHpANUecOWyMVZaUBA?=
 =?us-ascii?Q?l5goeJO3c91AH7IeyH64wI5wwvKDo1H1nMwQ9x16Q4hXv/Vgs5T+VdZySQ6k?=
 =?us-ascii?Q?qbPoicdyFfAM1hLcgqOr37Jyf1PzaoWnfY0aXg2TMvxrBHuMveq619OcszW+?=
 =?us-ascii?Q?vp9vdlcL12hLPYN3SxGdsxEuaCXK2hNQu+OGDWt3VzqqZXG3qs6guSDnezYn?=
 =?us-ascii?Q?u3bMc1pS0P149P6f5WufKAS0skdhe1JWW8AM1MsOC0875yMHqQlgvnQalKby?=
 =?us-ascii?Q?qsDYeDGnZeffTzEN+3+qP7ZlMS9W9ngtk8BFEKF0MpQ4LvXXppVtt8TOSdRC?=
 =?us-ascii?Q?bvu5TJ/ZL7YrXE89Tl68zV1aOIlFfOsNy9E60yLxfrm4Pt6JWkRFHQHlv0/h?=
 =?us-ascii?Q?BN0u7UMXR9Tkvk5ULxeJfKQZi9ozk1w8bBATwzH/LnxguRFLM4ZGToYd0M7B?=
 =?us-ascii?Q?22H9x7ff1Dyb/VhX04FVNxQ4hnKbv1XkcVD6XOaBTWcCGa2rX97vAgS44NUv?=
 =?us-ascii?Q?ryjy1sefvUxItuyXlQreeFv6IPBB9g6GU06ixa2neJl4ZJjTcLm8KTegYtyw?=
 =?us-ascii?Q?Yct4YixEdD+CUEZs+ZmWcmEF/QARpezPAQ69Yl8dIsVCDfzxdbu78//1ARiy?=
 =?us-ascii?Q?M0xsPOyt4ckBr8pQs6zz8PFEMKOGWdPtd0EYwETs2Lg0grGdgXAHK49RdgDz?=
 =?us-ascii?Q?7aL7dqaKKqZ10mYD0WEcu5B+k8MYWbIUcvueXZyLpWJTlDa2mi3+a9Nh+BKw?=
 =?us-ascii?Q?UG+j/0WIt7HJl2vTKSyFBkv8DqBZWrU=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7451c8d2-a907-4c74-c917-08dedd7ba91a
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:33:52.3242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oW4M1zWkj1YiRqMltzUKcULipFBbEUp1XSsgdT9JyXKPr1/wmeuGdcNHNaB45AIDc+8mHfKNpKyFRS7z1fHd5FdBTceZdOP0N9NluSA358o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4610

The MUEx50 UART provides an enhanced register set and programmable FIFO
trigger levels for RX, TX, and flow control.

Enable enhanced mode during port startup and program the MUEx50 FIFO
trigger registers according to the configured port settings. Clear the
programmed state again during shutdown to restore the default UART
configuration.

The TX FIFO write pointer and read pointer are driven by different
clocks. Clear the FIFOs repeatedly during startup so both pointers are
reset before programming the trigger levels.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 59 +++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index c82d3149a03d..c1fc5eba0c58 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -48,6 +48,19 @@
 #define MOXA_PUART_BASE_BAUD	921600
 #define MOXA_PUART_OFFSET	0x200
 
+/* Special Function Register (SFR) */
+#define MOXA_PUART_SFR		0x07
+#define MOXA_PUART_SFR_950	BIT(5)
+
+/* Enhanced Function Register (EFR) */
+#define MOXA_PUART_EFR			0x0A
+#define MOXA_PUART_EFR_ENHANCED		BIT(4)
+
+#define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
+#define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
+#define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
+#define MOXA_PUART_FCH		0x13	/* Flow Control High Trigger Level */
+
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
 
@@ -132,6 +145,49 @@ static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
 	iowrite8(cval, uir_addr);
 }
 
+static int mxpcie8250_startup(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	int ret;
+
+	ret = serial8250_do_startup(port);
+	if (ret)
+		return ret;
+
+	/*
+	 * The TX FIFO write pointer (w_ptr) and read pointer (r_ptr)
+	 * are driven by different clocks: w_ptr uses the PCIe clock
+	 * and r_ptr uses the UART clock. When TX FIFO flush is requested,
+	 * w_ptr may be cleared before r_ptr, so the UART can still observe
+	 * pending TX data.
+	 *
+	 * It is recommended to clear the FIFOs at least 5 times to ensure
+	 * both pointers are reset.
+	 */
+	for (unsigned int i = 0; i < 5; ++i)
+		serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+
+	serial_out(up, MOXA_PUART_EFR, MOXA_PUART_EFR_ENHANCED);
+	serial_out(up, MOXA_PUART_SFR, MOXA_PUART_SFR_950);
+
+	serial_out(up, MOXA_PUART_TTL, 0);
+	serial_out(up, MOXA_PUART_RTL, 96);
+	serial_out(up, MOXA_PUART_FCL, 16);
+	serial_out(up, MOXA_PUART_FCH, 110);
+
+	return 0;
+}
+
+static void mxpcie8250_shutdown(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	serial_out(up, MOXA_PUART_EFR, 0);
+	serial_out(up, MOXA_PUART_SFR, 0);
+
+	serial8250_do_shutdown(port);
+}
+
 static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
 {
 	void __iomem *bar2_base = priv->bar2_base;
@@ -226,6 +282,9 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.iobase = 0;
 	up.port.regshift = 0;
 
+	up.port.startup = mxpcie8250_startup;
+	up.port.shutdown = mxpcie8250_shutdown;
+
 	for (unsigned int i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
 
-- 
2.45.2

