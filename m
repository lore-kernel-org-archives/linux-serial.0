From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH trivial 02/16] serial_core: Grammar s/ports/port's/
Date: Tue, 11 Mar 2014 11:23:36 +0100
Message-ID: <1394533430-4746-2-git-send-email-geert@linux-m68k.org>
References: <1394533430-4746-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394533430-4746-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <trivial@kernel.org>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/serial_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6735e5f074cf..8ee90f731f31 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2611,7 +2611,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 
 	/*
 	 * Register the port whether it's detected or not.  This allows
-	 * setserial to be used to alter this ports parameters.
+	 * setserial to be used to alter this port's parameters.
 	 */
 	tty_dev = tty_port_register_device_attr(port, drv->tty_driver,
 			uport->line, uport->dev, port, tty_dev_attr_groups);
-- 
1.7.9.5
