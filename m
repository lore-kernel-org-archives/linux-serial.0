From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V3 04/10] tty: serial: bcm63xx: Fix typo in MODULE_DESCRIPTION
Date: Tue, 21 Oct 2014 15:23:00 -0700
Message-ID: <1413930186-23168-5-git-send-email-cernekee@gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:60995 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933804AbaJUWXa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Oct 2014 18:23:30 -0400
In-Reply-To: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: robh@kernel.org, grant.likely@linaro.org, arnd@arndb.de, geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

Remove the extra '<' character.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index de95573..b615af2 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -906,5 +906,5 @@ module_init(bcm_uart_init);
 module_exit(bcm_uart_exit);
 
 MODULE_AUTHOR("Maxime Bizon <mbizon@freebox.fr>");
-MODULE_DESCRIPTION("Broadcom 63<xx integrated uart driver");
+MODULE_DESCRIPTION("Broadcom 63xx integrated uart driver");
 MODULE_LICENSE("GPL");
-- 
2.1.1

