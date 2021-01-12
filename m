Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D23C072AF
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 21:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45A123123
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 21:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406399AbhALVh1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437071AbhALU4e (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jan 2021 15:56:34 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F7BC0617A2;
        Tue, 12 Jan 2021 12:55:42 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id d17so5428009ejy.9;
        Tue, 12 Jan 2021 12:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mB4awCptdOD4XxS2R3y9RjPkKqrjcCd8XVKkJUf17lY=;
        b=EXEloGtCq2Y1xv2n/lKx4y+IKjFMhuasWC47llqnFU3lg9F+ErefoQzMzs4QWaGb1I
         sSJLXccTNlo514WRLeswXNX0/Pv5Tzd5cWnuQapOZgbbNlBVAV7yTxtcdSDz6AL+78tc
         ndvNtdhcK7lQsyosQ/m2Jl+QTAdBbZ0xkRSJBBRxEEhxHkwocTWNcPKm/tgkwOeuK2y0
         jPhEWe8YX8gEn9hMRYhZ71fsnGOni0VWoVZGVd+Q/DrJYwuoh0q/d59c+Hbt2oASCWfn
         AABzI+gMYxMc/G8WJ5EB++xOmDY9qkWynY425QYj1nuKYOdBvfEQ4aBChJ/EJEtJZg+j
         aY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mB4awCptdOD4XxS2R3y9RjPkKqrjcCd8XVKkJUf17lY=;
        b=TA+dVlMG8k8qA6Qlh97uRWAWrVIBPY66UaNFUZTFKG4UM+nrbjuNHiifWxxObki+w+
         R9FpWfBT4boeYKLAogGfN2CeYMHN3p1rSwJSgYvrEWdu9SBKFjCr3W5ZMzJtWyHju3+W
         KRMCG116Z0Qlhp4dUOrgMTPGb09FcsRNKh3Td53Itxi/RlCP47Ksg1nD4lP0N30USMjT
         pZ0E3q5z1+O5dbD5BGJ0bqMYRKcpu317vjqRbb1JgPiGWpsV/4V0kTp19KqclMxK6n0n
         3vrmajsB5Upc+SOJ0PvqMGrrbkbNlUQcSMJhvXGPmRmAjkZUQLv7JBxgBvWj2RkMkXQ3
         S5dQ==
X-Gm-Message-State: AOAM533soNebZdO5ZuCTqKLl8uIW/3zCTM3ox38UY/dhCtkzBQOravFx
        uBG7JeRExQ3GvRE9uoETAt4=
X-Google-Smtp-Source: ABdhPJzwm/B8mmx3+HAGXVJ6HOwVSe5dwtB1AqDsh46+Tlxnnni5L0R7Nfumpd9EybxYCubE4esVsw==
X-Received: by 2002:a17:906:7804:: with SMTP id u4mr467339ejm.97.1610484940921;
        Tue, 12 Jan 2021 12:55:40 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id p3sm1641423ejx.0.2021.01.12.12.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:55:40 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] tty: serial: owl: Add support for kernel debugger
Date:   Tue, 12 Jan 2021 22:55:38 +0200
Message-Id: <026543195b9aeefb339d90abc5660a6ac7463c63.1610484108.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Implement 'poll_put_char' and 'poll_get_char' callbacks in struct
'owl_uart_ops' that enables OWL UART to be used for kernel debugging
over serial line.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v3:
 - Used 'readl_poll_timeout_atomic()' in 'owl_uart_poll_put_char()'
   to get rid of 'cpu_relax()' and provide a max bound to the loop,
   as indicated by Greg and Jiri

Changes in v2:
 - Reverted unnecessary changes per Andreas feedback
 - Optimized implementation for 'owl_uart_poll_get_char()'
   and 'owl_uart_poll_put_char()' callbacks

 drivers/tty/serial/owl-uart.c | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index c149f8c30007..abc6042f0378 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -12,6 +12,7 @@
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -62,6 +63,9 @@
 #define OWL_UART_STAT_TRFL_MASK		GENMASK(16, 11)
 #define OWL_UART_STAT_UTBB		BIT(17)
 
+#define OWL_UART_POLL_USEC		5
+#define OWL_UART_TIMEOUT_USEC		10000
+
 static struct uart_driver owl_uart_driver;
 
 struct owl_uart_info {
@@ -461,6 +465,36 @@ static void owl_uart_config_port(struct uart_port *port, int flags)
 	}
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+
+static int owl_uart_poll_get_char(struct uart_port *port)
+{
+	if (owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_RFEM)
+		return NO_POLL_CHAR;
+
+	return owl_uart_read(port, OWL_UART_RXDAT);
+}
+
+static void owl_uart_poll_put_char(struct uart_port *port, unsigned char ch)
+{
+	u32 reg;
+	int ret;
+
+	/* Wait while FIFO is full or timeout */
+	ret = readl_poll_timeout_atomic(port->membase + OWL_UART_STAT, reg,
+					!(reg & OWL_UART_STAT_TFFU),
+					OWL_UART_POLL_USEC,
+					OWL_UART_TIMEOUT_USEC);
+	if (ret == -ETIMEDOUT) {
+		dev_err(port->dev, "Timeout waiting while UART TX FULL\n");
+		return;
+	}
+
+	owl_uart_write(port, ch, OWL_UART_TXDAT);
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
 static const struct uart_ops owl_uart_ops = {
 	.set_mctrl = owl_uart_set_mctrl,
 	.get_mctrl = owl_uart_get_mctrl,
@@ -476,6 +510,10 @@ static const struct uart_ops owl_uart_ops = {
 	.request_port = owl_uart_request_port,
 	.release_port = owl_uart_release_port,
 	.verify_port = owl_uart_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char = owl_uart_poll_get_char,
+	.poll_put_char = owl_uart_poll_put_char,
+#endif
 };
 
 #ifdef CONFIG_SERIAL_OWL_CONSOLE
-- 
2.30.0

