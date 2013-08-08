From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] serial: bfin_uart: Fix incorrect placement of __initdata
Date: Thu,  8 Aug 2013 17:10:51 +0530
Message-ID: <1375962051-31873-2-git-send-email-sachin.kamat@linaro.org>
References: <1375962051-31873-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:39078 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab3HHL5l (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 07:57:41 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so3333312pab.34
        for <linux-serial@vger.kernel.org>; Thu, 08 Aug 2013 04:57:41 -0700 (PDT)
In-Reply-To: <1375962051-31873-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: uclinux-dist-devel@blackfin.uclinux.org, gregkh@linuxfoundation.org, jslaby@suse.cz, sachin.kamat@linaro.org

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/tty/serial/bfin_uart.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 378f3c3..3c75e8e 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -1176,7 +1176,7 @@ bfin_earlyprintk_console_write(struct console *co, const char *s, unsigned int c
  * don't let the common infrastructure play with things. (see calls to setup
  * & earlysetup in ./kernel/printk.c:register_console()
  */
-static struct __initdata console bfin_early_serial_console = {
+static struct console bfin_early_serial_console __initdata = {
 	.name = "early_BFuart",
 	.write = bfin_earlyprintk_console_write,
 	.device = uart_console_device,
@@ -1398,7 +1398,7 @@ static struct platform_driver bfin_serial_driver = {
 };
 
 #if defined(CONFIG_SERIAL_BFIN_CONSOLE)
-static __initdata struct early_platform_driver early_bfin_serial_driver = {
+static struct early_platform_driver early_bfin_serial_driver __initdata = {
 	.class_str = CLASS_BFIN_CONSOLE,
 	.pdrv = &bfin_serial_driver,
 	.requested_id = EARLY_PLATFORM_ID_UNSET,
@@ -1477,7 +1477,7 @@ static struct platform_driver bfin_earlyprintk_driver = {
 	},
 };
 
-static __initdata struct early_platform_driver early_bfin_earlyprintk_driver = {
+static struct early_platform_driver early_bfin_earlyprintk_driver __initdata = {
 	.class_str = CLASS_BFIN_EARLYPRINTK,
 	.pdrv = &bfin_earlyprintk_driver,
 	.requested_id = EARLY_PLATFORM_ID_UNSET,
-- 
1.7.9.5

