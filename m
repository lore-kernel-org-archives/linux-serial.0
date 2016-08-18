From: Rob Herring <robh@kernel.org>
Subject: [RFC PATCH 2/3] tty: serial_core: make tty_struct optional
Date: Wed, 17 Aug 2016 20:14:44 -0500
Message-ID: <20160818011445.22726-3-robh@kernel.org>
References: <20160818011445.22726-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818011445.22726-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In order to allow serial drivers to work without a tty, make calls from
drivers and serial_core work when tty_struct is NULL.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/serial_core.c | 3 ++-
 drivers/tty/tty_buffer.c         | 2 ++
 include/linux/serial_core.h      | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9fc1533..9dd444f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -111,7 +111,8 @@ void uart_write_wakeup(struct uart_port *port)
 	 * closed.  No cookie for you.
 	 */
 	BUG_ON(!state);
-	tty_wakeup(state->port.tty);
+	if (state->port.tty)
+		tty_wakeup(state->port.tty);
 }
 
 static void uart_stop(struct tty_struct *tty)
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index aa80dc9..ffab8ea 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -528,6 +528,8 @@ static void flush_to_ldisc(struct work_struct *work)
 
 void tty_flip_buffer_push(struct tty_port *port)
 {
+	if (!port->tty)
+		return;
 	tty_schedule_flip(port);
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 2f44e20..a27ca1f 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -412,7 +412,7 @@ int uart_resume_port(struct uart_driver *reg, struct uart_port *port);
 static inline int uart_tx_stopped(struct uart_port *port)
 {
 	struct tty_struct *tty = port->state->port.tty;
-	if (tty->stopped || port->hw_stopped)
+	if ((tty && tty->stopped) || port->hw_stopped)
 		return 1;
 	return 0;
 }
-- 
2.9.2
