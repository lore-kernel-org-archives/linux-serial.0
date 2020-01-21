Return-Path: <SRS0=m7Km=3K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DAFC2D0DB
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 17:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1D02253D
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 17:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eG+XPRzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgAURX7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:23:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40401 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAURX4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jan 2020 12:23:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so4161112wrn.7
        for <linux-serial@vger.kernel.org>; Tue, 21 Jan 2020 09:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=qulnROX80EQfKAAAdi+58//mX5ebVC1xGhbdWeXljF8=;
        b=eG+XPRzqZ6F4FmKkHJAHP7CO4l7BZ/6BzcAqbm2s8SSy6AGDVp+wczEGbXiWb1iJrF
         Qel8TreGnPjZz8PUCYkTC4w3bpZrvq14Te2kY9eKJjYdYs9OKTlRsPOaYb8aVn3OFn2m
         8i/m6y6AhASt6vHlvmwxUINw4oLnuf9zpJ25d0aMoMs/1BiDVPVBaUcmDTy6tHSSpuqN
         I+/L6N5zkTNiF5VxEIju3XoRsRyhOKys1YQrLc/gedSp9HHhZSrJ+79xczPT9EcTosSD
         QdD2EsKS16F8ivI0zBotGeSgd5Z+xtBoOU6Uh7Ogew341LgTJs5I/MBo3Dh3lyqwhGLi
         ILdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=qulnROX80EQfKAAAdi+58//mX5ebVC1xGhbdWeXljF8=;
        b=emVOp6XYH9y+EdB+YDlMLI9Vt2o4emLzrh+6ZzSRdf2rkrfNhALBk0GBMPBBSfpG/h
         OOFl/FG1NyuKMS7tT7oC5EAusUPl72X/EFsW5ovWk1Wa13eqeHRXyHYhCdUrfit4GiMM
         Wil4wUVLWEy2128M9LgTeW/eGYeioWsFMJ18HYm5BO6k6cLlYZ7uhQtBYnyCp/y6NwxB
         jwRDS4KuzQ+YTuesjF2B24H4F2A+0fW81J6FPVKMjxOJVhhk4f+RRszKpJnZhGcAkWKU
         3pkvlHiLUXY+sEQPNGmSGMngOHgZ+tjyAJV7tdb05Me1X+cEu7Spo/sdymWhuDRbgbU4
         NC8w==
X-Gm-Message-State: APjAAAXJ/m58A1Zx7OaE2OvId9mhs/5dcpnftbt8IEjcVBWG/mtHaP0W
        WWiBiQ2+MKibbaXkRWYlvi02eQ==
X-Google-Smtp-Source: APXvYqwUr3/YtOFR0+Q8ydmqs0w6X6w2Ly6cdHXfv3xa7K7S7JB/WxuwUXO9y+ENpSp33UCBQnBQfQ==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr6609447wrc.175.1579627433651;
        Tue, 21 Jan 2020 09:23:53 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v14sm52906783wrm.28.2020.01.21.09.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 09:23:52 -0800 (PST)
From:   Julien Masson <jmasson@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Julien Masson <jmasson@baylibre.com>
Subject: [PATCH v3] tty: serial: meson_uart: Add support for kernel debugger
Date:   Tue, 21 Jan 2020 18:22:52 +0100
Message-ID: <867e1klo48.fsf@julienm-fedora-R90NQGV9.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The kgdb invokes the poll_put_char and poll_get_char when communicating
with the host. This patch implement the serial polling hooks for the
meson_uart to be used for KGDB debugging over serial line.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---

Changes since v2 [1]:
* Increase UART timeout to 10 ms
  -> For some reasons the previous value (1ms) is now too low with recent kernel.
     It made KGDB hang when printing long string for example.
     By setting this timeout to 10 ms, we avoid this kind of issue.

Changes since v1 [0]:
* Use readl_poll_timeout_atomic instead of looping with read + cpu_relax
  -> read every 5 usecs during 1 msec
* add some comments


* Test environment:
Board: "Le Potato"
https://libre.computer/products/boards/aml-s905x-cc/

Kernel Tree:
https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git

Kernel command line arguments:
kgdboc=ttyAML0,115200 kgdbretry=4 nokaslr kgdbcon

Kernel modules:
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_KERNEL=y
CONFIG_FRAME_POINTER=y
CONFIG_KGDB=y
CONFIG_KGDB_SERIAL_CONSOLE=y

WARNING: for single step instruction I had to adapt/apply this patch:
https://lore.kernel.org/patchwork/patch/562423/


[0]: https://patchwork.kernel.org/patch/10792397/
[1]: https://patchwork.kernel.org/patch/10801583/

 drivers/tty/serial/meson_uart.c | 65 +++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index fbc5bc022a39..b79c6d64bfb2 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
@@ -76,6 +77,8 @@
 #define AML_UART_PORT_OFFSET		6
 #define AML_UART_DEV_NAME		"ttyAML"
 
+#define AML_UART_POLL_USEC		5
+#define AML_UART_TIMEOUT_USEC		10000
 
 static struct uart_driver meson_uart_driver;
 
@@ -427,6 +430,64 @@ static void meson_uart_config_port(struct uart_port *port, int flags)
 	}
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+/*
+ * Console polling routines for writing and reading from the uart while
+ * in an interrupt or debug context (i.e. kgdb).
+ */
+
+static int meson_uart_poll_get_char(struct uart_port *port)
+{
+	u32 c;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY)
+		c = NO_POLL_CHAR;
+	else
+		c = readl(port->membase + AML_UART_RFIFO);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return c;
+}
+
+static void meson_uart_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	unsigned long flags;
+	u32 reg;
+	int ret;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	/* Wait until FIFO is empty or timeout */
+	ret = readl_poll_timeout_atomic(port->membase + AML_UART_STATUS, reg,
+					reg & AML_UART_TX_EMPTY,
+					AML_UART_POLL_USEC,
+					AML_UART_TIMEOUT_USEC);
+	if (ret == -ETIMEDOUT) {
+		dev_err(port->dev, "Timeout waiting for UART TX EMPTY\n");
+		goto out;
+	}
+
+	/* Write the character */
+	writel(c, port->membase + AML_UART_WFIFO);
+
+	/* Wait until FIFO is empty or timeout */
+	ret = readl_poll_timeout_atomic(port->membase + AML_UART_STATUS, reg,
+					reg & AML_UART_TX_EMPTY,
+					AML_UART_POLL_USEC,
+					AML_UART_TIMEOUT_USEC);
+	if (ret == -ETIMEDOUT)
+		dev_err(port->dev, "Timeout waiting for UART TX EMPTY\n");
+
+out:
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
 static const struct uart_ops meson_uart_ops = {
 	.set_mctrl      = meson_uart_set_mctrl,
 	.get_mctrl      = meson_uart_get_mctrl,
@@ -442,6 +503,10 @@ static const struct uart_ops meson_uart_ops = {
 	.request_port	= meson_uart_request_port,
 	.release_port	= meson_uart_release_port,
 	.verify_port	= meson_uart_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= meson_uart_poll_get_char,
+	.poll_put_char	= meson_uart_poll_put_char,
+#endif
 };
 
 #ifdef CONFIG_SERIAL_MESON_CONSOLE
-- 
2.21.1

