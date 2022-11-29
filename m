Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE11C47089
	for <linux-serial@archiver.kernel.org>; Tue, 29 Nov 2022 11:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiK2LAv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Nov 2022 06:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiK2LAg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Nov 2022 06:00:36 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D3D60EA2
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2022 03:00:26 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v7so10591022wmn.0
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2022 03:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66v9x+ssuHFjAFxgnTX+6F9++y0ILnIqzqCVl0hnLGk=;
        b=nJxnN147YI4mzY6o9hHsv5BlYQ5y4BRZhzfsWsjUEwHB0BMxXolS5MRfwu55m3U/oN
         FOdG7hTyOreuh1+iD5UG9fZJPvWvMAA2WbWQWTas+sJqFYw8UUDxRg400OAPclT4lkfu
         nwwDm5R0qEXDBEeja/7O1MIgWFlDlCsLa4DBI3GtTlVYPQ4UKC2D6+IriQ46HXWSczYe
         9yYpoRZtgYShJPkHgxhkwmBFSLUZPP++p0+yVtbeAgfC7XaeTK6nfmalJN6oLN04fS6P
         I2vbP1k1nhxFiZoJLyrigjQLawnKA/NY6U5J9l1ZabpsUB+QQvre1Y3OZIE8Ux7L4796
         NbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66v9x+ssuHFjAFxgnTX+6F9++y0ILnIqzqCVl0hnLGk=;
        b=sK2ZaticJbWJAerEKEaSaHlRZbCW6Cq7Nqqj5zFeIoMwUlttn1azI3BTSr/2hnmU7m
         DprC9HDgA78W7iGvOGPMwQgiFUnHkveZhJqk8RB7kBtnFrqGc0Jp0EDXLQe+qY1fPAYl
         GWSo4xFFkTJlr4hGLBrsfzg0B4fSTFVCnxL/sxQJb1ZvmfPpYFbRk1nSM7DfrFSylQdZ
         6oknq6pWFVpdQRKV/i7UOkVS1T1izXlYA3r0FrP8qjVvv8xgM7Ozb7xUY0fd8uCPIQk5
         Ze77WQkfYChv6P8+rEu+9aRDHnvAInckHxCl/IyQPphhphuMVcounzIKrPrFLoqFwBeI
         f3MA==
X-Gm-Message-State: ANoB5pnGRvXn08jXLgIL0f4jN2ysDu6XnxKt0uVhD+bUkeHGpA7yfk45
        Sj6NAhegufd0s5NfSeLtZ/+1SQ==
X-Google-Smtp-Source: AA0mqf5F1VQCWwlM68M1Jltk9miDXXT6amSG+DACTciqlIXUICsELmGpczNAtuf2a5/RLQI6BFfpOg==
X-Received: by 2002:a05:600c:3d99:b0:3cf:cab4:a42b with SMTP id bi25-20020a05600c3d9900b003cfcab4a42bmr27202310wmb.36.1669719626501;
        Tue, 29 Nov 2022 03:00:26 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6b19:1d8e:fbca:fd02])
        by smtp.gmail.com with ESMTPSA id q19-20020a1cf313000000b003a3170a7af9sm1617658wmq.4.2022.11.29.03.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:00:26 -0800 (PST)
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
Subject: [PATCH v4 09/13] tty: serial: qcom-geni-serial: drop the return value from handle_rx
Date:   Tue, 29 Nov 2022 12:00:08 +0100
Message-Id: <20221129110012.224685-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129110012.224685-1-brgl@bgdev.pl>
References: <20221129110012.224685-1-brgl@bgdev.pl>
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
index ece5b4d543fc..7d6330f85ec2 100644
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

