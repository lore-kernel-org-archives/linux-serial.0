Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE8AC38142
	for <linux-serial@archiver.kernel.org>; Sat, 21 Jan 2023 15:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjAUPh0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Jan 2023 10:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjAUPhP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Jan 2023 10:37:15 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D7829144
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 07:36:56 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x36so9897674ede.13
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 07:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDEp4eKXdg/3wssI2Ou1QYWdbAeeL+58ez61t5CUM9E=;
        b=JQG3/QBq3Cu5aXSi75iJ529tcqRVrA08Kk09q8GDWwzYETH4PulFr8xpk+C1UeZP7t
         UrLrjn+b7SLfG9Si2udGHx+ijp1qO+PKXlkLon+qSFg44WBbLgoXTElPm2FOMoAVAAyu
         Pdq2KPJuJWMzkSCqYIAHt8xJDDDlOI6UBGWDd7wkns1kWRUU4y9c4XHHIk/wO6vIi7M9
         p/7coFP0GDE3ReSCIVhITHoKgwE4pjSKg7at8tnhGnV7tpYNkzx5Kev1CkxFwlB1cGGg
         DHiHBE5S1ljG9DXKG8Vkkrbj7Gjk8FDQZY6MZESqoIIusZzblTgCtCkD8lJtKpVed2+T
         zhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDEp4eKXdg/3wssI2Ou1QYWdbAeeL+58ez61t5CUM9E=;
        b=p03Zp536XbLMQpGbuzhURzLn+BwYpHThinScMxfT3X7W5Bskc3IZOGZZS3AiiiaPEb
         HuxnPb695Jhy2/ElmGCW/U0fFiClSUZDbf4+Wa4kvrZTsdY/vLmhWHKzdrXnTKKeaJbg
         0QDB4LzXGO8o3mctA+ebOQm/QWBU6iFuBGEWb4ImcWBQAEWzIaNyROp3Xa7VWELBwuPL
         QCgveo7uNOPwngGX/AFDq9oxuHIWdlGIxA0J+FvDcaOPgA/PAsHdEn2EkEIxTUm1LSnI
         ZsDrqauk/hZbhtC+PTX4AkVd+K/3vj9IfAZBSsd8XcoKZd9bZi8PjAoq3sbA7mf5KW19
         tHQg==
X-Gm-Message-State: AFqh2kqGXNd0hqVvYcfhgdfQFm9KKIr45pN9uU3iCtQ0mYfRZvTOQ6K5
        VjyXUpHN409SsSFt+lsHyt5m8NeD7Nw=
X-Google-Smtp-Source: AMrXdXvev1KC2/5QAYjPE4iBLwVSwtQqr3XKO+MlwcpsnrdjI3d6g33FMjpjdhYdk9I380ElvaGeAw==
X-Received: by 2002:a05:6402:40a:b0:499:1ed2:6456 with SMTP id q10-20020a056402040a00b004991ed26456mr19191580edv.22.1674315414273;
        Sat, 21 Jan 2023 07:36:54 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id vc10-20020a170907d08a00b008717a377125sm8187030ejc.85.2023.01.21.07.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 07:36:53 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 2/7] serial: imx: work-around for hardware RX flood
Date:   Sat, 21 Jan 2023 18:36:34 +0300
Message-Id: <20230121153639.15402-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230121153639.15402-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230121153639.15402-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Check if hardware Rx flood is in progress, and issue soft reset to UART to
stop the flood.

A way to reproduce the flood (checked on iMX6SX) is: open iMX UART at 9600
8N1, and from external source send 0xf0 char at 115200 8N1. In about 90% of
cases this starts a flood of "receiving" of 0xff characters by the iMX UART
that is terminated by any activity on RxD line, or could be stopped by
issuing soft reset to the UART (just stop/start of RX does not help). Note
that in essence what we did here is sending isolated start bit about 2.4
times shorter than it is to be if issued on the UART configured baud rate.

There was earlier attempt to fix similar issue in: 'commit
b38cb7d25711 ("serial: imx: Disable new features of autobaud detection")',
but apparently it only gets harder to reproduce the issue after that
commit.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 123 ++++++++++++++++++++++++++++++---------
 1 file changed, 95 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index bf222d8568a9..e7fce31e460d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -210,6 +210,9 @@ struct imx_port {
 
 	struct mctrl_gpios *gpios;
 
+	/* counter to stop 0xff flood */
+	int idle_counter;
+
 	/* shadow registers */
 	unsigned int ucr1;
 	unsigned int ucr2;
@@ -428,6 +431,8 @@ static void imx_uart_soft_reset(struct imx_port *sport)
 	imx_uart_writel(sport, ubir, UBIR);
 	imx_uart_writel(sport, ubmr, UBMR);
 	imx_uart_writel(sport, uts, IMX21_UTS);
+
+	sport->idle_counter = 0;
 }
 
 /* called with port.lock taken and irqs off */
@@ -834,15 +839,66 @@ static irqreturn_t imx_uart_txint(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/* Check if hardware Rx flood is in progress, and issue soft reset to stop it.
+ * This is to be called from Rx ISRs only when some bytes were actually
+ * received.
+ *
+ * A way to reproduce the flood (checked on iMX6SX) is: open iMX UART at 9600
+ * 8N1, and from external source send 0xf0 char at 115200 8N1. In about 90% of
+ * cases this starts a flood of "receiving" of 0xff characters by the iMX6 UART
+ * that is terminated by any activity on RxD line, or could be stopped by
+ * issuing soft reset to the UART (just stop/start of RX does not help). Note
+ * that what we do here is sending isolated start bit about 2.4 times shorter
+ * than it is to be on UART configured baud rate.
+ */
+static void imx_uart_check_flood(struct imx_port *sport, u32 usr2)
+{
+	/* To detect hardware 0xff flood we monitor RxD line between RX
+	 * interrupts to isolate "receiving" of char(s) with no activity
+	 * on RxD line, that'd never happen on actual data transfers.
+	 *
+	 * We use USR2_WAKE bit to check for activity on RxD line, but we have a
+	 * race here if we clear USR2_WAKE when receiving of a char is in
+	 * progress, so we might get RX interrupt later with USR2_WAKE bit
+	 * cleared. Note though that as we don't try to clear USR2_WAKE when we
+	 * detected no activity, this race may hide actual activity only once.
+	 *
+	 * Yet another case where receive interrupt may occur without RxD
+	 * activity is expiration of aging timer, so we consider this as well.
+	 *
+	 * We use 'idle_counter' to ensure that we got at least so many RX
+	 * interrupts without any detected activity on RxD line. 2 cases
+	 * described plus 1 to be on the safe side gives us a margin of 3,
+	 * below. In practice I was not able to produce a false positive to
+	 * induce soft reset at regular data transfers even using 1 as the
+	 * margin, so 3 is actually very strong.
+	 *
+	 * We count interrupts, not chars in 'idle-counter' for simplicity.
+	 */
+
+	if (usr2 & USR2_WAKE) {
+		imx_uart_writel(sport, USR2_WAKE, USR2);
+		sport->idle_counter = 0;
+	} else if (++sport->idle_counter > 3) {
+		dev_warn(sport->port.dev, "RX flood detected: soft reset.");
+		imx_uart_soft_reset(sport); /* also clears 'sport->idle_counter' */
+	}
+}
+
 static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
 	unsigned int rx, flg, ignored = 0;
 	struct tty_port *port = &sport->port.state->port;
+	u32 usr2;
 
-	while (imx_uart_readl(sport, USR2) & USR2_RDR) {
-		u32 usr2;
+	usr2 = imx_uart_readl(sport, USR2);
 
+	/* If we received something, check for 0xff flood */
+	if (usr2 & USR2_RDR)
+		imx_uart_check_flood(sport, usr2);
+
+	for ( ; usr2 & USR2_RDR; usr2 = imx_uart_readl(sport, USR2)) {
 		flg = TTY_NORMAL;
 		sport->port.icount.rx++;
 
@@ -1180,55 +1236,64 @@ static void imx_uart_dma_rx_callback(void *data)
 	status = dmaengine_tx_status(chan, sport->rx_cookie, &state);
 
 	if (status == DMA_ERROR) {
+		spin_lock(&sport->port.lock);
 		imx_uart_clear_rx_errors(sport);
+		spin_unlock(&sport->port.lock);
 		return;
 	}
 
-	if (!(sport->port.ignore_status_mask & URXD_DUMMY_READ)) {
+	/*
+	 * The state-residue variable represents the empty space
+	 * relative to the entire buffer. Taking this in consideration
+	 * the head is always calculated base on the buffer total
+	 * length - DMA transaction residue. The UART script from the
+	 * SDMA firmware will jump to the next buffer descriptor,
+	 * once a DMA transaction if finalized (IMX53 RM - A.4.1.2.4).
+	 * Taking this in consideration the tail is always at the
+	 * beginning of the buffer descriptor that contains the head.
+	 */
 
-		/*
-		 * The state-residue variable represents the empty space
-		 * relative to the entire buffer. Taking this in consideration
-		 * the head is always calculated base on the buffer total
-		 * length - DMA transaction residue. The UART script from the
-		 * SDMA firmware will jump to the next buffer descriptor,
-		 * once a DMA transaction if finalized (IMX53 RM - A.4.1.2.4).
-		 * Taking this in consideration the tail is always at the
-		 * beginning of the buffer descriptor that contains the head.
-		 */
+	/* Calculate the head */
+	rx_ring->head = sg_dma_len(sgl) - state.residue;
 
-		/* Calculate the head */
-		rx_ring->head = sg_dma_len(sgl) - state.residue;
+	/* Calculate the tail. */
+	bd_size = sg_dma_len(sgl) / sport->rx_periods;
+	rx_ring->tail = ((rx_ring->head-1) / bd_size) * bd_size;
 
-		/* Calculate the tail. */
-		bd_size = sg_dma_len(sgl) / sport->rx_periods;
-		rx_ring->tail = ((rx_ring->head-1) / bd_size) * bd_size;
+	if (rx_ring->head <= sg_dma_len(sgl) &&
+	    rx_ring->head > rx_ring->tail) {
 
-		if (rx_ring->head <= sg_dma_len(sgl) &&
-		    rx_ring->head > rx_ring->tail) {
+		/* Move data from tail to head */
+		r_bytes = rx_ring->head - rx_ring->tail;
 
-			/* Move data from tail to head */
-			r_bytes = rx_ring->head - rx_ring->tail;
+		/* If we received something, check for 0xff flood */
+		if (r_bytes > 0) {
+			spin_lock(&sport->port.lock);
+			imx_uart_check_flood(sport, imx_uart_readl(sport, USR2));
+			spin_unlock(&sport->port.lock);
+		}
+
+		if (!(sport->port.ignore_status_mask & URXD_DUMMY_READ)) {
 
 			/* CPU claims ownership of RX DMA buffer */
 			dma_sync_sg_for_cpu(sport->port.dev, sgl, 1,
-				DMA_FROM_DEVICE);
+					    DMA_FROM_DEVICE);
 
 			w_bytes = tty_insert_flip_string(port,
-				sport->rx_buf + rx_ring->tail, r_bytes);
+							 sport->rx_buf + rx_ring->tail, r_bytes);
 
 			/* UART retrieves ownership of RX DMA buffer */
 			dma_sync_sg_for_device(sport->port.dev, sgl, 1,
-				DMA_FROM_DEVICE);
+					       DMA_FROM_DEVICE);
 
 			if (w_bytes != r_bytes)
 				sport->port.icount.buf_overrun++;
 
 			sport->port.icount.rx += w_bytes;
-		} else	{
-			WARN_ON(rx_ring->head > sg_dma_len(sgl));
-			WARN_ON(rx_ring->head <= rx_ring->tail);
 		}
+	} else	{
+		WARN_ON(rx_ring->head > sg_dma_len(sgl));
+		WARN_ON(rx_ring->head <= rx_ring->tail);
 	}
 
 	if (w_bytes) {
@@ -1304,6 +1369,8 @@ static void imx_uart_clear_rx_errors(struct imx_port *sport)
 		imx_uart_writel(sport, USR2_ORE, USR2);
 	}
 
+	sport->idle_counter = 0;
+
 }
 
 #define TXTL_DEFAULT 2 /* reset default */
-- 
2.30.1

