Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52402C3DA79
	for <linux-serial@archiver.kernel.org>; Thu, 29 Dec 2022 15:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiL2Pvn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Dec 2022 10:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbiL2Put (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Dec 2022 10:50:49 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED24D4B
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 07:50:44 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ja17so13403427wmb.3
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 07:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMVKrwdZWEXr4SpaY5rZECUzCmLZAbyQFJGjBVIK3cY=;
        b=M4K3oPLWC8XPeEjHXcBiEU120Ik7Q3MhxDOxbT6QisHcUgbXhyMnIIQVhzuXEhsnKi
         SOi42g9ylj8TQdeq9kuF52sBvj/8mx24DLAuRrYSbyKGnkur/8B6w/X2TeAj6t+pGK84
         fR1fum/WpBxE150PCiI6gJ0nWLFaA4FMnMCcEpmU1vPfmGwwne0Rq1a32gC56qAe8Eay
         DJQg6pSrnYTQEKnHbwHsICnQBp4yUC3p7afEZrl2+8ptdG9i3ClZW/dstgJkOuzEr6+o
         fieZ1VtpPl7Obr/riPpG6Sxd6d/1q1F1zWOAqwRni9GGn+sxzDF1JW0ihLCuVnlb4JT5
         IXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMVKrwdZWEXr4SpaY5rZECUzCmLZAbyQFJGjBVIK3cY=;
        b=DavlN7kbyV40fKGatW9p2qmWLEhP1YbWeOcjCX52JcOTKB1JOlrO8LWjfjmQNxaagv
         nx4wmnsbIamDeGqtUljc3m16VC2GRa0r5myu+4bUY1KyQwkErD4kVGpswuQqObCJ506G
         wufFppJSiXt6DOkHYp6ZCZY/Fsp69aivyp4hS3F710EQMSNSWmNOgTg348vRwH6OYcM+
         em0Lc7ttUj4Cnt0rbWV8sSp/TP23nIg7v7ZUg+PRFDLjAPU0tPXk/ClDYPTu/C4EFBs5
         /s1LUEF9mKcjYgMsL3N/KhNMMIoiJmLHK/RndOvhROp/B1cilqoeGj3igM7FBbVoRPrK
         d6rg==
X-Gm-Message-State: AFqh2krU4HOPnqI65zk6hawjSk3YwyAn30FTaJ2pUEPY6a/e+Fny00Ug
        xIQvBTF0WFCDgK20JXxJlPimjQ==
X-Google-Smtp-Source: AMrXdXt2KvdOsGmdgCgY2p4lN7SOGTNM5pDZhTjrxi31uhL0bxEl8B0zOb6NWjynO+iUA0avgVVXdg==
X-Received: by 2002:a05:600c:1e10:b0:3d1:f496:e25f with SMTP id ay16-20020a05600c1e1000b003d1f496e25fmr21640763wmb.16.1672329042697;
        Thu, 29 Dec 2022 07:50:42 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm25251647wmb.38.2022.12.29.07.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:50:42 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v6 09/14] tty: serial: qcom-geni-serial: split out the FIFO tx code
Date:   Thu, 29 Dec 2022 16:50:25 +0100
Message-Id: <20221229155030.418800-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229155030.418800-1-brgl@bgdev.pl>
References: <20221229155030.418800-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

qcom_geni_serial_handle_tx() is pretty big, let's move the code that
handles the actual writing of data to a separate function which makes
sense in preparation for introducing a dma variant of handle_tx().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 60 +++++++++++++++------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index e34fe56247d9..bd91a6a5ad37 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -704,19 +704,48 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 }
 
+static int qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
+					    unsigned int chunk)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	struct circ_buf *xmit = &uport->state->xmit;
+	size_t remaining = chunk;
+	int i, tail = xmit->tail;
+
+	for (i = 0; i < chunk; ) {
+		unsigned int tx_bytes;
+		u8 buf[sizeof(u32)];
+		int c;
+
+		memset(buf, 0, sizeof(buf));
+		tx_bytes = min_t(size_t, remaining, BYTES_PER_FIFO_WORD);
+
+		for (c = 0; c < tx_bytes ; c++) {
+			buf[c] = xmit->buf[tail++];
+			tail &= UART_XMIT_SIZE - 1;
+		}
+
+		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
+
+		i += tx_bytes;
+		uport->icount.tx += tx_bytes;
+		remaining -= tx_bytes;
+		port->tx_remaining -= tx_bytes;
+	}
+
+	return tail;
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
 
@@ -735,7 +764,6 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	avail = port->tx_fifo_depth - (status & TX_FIFO_WC);
 	avail *= BYTES_PER_FIFO_WORD;
 
-	tail = xmit->tail;
 	chunk = min(avail, pending);
 	if (!chunk)
 		goto out_write_wakeup;
@@ -750,29 +778,7 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
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
+	xmit->tail = qcom_geni_serial_send_chunk_fifo(uport, chunk);
 
 	/*
 	 * The tx fifo watermark is level triggered and latched. Though we had
-- 
2.37.2

