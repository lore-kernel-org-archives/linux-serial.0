Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012034.outbound.protection.outlook.com [40.107.75.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC43603C0;
	Wed, 29 Jul 2026 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305203; cv=fail; b=BIT+YwwrJ5HYSUz0HQojowLghTOaTWdWgnFxprcsbZGj0LSbR7WvZlPULwyefbWQocMwh3+5kB0HtzFWQp6E7kmj8fuJqQBUVMd7AReHz1/Z4JvASC3JRNOxpFwK0qxdQ5vHtGUH/wYvD+58pEG7C50StZewtF+1akH7xDaEmlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305203; c=relaxed/simple;
	bh=FzvSAkehIF149/xXeweoB9WsSqv53ScFuh63rFmmtZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AT+rEMh3kebnkbvXHvxwzRQ2FNtMGL7TD8YyggChg78Q6dgsOTdUW3iS7WjHiAJBFi4ylAnVZdl+PRpxDKfo7R5Nv+PH4qYkRNVZZYonYhH1SAkvZUJ4dnHVxe++aKXhLa4cJYVC1mYyTvtUMYw460P3Fg7UWlsKgd1gWqa5lFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=TAN3u0t3; arc=fail smtp.client-ip=40.107.75.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="TAN3u0t3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWlTkIWMjxMP7qw1AiS/GVlZbFbXPYom8Sv9vQAhTa6urw43Y8UZ/xk0BkxtWkeWkiEXSPW/DpRU3mgEDT48mFA2Kx3dE45xb0d9UjwU00xmSkZeArC54VHi8extUN7vE9PC8V9l9uAJ0uIWbsdnAl3KrOMdnBtAzyWDKaJBaAhScmAzdNxDoWRiPXmBRPP3kRF/92IgjMi1i/DDcXk/YeD638v0f+AnodKozxt5/vopdBI0/vucunpFqIKxHUlwrBhiBE8iTphmfjcERV5AoQz2iNEPNZOQ9W8RAvt5yQ6F3DJXaKCngKBR9ho/uuDBg/WIhTc89T71yPglhevTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2fCGeIL3CiSbXo39iu2l2jDoh2kvPxZ5AHzSIvE3jM=;
 b=vOI0DXaBZR+GC/Nd0kW+6T3wTJ0acM6Pnd8H1kI2ezGeT8FFcLjX+UAlIKA4WJIbPDgxL2WbxHTKDLt7GQgxF4inmcMGaEIo5IGkf6SNnloeGl3ZPQcDLEdyL93FigKTgARcDav8DIPNeE2Pop8cZKH/X05oC+7BvQ+p4ijxaavGBMt/dX/u/22IyGEJgaQ7DADwE6Fj244JDyQ+v5KlR40REirLJy8e7XniMOjght6rnK0CXeX9kjQueISbMy5qwG85LUhxEBj4LdPdiHhqJMmsLeStPw1Ui8r74FigT5cmMkbYMa6fX8NXdK9TdmWJYS+xrw90XV9kpcroGJNhqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2fCGeIL3CiSbXo39iu2l2jDoh2kvPxZ5AHzSIvE3jM=;
 b=TAN3u0t30ZGCPza+F2vykT8/i0GCLqi/04YjghPhYs6mEx/xM2JMDHtnxqKEskkRPDYMM06yC+/nWad84dfPVipmLFTDlLvEHZ/Qnozpeo1RmJdV7fH5jUZUa6wFSYWswUmLUZ5QTeeLCQhpu7fCq4Vj7BYiuupw1/6Utmjl28w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEL0PF4D55A38B9.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::59b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:06:29 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 06:06:29 +0000
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
Subject: [PATCH v4 07/14] serial: 8250_mxpcie: speed up RX using memory-mapped FIFO window
Date: Wed, 29 Jul 2026 14:05:55 +0800
Message-ID: <20260729060602.492430-8-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 078acce8-77ee-4d1e-f2cc-08deed3787d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|23010399003|38350700014|18002099003|22082099003|6133799003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	4J8H0zlBKSzEJH+Vv59JtsQfc8mQAWPTjLBtrtnt+nqSg3DX7IuEYSTetgkC29g0+O/6e/P28lOvJZ3QyJ2jJZZeujNy4T3z3FCtOo9WMXcleg6DK6GYtLl2xd7FrZjjlYiAoneKioNyLuHjHO02WtJPEv+nmyrNeXa2SJ7WxfTLBlzLKUHap9b2ODixiOmhb2+4zP4PzR6+9XrrQzBPN49CkXH6elMQ/MWcM4Jyj1/7nJeKUuLBveZhRHVlgVZep7yDbUiA1eCNHndvBsZBisauVzvKx5lcZGyxf6QKJ46w81BaaByjSgV1izmSJDtJaDTuLtIVMwZmORYcXrwO3IfIcOEH68gMt3Sew+wifZWkv2/I5yK3Ib7wMewNIE8/VjX5yDTJqIxU/tTWErH5nXpl8DqXpUS5s09934LU/4UDx9FN6lA4bjBI8q4jxDsZff7HgcFooEfEtfWiWx4/fSU1ZKzdhWsvD8zluwaldHBQYUGsN3tmCsx9eH8uz59rWR7DTLBTc3pdb92y0YIXS6/WDNSGVmiB+w1y0OZGkb6duqfiQIcOZtVYvJgTJ/e2rX35Rk4HtKZbFtnTzCNyom5GgL6wGNpq32OIAfmE2BQDtDvk1oya3ju5UcRNuRRPnQCScIH1Hw4EIOULOo91fllON6E5pxOiX8FA2RxaLrKPPL7RwnrB4t6ZaNkwhcOAAYF3Zz3rq9RWhNfd9/X/yD7R9Mz6vdjqiSeTe3cOsW4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(23010399003)(38350700014)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V4niRCCOiihpJiZhzBykqQkEVdJZMsKmtownWSbQk48ZiSYlIRuh0VL+SZVy?=
 =?us-ascii?Q?t2f+tR1C1yawRJmWgSisZs2+GelbZA3YsE47Ajx3DnMDTMqxypmJVTmNMxpY?=
 =?us-ascii?Q?hFSZ70qZMi0rwYS2Vi5xA17VZ5fGBqYtTvECZ93aUx1toWSNA6Kb0qyG9zHj?=
 =?us-ascii?Q?bY8YYYzJOKp3Zh75Mdkljg2i0ItgsQD3JuEYDgfinIRmg8h0cARV3RlBqOth?=
 =?us-ascii?Q?x+sxDfusyaKSB7x5VyNLpCXQi3Cc+1iKszx2yWOV99yz2JYz+fiNIzGVDYJ7?=
 =?us-ascii?Q?X+X8/9lOQWI1bHqj+xwKlboYLU9pEUe9pzk4zz/e8RKmSHG7bosKSRITPTa9?=
 =?us-ascii?Q?KZxwjU+eAnzFqq3ceBWx1+ZZ2C7YasDUSCtp/HaStwLF0bpGryDKkWEFkL5S?=
 =?us-ascii?Q?25AegRjZ/w51e+VCCYbPn86yQi41DFt7edPq6xWqmn8cNAlASJAz3gqSqzA3?=
 =?us-ascii?Q?emDzPA/H6inumLCFZw8M1jwVpP7z6tYMB7lAJigr9ah69iDvo5mWpELg624u?=
 =?us-ascii?Q?0hKKWgXdESp5s4ZNGTktEqCRJ1jRjz1oj1fxSJufD1M0vU0Ih4zTCiS//PFt?=
 =?us-ascii?Q?yK3wWk0CH+W5UEl/QsSpu4QK9QwglxTWC1Dgrpdy6FBDR7RqNw3FgJ/sCWnI?=
 =?us-ascii?Q?oRL/yZWIAe+RkmtDlOszb1/1FUx9C7ZEpaLG+Kjnhcltkx1/vgplvp7lf/lg?=
 =?us-ascii?Q?Ffu/fxxh2fNagsgiqDXwfERdjne+N5Xk1v1eTqyZACZAeyB9mPdl2AWADChS?=
 =?us-ascii?Q?wDb+uW2A1Jq+GzUaQgfBP87DPl6hEvZx3l4t60tQzKVmqJcuRiQtIzYv+nWO?=
 =?us-ascii?Q?kE/ELw43swcJ7V4NWR42oq5DOnCJGn61Gpdtik6OhJt7qQoVG/BVc3P2EK1j?=
 =?us-ascii?Q?vqIAk/BkihvGIEN+pzk8mJJaGsknkE0XH/21EbErJBxCeOo0r/+ck6VTXZz7?=
 =?us-ascii?Q?sK5WWA7Ss1gVryivWpNxcXMcJ5hA9x7AvgSGaR/s2ThAE5cQK2PwdpuUMB1l?=
 =?us-ascii?Q?Ld5rwfOwc+QEU/Muq3PKI/2sClBkgIE9PRAOmTQthnNkrJWfGMNOv1BlQkHH?=
 =?us-ascii?Q?wdthpC1D/2xu5dTSPNUAGY4EWlETMRrue5YDokcKe5QMfW5D0eiXdDv2X0dn?=
 =?us-ascii?Q?Wo+fbsavh35eP3FWNjtwH/TLQ4rDuWZWp358dZiOss2eaISuBWOrr/7mJKbv?=
 =?us-ascii?Q?+QINc6Zfz2h6v9KaxoMUKNPRWqq5SNcvpdXZokcdPqjXGih1Oy8YjrCE0Tbu?=
 =?us-ascii?Q?4QztUwTR6taXRDplxk/xBud+LfiVk9nkpqMbQHFw7Ai7V2ecw1GFHseXUlfk?=
 =?us-ascii?Q?+YRDc5V4AScdAbCmatjSq5cy/yE5iWzfZQWkk5TppxGSrm+plEarJlJYH2bT?=
 =?us-ascii?Q?CBGdaelFeopPoRS8VIEdbs1mI4SctxjQsSGdYsIJwIGPBM7hZ5PSTomHhRMj?=
 =?us-ascii?Q?yhnocj4nD5ggCKnMQvZmeKPsJR4Cuv0u8ji0kdujMUImL4cR0x5NvU9F3X8i?=
 =?us-ascii?Q?MGDYJqlIRIAdvCjc9+nKb4wMar4O79HKDiM0fIZ9EwlvCyoOsnqUqr37suBk?=
 =?us-ascii?Q?2t6//h5LbmiIqVhTmkaHNHTzSth1y84CHq6jgQgL3SEo4LC+PDK//NjMAMdY?=
 =?us-ascii?Q?BirH/mhGgU63cuwGWl2AsJyfOHl63lPAUx/gOAbuOjCfzfrSBIe/Xhf/B0ZZ?=
 =?us-ascii?Q?92zknUPFhDjXFDFjnfjMrzQsFHqokis1YDzbQkYVQafTYhB5vk7GjlsriH/a?=
 =?us-ascii?Q?enlT9WBtgagQDGISVESRe3hZqtIM0ZI=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078acce8-77ee-4d1e-f2cc-08deed3787d5
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:06:29.3332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsTUR4eeCa5OXLG4G8A+9rvoOiuC3F0mKjX1/ngX6r6n4C74MCqAqeRscgOQaWWI6cQTv9I4N3xhQ2g4JauRssmx6alF2og5RnqhglakmsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PF4D55A38B9

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
index 2b177ed8ddc5..cfef7eee81a8 100644
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
@@ -265,6 +269,26 @@ static void mxpcie8250_unthrottle(struct uart_port *port)
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
@@ -295,8 +319,12 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
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

