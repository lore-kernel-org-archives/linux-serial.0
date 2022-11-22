Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0652CC4321E
	for <linux-serial@archiver.kernel.org>; Tue, 22 Nov 2022 10:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiKVKXQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Nov 2022 05:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiKVKWD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Nov 2022 05:22:03 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5155D326F1
        for <linux-serial@vger.kernel.org>; Tue, 22 Nov 2022 02:21:49 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i12so20113625wrb.0
        for <linux-serial@vger.kernel.org>; Tue, 22 Nov 2022 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzY04K9GyuBHm3usH7zJK0sqLLvwAU6csJcimfdY1bo=;
        b=fG9KF9TCboacMHM4Lqbb4TbFZF3dpm25PBc8vtuxLKqjWm2KdBep1qPauzfPaAQoMO
         mfTspLuptF7SrzxQUD0ssz88qQP+ZLWM8tZEOl+114Sz7P3w3u2fcYEATIm6hLKNfW/X
         6lbJamPubM3iNHZTxD8jJG2u5ww1gi736U2gECXWH32Wkib5t+Q0Y2aJ7rvil3jBPS0B
         Uk3hCb9QMljrmnyrGogyhtGLtZqY/H4MHsHM0FsFUPipFMhONjqBvodWfWdnpFcRmkY3
         O/kDhz12jkBIKsvb954rbJpx10BI9iPI2sbR7z02ELm02grGCxrpyNmerPxTOjF9au2X
         +UhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzY04K9GyuBHm3usH7zJK0sqLLvwAU6csJcimfdY1bo=;
        b=yj1QT7P8U5UY7l38bJv/n1N9DYxzUFFzyUgrz1EvexoasQTN7ZDii6rxXge2tgUJIy
         4zLDhNA7HpwQDmv4YLvaul/MhKjP+Am2hc7WURJGZyizQ9QoaRdpyrvOOa4r5lQIpqnN
         tAVoB6HDXsxX67FQDXN2axI2AGJwUobMn0b9eIstZUxRVvJYbr7BXxtSxcokggiYBpx+
         2vbhPGzbcsZP2NWT24pZ9pguG1CVgEj43ivbfWzUkcQFLzkLgFDpcAvIVjFRG+ypPtcH
         oHA8+JyJC2+gXdq12/rgaWPHd7eWejrMMHVTwHbMNMt7jNn82Y6LKT2EVwEWw9Q0qQb3
         9opw==
X-Gm-Message-State: ANoB5plD5e2uwoEgK+YePHR3hcOivGbgPNqLsPZPZzJrl1JqZgXxoQ38
        uxM43t0EYK9fJmRR2kTu3kxmLg==
X-Google-Smtp-Source: AA0mqf7M2SmijE0E3HGE39y4HvsVFKOmgJCiQ+hJcQmPzBn8cSrAu16BCHw4XfKa6tJDBbn1kc7w6g==
X-Received: by 2002:adf:e8cc:0:b0:236:7a1c:c437 with SMTP id k12-20020adfe8cc000000b002367a1cc437mr13408424wrn.124.1669112508869;
        Tue, 22 Nov 2022 02:21:48 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e011:9e81:66f1:3415])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b002366e8eee11sm13432873wrp.101.2022.11.22.02.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:21:48 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 08/15] tty: serial: qcom-geni-serial: refactor qcom_geni_serial_handle_tx()
Date:   Tue, 22 Nov 2022 11:21:18 +0100
Message-Id: <20221122102125.142075-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221122102125.142075-1-brgl@bgdev.pl>
References: <20221122102125.142075-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

qcom_geni_serial_handle_tx() is pretty big, let's move the code that
handles the actual writing of data to a separate function which makes
sense in preparation for introducing a dma variant of handle_tx().

Let's also shuffle the code a bit, drop unneeded variables and use
uart_xmit_advance() instead of handling tail->xmit manually.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 54 +++++++++++++--------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 68a1402fbe58..658b6d596f58 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -704,19 +704,42 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 }
 
+static void qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
+					     unsigned int chunk)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	struct circ_buf *xmit = &uport->state->xmit;
+	u8 buf[BYTES_PER_FIFO_WORD];
+	size_t remaining = chunk;
+	unsigned int tx_bytes;
+	int c;
+
+	while (remaining) {
+		memset(buf, 0, sizeof(buf));
+		tx_bytes = min_t(size_t, remaining, BYTES_PER_FIFO_WORD);
+
+		for (c = 0; c < tx_bytes ; c++) {
+			buf[c] = xmit->buf[xmit->tail];
+			uart_xmit_advance(uport, 1);
+		}
+
+		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
+
+		remaining -= tx_bytes;
+		port->tx_remaining -= tx_bytes;
+	}
+}
+
 static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 		bool active)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct circ_buf *xmit = &uport->state->xmit;
 	size_t avail;
-	size_t remaining;
 	size_t pending;
-	int i;
 	u32 status;
 	u32 irq_en;
 	unsigned int chunk;
-	int tail;
 
 	status = readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
 
@@ -735,7 +758,6 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	avail = port->tx_fifo_depth - (status & TX_FIFO_WC);
 	avail *= BYTES_PER_FIFO_WORD;
 
-	tail = xmit->tail;
 	chunk = min(avail, pending);
 	if (!chunk)
 		goto out_write_wakeup;
@@ -750,29 +772,7 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 					uport->membase + SE_GENI_M_IRQ_EN);
 	}
 
-	remaining = chunk;
-	for (i = 0; i < chunk; ) {
-		unsigned int tx_bytes;
-		u8 buf[sizeof(u32)];
-		int c;
-
-		memset(buf, 0, sizeof(buf));
-		tx_bytes = min_t(size_t, remaining, BYTES_PER_FIFO_WORD);
-
-		for (c = 0; c < tx_bytes ; c++) {
-			buf[c] = xmit->buf[tail++];
-			tail &= UART_XMIT_SIZE - 1;
-		}
-
-		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
-
-		i += tx_bytes;
-		uport->icount.tx += tx_bytes;
-		remaining -= tx_bytes;
-		port->tx_remaining -= tx_bytes;
-	}
-
-	xmit->tail = tail;
+	qcom_geni_serial_send_chunk_fifo(uport, chunk);
 
 	/*
 	 * The tx fifo watermark is level triggered and latched. Though we had
-- 
2.37.2

