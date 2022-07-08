Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5723DC43334
	for <linux-serial@archiver.kernel.org>; Fri,  8 Jul 2022 19:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiGHT6N (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 Jul 2022 15:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiGHT6M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 Jul 2022 15:58:12 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D8C72EDB
        for <linux-serial@vger.kernel.org>; Fri,  8 Jul 2022 12:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y89npbEIgFMcCFFs20Ua8pYHeiYcGMEN4AyDIzXv+WUNBxEu47W/L2Ar32Xsisu41VtBEbswVQWHMcdTxXvIzkpQrua1GEcUO6s9LCYujqr/jPRcbKIxvUFp+SkZR7w/iU4mC+RXVOgim1LvRqn2NEtltvKqJbrr45K4s9HbS+T3dxX/WvHbbSFI3HYeJ4IHYfJ9v06lifuSlNxEo8JU1EhZDtU4qBUUgt9JzK6gE3cqvPbNyB6e0oad7H96mwI0Y4Vdp9iSGYqmOW5R1yJGjmO0U4NWcyKU+Kcq2mUN6lshAXXy+0mdTO3fbKwt55h2PFTEPD9RAP2I6wzaYjeDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRuscwU9nEP2mRnZRg0A7fI0Eq9nAQTOpyZm5wxJuU8=;
 b=LIrRkSDkZ7N1ye6vAwtVUhx2hYggbMx0Myn7xtzHANJFRfYZf+k7mI1ke0d0zYJw0Ubex9wQ1zUOW8inRl9ZwRUJOFc1ackzzDrAulRCRu0psZyWPmBD+408338UHpB3sJn2i08IWC1Ey6GRR3FXoLSk5kreEpGTiROceCZEkiZ77Btskv5/fLi/vqeGtqe1x4HexvrVvUjjYb8ExD5/lDzRtr2VGqwkhmhbKaTPyFpvvtJ2+qGG8rxq+JkFjxxu/oxg3LY5b+xroT0+P5RdFjkDj/b8B2dJ4vlqAd+JUoFvh7Xvi+jB+X1qw+VSAw9cZ+rlEtFPbaCzddAbpaKUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRuscwU9nEP2mRnZRg0A7fI0Eq9nAQTOpyZm5wxJuU8=;
 b=GcT5Gji7uAG3ZQNvGHRGE0lukHW1FtvnKhlEWjvpyTjWPPuF9+hLGltrQmgKDhaJTbRIxL/K4xXFt0wapqcKFgx2fN/m/jSnRMh0oPciTfHtVGkvA8vTlMrbnABqK13fqQsv+tlzMM889WOdnaaHy2I8x5RNHvsODzuX/QQEN98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by DB7PR04MB5195.eurprd04.prod.outlook.com (2603:10a6:10:20::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 19:58:09 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::34eb:6533:85f0:5ed6]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::34eb:6533:85f0:5ed6%9]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 19:58:09 +0000
From:   shenwei.wang@nxp.com
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity bit in CS7 mode
Date:   Fri,  8 Jul 2022 14:58:00 -0500
Message-Id: <20220708195800.325933-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:334::18) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41eee7b0-ebff-413c-ec08-08da611c2e65
X-MS-TrafficTypeDiagnostic: DB7PR04MB5195:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owix4bV6Tbngyq1/PcJnvNjTH4NI4n+hALxX7vMnkyO82zomOUBWMYN0J5KhnQiF2o18Z1GA88E9+2dQAL6K4+WkZXeluHV2nSYvII26OXlR9pR/zwufE8fmD4/sHxmlk58wjgIW9gXz7etw87i6I2j36XJZrF5B6en563XdBEAmLuOnJVJ248uSOgd4FlyH6XN0Kq8eIOLQHbGvrIIfIaVqMs9A23PmJ4V0KIV76dNeLKqnHC/V/wgQwxFBo47pcoZluZmlxAeElKPtTrlyWq6M6k/povHF8V3b5o6o/cj4+fe/CyeUuErj6Y9mvX6YeYdLH2FauMm+VDQGA9HaJv50VLe4wXNJLsEoaLfBbRlWA7lBvUP/8c/aXMZcE5dfG/7xJ7iVbm8zO2ax1C9n6ZughDvBodwYZgCQiWHkANavgGBV0grCQq931QNkwvHRvYD3fBa6sNN32dN26zlXVyLcq7+GO3idQtbm2lhaOxBoFiWq7kMtJhhWUXRctfVFumDWI8jcO18eANls+AXqB6a2/FZIYZ4tgE5fjxXJe4TcI2SM6KZngl6E/NZal+yN4tjPTQK62uTPZz7gYd+tYhlYwlRTHTgBfUkLsf6oehfddVcouYAdUzK78j/pVyRAq6DIyKemumQp+HS3Q1AO2WRGXmxrrBhPefiZ+9mHgNYd6alwC9a5WwDBR4M7yJkxpmX1b2i8Ljr9quT7jYmnyv8CNA0bfxegMHtexvN2FaG8ovf1Q1MpVBhK99lxSopkpWcm59J9EsChScry8P756tr8VPiIHRxvDxm0UJeLX26UusdIVxthNp3FeyoD/FHj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(9686003)(1076003)(55236004)(6666004)(186003)(2616005)(83380400001)(6512007)(2906002)(52116002)(36756003)(38100700002)(41300700001)(38350700002)(6506007)(66946007)(8936002)(6916009)(66556008)(5660300002)(6486002)(66476007)(8676002)(4326008)(26005)(316002)(478600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j3IEUg26UnrU58MfT0NnRNz0GGt/wGdsv7uDr7PFq2c/LRjhvh+kDZn+/uze?=
 =?us-ascii?Q?RVhV0oJb76LU3UaJQxHFd577p9u9t7y/kt8BqxcVIWOWjz/5uuEeXMqtNec4?=
 =?us-ascii?Q?5JYgpK0XDek5x+0bQO44WOj0oHW1OE2fsjJCxFA4Sn4sbEF6ZUMrOjdpmKjT?=
 =?us-ascii?Q?fADjPAFOEGkZelGyVzCc/jypRCcEtScLg0FYCQI/uTnteZPx1VgWPogNGj4h?=
 =?us-ascii?Q?RL1vq0DiBdfdEhdPS82rUPT2UhIVTT/4xT1WzFLqPz3ZABQ9o39IH4AKrrk3?=
 =?us-ascii?Q?84+s+SSy2PkKQQ/C3w2WnY07F/BoziV/e7cBD/QW5SK4hdXaNb60B/J0Y1Xz?=
 =?us-ascii?Q?fEdiV/p8YsWFyxI4nohATYnxiK5Gw9+EL5LznsZQLgckjzCKCjdgJ/BKFfjZ?=
 =?us-ascii?Q?oO4bhPLXjQdlDLMxPet2ro6rPKWWeHTolhn4KJiawqNhfhCsOuHRPAesp4AL?=
 =?us-ascii?Q?mqihw8JHA2zTflyjkuuB6laHDITC9RMf6h1ROp4GMkvZzaptN4t4NZqY9K4l?=
 =?us-ascii?Q?XPy3vt161R8RcUf1EJ2iCjCMwcjbQa5sRcev2YpRixFDF6BKIx5o1rt8R5U7?=
 =?us-ascii?Q?5/DWBIdl4xXb/TFbt0OOkDYKtglYiXk0A0o0TXU5tQ2Mc83TrP0K+qxgviBF?=
 =?us-ascii?Q?nzAXqJjXuE87c1rFq+LtEcku98wN6DRkU6izMJlT/xfZUb5BvNbPRLm3zdWa?=
 =?us-ascii?Q?K/5EMnNA+tmTyijhp6u1VAkPqODt9OaMwDybL0NyXHQIprV0SQ2/roigVmIM?=
 =?us-ascii?Q?SdbtIDM6/g3/0d94g0EqwiZfCK9zmUjeMI3ShPePG9un+4ECI4SZ8UL/O8/y?=
 =?us-ascii?Q?J8c6E7ZQtNe/OZ+JwAKBRTAgpSKs6I7Vn4Jn86mDug1eY3Eej59DmVbaKxfj?=
 =?us-ascii?Q?wwspY4TQ9okgagq4ONrqB9O+gbolUzuU8yuBHwBRWPAcCi3nxNGC0TG8wad1?=
 =?us-ascii?Q?E/Oax3/P8GCQgohoBUobso+mSyH75bAoePad7uNk9/wvKOkbvwfz+HZQzzGU?=
 =?us-ascii?Q?f7rRg60C8hVQbySsBCmZeeSsMG/MuuKf7SKbNnKDtAlbGuvtLyq01ZCe/QGg?=
 =?us-ascii?Q?auYjPkKeFaLgwHvzSgrr4P6Yw5Wsc91gOHxG5ZvtjS0IsJdpmAJjlOiWxCY+?=
 =?us-ascii?Q?UTTodf+1bRKJmZPP1oVERsYORYjk4DCOJuVyXOUNQEjYckn04ClGxRVgHrNE?=
 =?us-ascii?Q?B15Z00K/tuZe9OOqRV/XYQ08yV9AxwVIUFtSzdUXx1qIn60hbSOkIz3DYMG1?=
 =?us-ascii?Q?iQ2LEnMRR3zJbAGcdlo/P8J87A+DTAD1lH6d+HwAsiCvN2GBAgrSj9F9fg9j?=
 =?us-ascii?Q?0xIFxbLH4B5miuXG0n6yPvtPiOMZeNbepBnA4sseAUxjLA8Am46taLn/7xk8?=
 =?us-ascii?Q?vRadJp3dqefNL1gjx7Rqn1Uf9y1O5gaPprzAfSwjSotG5pZs/SgJE5Q40n2b?=
 =?us-ascii?Q?YG4i2zW19CEEJzvU/xZxQVJ1obVkazceQUnHbTsSK1wn3eVRHnAL3jHOgycZ?=
 =?us-ascii?Q?95GXxUPLQdXvoir2DyQuuNrLBS8NpduNVcwXsQdnW6sC3I9cl6jiFlnw+uAO?=
 =?us-ascii?Q?ViyzmoU5SMsoCquiwOmzioj91Znb4IL8dK8TzI4h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41eee7b0-ebff-413c-ec08-08da611c2e65
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 19:58:09.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0EMlEoTpEwj5pKDvLyYv2GJwaqRfA/vvoO9hg+Bn3Fp8pzCyCdTFKc5BLZcVeG8w5LwXOSlg1WHuzz+OItoMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5195
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
changes in v1
- fix the code indent and whitespace issue;

 drivers/tty/serial/fsl_lpuart.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 8fe0494d4057b..a8f59fb27c825 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -274,6 +274,8 @@ struct lpuart_port {
 	int			rx_dma_rng_buf_len;
 	unsigned int		dma_tx_nents;
 	wait_queue_head_t	dma_wait;
+	bool			is_cs7; /* Set to true when character size is 7 */
+					/* and the parity is enabled		*/
 };

 struct lpuart_soc_data {
@@ -1022,6 +1024,9 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 				flg = TTY_OVERRUN;
 		}

+		if (sport->is_cs7)
+			rx &= 0x7F;
+
 		if (tty_insert_flip_char(port, rx, flg) == 0)
 			sport->port.icount.buf_overrun++;
 	}
@@ -1107,6 +1112,17 @@ static void lpuart_handle_sysrq(struct lpuart_port *sport)
 	}
 }

+static inline int lpuart_tty_insert_flip_string(struct tty_port *port,
+	unsigned char *chars, size_t size, bool is_cs7)
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
@@ -1227,7 +1244,8 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	/* Finally we read data from tail to head */
 	if (ring->tail < ring->head) {
 		count = ring->head - ring->tail;
-		copied = tty_insert_flip_string(port, ring->buf + ring->tail, count);
+		copied = lpuart_tty_insert_flip_string(port, ring->buf + ring->tail,
+					count, sport->is_cs7);
 		if (copied != count)
 			sport->port.icount.buf_overrun++;
 		/* Wrap ring->head if needed */
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

