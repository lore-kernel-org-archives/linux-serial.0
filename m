Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A00C4167B
	for <linux-serial@archiver.kernel.org>; Thu, 29 Dec 2022 15:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiL2Pvl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Dec 2022 10:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiL2Pup (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Dec 2022 10:50:45 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDB9D51
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 07:50:44 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so13433615wms.4
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 07:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwBCercycDWxENvRn7oc2eoBsxPaVeGT4GXBPNhdJ8g=;
        b=Jzvdpkw/XzdpFAkG+Z+tcJ4DUdRteMl63kgHVvLleVIbz2q6VSIsuZayKGtEVN0xp/
         Ru551p224IYpbyFIMcdWCLKGhQih//bMO5DN+c6F/sL/dC7qYetI1p0NTiwdoi0hWN2p
         m0ZSJHghLw6YmhNw5aHDYrN7rkC/+bC18/Y8vjyBO40kXtykn9XJenjYYrIQHGBB5OPn
         5VQS1P2lRNLd87W4KzSa7Gt5rTvsPzjwmjd8D1xX+t7sQCR1NINYMuT7EWl7jXHfS3/L
         8UzfyHug9AiglBcNocuqmBOrcQw9jnrG90cR7yabT7kCSrRKkIahDirX9kRwfXyH6kTi
         ACoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwBCercycDWxENvRn7oc2eoBsxPaVeGT4GXBPNhdJ8g=;
        b=wLWm+OSemyFJjSPKKMLcFsgfJgqApVhbBUec4tH6R6zJwl3Ct8Ctt9o6ZiDCjIK/VY
         UbH18T+TQHlzbLH1gDxNnV9yXCj4JCkYHKx6B7RlF+VWS9vndqkf064jGjyudCm8VKhg
         8O0/wQmKjNvp7oWW2rXeBfYVoAMlGwI75QWZEnXpf47gr7UxjCS0jGMdd7G2Q6Bp6Spt
         IHZDinhOIPyJ1jBGSV+xQu64/pEZMalO7FgT+RInztnWv4p1qNASC5N0mMhR9lqK1peS
         YUJm35JJuk/G6J0rROlklFTPpgZOVvhd6B1I0QYS2psO3FR0sLpV6cue0MnoDk4NnsdL
         duLQ==
X-Gm-Message-State: AFqh2kqDj0TSSd4phqqh8i3BHPYtWGy/mv0XsU4UddoAfrQFLLss2jHl
        hQWzcYApAMfI7wjWOeFKfI2wpw==
X-Google-Smtp-Source: AMrXdXvOC32xwrMXSpTwy25RHomedm9W00SV+mnmjOkX6+N08DbgALpCWo/PzROMAO42429U4u2CyQ==
X-Received: by 2002:a05:600c:1d89:b0:3d3:5cd6:781 with SMTP id p9-20020a05600c1d8900b003d35cd60781mr20126386wms.37.1672329043665;
        Thu, 29 Dec 2022 07:50:43 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm25251647wmb.38.2022.12.29.07.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:50:43 -0800 (PST)
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
Subject: [PATCH v6 10/14] tty: serial: qcom-geni-serial: refactor qcom_geni_serial_send_chunk_fifo()
Date:   Thu, 29 Dec 2022 16:50:26 +0100
Message-Id: <20221229155030.418800-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229155030.418800-1-brgl@bgdev.pl>
References: <20221229155030.418800-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Shuffle the code a bit, drop unneeded variables, make types of others
more consistent and use uart_xmit_advance() instead of handling
tail->xmit manually.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 28 ++++++++++-----------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index bd91a6a5ad37..3705c0f893a4 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -93,7 +93,7 @@
 #define IO_MACRO_IO2_IO3_SWAP		0x4640
 
 /* We always configure 4 bytes per FIFO word */
-#define BYTES_PER_FIFO_WORD		4
+#define BYTES_PER_FIFO_WORD		4U
 
 struct qcom_geni_private_data {
 	/* NOTE: earlycon port will have NULL here */
@@ -704,36 +704,28 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 }
 
-static int qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
-					    unsigned int chunk)
+static void qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
+					     unsigned int chunk)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct circ_buf *xmit = &uport->state->xmit;
-	size_t remaining = chunk;
-	int i, tail = xmit->tail;
-
-	for (i = 0; i < chunk; ) {
-		unsigned int tx_bytes;
-		u8 buf[sizeof(u32)];
-		int c;
+	unsigned int tx_bytes, c, remaining = chunk;
+	u8 buf[BYTES_PER_FIFO_WORD];
 
+	while (remaining) {
 		memset(buf, 0, sizeof(buf));
-		tx_bytes = min_t(size_t, remaining, BYTES_PER_FIFO_WORD);
+		tx_bytes = min(remaining, BYTES_PER_FIFO_WORD);
 
 		for (c = 0; c < tx_bytes ; c++) {
-			buf[c] = xmit->buf[tail++];
-			tail &= UART_XMIT_SIZE - 1;
+			buf[c] = xmit->buf[xmit->tail];
+			uart_xmit_advance(uport, 1);
 		}
 
 		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
 
-		i += tx_bytes;
-		uport->icount.tx += tx_bytes;
 		remaining -= tx_bytes;
 		port->tx_remaining -= tx_bytes;
 	}
-
-	return tail;
 }
 
 static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
@@ -778,7 +770,7 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 					uport->membase + SE_GENI_M_IRQ_EN);
 	}
 
-	xmit->tail = qcom_geni_serial_send_chunk_fifo(uport, chunk);
+	qcom_geni_serial_send_chunk_fifo(uport, chunk);
 
 	/*
 	 * The tx fifo watermark is level triggered and latched. Though we had
-- 
2.37.2

