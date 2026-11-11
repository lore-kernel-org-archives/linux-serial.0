Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794428335;
	b=NwxOxliutGAR26ScqEzETeB3NRUDv8Y+oqEOc31ahbCbj5f1R9wVeF69FAw7s+tPukeA
	 ZudnHbLiu1pCKkDQlgBqkRP1/i4Nim/M0N0XXHa/nrjV5drmx8YxX4p6fmaRqLv/Yrxzd
	 53rHfkAuuapP41O9wBymIKQOuJjSy7IKI8i9c6TYBm+4pcbqwELZQD6DYGPWdROGv618J
	 eE3brNAsuwEuz/82tZWiNRCTHwpmiabBwAdvHexwXkrxWlwKovrX0EGMzw33uaEjN2b5M
	 e4Pd+cFLouaIEd7xZhZ1GeONtOR1ZtFGyiymYNPjTSeUHgnURCGiKxySgdiY1xemP9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428335;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jDJhwP3zzkSeugxyHK4haAYh3p/yLpqLeSFpr6cxhxg=;
	b=doWYWTn1yTwdIgqs7x2a1vq9JreXi67VhwdZV5oOISk/lvZAEUPc0IxMvApQ/VXL5a2C
	 SodVCEJ4XJQzWy4rSyMUUfiNhZ2ewYNChnuP7yJtEPlvI8fLQrTtG/tiKnIjPF8tnmKMK
	 2yJBwgxAAFTenV3wxVzzKfuf+DPLZscCokNruBsXKqjAr7214ljoak7MNnx/+snB04sp5
	 3hEu0rt0rIiHAVP1sx+NJpUS0Snag3tP5yPxobQSRlbkXTaUFAhr1exp49DUUgmByA3dc
	 kyciSpQjsN7yEOkbOFodZ9tp/OCXk40Kzmx6AdOO1BynuGAJGZaJUsVtYie26agREtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="Z51OGi/W";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.49
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011049.outbound.protection.outlook.com [40.107.130.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B029B606A31C;
	Wed, 11 Nov 2026 20:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B029B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Z51OGi/W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmRqQZmrTq9fbIIuXOOsYyWcIIogT1tuSjFmE7XITeHUE8EyXer1HJ1dOfngjt2IcsJEhWbY78vvYNAnbflDy2kB2cfdYBqoU+bq2cxP845/ln4IkF5z1BaCecLFdLNQ/tcUAwj/Xp70k1+F7+H4wm4E0MXp5OnZKazxw1V2JoYMOEukGJ+eBKkrmCbB1TohdYICwvfkhN3ePdTKHGC1a3kJQtYwRbaPKdESjq8bvkvPBWLAxu8v9ucbD0CghRI84ZyzM3BWQH8mOAi606AolSr92SxLpaa2Qv/PqS/pO0aCGev73NIAwUhP3LjeGawSMM08INEs+z9bJyfGtqcpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDJhwP3zzkSeugxyHK4haAYh3p/yLpqLeSFpr6cxhxg=;
 b=fV0Aq4a8zFEsg0YVqry49I21eIuOcyr3ARji6MLSI4VAopXC86E7lPDewWi74pwRbYo4qqfisBgzG9tBmE25btTR7DCrV/u7yabS9MWzML7UBnJZ8O1eVrG4xBbu7ZiiCsJV+BB8Uiw5StLeTQVFauKwY33DPgthGyBwobMlP5K8X5HwjX2V7pHbvbJMxhioBfm18THNTfNxqGGVeNOw/ZtnFgA2a13g/JxOnThM95Y3u81W+mmrgEmtcIDK6VsqpnvPpnMtGqLSRs56+95zw1BzGUQY+mefcZsUm33pJ4Yip1DDuhaXdW9xhidsAkVwr8mb+QfVfmYOQkX4Jdh83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDJhwP3zzkSeugxyHK4haAYh3p/yLpqLeSFpr6cxhxg=;
 b=Z51OGi/Wnf+3yXrTBT2X+cayPHxt1TEktkrFbHSTbZVkhXi/IgNJpdAYjTR9pRQBYMYNjRVHwg878mFu/Oxoidf9nzSKyFwQHXsOP6guJDMfBwwv+TpaPMKDHqBvCwX9XFUelr4u5iwJuPAO6DXre3BXXo2gOkvbfDx6dTu7t+SA6T6J4SFYa3W4H8EsYQ9R7mbehIGZALGUZXsUiRlK8mpcop5BfFO7s3rFEtf3hHmPYVCf0lcnAv5hs/gDndfWwJOgSTxOUftGp4B0ylhZ74zOCk1uVBtDzdkxlNYwFF9wYNp2zYtS4I3AfdcQb/W1yYqAY9kJo1ZVvfuHZtZKPA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVXPR04MB10518.eurprd04.prod.outlook.com (2603:10a6:150:1eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 20:18:43 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 20:18:43 +0000
From: Frank.Li@oss.nxp.com
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kartik Rajput <kkartik@nvidia.com>,
	Frank Li <Frank.Li@nxp.com>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	=?UTF-8?q?Stefan=20D=C3=B6singer?= <stefandoesinger@gmail.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] tty: serial: amba-pl011: use dmaengine accessor API functions
Date: Wed, 11 Nov 2026 15:18:22 -0500
Message-ID: <20261111201835.3846654-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:510:2da::16) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GVXPR04MB10518:EE_
X-MS-Office365-Filtering-Correlation-Id: e1830c16-1163-40da-3892-08df4030fb7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|19092799006|376014|23010399003|921020|10067099003|11063799006|261021123027099003|261009223027099003|261026121527099003|261028144727099003|261022105027099003|261009221227099003|261021121427099003|56012099006|261102123227099003|261026140227099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ukm5mgSOq71oHnwx2oPXlMJokCsns/IcdI/f/MBawe+R9gcyXt9+aum2X8BCe7OOkylCuNIM0e6PhgClc3dgsMIQp8Wc/raFmhwfQtDFu/XUvZrn+KE8TGuuxPCK2lmmrFZYKgtMkcpn2FPw6bQkRWm6c6CQTZTnXaZVBNQo8uF/i7jVpCDrec60YZ1C42piiEF3D1yJauqao5whHOg+iGx9OPnjGA7lj3LWlZGiEJaYfahk5zJSCwT5Y3y7GvouTGMlWvzVdVTcoqA+UvLFu2/p26RMTGHgfPEullx9R3Dl6GlcqOk/PKOyOP4PqNV6uk7NJPXqI5zYDqvlTYR4wBLAeAQ0qJxcC8cUaSbCn/OjmUa57b0N2RV5D2z46BqDgQxffWu3MBPnXFJGLuxU2fDWRBWdGZ6bepFLDCUq5PQPLOiloy4RziPE/VSZ0ECbVpVJKx5TeEVBxY6RblqZijks/fFtxq+iE30KmjUG6DVMI0VKreq3+EqouJW9pui05GsZv+ngFN5Eef6wzHAL9QKMYif4QBADtFesFx4WJfgZVrD0YOOhK6bfaoyQsxDxkQo5ozfCEiNiZwGlHPBI3tofgRGwvrXjveYWPK+fGOUfpOqcAJsulO0BhA5ycjIAARB6TtPMZDMBONQ7nmlNlPEzH6hyRUWDyxv1+r/D9st59FTLLjjRNyQmJGNG7UqpQjD9F8s0RkPZ3+Xw0jLx6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(19092799006)(376014)(23010399003)(921020)(10067099003)(11063799006)(261021123027099003)(261009223027099003)(261026121527099003)(261028144727099003)(261022105027099003)(261009221227099003)(261021121427099003)(56012099006)(261102123227099003)(261026140227099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?66wHCJgaGcqlQ1s7XG60zifBVJJQ4wNjZBnktnL9Y23mKU5HaA729YB/sJMm?=
 =?us-ascii?Q?GTM3VtWvx1n26Ce8TT655J5CujkCAIpFHWadmZcADCUqEUO42fl5V1BdiWqW?=
 =?us-ascii?Q?E92yADLVYDxEdGWsxpnX1uG4vdUHMVPq+XglKkOGP9Zmrl+hd2Kwt0buhqPB?=
 =?us-ascii?Q?3wjflwW/jM9JfJk9prLhlGt+3HBnmSttIsaqiG/iS59AhTS1ImjeP0DXSOLD?=
 =?us-ascii?Q?QkVB4M/li1xEf0yzpw55jA5NztQovc9/S3eTkNDcMIGnBJNn6Id0kGkx9P3q?=
 =?us-ascii?Q?5u5g9waPfD3iMSn0rrP4LO0q48EkQlY8bR6PdF4m4KEaGbI7qXhkD3ob3jzK?=
 =?us-ascii?Q?+vmu47UE0lJCT35/+8SYPVf8oyGgvwF24iuc0g1Z2bFGvuEzXBmNVfiNF6Tj?=
 =?us-ascii?Q?ITHZgzdDTNCYVIEjvDiCNpkNWXLitTQo7ym+hMl0atmz/i1W2SIb+Z+yjlbT?=
 =?us-ascii?Q?pua9F3Zll1+LEeSqPMcWB0kNPzpg0RYpxxS6JcI+EIo0VlDuKHUGPzYuYES/?=
 =?us-ascii?Q?xAiufsnQwJnw1yLlRjWJj2GbWoN73ZPZgHKhf5J/WW38TnXrwTECmcsH87CE?=
 =?us-ascii?Q?fu3m6u9CuFdQOP9MK76WFCtiml3KmzJeCSR6nzdS6bDU4LaFalBZAFUrpD1D?=
 =?us-ascii?Q?JYSQiXopggDo/aH6I+t/w82rz2kPgYHMwyY2lCCyif/O815l5XvxoYgaiE11?=
 =?us-ascii?Q?QFgJLfdTStikCbc8PST+DN0Q44k7KdumxY7yCPwGCkZmla43QEGJX1aJ+z2k?=
 =?us-ascii?Q?pl7SHQUQFUipfiY8bg1UtNVuV6r2/rZvkAIfItB48GC7Ho08dojWuDt9PtbU?=
 =?us-ascii?Q?3UvX81ywpblelwuExDxDu8NyIfGMXiiLbmAE0oVaYXxw7jgpW9zbay46H4D8?=
 =?us-ascii?Q?Je1zUlEB3NS/x4x+27AXPGxVASXneYVHWgOVp8tyz7q8O+mRY5KBUZ84fm85?=
 =?us-ascii?Q?WY8qLlqE6vaeRRO67G0/p+pxbkWrSKOSCwUTXSnUnshCaWRrmKAD+bOj04FI?=
 =?us-ascii?Q?H805NmjqgLofpm3ywUz9h+PaxcJJMGbwm9H1WhAJQDzZse8SyXnfYrj5Lx7A?=
 =?us-ascii?Q?++n/O75ePN5JwrHXfrlndMZtMnjLCB2yx/66iGVK25uX33HdCg9mEW92trTA?=
 =?us-ascii?Q?WJdc/VbbQZs7SDxuwMB0OerZIyt5dob6LaDV4Hk5ICgnfjG8JyeJPUMH58Lh?=
 =?us-ascii?Q?wPjc/VqOYHGL5z67emN6c/aNAAeyXIOrkCm02twQ9xcVtjgNFU3GrqX/+Wlw?=
 =?us-ascii?Q?32QugckOLchIViSFIVqssIu9Fy9AVhPMnTZR73mrbDd6K9/JJeRYepGJfDHl?=
 =?us-ascii?Q?NzVw8OCpFdEYViVfkyrEjnZafTy0kv0e3G9Pq0+7tADMlKa8ydSymSeMqLf7?=
 =?us-ascii?Q?kIwCCjuUZ2LNhM5i9w2sFcRkyeN4wALVl4IbKTKNKznFafVjejFDj9qJ/1TH?=
 =?us-ascii?Q?4PdR37hN+z9ulEB7nb0t7Lv10VBxZgOJWQHRfmcMWRDdyocQP4h1JKphcVOz?=
 =?us-ascii?Q?kIzO9dvyGloH84DGCaNcyoyP6Rh51k/qU5R/+eajvp8UjZg73xuPABWHwayA?=
 =?us-ascii?Q?6Gnjg8a92qTvU4zNPTlQLfd5Dkq+eGELqMWmopucuF4D2HaJLK5P/nUQ+yFv?=
 =?us-ascii?Q?OcV1EOZCANweeXqbM20Sq7+M+h+Ll9wGpOjBCaGY+a9DoM5KvY0+AeC6VGCr?=
 =?us-ascii?Q?s72/e0pbwlmgTkFHAHMowZfgx2zS8xICd7Kxov5vH8N46+5ybxc8oF2LAmCk?=
 =?us-ascii?Q?nlZ8c6+tkUSUrqxgGLfnwOOg9GWlKLseq2eYz1x7Qc0ntA0HV+y7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1830c16-1163-40da-3892-08df4030fb7f
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 20:18:43.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XakcTGSfzADCt4JF3zoyKBkfHZfSE1l2VwImoo7jT/UebI0oxtLaA48vlpCdw2d4Zc/g4XP/QX5t7LK7BeWGNtWG6KEwcNUk1llf53M9LujV1QyQ+OH70LKaN67mh/93
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10518

From: Frank Li <Frank.Li@nxp.com>

Use dmaengine_get_dma_device() and dmaengine_get_copy_align() accessors
instead of directly accessing chan->device struct members. This follows
the dmaengine API convention of using accessor helpers to decouple
drivers from internal dmaengine structures.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/tty/serial/amba-pl011.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 1e04e6398c973..7acccb096ab57 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -655,9 +655,10 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 {
 	struct pl011_dmatx_data *dmatx = &uap->dmatx;
 	struct dma_chan *chan = dmatx->chan;
-	struct dma_device *dma_dev = chan->device;
+	struct device *dma_dev = dmaengine_get_dma_device(chan);
 	struct dma_async_tx_descriptor *desc;
 	struct tty_port *tport = &uap->port.state->port;
+	enum dmaengine_alignment copy_align;
 	unsigned int count;
 
 	/*
@@ -689,13 +690,14 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 	 * requirements. Some DMA controllers (e.g., Tegra GPC DMA) require
 	 * word-aligned transfers. Unaligned bytes will be sent via PIO.
 	 */
-	if (chan->device->copy_align)
-		count = ALIGN_DOWN(count, 1 << chan->device->copy_align);
+	copy_align = dmaengine_get_copy_align(chan);
+	if (copy_align)
+		count = ALIGN_DOWN(count, 1 << copy_align);
 
 	dmatx->len = count;
-	dmatx->dma = dma_map_single(dma_dev->dev, dmatx->buf, count,
+	dmatx->dma = dma_map_single(dma_dev, dmatx->buf, count,
 				    DMA_TO_DEVICE);
-	if (dma_mapping_error(dma_dev->dev, dmatx->dma)) {
+	if (dma_mapping_error(dma_dev, dmatx->dma)) {
 		uap->dmatx.queued = false;
 		dev_dbg(uap->port.dev, "unable to map TX DMA\n");
 		return -EBUSY;
@@ -704,7 +706,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 	desc = dmaengine_prep_slave_single(chan, dmatx->dma, dmatx->len, DMA_MEM_TO_DEV,
 					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
-		dma_unmap_single(dma_dev->dev, dmatx->dma, dmatx->len, DMA_TO_DEVICE);
+		dma_unmap_single(dma_dev, dmatx->dma, dmatx->len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		/*
 		 * If DMA cannot be used right now, we complete this
-- 
2.43.0

