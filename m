Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2100.outbound.protection.outlook.com [40.107.94.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4BA1F4188;
	Thu,  6 Feb 2025 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857394; cv=fail; b=RQByNzi15Veq/ADvEBom1bMdSYVwZ7+roS3kC78n27BKOm3j73gdUokowM4XazSmb+83nhhD1KkopnrZKek0r9IT1boKICu6GHS7h12TPC7zFdcwUC3dkAzai98yzbA3KvKwnaQ6biXuWonW3ZcRwtC/e9dfofktbFJZew5Ciuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857394; c=relaxed/simple;
	bh=6hAnsiYuvUkC3JOZVe9a/A2iXczqBcsm0u6eVaU94fk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P4hcaCnMagMBAXjzdhGlueigtnG018paoekFbinQXd2xaiHt2etbV/hFhW4wI/YOPvPNusJ1b2aRkA+hcYG+ox7Pv5bpqQcYV6ia1up+d+IndEhxXWmUVEbW0mlCFs5FMcQUfTspsc77UsNQKBndZTns5JAzhnoVavUBRksit2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=m9+X1pCT; arc=fail smtp.client-ip=40.107.94.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="m9+X1pCT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bT5iQ4UELtZEQabkPNz7STYk3lhAg7l2ZbxycpkgNR/VqizL+BYUZXEX07mRhNiMh3FYKn+SZDXQEsPkZei9HUw8PLaxVuz+Gw0kU/4rm0J2RUsSWYlQV3G1COhIqgWCaFxnOKnu7xfM/8w6eRuBbBPDFAipJIGSvTzpzUuPlpaKVXsez1rpMSZ0C/XoEgWSSeIdGJ1PRg+sLDTUB4D4Ux3OqMFRW1Baq8NMw4Yvy+gono9w+XMyHfeSGJ6wkMP+KNgPbO6zp26MmnubtzL2Lkwno2j3aSDgf+00GH77ZbpXEqb0MnRw7tcIkLESgVmzjjO6AEflP2wambpAAub9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e413R9hfW1JWiJW8oXqI3W/zO3ET1w/ejs+HuA3fjf0=;
 b=RtO9TpPmtR4vTEhHyOfBPr/5GmrsmSU5y0OzmNNOb0doMam2Uv7oG3cLlnWZqbzcIhA8Wb5ecpBuHnd+UUcN6c2kmQRgXM1hePmo74sKRiAFm4M7zR2KIlSCTOrnHlbylq1dwQkwaHtSkwTil1OEHPlmMn8U9Jf0cZwbJSc9MjzxsYojenBtXOfDyOyksbqx+yJWs6obQmSoJfJZ/w9puLK18XTzGzS8fWwj3GA/qD50yywn81Kf1SgvMvQ9r9r3Ii1xk3N7a77U7iUawNKn9LAH1iZsC6pQCwOFr+TxIhOSLMNagiSGSxN2782PEJes+xpS11GUNHVTVnZV1ofIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e413R9hfW1JWiJW8oXqI3W/zO3ET1w/ejs+HuA3fjf0=;
 b=m9+X1pCTgYKPAAgod72hIqB9aoBmt7eHIx2PrjCtBoQn+aTPr7MdyEDTErdshVnWk67lQh93N4S87l/GqS4cB7QaufDZ824jis40lnrKvBX6nqG+x3NwbNdIfOYmaOjE9xRpttLxIzDJFKY7aB+XAJXs5CkDsz75mnFnVx3NJ/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by DM3PR08MB9498.namprd08.prod.outlook.com (2603:10b6:8:1ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 15:56:30 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%3]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 15:56:30 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Matt Turner <mattst88@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Petr Mladek <pmladek@suse.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250: Fix fifo underflow on flush
Date: Thu,  6 Feb 2025 15:55:51 +0000
Message-ID: <20250206155555.85093-1-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0251.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::19) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|DM3PR08MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: ad39a8ce-1561-44ca-6158-08dd46c6d249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2AoUWDWeIfVbTyHKrkfLRui0ApxSw57SzmzQAXpIld9wXMbsHk3m3ZWNHTsu?=
 =?us-ascii?Q?oOCXBUjmH5ewT7LWVr+6sq0y8cJSqr3C7TiDv5Tiphhk0zqNtMCr1ohZatXn?=
 =?us-ascii?Q?a09qkHEpQzn7YTAqPK8OU86tcQdR6pdNlGcc7GHfF06+N2sAuj5m+B11SPqY?=
 =?us-ascii?Q?c4nHWiPu2vQ7G6WvB8JuAMNENCtnscA9q8R+PUvQoxgjjxSfDjK3hhW3w/rl?=
 =?us-ascii?Q?OjDs98JzoAJDCw+if22vSOtoiPDupTJFv8V3RlV36V6Unh0u0iuLM1Ts0ISh?=
 =?us-ascii?Q?gc++ArdMQRXVx1sjG8WkqP33urmi0LzhsJyDurWD70LlLjn9cAYPj3+wCorr?=
 =?us-ascii?Q?TBDqjBagWqtUfuN8Xsi7K3X/p2pptrnWgVCGAmoBUWiyWg0+7KCcyH/e5Lyw?=
 =?us-ascii?Q?Qp2MeDcfFntnWpfZX4tQ9K1ADnrLHg7WrEP41IUxG9iSEBIpz+Wum1X6eJy/?=
 =?us-ascii?Q?mSqtmYidx1B6wZMRqKjnge9EE6DxoVmgLmuC1SAUGQiW/3v9lmHC2xk/iraI?=
 =?us-ascii?Q?iu3w+GcbASDLDj2UqUr75uu3ZTNaoFKg21F/mlHY2IKghyfhGue3QCaN7H6S?=
 =?us-ascii?Q?jJ6fGmBShUS71/JFxLO7UTh6p5/wm1m3hJGkEdne0ydjEwAWu7vJFllZAaBq?=
 =?us-ascii?Q?vEIH6x8u5b7xhSy6SnWWftBTmBeH0+JKC4ppoCRujzobc2/14JIFRLM5r7r1?=
 =?us-ascii?Q?FNRYpQ40PiCDGhrjhCn02w7Dji0VBSvyxyjVgBOEHQqGjDpbVGeL7WTkamr5?=
 =?us-ascii?Q?j0xTzDZVxkItbyha3likx4dyU0a5QqDm7EgvD0H4CvRrtd7/pVoRVlLcIfGz?=
 =?us-ascii?Q?faaGGxYZUy77arRWry6EOtAJsqwWq9TGf1vde72UpEzOFQE124+wyPdnuSdG?=
 =?us-ascii?Q?2imgBpjyIBj3B4bePRYht1iLrr6VI43MTtcBlUCw/RHLZeT7xNptJD45ndPv?=
 =?us-ascii?Q?sAUzC9ex6iY8kVBEdisMDh6QI1OzAv8qjpidziHfw4vT7wvgIkIbiPt+/p+G?=
 =?us-ascii?Q?37R5gGcHoFdikcqgaEuN/f3iD2qDi34CezTbEBce3yRi7zO9aFSt3VL/3z2d?=
 =?us-ascii?Q?a1tldvn2DOA1zbsDdSv/iD8w/bhSZVe2YlzUhJit+yIb6OO8mOHFABHNOvnm?=
 =?us-ascii?Q?u2iRHGbvsTI74vvAyHfBOhGiRy5nFaQnRa2Emt9sJTedFrw8WzclVyLgBg7o?=
 =?us-ascii?Q?cTmSq27UkNALnpW17MYPPKvXsCi19Jm8gk0JhH5NqLWuu6g97Lf1IOEcWMTB?=
 =?us-ascii?Q?8H5sp+PIq32WMWD/OCJy0bTIpfEsQQR/AZrqhOvSfP8Q8kre+86zioGJIXhr?=
 =?us-ascii?Q?Ytu3GOlJsH+tW1FrmhMA2g8p18SphJMcLrI1wm5v4Cuz1mQR3xlA4vD5IbW7?=
 =?us-ascii?Q?Bv7LZMu02VkJH0TPEWh07f/NmePTM/4WYjgvKzDIHNR3yOiWQ/eFJD3PxtW3?=
 =?us-ascii?Q?sid3LbnPQcSMqSrajU/6jHTITm/duf/9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bmWoA3QpUI1U0DB9pKVRE/+e2gjp96l326ZhuTfEEOZNSovZns+tjIKQb7aV?=
 =?us-ascii?Q?0GmYgpumClgo4dEcThd717gp6uT9WbspYf+z4nHVfgu4YXvOWt90phdYDAxt?=
 =?us-ascii?Q?7NW8YleuuGcqkx9NNJqm6OdAyzp0Nr3DnkjueGmnh8ccXpOcneCV/kIrGw3v?=
 =?us-ascii?Q?2uiktzG2U4usXXcIeuS0j1n9Pn73CRp3kdxKcAOplaWFBP38EJliICsK0BZd?=
 =?us-ascii?Q?xWFHp6eop9Vxn0tUONf0ofb0MO7LHOCEFMn04Acjo+vf9KXQBVE4wG89Oj2u?=
 =?us-ascii?Q?gSP51DtH93qUueDUItke90mW9qZPcajwOlM0D8VqC2u3RacGUw0FtuunL85C?=
 =?us-ascii?Q?+TxYch1JV/3WrlVNbsAqd6Si/JNfZ1PUTvIB66wo8LhW5VGUex5VJASVaeac?=
 =?us-ascii?Q?4Mz32iH14wwXvElGV4LKo+aFT0vzz1UUCmRvF1cf26zLtJheqE5+M5OuiFQx?=
 =?us-ascii?Q?+R7ymRZSsKcoPK2yMc6NmvyUjF2djAwEfJfp0Sv+OPSOvItwwuM5hzf9vjsx?=
 =?us-ascii?Q?JiUfWLFqKenT/z4GJ+vXeHtwpvxW4IY8zLkVtqcmNlaVJWWPaBryraQlYlYp?=
 =?us-ascii?Q?4ASb9+6zEXyUoDMCTvTXPelPreTzuKg+qSfRdv12ppPrTHXOfhcbt4FY/Qcz?=
 =?us-ascii?Q?KoXdcFMIn8f3DD5Uj/qbRIy89wabp6u6vkUw8qNAuEEHKzqYhGJYZY2VFVQT?=
 =?us-ascii?Q?PJJxzwzz+LEfwQjBuxDzxuVm7OxqxtEJG59pc5gbxLn3fqBkyQCk47V6yUX2?=
 =?us-ascii?Q?E2fufAyJqCYSPVC4IdyhHdZVacT8Gr8OWZa5wlBGRGiaU1u6LgFwF54DCjHg?=
 =?us-ascii?Q?brONTzUVwXalevYwmjwIAGGpCuWaxglceCq5ox0Ax+KXsdFSc6KMa+PFJLMP?=
 =?us-ascii?Q?RcpHOOq/QDEujiHzY3QAHRTHM7bLprNmgbbHRkk7L329EySOCm8aESpYiq0t?=
 =?us-ascii?Q?Awf6lstiZ4DkCmVg4mrkvpkWoL5F94a6zB3mrY6/R0vOg5LCr1/lT+oU8kMt?=
 =?us-ascii?Q?mGQkSj/StSuAsmPJqBoq/oJ4pKRO/0I6lEgMskgFZkFBNyyICw/2apQvwKdq?=
 =?us-ascii?Q?rCChosACYti0PT/rQXVg7KdL4iHM8JcPzo30npsXJQdUZNaAoOZbcwVxGFqG?=
 =?us-ascii?Q?HeyPe5MMIbv7VKvGzX8PB+2Ojw8WICC6k/r/QMOM0RNZVI19tR7jr7rZ4xcy?=
 =?us-ascii?Q?2uc7pDOoAAOEvwbZ7+AQplWd64a2VOfVg9pJHXlIKSmhOuibbXQdGZI5K8vk?=
 =?us-ascii?Q?xVd429t7GsljtkEJNBoG9aBKzS9W7T4h1V9ceNTKuqp4Yv2Y0kDuDkg4DtDU?=
 =?us-ascii?Q?WFOnnBt/PSyFp1UJv1KFPEApRigvLTzWWtJWClTnMgl4CoM0m/5rBONziofe?=
 =?us-ascii?Q?hV6zCb9HJjdj9VjKAAke4mcMik3BUHXHXS0z3KKm/KqUAOhqzjTdWLGJVC6M?=
 =?us-ascii?Q?xiMef7IPso2d+kERFknXZhpEdlWN2EL4DHThW1FUp/lZo97u0kr5JWyAMFSk?=
 =?us-ascii?Q?vJq2mRHD7c9mTrQzuh2D6v7+bx0yQi7ABunZH26CCFcfcp27vL/W4b2e4sky?=
 =?us-ascii?Q?Zqe8de3/Iy0nmXbRxJh44/DdpIrpCnc/XExn1Que1GfXlzwEkL7vMtvCRKU3?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad39a8ce-1561-44ca-6158-08dd46c6d249
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 15:56:30.3475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wET+DWtoVAEC/gJ4cOSwZSNBNVsUt6zLOMZ5lr8c2Q3EKTaCHPByIZHFrxRy8RoFhTCRxpUPX108y+FkJsGvdW+759Ir24rXMHQbSKCszLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR08MB9498

When flushing the serial port's buffer, uart_flush_buffer() calls
kfifo_reset() but if there is an outstanding DMA transfer then the
completion function will consume data from the kfifo via
uart_xmit_advance(), underflowing and leading to ongoing DMA as the
driver tries to transmit another 2^32 bytes.

This is readily reproduced with serial-generic and amidi sending even
short messages as closing the device on exit will wait for the fifo to
drain and in the underflow case amidi hangs for 30 seconds on exit in
tty_wait_until_sent().  A trace of that gives:

     kworker/1:1-84    [001]    51.769423: bprint:               serial8250_tx_dma: tx_size=3 fifo_len=3
           amidi-763   [001]    51.769460: bprint:               uart_flush_buffer: resetting fifo
 irq/21-fe530000-76    [000]    51.769474: bprint:               __dma_tx_complete: tx_size=3
 irq/21-fe530000-76    [000]    51.769479: bprint:               serial8250_tx_dma: tx_size=4096 fifo_len=4294967293
 irq/21-fe530000-76    [000]    51.781295: bprint:               __dma_tx_complete: tx_size=4096
 irq/21-fe530000-76    [000]    51.781301: bprint:               serial8250_tx_dma: tx_size=4096 fifo_len=4294963197
 irq/21-fe530000-76    [000]    51.793131: bprint:               __dma_tx_complete: tx_size=4096
 irq/21-fe530000-76    [000]    51.793135: bprint:               serial8250_tx_dma: tx_size=4096 fifo_len=4294959101
 irq/21-fe530000-76    [000]    51.804949: bprint:               __dma_tx_complete: tx_size=4096

Since the port lock is held in when the kfifo is reset in
uart_flush_buffer() and in __dma_tx_complete(), adding a flush_buffer
hook to adjust the outstanding DMA byte count is sufficient to avoid the
kfifo underflow.

Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
---
 drivers/tty/serial/8250/8250.h      |  1 +
 drivers/tty/serial/8250/8250_dma.c  | 15 +++++++++++++++
 drivers/tty/serial/8250/8250_port.c |  9 +++++++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 11e05aa014e54..8ef45622e4363 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -374,6 +374,7 @@ static inline int is_omap1510_8250(struct uart_8250_port *pt)
 
 #ifdef CONFIG_SERIAL_8250_DMA
 extern int serial8250_tx_dma(struct uart_8250_port *);
+extern void serial8250_tx_dma_flush(struct uart_8250_port *);
 extern int serial8250_rx_dma(struct uart_8250_port *);
 extern void serial8250_rx_dma_flush(struct uart_8250_port *);
 extern int serial8250_request_dma(struct uart_8250_port *);
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index d215c494ee24c..272b52cd2a18f 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -149,6 +149,21 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	return ret;
 }
 
+void serial8250_tx_dma_flush(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	if (dma->tx_running) {
+		/*
+		 * kfifo_reset() has been called by the serial core, avoid
+		 * advancing and underflowing in __dma_tx_complete().
+		 */
+		dma->tx_size = 0;
+
+		dmaengine_terminate_async(dma->rxchan);
+	}
+}
+
 int serial8250_rx_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma		*dma = p->dma;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d7976a21cca9c..442967a6cd52d 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2555,6 +2555,14 @@ static void serial8250_shutdown(struct uart_port *port)
 		serial8250_do_shutdown(port);
 }
 
+static void serial8250_flush_buffer(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	if (up->dma)
+		serial8250_tx_dma_flush(up);
+}
+
 static unsigned int serial8250_do_get_divisor(struct uart_port *port,
 					      unsigned int baud,
 					      unsigned int *frac)
@@ -3244,6 +3252,7 @@ static const struct uart_ops serial8250_pops = {
 	.break_ctl	= serial8250_break_ctl,
 	.startup	= serial8250_startup,
 	.shutdown	= serial8250_shutdown,
+	.flush_buffer	= serial8250_flush_buffer,
 	.set_termios	= serial8250_set_termios,
 	.set_ldisc	= serial8250_set_ldisc,
 	.pm		= serial8250_pm,
-- 
2.48.1

