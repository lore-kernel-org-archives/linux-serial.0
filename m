From: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Subject: [PATCH] serial: samsung: fix s3c2442 platform data
Date: Thu, 23 Feb 2012 08:23:52 +0100
Message-ID: <1329981832-29058-1-git-send-email-GNUtoo@no-log.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp202.alice.it ([82.57.200.98]:59928 "EHLO smtp202.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479Ab2BWH3a (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 23 Feb 2012 02:29:30 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>

Without that fix machines having a s3c2442 CPU have something
  like that in dmesg:
    samsung-uart s3c2440-uart.0: could not find driver data
    samsung-uart s3c2440-uart.1: could not find driver data
    samsung-uart s3c2440-uart.2: could not find driver data
  And serial is never initialized.

The previous log was obtained trough early printk on the gta02
  machine.

Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
---
 drivers/tty/serial/samsung.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index c55e5fb..de249d2 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1507,7 +1507,7 @@ static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
 #endif
 
 #if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2416) || \
-	defined(CONFIG_CPU_S3C2443)
+	defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2442)
 static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 	.info = &(struct s3c24xx_uart_info) {
 		.name		= "Samsung S3C2440 UART",
-- 
1.7.4.1

