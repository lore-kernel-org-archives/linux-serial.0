From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] serial: bfin_sport_uart: Fix incorrect placement of __initdata
Date: Thu,  8 Aug 2013 17:10:50 +0530
Message-ID: <1375962051-31873-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:43464 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab3HHL5i (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 07:57:38 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so3046453pbc.39
        for <linux-serial@vger.kernel.org>; Thu, 08 Aug 2013 04:57:38 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: uclinux-dist-devel@blackfin.uclinux.org, gregkh@linuxfoundation.org, jslaby@suse.cz, sachin.kamat@linaro.org, Sonic Zhang <sonic.zhang@analog.com>

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/tty/serial/bfin_sport_uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/bfin_sport_uart.c b/drivers/tty/serial/bfin_sport_uart.c
index 424ed36..016c3e9 100644
--- a/drivers/tty/serial/bfin_sport_uart.c
+++ b/drivers/tty/serial/bfin_sport_uart.c
@@ -884,7 +884,7 @@ static struct platform_driver sport_uart_driver = {
 };
 
 #ifdef CONFIG_SERIAL_BFIN_SPORT_CONSOLE
-static __initdata struct early_platform_driver early_sport_uart_driver = {
+static struct early_platform_driver early_sport_uart_driver __initdata = {
 	.class_str = CLASS_BFIN_SPORT_CONSOLE,
 	.pdrv = &sport_uart_driver,
 	.requested_id = EARLY_PLATFORM_ID_UNSET,
-- 
1.7.9.5

