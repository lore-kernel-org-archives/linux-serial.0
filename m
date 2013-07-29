From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] serial: max310x: Fix dev_pm_ops
Date: Mon, 29 Jul 2013 19:27:32 +0400
Message-ID: <1375111652-17436-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback8.mail.ru ([94.100.176.136]:36286 "EHLO
	fallback8.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab3G2P2A (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Jul 2013 11:28:00 -0400
Received: from smtp21.mail.ru (smtp21.mail.ru [94.100.176.174])
	by fallback8.mail.ru (mPOP.Fallback_MX) with ESMTP id EE3AB367C116
	for <linux-serial@vger.kernel.org>; Mon, 29 Jul 2013 19:27:58 +0400 (MSK)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch fixes wrong dev_pm_ops which caused by commit:
serial: max310x: Driver rework.

  CC      drivers/tty/serial/max310x.o
  LD      drivers/video/fb.o
  CC      drivers/w1/slaves/w1_ds2433.o
  CC      drivers/w1/slaves/w1_ds2760.o
  CC      drivers/xen/balloon.o
  CC      drivers/video/backlight/adp8870_bl.o
drivers/tty/serial/max310x.c:1292:8: warning: initialization from incompatible pointer type [enabled by default]
drivers/tty/serial/max310x.c:1292:8: warning: (near initialization for 'max310x_pm_ops.suspend') [enabled by default]
drivers/tty/serial/max310x.c:1292:8: warning: initialization from incompatible pointer type [enabled by default]
drivers/tty/serial/max310x.c:1292:8: warning: (near initialization for 'max310x_pm_ops.resume') [enabled by default]
drivers/tty/serial/max310x.c:1292:8: warning: initialization from incompatible pointer type [enabled by default]
drivers/tty/serial/max310x.c:1292:8: warning: (near initialization for 'max310x_pm_ops.freeze') [enabled by default]
drivers/tty/serial/max310x.c:1292:8: warning: initialization from incompatible pointer type [enabled by default]
drivers/tty/serial/max310x.c:1292:8: warning: (near initialization for 'max310x_pm_ops.thaw') [enabled by default]
drivers/tty/serial/max310x.c:1292:8: warning: initialization from incompatible pointer type [enabled by default]
drivers/tty/serial/max310x.c:1292:8: warning: (near initialization for 'max310x_pm_ops.poweroff') [enabled by default]
drivers/tty/serial/max310x.c:1292:8: warning: initialization from incompatible pointer type [enabled by default]
drivers/tty/serial/max310x.c:1292:8: warning: (near initialization for 'max310x_pm_ops.restore') [enabled by default]

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 4ab5b27..b2e707a 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -991,10 +991,9 @@ static const struct uart_ops max310x_ops = {
 	.verify_port	= max310x_verify_port,
 };
 
-static int __maybe_unused max310x_suspend(struct spi_device *spi,
-					  pm_message_t state)
+static int __maybe_unused max310x_suspend(struct device *dev)
 {
-	struct max310x_port *s = dev_get_drvdata(&spi->dev);
+	struct max310x_port *s = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < s->uart.nr; i++) {
@@ -1005,9 +1004,9 @@ static int __maybe_unused max310x_suspend(struct spi_device *spi,
 	return 0;
 }
 
-static int __maybe_unused max310x_resume(struct spi_device *spi)
+static int __maybe_unused max310x_resume(struct device *dev)
 {
-	struct max310x_port *s = dev_get_drvdata(&spi->dev);
+	struct max310x_port *s = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < s->uart.nr; i++) {
-- 
1.8.1.5

