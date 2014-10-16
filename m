From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 07/10] serial: core: Remove redundant timeout assignments
Date: Thu, 16 Oct 2014 16:54:24 -0400
Message-ID: <1413492867-20679-8-git-send-email-peter@hurleysoftware.com>
References: <1413492867-20679-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413492867-20679-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

tty_port_init() initializes close_delay and closing_wait to these
same values; remove.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index be58916..676c03a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2346,8 +2346,6 @@ int uart_register_driver(struct uart_driver *drv)
 
 		tty_port_init(port);
 		port->ops = &uart_port_ops;
-		port->close_delay     = HZ / 2;	/* .5 seconds */
-		port->closing_wait    = 30 * HZ;/* 30 seconds */
 	}
 
 	retval = tty_register_driver(normal);
-- 
2.1.1
