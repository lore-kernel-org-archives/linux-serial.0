From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 7/8] serial_core: Deinline uart_update_mctrl, save 304 bytes
Date: Tue, 27 Oct 2015 17:40:01 +0100
Message-ID: <1445964002-10093-8-git-send-email-dvlasenk@redhat.com>
References: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This function compiles to 92 bytes of machine code.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Hurley <peter@hurleysoftware.com>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial@vger.kernel.org
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 603d2cc..0eed1fc 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -110,7 +110,7 @@ static void uart_start(struct tty_struct *tty)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static inline void
+static void
 uart_update_mctrl(struct uart_port *port, unsigned int set, unsigned int clear)
 {
 	unsigned long flags;
-- 
1.8.1.4
