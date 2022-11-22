Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0154C43217
	for <linux-serial@archiver.kernel.org>; Tue, 22 Nov 2022 10:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiKVKXW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Nov 2022 05:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbiKVKWJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Nov 2022 05:22:09 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417F942F6A
        for <linux-serial@vger.kernel.org>; Tue, 22 Nov 2022 02:21:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id cl5so23986694wrb.9
        for <linux-serial@vger.kernel.org>; Tue, 22 Nov 2022 02:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27Y/3dF94+Cm6VsgYrXb3WffaYznVRIrRKIsZki0OWQ=;
        b=p5tYf/k5kFhRazIIzD8o3PSLNCLLkbhWf5IpnTaCYOf/WP+9EuBZSo7s69h6Q94ChN
         n/Bcik7yUYAGKPWoJ4gyb9y2JHOlm3rrWIxUWSL2aRiRj/r9ibSL7T5LvAEYeCsBcvDi
         fDOZ7IovrDkq+U3UltW4+skli0Xy4Wvtq/2mQXSVLzzr4rE9w6hp3lWvXXY5FhSZRm1+
         0qepDYOH9luRPwTNWjBo4zd9Jn7KCbBeBfcyieczJvodOM4r9Yuv17uNRfq2vPNNGAcj
         wvg1H/UYaxTKbxkIrby6WlMu4PWFgRD6GAtUzbXn3rmnV43/htX16BeMvTP/XPlmjH6F
         XnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27Y/3dF94+Cm6VsgYrXb3WffaYznVRIrRKIsZki0OWQ=;
        b=s40aeFdDJstK2GuoaN2z1FF06Lbq1g8HdzHFT3+RzguLO5/6SoJl/Q6DDumQSGZiTg
         Xrb3pw0YenVdS1HiCX5FIr5sci9M49KsJ5V4akEJ4pHUBjLS8XA73oc1n3koCHHNZc9A
         FHqaetJ5KAh/BuWIyTcTVwggoZyu5HzSljhTYgwatHxr1vHWlmrt+Nwp0TmLmn7lBRhL
         MGyw9YJVn3FH7318Zawppqxgqt0nMVhwxaWqkrUQONniWWro1pzNzx+k2ixS7Kpx6vQk
         XArSCXl3KF5flVovg/HduFftYlx8hZ8X980JVf2d0Flx/X6ozzAQa+GvtvFvm5XXE1Ek
         jROw==
X-Gm-Message-State: ANoB5pkSrrCvY7U0fseJ2J+ltewsXlDmd9PcVZV6s2W8ZkDdj6nWyAxU
        gO1WZH9SysbZ7/M5YQT2GL4WbQ==
X-Google-Smtp-Source: AA0mqf69CXjewIeRpNzNev2em/khtbWChfmHSS0jstlGQT/jsPxEEfH6FaoJCa9gp8/qvh1dU5m5yQ==
X-Received: by 2002:adf:f352:0:b0:236:7cdb:3c8b with SMTP id e18-20020adff352000000b002367cdb3c8bmr13444835wrp.280.1669112509815;
        Tue, 22 Nov 2022 02:21:49 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e011:9e81:66f1:3415])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b002366e8eee11sm13432873wrp.101.2022.11.22.02.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:21:49 -0800 (PST)
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 09/15] tty: serial: qcom-geni-serial: drop the return value from handle_rx
Date:   Tue, 22 Nov 2022 11:21:19 +0100
Message-Id: <20221122102125.142075-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221122102125.142075-1-brgl@bgdev.pl>
References: <20221122102125.142075-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The return value of the handle_rx() callback is never checked. Drop it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 658b6d596f58..d5c343b06c23 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -114,7 +114,7 @@ struct qcom_geni_serial_port {
 	u32 tx_fifo_width;
 	u32 rx_fifo_depth;
 	bool setup;
-	int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
+	void (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
 	unsigned int baud;
 	void *rx_fifo;
 	u32 loopback;
@@ -502,7 +502,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 		spin_unlock_irqrestore(&uport->lock, flags);
 }
 
-static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
+static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 {
 	u32 i;
 	unsigned char buf[sizeof(u32)];
@@ -537,16 +537,15 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 	}
 	if (!drop)
 		tty_flip_buffer_push(tport);
-	return 0;
 }
 #else
-static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
+static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 {
-	return -EPERM;
+
 }
 #endif /* CONFIG_SERIAL_QCOM_GENI_CONSOLE */
 
-static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
+static void handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
 {
 	struct tty_port *tport;
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
@@ -557,7 +556,7 @@ static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
 	tport = &uport->state->port;
 	ioread32_rep(uport->membase + SE_GENI_RX_FIFOn, port->rx_fifo, words);
 	if (drop)
-		return 0;
+		return;
 
 	ret = tty_insert_flip_string(tport, port->rx_fifo, bytes);
 	if (ret != bytes) {
@@ -567,7 +566,6 @@ static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
 	}
 	uport->icount.rx += ret;
 	tty_flip_buffer_push(tport);
-	return ret;
 }
 
 static unsigned int qcom_geni_serial_tx_empty(struct uart_port *uport)
-- 
2.37.2

