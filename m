From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 05/15] serial/m32r_sio: Deinline wait_for_xmitr, save 165 bytes
Date: Tue, 27 Oct 2015 18:46:37 +0100
Message-ID: <1445968007-12616-6-git-send-email-dvlasenk@redhat.com>
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
 drivers/tty/serial/m32r_sio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/m32r_sio.c b/drivers/tty/serial/m32r_sio.c
index 8f7f83a..0eeb64f 100644
--- a/drivers/tty/serial/m32r_sio.c
+++ b/drivers/tty/serial/m32r_sio.c
@@ -990,7 +990,7 @@ static void __init m32r_sio_register_ports(struct uart_driver *drv)
 /*
  *	Wait for transmitter & holding register to empty
  */
-static inline void wait_for_xmitr(struct uart_sio_port *up)
+static void wait_for_xmitr(struct uart_sio_port *up)
 {
 	unsigned int status, tmout = 10000;
 
-- 
1.8.1.4
