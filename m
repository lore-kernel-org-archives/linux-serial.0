Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013064.outbound.protection.outlook.com [52.101.127.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF044368D63;
	Wed,  1 Jul 2026 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877456; cv=fail; b=BiQqkyVbvUXD81azPKoz28FLtZ3oViRSrVVIVukegrkObAWRlu6cNZ9tlkVJ2x+vBk8Emc0OKz6Pyg3CPVb3sAFdKW7aTI0DdV+p0U67kht2kTgC91qDAcvUGAerUw6Tz3NjVdP7Zf1xkE1TtYmNnW5KZ1aXdxzAG+vyYJES+wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877456; c=relaxed/simple;
	bh=bYlPhvkQQj/kNS4VnxOm0p+IPDV7ilf3y4zWYrHfSBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OcWYcc4X3CtgrWCjkbUaDuDFRTnMcXTlMcPeKj8S4diH3/Va/6ZI3sWdSVkrF4/hdsY99nFJ6vrnPudyEh1Vsyl4BwE/kL6nclxkhpxmY/VuA2riDOTTzUnKh9DmIxhamfclDDZo0meWC1x7imKM07AiAA4fux1h6xZY6yAhZ0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=B+t2byU2; arc=fail smtp.client-ip=52.101.127.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="B+t2byU2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnAZ7A7+59aVZy3bPW0Sl0XsQG4QPd8+vg2yjNBWej9sZ2KyE3NUZ9FmTYnoCEAPwZqdoX1QDM+nlzxyJla6/OUVmU4SkUYihulwUebVJ3AaxIRMED92E6wVA1MTPnEjsIFDGFGE2vmQ7qJl233JdfGoeVg4Hq1bVCyPaPB+FvuBjD1F7xNceu0Y5JTJ5v0wnUIVXhL1Z4QYsR8xN2yka140/0utXR3Vv2g3358yBKazX5O77J2r5IqtZsZaB2QJFAxWF/bOlkT1I256Ag05Lm4Th968GwSxON0z9mWppgYZjhwYJGs9dYNV5VTpuDGPq2A+hLdp6GuAO4U1+u9SAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeKhXvO9XeSSz70tP9x93ajrht5CBRoJW4X2akVibv0=;
 b=CWf0QnqU8WcaAnNVKZhT9LqqT3Gz8EZFGTUOHK5oLaAek1FnIQLZqyptrDyOIc9O0uj+IvwAMBG13AK65N8LQo2uExzxn2S82d/82AOPGQCcLMl3HTRZqaCYJNXevc5Qx+jzTzFIQWZaiceQ6eXjaxITcaXRZmDozRzVu2GQxXHBPbv0W6FXR1phKuCPllk8FDp/0xnaOcIPWDN2BsAFr4/st4TQTbq16dGzHyrwsR6ZG38I3H8bTVBeEVA9K+4vTTI7SWQRbOrvQ2XCVQ+YxBCaCZrbHmRn6J36GNDqE0OaNWCng1wh+4Z6/MH4Ek1DYtACXRc6kqB/h7jAFmnYcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeKhXvO9XeSSz70tP9x93ajrht5CBRoJW4X2akVibv0=;
 b=B+t2byU2iN5gfnzSW3hmTY2s7wsU2WUWmWjdhWexBpkS5hV9caknX0AjCr/flct86Mct4G4HvhvfKUAbXMJOmMyy3O02mVo0djWP9AhlDTFRAaSRWzQGDGG+0Rd/1vyVmZq17YGl7GRos+rKXpZiUt4hUHNrHq2h8DMAwLQXmZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KUXPR01MB8048.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:7f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:44:12 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:44:12 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2 08/15] serial: 8250_mxpcie: speed up TX using memory-mapped FIFO window
Date: Wed,  1 Jul 2026 11:41:21 +0800
Message-ID: <20260701034128.218569-9-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
References: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::14) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KUXPR01MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a2be52-0998-423a-46b6-08ded72303df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|3023799007|6133799003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	wsfzNof+PsLWBsl/UrC+rAJNUzD2m16urvd0MwE5PMO+xgyYn0C51Mle2iA/FTZaa78zPYUVS8pFqpncbjE2V7urvYCCsdF0+yQNRLKRZOBnTvulIhVu9rjCXJJP/Ho51VZBQgepTnU/XEhoyVnDIWzjCxinTlUCQfVFTzns3S66AE/HlbYRo/abIB9lCEqI9WaHewNsVvX9qPlNqt7G8YOGHPCeolULC9AOjdCLxc8e3/Tyf4I3DJ/HOQebV/+41Q+PsuGzZwCw78LMUDhPug5vKzMM691PxfOrXayz7QdE3NPg6PaA9cXPdYMeg2n5k80PYRmFIBMmS7/BhSn84/AWXxcCoQmbpakG5xf4zG+ULjBwz4ed9rMXiSYQw/kBoyg8mdwVZSooZa7hHdDc01HUqdDWfi2tJn9lJZO42l1EiD93bQqmOn8MW51epCvTuOLNSMNQLayEzCBestTiBY/T8M92DTitjKyMqMJIFLCjzyed/I2CHG9kkXMvwzNuiBt10+CmPlWjrNv08ua1JBXy2qFYBwu5RHqrDnzLcdtyCaff5UCW3UCTHrqjcGlAI5VpuCPbgz+1mW9mjmYcJG3Ty009ELKr9Cp/21yVYzHnFmTQpFYNr9r/o1dUiFEw5lBNv3lzOPTx7k8gAuy7e13QwBEbz3orrK9m0O7R2b5XuHg0XLxKo5gmcKC39QwsNTjbaC1hisrXqwnWKDMxQhJJEd9ISJL376G4d/Npdqk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(3023799007)(6133799003)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oFyZR1XJe7aRut0Gu5kGu8r9GCvXg+ReZA8v9Loy3fdCS77XviZR4YsvbYSy?=
 =?us-ascii?Q?y9W68heRgB/16uei++1l+478CkSqeUOnSTtud1sAxIqRLMPVbbnhQ4Jw2+04?=
 =?us-ascii?Q?wBQWW4PZip+kpwzZE8NOziPJCXhveZVHBKyG/jfGj9X0YWy2jlRof39n8dfV?=
 =?us-ascii?Q?AvTkoEf68HHPD8FJriSlp0wII/C9huAQq769nnDjGXOUx4mORKeyMpY6kBmO?=
 =?us-ascii?Q?SnbJp6dU/Glra5E+ytb5UV/Nee3ejO9pe87+FJCK02/lRrDypYtRtU8GUTTo?=
 =?us-ascii?Q?+HH5+PE8YaE9frZ7CWrArRj7jIHPRLzrkslOHmL7AzQleA3CQsnnSyKFI+le?=
 =?us-ascii?Q?7xOeNCzaFkgZyDQRj4BC7Ro0t/TStEvw6hkVkVzunNEi+f8pq/rbTm/nEy5A?=
 =?us-ascii?Q?AMTIULJqfvZ3RMxXAeGcUhiS2qeo/S/2ChxKiOLbxcpFdzP2s6eHM0T9RKiN?=
 =?us-ascii?Q?oTni1kaak8JgHsGo8yqryJX8kwIY8pAwIVhZPif0Q+pBbLLrU3sLse539CqQ?=
 =?us-ascii?Q?UhlQ6cWiJej3aqcVVniC90l8AFZYAnvHFD7gtXljy1ngwo/WeTLFrfCSC+vW?=
 =?us-ascii?Q?QuE57B3fr8nul/FIVl12lzcmIBX3pcj3PzW1LCTLlqgRD5YwvIB8XXafJx5p?=
 =?us-ascii?Q?Ayr5uWKevzC6fU3Wb7NySTHA8qgpiyGoKTwRF0X3VQ7jawoBoz1ePuRO63hT?=
 =?us-ascii?Q?kvtxYVVfzEGNbTG972k+9JIgtP8pWT7x96FaxXxBbVHXDEyNRHtKDAYmIY1j?=
 =?us-ascii?Q?kU4zZ6fHp40qU5yqLzOQFSRl0PK5OWqY9QkpIRWXJZ5UlY74aVbkQwByZ/BO?=
 =?us-ascii?Q?mFcCE3S04gqYsJq+4qzw1qrz3wesxBPRAhMrKZfWDharCscMC+2cfVa0H6dl?=
 =?us-ascii?Q?d/UGhyjW2HtYxwtc1x2In+XRTuQNpTC89TpRc2LCRuazMrrsp/XuKMm7gLyM?=
 =?us-ascii?Q?+4CZXVZXKkGLkOXJmvLeEovqLtNap31cXNufo2ctJZKlyKwVVbMhw5sS5LrX?=
 =?us-ascii?Q?lMpYKGDDf+kbIZBg3gAE3NpfFU+JjXta+rvOyfLJ9rYF8X/LLi9ftrSxdeOT?=
 =?us-ascii?Q?dlBheP1AQvU++D9c1GSVkpiSdBCtu1UIBzuNDblLt85fstqDpweJ/iuIKEGJ?=
 =?us-ascii?Q?/BqBnUcS9Lyxs46u8yaWpInCgMN8da1S6FK9DWWJavGavkgQwNoSj1arPqFK?=
 =?us-ascii?Q?A23iA+fDpHeFNK3MXWGLFqUvj5GRQajPi2uBy12C1lCkz2AUGHPBV1mpBjWD?=
 =?us-ascii?Q?jS8gN+AWIiV0meYlG1/9bKAsih4SWtIJYpjtjL1tuuIe0ddOZOcCNrhzPRXA?=
 =?us-ascii?Q?UvogyVVwlPlKtcd2HVHbWfRQWf7A4Q4frT43AoKVbSV8HqEKIPhk2/K+NUu0?=
 =?us-ascii?Q?3liWAtF8mJYb56xOtqmc7g2S++Q2rYooQSpKFjoC3ZyhTcJIyFrnfZPblPgV?=
 =?us-ascii?Q?hrt39h+HS1IcMrPVP834pWJWc8WFRQr92Vkj5my/ugQQpR+2uPI/u7z4M9Q3?=
 =?us-ascii?Q?UVcgKN/u4SKltOQFIgLO3+Ds6G1jtWNprAH2v9kSh36KO+494tvEYfy9RO9Q?=
 =?us-ascii?Q?haXZeSteOfSenqK/BcxHHHzBch3gAhkildGZKpjSy9KzsKE6kRfaz4wvt0vU?=
 =?us-ascii?Q?Mq0k8wyOF1b8cJmGxEbJ72mpulIb9iK89g9m24Pv1KJHnzkGtIyrR4l9e/C/?=
 =?us-ascii?Q?zxlnj8kvWuWWDSjmtMUzx8CL4UPmr2r2iKLzt+UIqZFskx8rPV+JiWxp3pn8?=
 =?us-ascii?Q?0kMPjnfHkYAZGzA3ypG4v9ln9LZyGl0=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a2be52-0998-423a-46b6-08ded72303df
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:44:12.3877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJvGgDCcSlbokQve6o+STp9aflenIhsk/JSv06JyHAxWyWMo/vVbntV/2RqV7u0CqNy3M/EoxtsecWThRuHpy8J/52HphBigI1SRbPvMbXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR01MB8048

The MUEx50 UART provides a memory-mapped TX FIFO data window along with
a TX FIFO level counter.

Fill the TX FIFO in bulk via the MMIO FIFO window based on available
FIFO space, and use this path from the mxpcie interrupt handler instead
of the generic serial8250_tx_chars() helper.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 35 ++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 4aaf56902949..8d38f7d80282 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -85,8 +85,10 @@
 #define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
 #define MOXA_PUART_FCH		0x13	/* Flow Control High Trigger Level */
 #define MOXA_PUART_RX_FIFO_CNT	0x15	/* Rx FIFO Data Counter */
+#define MOXA_PUART_TX_FIFO_CNT	0x16	/* Tx FIFO Data Counter */
 
 #define MOXA_PUART_RX_FIFO_MEM	0x100	/* Memory Space to Rx FIFO Data Register */
+#define MOXA_PUART_TX_FIFO_MEM	0x100	/* Memory Space to Tx FIFO Data Register */
 
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
@@ -318,6 +320,37 @@ static u16 mxpcie8250_rx_chars(struct uart_8250_port *up, u16 lsr)
 	return serial8250_rx_chars(up, lsr);
 }
 
+static void mxpcie8250_tx_chars(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+	struct tty_port *tport = &port->state->port;
+	unsigned int i, count, txsize;
+	unsigned char c;
+
+	if (port->x_char) {
+		uart_xchar_out(port, UART_TX);
+		return;
+	}
+	if (uart_tx_stopped(port) || kfifo_is_empty(&tport->xmit_fifo)) {
+		port->ops->stop_tx(port);
+		return;
+	}
+	txsize = serial_in(up, MOXA_PUART_TX_FIFO_CNT);
+	count = min(kfifo_len(&tport->xmit_fifo), port->fifosize - txsize);
+
+	for (i = 0; i < count; ++i) {
+		if (!uart_fifo_get(port, &c))
+			break;
+
+		serial_out(up, MOXA_PUART_TX_FIFO_MEM + i, c);
+	}
+	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (kfifo_is_empty(&tport->xmit_fifo) && !(up->capabilities & UART_CAP_RPM))
+		port->ops->stop_tx(port);
+}
+
 static int mxpcie8250_handle_irq(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -338,7 +371,7 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
 	serial8250_modem_status(up);
 
 	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
-		serial8250_tx_chars(up);
+		mxpcie8250_tx_chars(up);
 
 	uart_unlock_and_check_sysrq_irqrestore(port, flags);
 
-- 
2.45.2

