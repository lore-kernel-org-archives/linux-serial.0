From: Deepak Saxena <dsaxena@laptop.org>
Subject: [PATCH] Restore serial console speed on resume
Date: Sun, 23 Nov 2008 21:02:23 -0800
Message-ID: <20081124050223.GA26795@trantor.hsd1.or.comcast.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plexity.net ([206.123.115.38]:46665 "EHLO plexity.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbYKXFL6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Nov 2008 00:11:58 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>, Andres Salomon <dilinger@queued.net>, Marcelo Tosatti <mtosatti@redhat.com>


Commit b5b82df6 introduced a change to the 8250 driver which
resets a NATSEMI device to high speed mode in the resume
path. From that commit message, this was added to workaround
broken firmware that disables this mode; however this makes
the serial device unusable (at least on the OLPC XO) when
no_console_suspend is enabled as the port comes out of resume
running at a different speed as when we suspend, thus causing
garbled output in the serial terminal.

This patch workaround this issue by reseting the serial
console speed when resuming regardless of whether we suspended
it or not.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Deepak Saxena <dsaxena@laptop.org>

---

[Resend as I don't see my original message in the linux-serial
 archives]

Marcelo wrote the original patch and the OLPC tree has been carrying it 
since May 24, 2007, just after b5b82df6 went in. I'd like to resolve 
the problem with an upstream-acceptable patch. I'm not attached to this 
being the only way to solve it. Other option are to add a simple 
machine_is_olpc() check to serial8250_resume_port(), or saving more
serial port state in serial8250_suspend_port() if running with a 
NATSEMI port and then restoring it in serial8250_resume_port().

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 874786a..f319c79 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2075,11 +2075,26 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *port)
 	struct uart_state *state = drv->state + port->line;
 	struct device *tty_dev;
 	struct uart_match match = {port, drv};
+	struct ktermios termios;
 
 	mutex_lock(&state->mutex);
 
+	/*
+	 * First try to use the console cflag setting.
+	 */
+	memset(&termios, 0, sizeof(struct ktermios));
+	termios.c_cflag = port->cons->cflag;
+
+	/*
+	 * If that's unset, use the tty termios setting.
+	 */
+	if (state->info && state->info->port.tty && termios.c_cflag == 0)
+		termios = *state->info->port.tty->termios;
+
+
 	if (!console_suspend_enabled && uart_console(port)) {
 		/* no need to resume serial console, it wasn't suspended */
+		port->ops->set_termios(port, &termios, NULL);
 		mutex_unlock(&state->mutex);
 		return 0;
 	}
@@ -2096,20 +2111,6 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *port)
 	 * Re-enable the console device after suspending.
 	 */
 	if (uart_console(port)) {
-		struct ktermios termios;
-
-		/*
-		 * First try to use the console cflag setting.
-		 */
-		memset(&termios, 0, sizeof(struct ktermios));
-		termios.c_cflag = port->cons->cflag;
-
-		/*
-		 * If that's unset, use the tty termios setting.
-		 */
-		if (state->info && state->info->port.tty && termios.c_cflag == 0)
-			termios = *state->info->port.tty->termios;
-
 		uart_change_pm(state, 0);
 		port->ops->set_termios(port, &termios, NULL);
 		console_start(port->cons);

-- 
 Deepak Saxena - Kernel Developer, One Laptop Per Child
   _____   __o                                   (o>
------    -\<,  Give One Laptop, Get One Laptop  //\
 ----- ( )/ ( )  http://www.amazon.com/xo        V_/_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
