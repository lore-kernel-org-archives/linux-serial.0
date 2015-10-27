From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 08/15] serial/omap-serial: Deinline wait_for_xmitr, save 165 bytes
Date: Tue, 27 Oct 2015 18:46:40 +0100
Message-ID: <1445968007-12616-9-git-send-email-dvlasenk@redhat.com>
References: <1445968007-12616-1-git-send-email-dvlasenk@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445968007-12616-1-git-send-email-dvlasenk@redhat.com>
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
 drivers/tty/serial/omap-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 7a2172b..d404698 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1163,7 +1163,7 @@ serial_omap_type(struct uart_port *port)
 
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
 
-static inline void wait_for_xmitr(struct uart_omap_port *up)
+static void wait_for_xmitr(struct uart_omap_port *up)
 {
 	unsigned int status, tmout = 10000;
 
-- 
1.8.1.4
