Return-Path: <SRS0=RakX=7L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF542C433E2
	for <linux-serial@archiver.kernel.org>; Fri, 29 May 2020 15:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF1A206F0
	for <linux-serial@archiver.kernel.org>; Fri, 29 May 2020 15:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGUtShBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgE2Pub (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 May 2020 11:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgE2Pu3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 May 2020 11:50:29 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B00C03E969;
        Fri, 29 May 2020 08:50:29 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s19so2067098edt.12;
        Fri, 29 May 2020 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EsMvt8EiZib5FGRRaF/qmPkTiPSrV02BKHt077M8wMI=;
        b=cGUtShBaCi9MqoE1+GESbw69dKQPzfpBkPzL3us2slLVv6fyW3FzZR38Ss0xy1A4Yh
         8iss/1gsa3WW9/xeUZSAv4euyAve2ASBsIjapI7OxHttUYUEEopFsOQr5gtW2x5K5DVv
         xVcOJQyCfYgiQM0ZEi2S3hc4pTM0phT9t8mt4RPzVUv4RbiwbWMbTC4Xda9iJQ19GUFU
         4Vuze25Dm/GfmaXfyvhPMotiRoRlhae3fCXG+9MqDgTLBwr0foE2cAwLI/LkEyRSuBXL
         YPVTXNicS/KYigpGnlH14hS02GzJL0KIS5PDjXI8yWtoebKHBFfq3ifTgX2kWJOrJtmT
         +e1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EsMvt8EiZib5FGRRaF/qmPkTiPSrV02BKHt077M8wMI=;
        b=tOmhRHW3FDVQMULiSoDaRuLgnK1Sowcr/+B7aCUe+5k06e9p0OuCElPBvaWXKQLxxJ
         q7wsggLyrtfxGRBoBJ/LIN/hCMvq7Ve66Ctyhb0p2MGX3QoHRCUSm01ea884ZBzv0e3O
         CIQWYdTdj7juBqFWpwEe8IW39990bwGtqQPFrTmkwrQtIjGj/TTfuguWRoAkQ6G7pG95
         KVXvT9a9FPVzwCSS7BtIcFKMG2PiwoLWoFO2ExLcYCZs7ijY1bPCVmD75hXOS6j2v7kj
         D1YlAwQpqDVGtvZ88DzVGI7dkRcL1hm/8IYduc6LwSlyDujSnhin6HBuAMYDnQAGrlg8
         +uwA==
X-Gm-Message-State: AOAM532xkH56YbQlztNYW3NeYizuW1UX22HPrjLlXvMNpx4NRBlxTGzh
        3S1Rgmj4z7EjjGOqmgffkC4=
X-Google-Smtp-Source: ABdhPJx6DPMPIrVyjdcMp9A6H0ZgGz361F/QduvdG+yveRgopAM+PuB1Tb/x09hjpiea6VuHfcN3Iw==
X-Received: by 2002:a50:bb41:: with SMTP id y59mr8736067ede.311.1590767427825;
        Fri, 29 May 2020 08:50:27 -0700 (PDT)
Received: from localhost.localdomain ([188.27.38.213])
        by smtp.gmail.com with ESMTPSA id cz9sm7068103edb.18.2020.05.29.08.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:50:27 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: [PATCH 1/1] tty: serial: owl: Add support for kernel debugger
Date:   Fri, 29 May 2020 18:50:25 +0300
Message-Id: <6ee88060c129715980592a1ae33c93923916a14b.1590766726.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Implement poll_put_char and poll_get_char callbacks in struct uart_ops
that enables OWL UART to be used for KGDB debugging over serial line.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/tty/serial/owl-uart.c | 45 ++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index c2fa2f15d50a..26dcc374dec5 100644
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
@@ -20,13 +21,13 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 
-#define OWL_UART_PORT_NUM 7
-#define OWL_UART_DEV_NAME "ttyOWL"
+#define OWL_UART_PORT_NUM		7
+#define OWL_UART_DEV_NAME		"ttyOWL"
 
-#define OWL_UART_CTL	0x000
-#define OWL_UART_RXDAT	0x004
-#define OWL_UART_TXDAT	0x008
-#define OWL_UART_STAT	0x00c
+#define OWL_UART_CTL			0x000
+#define OWL_UART_RXDAT			0x004
+#define OWL_UART_TXDAT			0x008
+#define OWL_UART_STAT			0x00c
 
 #define OWL_UART_CTL_DWLS_MASK		GENMASK(1, 0)
 #define OWL_UART_CTL_DWLS_5BITS		(0x0 << 0)
@@ -461,6 +462,34 @@ static void owl_uart_config_port(struct uart_port *port, int flags)
 	}
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+
+static int owl_uart_poll_get_char(struct uart_port *port)
+{
+	u32 c = NO_POLL_CHAR;
+
+	if (!(owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_RFEM))
+		c = owl_uart_read(port, OWL_UART_RXDAT);
+
+	return c;
+}
+
+static void owl_uart_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	/* Wait while TX FIFO is full */
+	while (owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU)
+		cpu_relax();
+
+	/* Send the character out */
+	owl_uart_write(port, c, OWL_UART_TXDAT);
+
+	/* Wait for transmitter to become empty */
+	while (owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TRFL_MASK)
+		cpu_relax();
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
 static const struct uart_ops owl_uart_ops = {
 	.set_mctrl = owl_uart_set_mctrl,
 	.get_mctrl = owl_uart_get_mctrl,
@@ -476,6 +505,10 @@ static const struct uart_ops owl_uart_ops = {
 	.request_port = owl_uart_request_port,
 	.release_port = owl_uart_release_port,
 	.verify_port = owl_uart_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= owl_uart_poll_get_char,
+	.poll_put_char	= owl_uart_poll_put_char,
+#endif
 };
 
 #ifdef CONFIG_SERIAL_OWL_CONSOLE
-- 
2.26.2

