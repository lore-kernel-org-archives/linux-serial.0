Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013014.outbound.protection.outlook.com [40.107.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FE73C0A14;
	Fri, 31 Jul 2026 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484158; cv=fail; b=cbVvMCbG9j9OUXmV2BWXJHGXjlCcIc2mH250+qgn4CvnthwbEPavFoJTKYH4rbOadUgBtZlqHJ6SXjs+cfvigA2/GtYj69KF6zpKe8LgC92Qpe/hZMpdBgO68Zg+1qJ++AheADXvawXtz0wNwIvU2Zo7gQRResP6Mu5y2/maEOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484158; c=relaxed/simple;
	bh=XO64bQlUNXAfPvsBFFnX1Om6+N5XN9eVNqNbXd8OSPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=py9/YwzSKNg6JxcVlIfeyobmX3Tebgmr0tAwJaESe4qQlF55YqvLfj1QiLmSUgI8DyTxMk06bvI8gPnT4ETXqfaJmtV0e/SC5/eU9pZxkFIA4kru/YsRMW1iCzOxQHkbe+FvQr++kSki6FYm6+h3EGu2c4YCXIPFatAyMD8oH34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Y7yuDNTk; arc=fail smtp.client-ip=40.107.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Y7yuDNTk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kquxlwVSzvwyPs0g2MAMFkF13FPLwuBtaNJvvrAXYjQkVebcdVjROXClFOG0MOUzC9aUWnBSuqCmPYSAqHxJybKnamyw3HNBQMJ9rKYYYYuz50PxjTRCOlk9leXznH5IzWVj24k7eye59mP1AIXC9iD/LmBV2tmuUV87NFYV/9JB6ckWkt3KLQUdjMWOsylLxMA3aeNpTKmJlqMtOU+Q4ncmQHqOa/BeMdvg/4n+C34P1rXwaIGoxyr7DewEMJy/1q71QhJWQ6mGia+wdX3aZb1TihOLNr5ztvxuHlYDTMIqzRO5beXt0RAamuAhsu2YYgd5hxMOjVLSHEynzIQ3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDbvMqWVgJJ7YEbp0YEd3IW3pdtQtB0QUTjlov1018k=;
 b=lDpnaPpIV80PDKH1R1j1ASmuHWtwWX7dcE4OoQ13+FIKYF2D8997gFAq/SuASTdQ67hXYyMNTibGCxIyke/i/xpuA9Hp6TPVTMHev/fNLAIE5vd8kf06A/mqg2X0VPjEGFjvm8skQx/PNt+sRS96bQEKS5nFCEZqaOe8xHSzeLKVa07R+ND1pUDkFVHIMUvXtjCFOasWu0uqUm/2qJ6Iv9IEI6Y7BmtEECLoeyIYZUztN3Ap2LKQZBg8Sl9/wGet1l/fvMv7CE//Uw9L3zE8aEIdF6zPo9A0uxGBIP+Y5poYk5e+YzFkRmWsOO5sQNWJ/LY3XJDpn+t2RLwpbKi57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDbvMqWVgJJ7YEbp0YEd3IW3pdtQtB0QUTjlov1018k=;
 b=Y7yuDNTkK6g2H9iI0k/Q7DMjMQOAyb12sBdI2mhhfhMj/auAOS3u6+vdbNDjJ8acfbMzFrHJ1l3dWkY9HlxN1HRK9CHnMY/cOQB+DR585oBnaEGFZIpjgrxr06wiwz8V9bK92pPLrSMVUrNkCkjlCjv8VK8Tgkqm4pCFyCl8QPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB4488.apcprd01.prod.exchangelabs.com
 (2603:1096:101:89::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:49:05 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:49:05 +0000
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
Subject: [PATCH v5 07/14] serial: 8250_mxpcie: speed up RX using memory-mapped FIFO window
Date: Fri, 31 Jul 2026 15:48:13 +0800
Message-ID: <20260731074820.735619-8-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 93fffa06-b5b8-4291-ee52-08deeed831cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|23010399003|1800799024|38350700014|6133799003|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xaEF8K0yCtfoYdytKqdiPWfeW/bzhRRqUMa5UWZCWg8IFVSJRZPDv/Sz4iZeC8oP2C77/gGKXDEiFe2iE7hUwDiQzBouDHR/LdxoJTO5q8t9aCjQrM1PyrmGefpZQPtigG44RzmFkXWZX7KJmFMaamvuMQdxnH/8BNOy3gpkwuNGMIZPf9y3iYOeiG0jvaYyRcLp4DlDVjAK3osmMgzf2C+9fTbnwgxWQ6dG8rB+1/O9p4oXvHGJ1F6Drbv67onMrFcaD1hER8JYPxhbSxyliCTgoEMVo3CeNvTyR+h3IyTxNr3cxMptQ0ioVizoq6q2bcDlTriqrPgyVzWuvZgL7xki9qtBYtK9asZ2/XhVqIC6wDmZryZlWqxMp70Fr3EDneFMg35wW1sC7ox+JXM4rgcB2wSOdApbOSiLfBiRRfLVR7TLKPmefCerMLgs5sNzfdJ9d8kQnmNJBRfo8b2DsVEUJG0YVdL+jV+ecFOCsdOOUo7asQyXm97glNe/JPd/6HuKfK41Ov/jSwPumvKGqd0UWU0fXyovj6KD0CiJNJd0Z76G3uBCu7JsH5KYbsZ+913HoMULFDGP6ukeuvj8o2ikVWsNuIB5DPcPfPR8NTCgTze7Zp7lFOP+zmG35a5Mnc8ez/fV/wzfRan4SzqzF8nrKhdaAxleHiBB1EZjhXe3WStCdnVgeS4Fj2O0kwTFGO/hc7K+mNE4mgR5zfO3lNNM1+vH+eZu3j1J2F8zn48=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(23010399003)(1800799024)(38350700014)(6133799003)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s4k6vg77Oh4F9Tx8el12du7FxO9uQQQd1XDivdOMbNEl1lE0+oY1fngFlgnR?=
 =?us-ascii?Q?kWzZ88nO6nN6DpnNYi6CdOHhorYYXTuLSeUFDBpWFn/8b1F6uA01oFiHFNUK?=
 =?us-ascii?Q?pLGu5HqUmZMGjYEk9mN9Eizj0opIOknLDYbCZQN9SUDE6dDRVYw2d90+u06C?=
 =?us-ascii?Q?kckOWZZQlKYa7v4BOoYvDYnuFR6qyaj8XKRghF/RlIrhYeyKMozrCT/31+22?=
 =?us-ascii?Q?Krmbd55OVuaHEAfvtbAI53rDTD76gxCR/kxY4hRBB1bI3jTsnxvN8fsWv6Ij?=
 =?us-ascii?Q?qRNaf0thB0gLJ6NVEOP7VLzlJK9BFLvtNcVVS72HXzOpJi9QDISJd3ZAywTb?=
 =?us-ascii?Q?vf8GqFp372C9ndn92sLIsPwnUeaXRK2j5pr93HVcwbrlQpLXQlheog5zIK4N?=
 =?us-ascii?Q?Wa5/tF9WcLhXMi+YyFNPbjILnFCkFu7NT8kNRE10Ao8tcRyYGWlqE4no6m5j?=
 =?us-ascii?Q?pxGfdm2qB5Ghnn3M1hqpygQr/irNM5EccC8NEJPm1hgQ9OJBlFW1H9mrKeLB?=
 =?us-ascii?Q?Fv1fGVbQbl44JgolgzJcoKjO6K6wPpWkGAgC+684oCr304glbOj6EpQbOxsj?=
 =?us-ascii?Q?+cFTcanKbwVt/b10koIZsAHIgBgTeqpEUKVI50/B2qZs0zek66RFN1ycehoN?=
 =?us-ascii?Q?Qrx8YXZKEu3l26A5a0fjUr1g7hyFavK+C2M5yms3Ubm3qnmAOV2Ch5LM2Mrn?=
 =?us-ascii?Q?dxYVndVMQLcNay82eaXjuAjc+HCmnmZV6ABBJdUuhw46nn9ONdhW1m/cG1ni?=
 =?us-ascii?Q?YW3/TswkzAcOft1kLY9wp5MTnOIaTqzFGHIRHoAJ8nxyW+xLIdOFMGKVyYAJ?=
 =?us-ascii?Q?xrAooDxbxRIkaCjGo80E7KdhjwjWPQANtccCEI1EaOeiogsvpmDMcnxsY8gr?=
 =?us-ascii?Q?zuUYjM3pFQpERvVo1kykCU5p/KlYfTz9Ec/ivP0T20/vJFDcuE1xGp/sQ84e?=
 =?us-ascii?Q?QuxdbcXrSrvdCyq0kho/yLWR4vBDz6Fd2eeIRTonGIw+nuc/wEDx856VbB09?=
 =?us-ascii?Q?t2N5LVEsAZnk1BzI2we3a2XxXvKtARhXW8oKP0ClHYZ9igv1hQBaeJmxvNxR?=
 =?us-ascii?Q?THDI76mng7sWD51yuLnb91lzlF1sh/3YtGHOkpTOrZB3hevpPJfj+RRNYjlH?=
 =?us-ascii?Q?AJUE+4eHyh1jX+xyA8Ss2dc33ZrQQlxs7BW1wGybJTluuE2Ld2987O5KH0oE?=
 =?us-ascii?Q?lumlljSosPuUea85HrdIxediYURD21O6mU6NlzehD55l9RskRqnff/xTFYw+?=
 =?us-ascii?Q?4Xj6J/D3TFoFcPjq88aFvbr6Ceow4vySJGHQmXj1H17SuhXCCM4f9SE7nEPi?=
 =?us-ascii?Q?d9/nTzVrvJmuEic4G4rUbAeAWZWu4D4mANqTqfU0R6Q4IlBMWHCe3yAUg+Wj?=
 =?us-ascii?Q?Twmf3tzcm/s4SkKZOAij5taApEmskdfN7BFBzY+HhaHFIek8Ec8DsP/rTxWT?=
 =?us-ascii?Q?J9Ni7C8fhvT8gwARnsQt45wFzB4wjmKpBzfvYH3c0H5Z9u51SLsYRlp1jXWR?=
 =?us-ascii?Q?1wic89p9VHed8/irgYaXQDUnAnV/1WdOr65V+Ge3B5HRWpP2n+BXp4gPRHcj?=
 =?us-ascii?Q?D1SjS12hp3R4AdCHj0Noz8CWI7azfICxIJmhxdRp5IYTQfscCYFZ/HVpvw3P?=
 =?us-ascii?Q?h4tbEehg471QWWP2roogCvYVzuPgFGDUh4XaCcC49aFuDHvnhSY1KiTvvssM?=
 =?us-ascii?Q?TokFCigLCiTBux2oU2Fp8+a5ZUR/pwcijeLfW2cP/tMML/5eA6HlVHecoVfl?=
 =?us-ascii?Q?NAHdHmqfpGithC2tqmARg+RnI+YGThA=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fffa06-b5b8-4291-ee52-08deeed831cd
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:49:05.0949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXq1oKv1jQJSXFNBmbxRYFmwF6r6vj04hKAg2LvK5Si2PunxBCQINtUAIHEXj9pvvZBKLHLEm+iAckrlo8EVH0N4ne7FwZo+CkNLrE8IfZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4488

The MUEx50 UART provides a memory-mapped RX FIFO data window along with
an RX FIFO byte counter.

When no break or error conditions are present, read received data in
bulk via the MMIO FIFO window and push it to the tty layer in one
operation. Fall back to the generic 8250 RX path for break and error
handling.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 32 +++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 9190825ff3d3..415468a02d0d 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -13,6 +13,7 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/tty_flip.h>
 #include <linux/types.h>
 
 #include <linux/8250_pci.h>
@@ -79,6 +80,9 @@
 #define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
 #define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
 #define MOXA_PUART_FCH		0x13	/* Flow Control High Trigger Level */
+#define MOXA_PUART_RX_FIFO_CNT	0x15	/* Rx FIFO Data Counter */
+
+#define MOXA_PUART_RX_FIFO_MEM	0x100	/* Memory Space to Rx FIFO Data Register */
 
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
@@ -263,6 +267,26 @@ static void mxpcie8250_unthrottle(struct uart_port *port)
 	serial_out(up, UART_IER, up->ier);
 }
 
+static void mxpcie8250_rx_chars(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+	struct tty_port *tport = &port->state->port;
+	unsigned int count;
+	u8 *buf;
+
+	count = serial_in(up, MOXA_PUART_RX_FIFO_CNT);
+	count = min(count, port->fifosize);
+	count = tty_prepare_flip_string(tport, &buf, count);
+	if (!count)
+		return;
+
+	for (unsigned int i = 0; i < count; ++i)
+		buf[i] = serial_in(up, MOXA_PUART_RX_FIFO_MEM + i);
+
+	port->icount.rx += count;
+	tty_flip_buffer_push(tport);
+}
+
 static bool mxpcie8250_should_rx(struct uart_8250_port *up, u16 lsr)
 {
 	struct uart_port *port = &up->port;
@@ -293,8 +317,12 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
 	guard(uart_port_lock_check_sysrq_irqsave)(port);
 
 	lsr = serial_lsr_in(up);
-	if (mxpcie8250_should_rx(up, lsr))
-		lsr = serial8250_rx_chars(up, lsr);
+	if (mxpcie8250_should_rx(up, lsr)) {
+		if (!(lsr & UART_LSR_BRK_ERROR_BITS))
+			mxpcie8250_rx_chars(up);
+		else
+			lsr = serial8250_rx_chars(up, lsr);
+	}
 
 	serial8250_modem_status(up);
 
-- 
2.45.2

