Return-Path: <SRS0=bTed=DL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDB1C4363C
	for <linux-serial@archiver.kernel.org>; Sun,  4 Oct 2020 16:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994FF2068D
	for <linux-serial@archiver.kernel.org>; Sun,  4 Oct 2020 16:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="oqgm8R3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgJDQM1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 4 Oct 2020 12:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgJDQM1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 4 Oct 2020 12:12:27 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E531C0613CE
        for <linux-serial@vger.kernel.org>; Sun,  4 Oct 2020 09:12:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so6895352wrl.12
        for <linux-serial@vger.kernel.org>; Sun, 04 Oct 2020 09:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYuhyAORLEs/TuTZaeKFtUnXW5HigCtXRrY239415Ag=;
        b=oqgm8R3KGCmZtDtySorhUXgMkoWySsCXpy/AOPJ6lOmObuxyWrZhFyVhFBOxPoalhJ
         Podenju79quGRGzrdDqWXnH3Aniv7sNJAIUYcDpOXbPHLN7pJ2H1m+twsdGrwhWKr3rL
         m/0g8c4lW8EZ9BN5oEM1HHwz/CBJXOeV2Tsa6LR4dWZD1XAWs+UmhN3FVNULRMfxUkAn
         C2v9eK9AJh5Jc2NFhGzZbIs3x5FKQpQxTo5p8wRpm89B806Tr/YvPYBOkMVEDRPX/sUA
         kHi8/VJNEclc218AZkmC60OlhclSq+lso0XFBvvP4nYPWCsx4Beri+52PK5aGdAsxMsH
         d/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYuhyAORLEs/TuTZaeKFtUnXW5HigCtXRrY239415Ag=;
        b=HPY9lx1OcJIlEEAhIE0usV8k/PfCfmBg2zWuwt8sHY9I37e8NwGYbPrZuES9FvvVG8
         yQJTN3+b1x/BzJXoBuMwvb8haoAuRpLAqHCSCrACopK3y4CvkPDsfmy8Y0uctXKPSCyu
         yGFZX27df3ea8aYxYFr1SEBaWCXwOfOe6b+CWAmMVYreg0ukHqZR7+1PqnKKdNGETGnA
         81tF5UGZAf7cxFLzt6PVy3cgJx8Kgl63fHMmq/wvdx8R3tcq88vFuGI1CRHjUnP1yZWl
         yqaQbmREQrng7rMcs4fgq3+1wbzENqw0Wi898pea3IXYgh0JpbV8zVD2gYvSNHSRaHiR
         2Alg==
X-Gm-Message-State: AOAM532uVAJz8OKJeLmZ6LZSHOKIcr1o0IZ4xRRV12Y2i1yL/rCHLgom
        N/eif33KSlGfND5VxSrX8dSsCg==
X-Google-Smtp-Source: ABdhPJxJfR0VyR+/DI+GJ2x6li8L6SyYy3DemkRBh9qMf/9cfUuwLOuvYmxhnPM6whmhWFQj3hFgsw==
X-Received: by 2002:adf:e9c3:: with SMTP id l3mr12915289wrn.63.1601827943852;
        Sun, 04 Oct 2020 09:12:23 -0700 (PDT)
Received: from dfj.4.4.4.4 (host-79-20-236-235.retail.telecomitalia.it. [79.20.236.235])
        by smtp.gmail.com with ESMTPSA id a3sm9132644wmb.46.2020.10.04.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 09:12:23 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, peng.fan@nxp.com, michael@walle.cc,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH] serial: fsl_lpuart: add sysrq support when using dma
Date:   Sun,  4 Oct 2020 18:11:44 +0200
Message-Id: <20201004161144.1307174-1-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add handling of magic sysrq keys when using dma/edma.

Tested by sending BREAK followed by a sysrq command inside
a 5 secs time window, by:

echo 1 > /proc/sys/kernel/sysrq

BREAK + h, t, e, b, c

Tested also sending a command after 5 secs after BREAK, that's
properly ignored.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
 drivers/tty/serial/fsl_lpuart.c | 57 +++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 7ca642249224..25e5f0c8d935 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -978,6 +978,15 @@ static irqreturn_t lpuart_int(int irq, void *dev_id)
 
 	sts = readb(sport->port.membase + UARTSR1);
 
+	/* SysRq, using dma, check for linebreak by framing err. */
+	if (sts & UARTSR1_FE && sport->lpuart_dma_rx_use) {
+		readb(sport->port.membase + UARTDR);
+		uart_handle_break(&sport->port);
+		/* linebreak produces some garbage, removing it */
+		writeb(UARTCFIFO_RXFLUSH, sport->port.membase + UARTCFIFO);
+		return IRQ_HANDLED;
+	}
+
 	if (sts & UARTSR1_RDRF && !sport->lpuart_dma_rx_use)
 		lpuart_rxint(sport);
 
@@ -1006,6 +1015,37 @@ static irqreturn_t lpuart32_int(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+
+static inline void lpuart_handle_sysrq_chars(struct uart_port *port,
+					     unsigned char *p, int count)
+{
+	while (count--) {
+		if (*p && uart_handle_sysrq_char(port, *p))
+			return;
+		p++;
+	}
+}
+
+static void lpuart_handle_sysrq(struct lpuart_port *sport)
+{
+	struct circ_buf *ring = &sport->rx_ring;
+	int count;
+
+	if (ring->head < ring->tail) {
+		count = sport->rx_sgl.length - ring->tail;
+		lpuart_handle_sysrq_chars(&sport->port,
+					  ring->buf + ring->tail, count);
+		ring->tail = 0;
+	}
+
+	if (ring->head > ring->tail) {
+		count = ring->head - ring->tail;
+		lpuart_handle_sysrq_chars(&sport->port,
+					  ring->buf + ring->tail, count);
+		ring->tail = ring->head;
+	}
+}
+
 static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 {
 	struct tty_port *port = &sport->port.state->port;
@@ -1092,6 +1132,15 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	 */
 	ring->head = sport->rx_sgl.length - state.residue;
 	BUG_ON(ring->head > sport->rx_sgl.length);
+
+	/*
+	 * Silent handling of keys pressed in the sysrq timeframe
+	 */
+	if (sport->port.sysrq) {
+		lpuart_handle_sysrq(sport);
+		goto exit;
+	}
+
 	/*
 	 * At this point ring->head may point to the first byte right after the
 	 * last byte of the dma buffer:
@@ -1123,6 +1172,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 		sport->port.icount.rx += count;
 	}
 
+exit:
 	dma_sync_sg_for_device(chan->device->dev, &sport->rx_sgl, 1,
 			       DMA_FROM_DEVICE);
 
@@ -1559,6 +1609,7 @@ static void lpuart_tx_dma_startup(struct lpuart_port *sport)
 static void lpuart_rx_dma_startup(struct lpuart_port *sport)
 {
 	int ret;
+	unsigned char cr3;
 
 	if (!sport->dma_rx_chan)
 		goto err;
@@ -1575,6 +1626,12 @@ static void lpuart_rx_dma_startup(struct lpuart_port *sport)
 	sport->lpuart_dma_rx_use = true;
 	rx_dma_timer_init(sport);
 
+	if (sport->port.has_sysrq) {
+		cr3 = readb(sport->port.membase + UARTCR3);
+		cr3 |= UARTCR3_FEIE;
+		writeb(cr3, sport->port.membase + UARTCR3);
+	}
+
 	return;
 
 err:
-- 
2.28.0

