From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 5/8] serial/bcm63xx_uart: Deinline wait_for_xmitr, save 374 bytes
Date: Tue, 27 Oct 2015 17:39:59 +0100
Message-ID: <1445964002-10093-6-git-send-email-dvlasenk@redhat.com>
References: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This function compiles to 141 bytes of machine code.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Hurley <peter@hurleysoftware.com>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial@vger.kernel.org
---
 drivers/tty/serial/bcm63xx_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 681e0f3..b2d2b05 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -653,7 +653,7 @@ static struct uart_ops bcm_uart_ops = {
 
 
 #ifdef CONFIG_SERIAL_BCM63XX_CONSOLE
-static inline void wait_for_xmitr(struct uart_port *port)
+static void wait_for_xmitr(struct uart_port *port)
 {
 	unsigned int tmout;
 
-- 
1.8.1.4
