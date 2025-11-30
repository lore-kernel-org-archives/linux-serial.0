Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022137.outbound.protection.outlook.com [40.107.75.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED3B27A92D;
	Sun, 30 Nov 2025 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499478; cv=fail; b=gloHnPB+sUmgYbuAZuPpXcV2FHKQTtK7mchOQXZE3Np5oK4/GQqPIjphWI0bzJY8kbJGtK41cScJv5sGLT9J/zH5X6qkXzZ0Lo/Kj2eIQrBWTrDqNjlxOwAfosBE+Jh3TtXps2nIiglgLRfwxa1HAghCCvkYhB9Hy8ofU2Q0tXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499478; c=relaxed/simple;
	bh=FULQ7tFrpS98Mn2zVtbb4eQty3I6m1ED0VlHLfGkY/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=He0JGn6G3umwK8N2dvPPuDa3VdQdrjkRUtYKGhht3L8W16MxU9AIH5mBPxiKn1agko6MOTHb88ojXTXeV6L5X9lFScHxr9Szu+3Accv7ga7hTDLIXvh9WmZ04Pj5xWGkARR+sF3NMH18JuzDPyGRg6MJ0f0N6ahau2Sgg7DSl78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=YP5y/mba; arc=fail smtp.client-ip=40.107.75.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="YP5y/mba"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbHcsDWr8u9OxiVk1kJKefLH6H1CvXYqEk7DyjiIIbkG3bJQMa2oHPbsT37LVKsrmeSHs9R9Sos+mAfoHfU0Etzb3f+djYOvavuXgDL+J8K9iQs/imMF5nwL7It0smKD7s+e9Lm09SxaZuRIu9TSX7JyH1Kx/gChP0YexyYtmd1AgcZpDO8S98KMPFRU5H4KQ5+SvmkjJO/Ls7lGPVnNkEZfc0UkavWeOoCIMeLGfV9/TWnTraeVNDsB0ZtYMVhxCE/t8yt/NCkHPm6B+6RkGqT30xAnYmuMQ/uMU0M2CoPI9a5TF3umDt17aMlo9elU0CP3KTIkjjT5JRE3jXIbEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gd/DE/w6Jph7HPyNqa3v6hxD4hscyu+SBSztKIeLW04=;
 b=kcAYg99X2a1/kWMR6wyM1jzPxkR1v29zufGcE3hytCSJzEWLD2NeQSf52R0THkzuYRNPTW//5steyYLxn6KgBQaWT4D/ctOGy+sT5VCdmQZghoweYl6AyQys9vsX8RnuYP4eUDh5hrHPlLMDlkZJ3KB1PPUNLxB1ejBq/qZBuQJCmWxcNfahbWSnCHg8K5t9BImdKfQ2t5ZHDEXVq45OL4JFdzJ85Lh0b+W4r4hbayKZS8rdWviEFvM+22YDrhSXQ10+3h3yGjNAHkzhYhbe0fvkClY3hQVIwB8AMljMaMVCyV7wHC9wYW8QPb1qJkcyy+GQow+eDoqIaoRQF3qDHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gd/DE/w6Jph7HPyNqa3v6hxD4hscyu+SBSztKIeLW04=;
 b=YP5y/mbagb4q/00KIHmj7urCiYc8oo2UmJ10zSCCvEM+GLKXSObmq3gVc4KD0tLgT/5uVFJglVzERQYqTeNQxVeyTytkISRro/L1Sj3Rm0+7Dr3dZ5D80jrMdfNpEQ75J4KSZ8H8XwQFc+CNOKEjDc8RllICmyM9I/thXkOS1+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4235.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:44:33 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:44:33 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 14/31] serial: 8250_mxpcie: add custom handle_irq()
Date: Sun, 30 Nov 2025 18:42:05 +0800
Message-ID: <20251130104222.63077-15-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a24313-5331-4f0d-d142-08de2ffd72ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ONS6eKleL81rzX+v1t5kkT/qcH3ClGTzyyv4lHxy9eAPej9BkwuWN3IE17I?=
 =?us-ascii?Q?Vc5K9xahXt3dSsRGf1C3hPPAamMsMimHOfv+AdfVthhM3gHWrmrTMYHg4fMH?=
 =?us-ascii?Q?2yTwHbmtpzDiVjf1FPeNqEhgZpLCAq8wUxFWzdThOYEIT0VXcnaZSt7TlJR6?=
 =?us-ascii?Q?UKpgZVg+r1vwTOsDoOvD01COVIQA3qgeFLvboa30RDNE2l/kAhoRWdKAaaCZ?=
 =?us-ascii?Q?E6SHfSh8I1v57NIvysHa5ErtV7d+D5w8r5qEnwHeF5sWA4L9F6KbdxjCnsRP?=
 =?us-ascii?Q?PLZoiJnEsUPJyeINL//52OuYKXGuS+hlIWVxk+5uWcFL2AU1pM3rqjpub15j?=
 =?us-ascii?Q?N8EXh6uIaPRKMskdrF+QAYuX2y2AlEDK/WATowwt4HqA+hR7+pxQ0mUsZCBy?=
 =?us-ascii?Q?08xU2RusbmxJL5UUdyMVHgv5YB172ifvwlEOnEy3VVFVXB2ZrOejqBb26C8R?=
 =?us-ascii?Q?OZW8KgakcYELUIU3yqcfsYWa9E6Co4J2HZHTCqa+yDbEva4jkdVgx2IHH8NF?=
 =?us-ascii?Q?QMb32PUozzbJVUg6AI2qKj12MM/Rgsy9TI4iAqx8RzuH0BAFsXCEKeYdIGUO?=
 =?us-ascii?Q?K/7CXp2J48Qi6rKEvDNbNvuif/P4Qmz9BnzfIZ3ZDHJaoEORRLWb4rIITQn+?=
 =?us-ascii?Q?7SkHxR3bd/yxYbci7rLk3DJhkiNDb/cLtUuVeaMOc1ZXVtOhAKcuJvo3EnG8?=
 =?us-ascii?Q?H989yYmj4YHaJXbOrGGRZOO5cSsQicTLRex7jVA6ItI2CJgYjMEu7Jho6C0T?=
 =?us-ascii?Q?LtFU+Z6iPFZHzWUjkhbF//c+KkrmKNbvxSnvNrdpYAsoXkleg4OgJatsyZEQ?=
 =?us-ascii?Q?2uNmqV8RAgqfkXXjgnMpzVbfpilIpoBQyi330IXBMZC7dIXGTDuzP4yMrhJG?=
 =?us-ascii?Q?SK6xf4d9Nc0TfFKbrC2Jng1fbXfSR0FCCm5cCEVRo6rPaFCU502qmZyjG9bJ?=
 =?us-ascii?Q?shaY7Gt27/kYwYZ7DqEGzhhI59KNEX2FTkp+hmge1Ne3cYlaNo5Q6qfP9jIC?=
 =?us-ascii?Q?mzZuzwiUIv5AVXsSfALmIBiDQOgMCloI8gDXXZqBtfeHnqpyQKyV5cZhNXtV?=
 =?us-ascii?Q?uNuTpv4fXQXM+5wa2qx69TuGlasxn957ghnt1PKOny4M7JNX3a6/bwyQ2X8J?=
 =?us-ascii?Q?bh0R8njcVOKUMyhsHINbCnUrHkW1sfVRH71Ag9zfrb9DsA7HFNTJj+yDZTBd?=
 =?us-ascii?Q?LYgmLfvv8VyW7pBK/nGYqEElbxYqwW45nmfWNb3Ftf0Z3B2iEb4tVZPNw1bL?=
 =?us-ascii?Q?AIpIPGA0PUq2COuEWseCqkZ+V2eXGsuBeuUPi4NfHUabDTd4YWowE3NfxTzm?=
 =?us-ascii?Q?iWw1V8rUgiflGHUfOHXoYQmkm9L3AiHqo8ko/yU547RQ/l5UR02Jh6/8/zEY?=
 =?us-ascii?Q?VnkvQ4/HNomyyrjh4WXmq4ZWuVeNi2EF9uuoiN9TyHrs8YMEuOejC8Db9UDW?=
 =?us-ascii?Q?hjOGWGI9AC2RdIIQdTTNZTOmsW8+YkFXlykXJCV5YChEq6ZDbQTSCpSKHPNf?=
 =?us-ascii?Q?9nC1b3F8YqZ6AAUKyL0/THUi0Bbt2fZRtdFh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8k/SfjCxCTi14AZvgyxnxmAx7GcxM3htvHRoU5/vobUS5m5zPmAmr36m+RSB?=
 =?us-ascii?Q?iVW8d0ovkAZt3TgUvA4t61cKLrb5MMeTru1OOSAFgahXRkHSuLxmyoFk/daU?=
 =?us-ascii?Q?+PXi4GVzbColVDAU/P02+M3cg1jf4SvguANOVLch3fKsjcka9qPOm2sKKgQw?=
 =?us-ascii?Q?G40IG0URvFAWu8/UCxCYUMoztXDSf/Q/I1Y6QF/A592aMbWRa35bqMMTzM/B?=
 =?us-ascii?Q?WwJL5LUODMd7Wkw6tXf9WXE/QAFKb+CgJBWl+u1p/71U+qzsnc6lVKeS8Gu9?=
 =?us-ascii?Q?Z3xCfk2+zrmrvjClAS0bHT+eP9pdcrx9f9noHbIjelPOyKjBsYK/6UYHXIww?=
 =?us-ascii?Q?KeHtmwAzW9ir4N6NEC9X0oP52Sr7GmmHxvYtXANmEJxzXiCw5ka8UW/ukLFj?=
 =?us-ascii?Q?ZnSbWwFzv2/ddeH7MbdJWqrKLiaHIRWa6pMajht3ZYA+91hfluzEvO5689I4?=
 =?us-ascii?Q?LF4xcGZSVu2rYDilxf9sygUOlFRrnyXCab1BXtlhmKOSoOppervI5C4CFwTr?=
 =?us-ascii?Q?NFF3Cx7hNKSRe6McpFVr/ZCpSEuYdC/Bm5FIfyBx7yTg2LoIisZLFyyc+qEc?=
 =?us-ascii?Q?XLDzXzm8XRrFrSc1uMOXHAPsTSCWimTOQ3dCjj3JxFJZjfJKZ1Y3E0a7xlpR?=
 =?us-ascii?Q?YU3Nl/LTPGiY73lrWYYij6t82176OzoOr87DodBSwxipYD0r6PhatelsUvRV?=
 =?us-ascii?Q?FRh8CBZOOmhQwIBFeZbhpTb3np3o5p+zemkk1J0UiAPr9gZs+kLJrwIkHTNA?=
 =?us-ascii?Q?WIdcsqSYYdlHH8XKCVrfZ2VrR0fE8nMrkCDkAh9TuAzRpNhoyeIR39URexZS?=
 =?us-ascii?Q?YjGaq6xjbnQHej0HWR8pwIToxEfPl1i1Dh45B+7F4gBqFtTtwmVCIdJTwk1L?=
 =?us-ascii?Q?DvLzWXojAedL3/fvqHIom9Xy7QAd7xPpV9X+iQcEc/I8Pks6Pa6v0YvycuWL?=
 =?us-ascii?Q?QJQxm1P5SQLzVVfXq9PuKdh7ift9GunpMvf5drg0vdPHDuyDJWviwPtdrvfZ?=
 =?us-ascii?Q?63rs8L1MLHDESnlDQ2rzx5kKTK9cfcjI++LqT8GvxAS9G9PiWb+rHjMvrbM4?=
 =?us-ascii?Q?Zu9b/SEqJHUR6pKaOmI7olnfc8khphuXXPXt84fIHtHjJkPVujNP1oZI4aW8?=
 =?us-ascii?Q?RYLqekb2r+U174BtskaauqunPF+fLBFL2tDyJUajx9AzznRYG42qq7J5pQSh?=
 =?us-ascii?Q?zbN8uIdQEisvXDRM64AgSgNc8Ucbe2DOg7EvxgwBFDfHNMWNyHQgN36L4BBS?=
 =?us-ascii?Q?PnJ6Z7HljksSGoPHQSM9h5DWKTWMxX/ybqM1Psa2g/13QulR6Ri9VWgsNTNb?=
 =?us-ascii?Q?q9bnOTdj85Sb0zSgQ5FZ4OQkE9ZWF2m/HdeTia7fRtMUUWSpTE1OtGAN9ncL?=
 =?us-ascii?Q?UWXspvifN+FGhq1GtTBBq2nlotxs315VRrZ50YdSPTKwL5j8U22DlGKyDYgj?=
 =?us-ascii?Q?f7o6RHgek5gO+EkfpabiCHX3Ck80RPyRgC3cKRn4V+DTj6PEepG6q5XzlZSV?=
 =?us-ascii?Q?qm8z1sE73dZPFVUz1fkXTFckOTLXq6Pu6dRq29VId7G/QiY0uplWLbweiGig?=
 =?us-ascii?Q?Q5baJV9bQF7xITbIi16toCoNR9D0M6O/3tLtXG2Xklrvbrlx+w/a5cecRzAv?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a24313-5331-4f0d-d142-08de2ffd72ad
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:44:33.1466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIqERqyaO5vNB1Al9EoHDnTRve0wazNamFusAgdLIB2r1aRluFYxp1ypiDqRsmEdHzYOatfEBLc8zy7rcJlAaSh4rIZ0B5Q8I775mlV9MfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4235

Add a custom handle_irq() for 8250_mxpcie based on serial8250_handle_irq(),
removing PM wakeup and DMA handling that are not needed.

This prepares for future adjustments to RX and TX behavior specific to
Moxa MUEx50 UART.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 36 +++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index ceef6a5e677e..fe2906d16d80 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -253,6 +253,41 @@ static void mxpcie8250_unthrottle(struct uart_port *port)
 	uart_port_unlock_irqrestore(port, flags);
 }
 
+static int mxpcie8250_handle_irq(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	bool skip_rx = false;
+	unsigned long flags;
+	u16 lsr;
+	u8 iir;
+
+	iir = serial_in(up, UART_IIR);
+
+	if (iir & UART_IIR_NO_INT)
+		return 0;
+
+	uart_port_lock_irqsave(port, &flags);
+
+	lsr = serial_lsr_in(up);
+
+	if (!(lsr & (UART_LSR_FIFOE | UART_LSR_BRK_ERROR_BITS)) &&
+	    (port->status & (UPSTAT_AUTOCTS | UPSTAT_AUTORTS)) &&
+	    !(port->read_status_mask & UART_LSR_DR))
+		skip_rx = true;
+
+	if (lsr & (UART_LSR_DR | UART_LSR_BI) && !skip_rx)
+		lsr = serial8250_rx_chars(up, lsr);
+
+	serial8250_modem_status(up);
+
+	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
+		serial8250_tx_chars(up);
+
+	uart_unlock_and_check_sysrq_irqrestore(port, flags);
+
+	return 1;
+}
+
 static int mxpcie8250_init(struct pci_dev *pdev)
 {
 	resource_size_t iobar_addr = pci_resource_start(pdev, 2);
@@ -344,6 +379,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.shutdown = mxpcie8250_shutdown;
 	up.port.throttle = mxpcie8250_throttle;
 	up.port.unthrottle = mxpcie8250_unthrottle;
+	up.port.handle_irq = mxpcie8250_handle_irq;
 
 	for (i = 0; i < num_ports; i++) {
 		if (mxpcie8250_setup(pdev, priv, &up, i))
-- 
2.45.2

