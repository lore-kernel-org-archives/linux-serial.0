Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013010.outbound.protection.outlook.com [52.101.127.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5CF3AA4F9;
	Fri, 31 Jul 2026 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484161; cv=fail; b=dqp8JoZp1miZQve7iBpiPf+3oH1qfrZJXTR4GwrbTXZka/ASxd9/AnthGeVC0B8PZNizJLS6pT0eHk5CYNWKtde2RZE1vBf1Yd6n87CbwiZQqMWogs1qgC+8YVIhqT6wuwF7Pz1fHOgeg1QYFVyQ/JZtfFklzjiiIL5Bqx4heHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484161; c=relaxed/simple;
	bh=dK4XALSpKbOGXlknxTsGgT6HZU2kLc4PBeuj+KQDzBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pPE1U2I3JLXAChStAgVLcTmaW+iKMRIgHMR4fJQMJVFNV75ti60WC9/tQERHoO+HH8iKcwpSHH5Or7iOV97r+kZRUrv0Alf5FF5alqE989kJ5IkQIeQLqMWJdHLONBX7nn4ERWFJbEwNADQP5NH3Fgo9J31MlVzw6eBYNt6+WHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Jl8wJT6A; arc=fail smtp.client-ip=52.101.127.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Jl8wJT6A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcIi5/UISgmA/8PFIv8XNN0xoaR7Ru3NS1aebhyzyT+yV0h0evOOhbwgHspqlAu82aDMKIeos2vamuiF3OYvNKJay9Jf5n3KOJ16wCL+1ZtsVge7xRxNW04FC00K6MtpBvovQ9XXWMbkMPP8m9+sdLOHURSQPz0kfzDbSdbrYSuT5q1c33LiEZ9sRC+a8eX73khzWyTCLXZy+noyR1qCycA99WXbH4ev1g4GVHY0+XBOIh99UewbLiE8fZu70ijNZDWTASA2SXlxhVGDWaal87r4It/3ADczfyI5vrwFiLir9IsEUqi1XHAQewD+yVMpywrZ3G9O0wJfUoClXqPcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9vHIKMI2J1kKxx31iKybJu68F1wJNAtGSwA/LHZs34=;
 b=PTP9XIT+h4XrQIqat8s7J7iLjDVtEbUEuAu7v+b0eU+wEPC+0kkBoCG9LE6VntOX02RCFc4dccKRpEMO4rbLxMeD5auyuaKsIZ3kPaWzR5fEbOgohXFUP2NS2TXq4vdgvHBTirbtZOdUvNJIDCYBHVrpg0om1lsrkizQBzGMoDp0yHyxn2uy8vV50i2aDadTaPLRmmM0IeI+HJhpJCd0m9fzNbIEV5vQ0xYGsMph40o9YFNjBYyO1wptXf5aqtlRoqi6Iwvq5ZluyGTf+AVPhOgVpSTsrVI3MMuFCuKTwXimovjTPa2kKRwxESiUtHFYcl1rsV48/yVBZq4JkWC+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9vHIKMI2J1kKxx31iKybJu68F1wJNAtGSwA/LHZs34=;
 b=Jl8wJT6AqDBel5iuTPponC6AuhtBXhi1Cuck7TJWBH+4YcbxnOimvfo/Z4MBhvpu2/Cx3pb4Q2LKzO9NyRd8NNOaLlVJWfeXzaxp3J8YBg9qxqEIE0qaCvK3IwDzijRfO0OnI30jewqqd82sS8FEpUETzjLVuzElzv7nfwV1F2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB4488.apcprd01.prod.exchangelabs.com
 (2603:1096:101:89::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:49:06 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:49:06 +0000
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
Subject: [PATCH v5 08/14] serial: 8250_mxpcie: speed up TX using memory-mapped FIFO window
Date: Fri, 31 Jul 2026 15:48:14 +0800
Message-ID: <20260731074820.735619-9-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEYPR01MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7520c0-5e58-4f4f-0db3-08deeed8326c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|23010399003|1800799024|38350700014|6133799003|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lHVLpTaDhP+eAR0HH2URFE13Sj6a/YrCYPuAfUE6gTST6S5weRPI/c8G9Tm/a8IzlzDqtjOjoDBOwRYwmsCzkVcWNGu//d2prPIHbShYC0F8hzz99ATez5eKjJcFuiCOw4wvS57fpkDbCtO5FqNlC/74IlAo8OKb8I3im4yfpXBVGz/YPMFheLvFuwHThclGdRn/BC+/ieLxbzgaDH2bR+z8Ws9xYwqhHf5v1D6sRCNPzr8kAiBSXXggcDJGEImZcN7E3AAWIMBHYTm6U7WayX1zanOkazQgB6Uwc8a09xdDhjiXm8LeIhrRL3ldzUALwM11u7fMbHhTEvr5ANCrZVv7svMg6eVR4eahqiXkOg2gyt0y7oFs82nk9RvTj818a08T+Ju4d939jIQsJYiFStH0sCagql0UwbhnlNlrhlT7N5nCrLMJRni1EBd64DDnY2muJepmon8LfZeDP6+gTkrxkGGlC+s3yakB/ztBWprhkL2JrJEbh24Ix78rM5C75YtMKMFYdbhQQQ77DofjqT5uk1iF2SqEEYVYlpGISCWDmfa7oa1KqEnWyQ33CREQQeAqKS/wQlJWsyodcXoF0EpSx3oyazu6dfMBDkV4fSGsOCxVV2G7yrwWSakCrrOwQrxJvxdh/b/NUhrUMF2pHdp0OQBWv8mAFIyojPVf0qpdkmNwdnVUdo5Qj4C075TjIy0VBoo25B/4azRjQnoCjWIetnC2brhPFxWPASFV+rQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(23010399003)(1800799024)(38350700014)(6133799003)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U1x3QFVknUsZcq14cTf5dNri3Mi43qw/lZz4VjHyHxdixgjxyALNdS6RPBlm?=
 =?us-ascii?Q?wR85A0rKV4orVTyxtxvRWBrgBobO4U/nAv+KqqVhP9aPn0gBXvqx2ouydjNP?=
 =?us-ascii?Q?iPxVVca2bFxUdIS8J1d88WGi1WyKNBuWdqNFGzRirbZvTpr2fQIo4TkjFSJ+?=
 =?us-ascii?Q?UCM/4TwC5LvPa6HKxWvNIkr8xQgNOD/tsxtLw8Vbcrtpd2PqdfZxlNFGeNsV?=
 =?us-ascii?Q?Y98yp6/KZgIV63J8lb5h+Kk5UckTNgkFJMHpoUzxNZEWIKjdPnyyDaoitLX4?=
 =?us-ascii?Q?OhzFvGz1VEZHZw6KmfOuMp3+RzEqbNXpgCnxwHRDyibAjYiZtspzvlshpRTt?=
 =?us-ascii?Q?7SFCSm/pUEKxY0keKGQLCBKKgq1p1aemf9cQvj+cSkZRIRxKkLeb1tLqzFZx?=
 =?us-ascii?Q?kQ4FSIAy1OWfqHbXiYen3WIlyjF96P/Sc6YEz7YkBbrItydq2IR9wpsyOy4t?=
 =?us-ascii?Q?0MKhNr66z6UysXH/eOd2cIDuh3hDk9igFy8onQa1Qa3/tVR/1OW8iaTg0qCz?=
 =?us-ascii?Q?hTYiCNW7Uq7PCrlrENjW8xTr5t1XNomi/XkmvovQzyIT0LC5XeemOIXJeotU?=
 =?us-ascii?Q?J6WPx31Xux3sKCLjVSKUZZuV3UDNRfE1RBIvIVaQQnB1gghy5jd3MOzpC16M?=
 =?us-ascii?Q?tjlgJwghmbw/4j+sQXSpwWpR2BUcR5e5qgF22ajqIx/seia4xp8f2kSvvHiZ?=
 =?us-ascii?Q?9FTjccSm7FCa3ifNs3bhD1JSehHWXxJAH5vrDL1OVdktrxB2dJtjQti4ZtG6?=
 =?us-ascii?Q?rLv9gbpokndznoJWSHjA10mgQ8ePyj/6ITkswpVopqAORRKsqh6PYvO34Ukc?=
 =?us-ascii?Q?nlSgSZ/PsaMuWw+0G/KvhDq10ipgQctP52uBZVN8uDyFH+z19Wl4/SYpjh4n?=
 =?us-ascii?Q?Rd32E53YS9hprH9cqS5nmI7TlkEwnJVQbQTWu+sN2/M8JThzxeq8PWckcyCG?=
 =?us-ascii?Q?quOQHdFPHiFKPkKZcsScIKGu1pFdXNgqCfZALfFi7D8Rsbwra6oVCaml1CIH?=
 =?us-ascii?Q?Ic2yIuY1dbkDhk/cUqDzHDqeVxcxFQvMGjHPjy2zrcNURUShs6AV/dOWZh2R?=
 =?us-ascii?Q?h8se3KT2sVSwy549OZ8U+FZLBQaNvIZsF1Mly7H9Af3Z18lQZUFtKPPNzaZJ?=
 =?us-ascii?Q?VTEA7KQAv2TY3LyuNnfNmJ6IMGuxI2KQCI9pv6mp2l2+zQ9GyeyZEjfDre5d?=
 =?us-ascii?Q?2weLrRxwOHvoGHycMcdRssntArziZIbGVaBCuNkbB1xWycbf2bsbyMmay+TC?=
 =?us-ascii?Q?cVYOdnVkV2/ceIv2WYEjsXQx9pJ5g7O9fiEfXcZp5SwJAsF1k5I0anxW2jwh?=
 =?us-ascii?Q?s3+6YMBn9F6GvnMwGvl4YtV6dxGu9h2CDAHhqHL12Wu9Z1+TVifKi9GoP4De?=
 =?us-ascii?Q?fqsTpRm78glq8XMzOGVv8xBOupD0EG8KXgbVts0sFMHWMfn2G0wut14apHRN?=
 =?us-ascii?Q?VAWzLnKwzLFB9cKlA+iZsMc5I5SIwvicZBfFOKsUGknQr9To4ty85UCbxYgf?=
 =?us-ascii?Q?gP2nalCsbh5SJxgL8xNdw/KZaIGzWl+7OZhI+QqNnlfP49d6j8lMkxOGWqyz?=
 =?us-ascii?Q?bz3AvH0uPIsJ1ym+PfuZDtUsebQgKiiI3V1LSNsOqiOGjiHFGs1jZcYqhe6d?=
 =?us-ascii?Q?swBBthNaHxSUl5Xpb8D5pgwD9b27XRK069plJF1vOBboEjCUOiNJt9+lh1Xj?=
 =?us-ascii?Q?hWQ7LTmEB/2NjRTbVnYiC6rcCpkf3wkLSdOWybJWTR9rMJA+FCgL7HhpiAiv?=
 =?us-ascii?Q?5RihVQHWKPcYclQg8zOuS1kgyg6XFIg=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7520c0-5e58-4f4f-0db3-08deeed8326c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:49:06.1068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrBL/eCxtE7F8dZaB7A86a8+EPsVrlp5Qr7PL1ALlO1c/bQB0TPMU3KrFvfsdKvx/0dC0do3/Nr4nmk8lVGHdow1cyL6hDKPtL8HqoxbZIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4488

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
index 415468a02d0d..e864fb0624e5 100644
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
@@ -304,6 +306,18 @@ static bool mxpcie8250_should_rx(struct uart_8250_port *up, u16 lsr)
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
@@ -327,7 +341,7 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
 	serial8250_modem_status(up);
 
 	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
-		serial8250_tx_chars(up);
+		mxpcie8250_tx_chars(up);
 
 	return 1;
 }
-- 
2.45.2

