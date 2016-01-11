From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 5/8] serial: core: Cleanup uart_open() exit
Date: Sun, 10 Jan 2016 20:23:59 -0800
Message-ID: <1452486242-7297-6-git-send-email-peter@hurleysoftware.com>
References: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

If aborting uart_open() unsuccessfully, retval is non-zero, so the
existing fall-through exit is equivalent.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f8c28a7..f77be14 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1622,15 +1622,12 @@ static int uart_open(struct tty_struct *tty, struct file *filp)
 	/*
 	 * If we succeeded, wait until the port is ready.
 	 */
+err_unlock:
 	mutex_unlock(&port->mutex);
 	if (retval == 0)
 		retval = tty_port_block_til_ready(port, tty, filp);
-
 end:
 	return retval;
-err_unlock:
-	mutex_unlock(&port->mutex);
-	goto end;
 }
 
 static const char *uart_type(struct uart_port *port)
-- 
2.7.0
