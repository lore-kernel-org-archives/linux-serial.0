Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1B2C433EF
	for <linux-serial@archiver.kernel.org>; Fri,  8 Jul 2022 19:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbiGHTP2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 Jul 2022 15:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGHTP1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 Jul 2022 15:15:27 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A28E45042
        for <linux-serial@vger.kernel.org>; Fri,  8 Jul 2022 12:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQ7mvT2i84oX9PsWXZZkaz8Cu00nblqYp+1sqKfPW8SV0uNAVPO9ARQkdPxEysfxXLBV4UyM0/2he8RwO9asxnypSb3KYKo8cnDoQTUZHst89L/pMsaZLIGrQblioXy4qo84X4BorSYwR4SoUvSIS0yG41/HOLbh5r8BjlEEvPtv7dmLjym8OLhDr3jwPlBQbcs7dUgZuQ/0Bej9Ix1xfO7IRmqEmaFvExzbN37vnbqyeclkYD6VJVq4xj6ylcBIfbEOgDc+XEi+PbQ+nD2gStcL8wsGgyilAuRy0owiDRI3k0e7+pCdQ+bh3Zbj2I1N2O+F22SA5INAEX2QQqmi4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLOkr9E+uf2xoQCeAS/kmOFiih+Kc7HZ3/liinMrtUw=;
 b=ZN/lyhgueH+IRutjqu5Th2BRYDCin0x0Hm7aRxtPO2uznOJ8f/Uq3CKDAILbybhgcMtAfmCxtMs4YLVPsVYZGsrIHYGR06NDfJmANHmzuza5fsPnrnmweKETpSbTudPCQ/9MmlbrwUDRgvQQCv3Jg9/341pb7Krl4Bi20bjvntAxS6bykIGgTSkkfRi7KzCUc0GMG6Z/IL8hXkkmpg3b2thJckX8scEbNMHEOGEhNQGVk63HCfj6+MB3kHHzSGgKmeyHcs6wkSIXQubxdZ6FLYLWYu7xKhj3zJEjh3H1Vz5NZ4xFd8OWj49CrIjkWNquTzZLsuVBSUwXr10nxxCAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLOkr9E+uf2xoQCeAS/kmOFiih+Kc7HZ3/liinMrtUw=;
 b=I9pm145e5Yse6RAupnUywqS/fcTbCWUK9bXU7xegJWvFP27Yrg250AlkchClnqp1GaK/lOjZ3vNM1+CR7kyv+QrUDl8PUUxleLMm2Qp9W0ZSvWfbFdO0uzKRUKDtQo6abqpaCAZxYAxidthQlFsH+6A9jaOYFtsnsqfC76Ld/wM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AS1PR04MB9503.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 19:15:24 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::34eb:6533:85f0:5ed6]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::34eb:6533:85f0:5ed6%9]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 19:15:24 +0000
From:   shenwei.wang@nxp.com
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH 1/1] serial: fsl_lpuart: zero out parity bit in CS7 mode
Date:   Fri,  8 Jul 2022 14:15:04 -0500
Message-Id: <20220708191504.324308-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::16) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 860fb0ab-5663-4c46-9a1a-08da6116355f
X-MS-TrafficTypeDiagnostic: AS1PR04MB9503:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TIXEhZJAcr/T0mX42QSqYI8Ta+Trn1rEs4E58a2IcCRP/8bEicOzc7Xjngv72AKNYG2k+DrrrR5kEZb7VYw42IUC+R6Pkqtes8bPZ5DY/2Rcv7rDTT8zX2xJ6Bm+an1CDncTu67EYER5rl+tROzHxdTADAZ2m1AARVSR6WAoF9Xhj8IcYDlTYN1wSACki0dcVW9sJtw8S6bScFQZthhdLh7s2LKP8xliTP/Z/DKef0t0U/zYBmgZcQpldpOQlelNfROSRe+BlNXb33jtfdYho8ms76GplcmdzYGmHwE6So5HEGFXpjoI2oA8m7vZaBMJMj1M1YVrV6Dnj8d84gc6Co259+LI2EEquSVOVAXhmrE7ea45veW5SUtGPWpMOBWUG4p/Bk8AD6vWN3T9K30odAHg4IhtJ08JeLPZVxaGixjkUPh1DKWf7QNMLj9NoKnatxp0VKVlodlqreyw5Y95OiYcCjLjZ6pF5TmJFkA7b1J4KdcoLBMLIR1NLLx/3jEqjT4xAj/rJD9G72dmvy0KxLP18rnn1uEy6KSC5g5oJpd4Pn2UawjCevcQdRstnPk8sczpBHGXSDexGzjfx3XS6tDZJ4LefwZClAGDbkyuQKbYPtmA9WSpl8OQYNekSlTgMt995psmOFnz16ffuWkY4PVng/Os/cCmvcx57ToIfyNUjEdl+bNgGmmmGMnWrZkhuCGD3J1UdXV5czh4T8OdSCfGEoOFWmgiShuRYgBOa39zY3I0vSp3DTOXa3tUBPNjPnjL9ydf9URxTkgXmrEwGdwYowjbGCJUMKvIFis2A86rXoTwvkEk6NpdqgsK97/s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(6512007)(478600001)(9686003)(86362001)(8676002)(66476007)(66946007)(66556008)(6486002)(8936002)(4326008)(83380400001)(38350700002)(1076003)(38100700002)(55236004)(26005)(186003)(41300700001)(2906002)(6666004)(316002)(5660300002)(6506007)(2616005)(52116002)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eN5V00DElD9d7Usn21jC6rLFXM+aRoQmF68Qk8Dvc2KHGjaGv0mURuaJ1ri0?=
 =?us-ascii?Q?c/cOlveaughn+7av8ta5EVq8Z2hf91bfOiGAxO0mxaK7labc/OqGPSZ0DOAi?=
 =?us-ascii?Q?TMNkqctpnHjiXSqIKqvM57wBdJ9dH4nwPoop22u62DcTbbkyw+4n5xdV8M3X?=
 =?us-ascii?Q?MdSyT6UJWQCMqMt2sqC3fWnQMgcE48/uzEfMealtOdunbuElZ/k0jxi4fyKx?=
 =?us-ascii?Q?7i83ppR2LqxxPnCfUMekXjhyj7xXgFyF7Me+81OVjmGunweaVjODgb6L0OQZ?=
 =?us-ascii?Q?nNVAi/Z/k9YkidX1S44MD+4cGc9CH0wtjBqICxk71EFo/HMTSVIKeOHBgRGc?=
 =?us-ascii?Q?D0Z0Crjputge1/HdXrRc+6K4rVmb9sufkzXIXuLsxPPIuhzBqZ8jOdqNvywA?=
 =?us-ascii?Q?tXtOukIMnComlbVPbL7QyKuK1dwTmk/AR7CueRlKUCWb+cGuQWnw3GQzstrY?=
 =?us-ascii?Q?7lP24rRrDPZJ0F3YPjyqyizNvwNCW6h2StLfM1GKJVogciLcHeWpQHLoCsp/?=
 =?us-ascii?Q?MSmMNQEPZGCgDisQEQkZNSYlQVBQ67kCgMbBwswvNFu/uDL3DyP810O85K9w?=
 =?us-ascii?Q?JyxAPTeOoSHh+fKM69P+G8AjVbwACvw16XcKkaf3vu3rnmsakas4eRGbKL2Y?=
 =?us-ascii?Q?Nb7IPzbZb764QzFS0sBsXEhX4ELsJrAeOUdJdofAJ2BHMYjciVzdjodcYjqT?=
 =?us-ascii?Q?wv36r4bYuZrYiy34l69L9MHoG8iuVq5WJwEWOPD4S+wYrD6JHxVVoUe5OY0a?=
 =?us-ascii?Q?xmeJKVXICvD6EV+zXs9whBKPJCEKAQkWRURJxSJ/WY3vTxjtcqcVlw6TCeXN?=
 =?us-ascii?Q?sHv/oUYwVG5Y0nXXqMIEkOmwS6fPoMmUrYieNas0gnjh4OpQ6dpQpXtd/S1C?=
 =?us-ascii?Q?glSAH+lB0Ceor6T6kaxC9x3yGe38CzWSLO6TEkTyDIWS0eR3JgpUd8fD9xET?=
 =?us-ascii?Q?dH1IfDyaiQJ5lgkts8fGbWtlDRnHoUTE/kC8Q0bkSLZs+S1v0LoWGDSak6U9?=
 =?us-ascii?Q?61q1hv+NM8QpQBEpAgE1p2/j5QpvbWr0A9BEqGBjmaqra1SucaHqBx+vGC+x?=
 =?us-ascii?Q?A8E9eQfhWX6RGrjjTKNm34tC0bcb83c4Bml901xFOlwHNb46uR1dW2f2CK7p?=
 =?us-ascii?Q?btJNJ0Fah4xartD21QklxEg17R6xLbSkdDY+Kp23KPX1uCsmh0znaDMPXPov?=
 =?us-ascii?Q?tz21krskzbIzgpleH3H2uLzzOwwYkaglIpK1cDzjq8eZh0ttCc0eC97/LCEy?=
 =?us-ascii?Q?LEnxcOZ662OEikD2ZYVXsUD07Lij3VEK0xyzu7mmOADPzwsPLdTWGOrCbuF+?=
 =?us-ascii?Q?RvxmlR+dR2QfkhEnbidpGOVxds9WXgYIBgQkN8WiWnV3YCT7fQHMXm3qQLLc?=
 =?us-ascii?Q?RzTnC5HwIHuOK7L2JWr5PYjDtAO9YSSjpNaHij2M2C4hERwSdjeBNyi1OSb2?=
 =?us-ascii?Q?Kiq3R184ICRzA+zIFfbko6Jq5vMS5YgEtGnYTV53qsINEBqW3Ug9PWq0Rtbf?=
 =?us-ascii?Q?Oe297ecQuEukWQWMwCYxMa3bHIMrzeLCLmx9JtM+5LhPAa9tkX7yEEaDj4pV?=
 =?us-ascii?Q?ih6JJ5kG+ewjvuXu4IbsnM3PoJbiZpqA6LPM7+MSWOVo81o5yNQk2wABm1mG?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860fb0ab-5663-4c46-9a1a-08da6116355f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 19:15:24.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55FKwLQ+D8sN6oiI3761n1IhIYVkRci0m9WoWU9JGd++qIp8FlKurMUHmFFAVYJF7dSuksCN8z3NIwxtHxp9mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9503
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The LPUART hardware doesn't zero out the parity bit on the received
characters. This behavior won't impact the use cases of CS8 because
the parity bit is the 9th bit which is not currently used by software.
But the parity bit for CS7 must be zeroed out by software in order to
get the correct raw data.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 8fe0494d4057b..202431f75e913 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -274,6 +274,8 @@ struct lpuart_port {
 	int			rx_dma_rng_buf_len;
 	unsigned int		dma_tx_nents;
 	wait_queue_head_t	dma_wait;
+    bool		is_cs7; /* Set to true when character size is 7 */
+						/* and the parity is enabled			*/
 };
 
 struct lpuart_soc_data {
@@ -1022,6 +1024,9 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 				flg = TTY_OVERRUN;
 		}
 
+        if (sport->is_cs7)
+			rx &= 0x7F;
+
 		if (tty_insert_flip_char(port, rx, flg) == 0)
 			sport->port.icount.buf_overrun++;
 	}
@@ -1107,6 +1112,17 @@ static void lpuart_handle_sysrq(struct lpuart_port *sport)
 	}
 }
 
+static inline int lpuart_tty_insert_flip_string(struct tty_port *port,
+               unsigned char *chars, size_t size, bool is_cs7)
+{
+	int i;
+
+	if (is_cs7)
+		for (i = 0; i < size; i++)
+			chars[i] &= 0x7F;
+	return tty_insert_flip_string(port, chars, size);
+}
+
 static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 {
 	struct tty_port *port = &sport->port.state->port;
@@ -1217,7 +1233,8 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	if (ring->head < ring->tail) {
 		count = sport->rx_sgl.length - ring->tail;
 
-		copied = tty_insert_flip_string(port, ring->buf + ring->tail, count);
+		copied = lpuart_tty_insert_flip_string(port, ring->buf + ring->tail,
+					count, sport->is_cs7);
 		if (copied != count)
 			sport->port.icount.buf_overrun++;
 		ring->tail = 0;
@@ -1227,8 +1244,9 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	/* Finally we read data from tail to head */
 	if (ring->tail < ring->head) {
 		count = ring->head - ring->tail;
-		copied = tty_insert_flip_string(port, ring->buf + ring->tail, count);
-		if (copied != count)
+		copied = lpuart_tty_insert_flip_string(port, ring->buf + ring->tail,
+					count, sport->is_cs7);
+	if (copied != count)
 			sport->port.icount.buf_overrun++;
 		/* Wrap ring->head if needed */
 		if (ring->head >= sport->rx_sgl.length)
@@ -2066,6 +2084,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	ctrl = old_ctrl = lpuart32_read(&sport->port, UARTCTRL);
 	bd = lpuart32_read(&sport->port, UARTBAUD);
 	modem = lpuart32_read(&sport->port, UARTMODIR);
+	sport->is_cs7 = false;
 	/*
 	 * only support CS8 and CS7, and for CS7 must enable PE.
 	 * supported mode:
@@ -2184,6 +2203,9 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	lpuart32_write(&sport->port, ctrl, UARTCTRL);
 	/* restore control register */
 
+	if ((ctrl & (UARTCTRL_PE | UARTCTRL_M)) == UARTCTRL_PE)
+		sport->is_cs7 = true;
+
 	if (old && sport->lpuart_dma_rx_use) {
 		if (!lpuart_start_rx_dma(sport))
 			rx_dma_timer_init(sport);
-- 
2.25.1

