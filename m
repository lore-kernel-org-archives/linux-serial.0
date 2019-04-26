From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH 1/2] serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
Date: Fri, 26 Apr 2019 10:36:56 +0200
Message-ID: <20190426083657.5544-1-esben@geanix.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, He Zhe <zhe.he@windriver.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

With serial8250_register_8250_port() forcing UPF_BOOT_AUTOCONF bit on, it
is not possible to register a port without having
serial8250_request_std_resource() called.

For adding a 8250 port to an MFD device, this is problematic, as the
request_mem_region() call will fail, as the MFD device (and rightly  so)
has requested the region.  For this case, the 8250 port should accept
having passed mapbase and membase, and just use that.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/tty/serial/8250/8250_core.c | 36 +++++++++++++++++++++---------------
 include/linux/serial_8250.h         |  2 ++
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index e441221..ddbb0a0 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -957,20 +957,8 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-/**
- *	serial8250_register_8250_port - register a serial port
- *	@up: serial port template
- *
- *	Configure the serial port specified by the request. If the
- *	port exists and is in use, it is hung up and unregistered
- *	first.
- *
- *	The port is then probed and if necessary the IRQ is autodetected
- *	If this fails an error is returned.
- *
- *	On success the port is ready to use and the line number is returned.
- */
-int serial8250_register_8250_port(struct uart_8250_port *up)
+int __serial8250_register_8250_port(struct uart_8250_port *up,
+				    unsigned int extra_flags)
 {
 	struct uart_8250_port *uart;
 	int ret = -ENOSPC;
@@ -993,7 +981,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->port.fifosize     = up->port.fifosize;
 		uart->port.regshift     = up->port.regshift;
 		uart->port.iotype       = up->port.iotype;
-		uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
+		uart->port.flags        = up->port.flags | extra_flags;
 		uart->bugs		= up->bugs;
 		uart->port.mapbase      = up->port.mapbase;
 		uart->port.mapsize      = up->port.mapsize;
@@ -1086,6 +1074,24 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 
 	return ret;
 }
+
+/**
+ *	serial8250_register_8250_port - register a serial port
+ *	@up: serial port template
+ *
+ *	Configure the serial port specified by the request. If the
+ *	port exists and is in use, it is hung up and unregistered
+ *	first.
+ *
+ *	The port is then probed and if necessary the IRQ is autodetected
+ *	If this fails an error is returned.
+ *
+ *	On success the port is ready to use and the line number is returned.
+ */
+int serial8250_register_8250_port(struct uart_8250_port *up)
+{
+	return __serial8250_register_8250_port(up, UPF_BOOT_AUTOCONF);
+}
 EXPORT_SYMBOL(serial8250_register_8250_port);
 
 /**
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 5a655ba..9d1fe2e 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -145,6 +145,8 @@ static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up)
 	return container_of(up, struct uart_8250_port, port);
 }
 
+extern int __serial8250_register_8250_port(struct uart_8250_port *,
+					   unsigned int);
 int serial8250_register_8250_port(struct uart_8250_port *);
 void serial8250_unregister_port(int line);
 void serial8250_suspend_port(int line);
-- 
2.4.11
