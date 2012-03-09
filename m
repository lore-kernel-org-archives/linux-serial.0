From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/7] serial: make 8250's serial_in shareable to other drivers.
Date: Thu,  8 Mar 2012 19:12:09 -0500
Message-ID: <1331251934-25540-3-git-send-email-paul.gortmaker@windriver.com>
References: <1331251934-25540-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44811 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab2CIAM3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Mar 2012 19:12:29 -0500
In-Reply-To: <1331251934-25540-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>

Currently 8250.c has serial_in and serial_out as shortcuts
to doing the port I/O.  They are implemented as macros a
ways down in the file.  This isn't by accident, but is
implicitly required, so cpp doesn't mangle other instances
of the common string "serial_in", as it exists as a field
in the port struct itself.

The above mangling avoidance violates the principle of least
surprise, and it also prevents the shortcuts from being
relocated up to the top of file, or into 8250.h -- either
being a better location than the current one.

Move them to 8250.h so other 8250-like drivers can also use
the shortcuts, and in the process, make the conflicting
names go away by using static inlines instead of macros.
The object file size remains unchanged with this modification.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/8250/8250.c |    5 -----
 drivers/tty/serial/8250/8250.h |   10 ++++++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 9674eac..4009e24 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -482,11 +482,6 @@ serial_out_sync(struct uart_8250_port *up, int offset, int value)
 	}
 }
 
-#define serial_in(up, offset)		\
-	(up->port.serial_in(&(up)->port, (offset)))
-#define serial_out(up, offset, value)	\
-	(up->port.serial_out(&(up)->port, (offset), (value)))
-
 /* Uart divisor latch read */
 static inline int _serial_dl_read(struct uart_8250_port *up)
 {
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index ae027be..2868a1d 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -86,6 +86,16 @@ struct serial8250_config {
 #define SERIAL8250_SHARE_IRQS 0
 #endif
 
+static inline int serial_in(struct uart_8250_port *up, int offset)
+{
+	return up->port.serial_in(&up->port, offset);
+}
+
+static inline void serial_out(struct uart_8250_port *up, int offset, int value)
+{
+	up->port.serial_out(&up->port, offset, value);
+}
+
 #if defined(__alpha__) && !defined(CONFIG_PCI)
 /*
  * Digital did something really horribly wrong with the OUT1 and OUT2
-- 
1.7.9.1

