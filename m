From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 05/10] TTY: serial, document few functions
Date: Wed,  9 Nov 2011 21:33:47 +0100
Message-ID: <1320870831-23778-5-git-send-email-jslaby@suse.cz>
References: <1320870831-23778-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320870831-23778-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jirislaby@gmail.com, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Just put a kernel-doc comment to uart_change_pm and uart_insert_char.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@linux.intel.com>
---
 drivers/tty/serial/serial_core.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index fcb5342..036e0cc 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1822,6 +1822,14 @@ uart_set_options(struct uart_port *port, struct console *co,
 EXPORT_SYMBOL_GPL(uart_set_options);
 #endif /* CONFIG_SERIAL_CORE_CONSOLE */
 
+/**
+ * uart_change_pm - set power state of the port
+ *
+ * @state: port descriptor
+ * @pm_state: new state
+ *
+ * Locking: port->mutex has to be held
+ */
 static void uart_change_pm(struct uart_state *state, int pm_state)
 {
 	struct uart_port *port = state->uart_port;
@@ -2495,6 +2503,18 @@ void uart_handle_cts_change(struct uart_port *uport, unsigned int status)
 }
 EXPORT_SYMBOL_GPL(uart_handle_cts_change);
 
+/**
+ * uart_insert_char - push a char to the uart layer
+ *
+ * User is responsible to call tty_flip_buffer_push when they are done with
+ * insertion.
+ *
+ * @port: corresponding port
+ * @status: state of the serial port RX buffer (LSR for 8250)
+ * @overrun: mask of overrun bits in @status
+ * @ch: character to push
+ * @flag: flag for the character (see TTY_NORMAL and friends)
+ */
 void uart_insert_char(struct uart_port *port, unsigned int status,
 		 unsigned int overrun, unsigned int ch, unsigned int flag)
 {
-- 
1.7.7
