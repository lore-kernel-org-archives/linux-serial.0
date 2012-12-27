From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 2/3] tty: Update serial core API documentation
Date: Wed, 26 Dec 2012 20:43:42 -0800
Message-ID: <36136cf35664198e8f218ad347ae566f@localhost>
References: <c141e9cf9329550e53d18c9a8a2c6246@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [69.28.251.93] ([69.28.251.93]:60076 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab2L0Eyb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Dec 2012 23:54:31 -0500
In-Reply-To: <c141e9cf9329550e53d18c9a8a2c6246@localhost>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-serial@vger.kernel.org

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 Documentation/serial/driver |   39 +++++++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h |    8 ++++----
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 0a25a91..c680678 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -133,6 +133,16 @@ hardware.
 	Interrupts: locally disabled.
 	This call must not sleep
 
+  send_xchar(port,ch)
+	Transmit a high priority character, even if the port is stopped.
+	This is used to implement XON/XOFF flow control and tcflow().  If
+	the serial driver does not implement this function, the tty core
+	will append the character to the circular buffer and then call
+	start_tx() / stop_tx() to flush the data out.
+
+	Locking: none.
+	Interrupts: caller dependent.
+
   stop_rx(port)
 	Stop receiving characters; the port is in the process of
 	being closed.
@@ -255,6 +265,10 @@ hardware.
 	Locking: none.
 	Interrupts: caller dependent.
 
+  set_wake(port,state)
+	Enable/disable power management wakeup on serial activity.  Not
+	currently implemented.
+
   type(port)
 	Return a pointer to a string constant describing the specified
 	port, or return NULL, in which case the string 'unknown' is
@@ -307,6 +321,31 @@ hardware.
 	Locking: none.
 	Interrupts: caller dependent.
 
+  poll_init(port)
+	Called by kgdb to perform the minimal hardware initialization needed
+	to support poll_put_char() and poll_get_char().  Unlike ->startup()
+	this should not request interrupts.
+
+	Locking: tty_mutex and tty_port->mutex taken.
+	Interrupts: n/a.
+
+  poll_put_char(port,ch)
+	Called by kgdb to write a single character directly to the serial
+	port.  It can and should block until there is space in the TX FIFO.
+
+	Locking: none.
+	Interrupts: caller dependent.
+	This call must not sleep
+
+  poll_get_char(port)
+	Called by kgdb to read a single character directly from the serial
+	port.  If data is available, it should be returned; otherwise
+	the function should return NO_POLL_CHAR immediately.
+
+	Locking: none.
+	Interrupts: caller dependent.
+	This call must not sleep
+
 Other functions
 ---------------
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index c6690a2..ccfeab2 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -37,8 +37,8 @@ struct serial_struct;
 struct device;
 
 /*
- * This structure describes all the operations that can be
- * done on the physical hardware.
+ * This structure describes all the operations that can be done on the
+ * physical hardware.  See Documentation/serial/driver for details.
  */
 struct uart_ops {
 	unsigned int	(*tx_empty)(struct uart_port *);
@@ -65,7 +65,7 @@ struct uart_ops {
 	/*
 	 * Return a string describing the type of the port
 	 */
-	const char *(*type)(struct uart_port *);
+	const char	*(*type)(struct uart_port *);
 
 	/*
 	 * Release IO and memory resources used by the port.
@@ -83,7 +83,7 @@ struct uart_ops {
 	int		(*ioctl)(struct uart_port *, unsigned int, unsigned long);
 #ifdef CONFIG_CONSOLE_POLL
 	int		(*poll_init)(struct uart_port *);
-	void	(*poll_put_char)(struct uart_port *, unsigned char);
+	void		(*poll_put_char)(struct uart_port *, unsigned char);
 	int		(*poll_get_char)(struct uart_port *);
 #endif
 };
-- 
1.7.10.4

