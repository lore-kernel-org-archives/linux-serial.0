From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH] RFC: serial: core: Dynamic minor support
Date: Thu, 20 Apr 2017 14:03:57 +0200
Message-ID: <20170420120357.18317-1-sjoerd.simons@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Quite a few serial port drivers use the "Low-density serial ports" major
which is rather packed. And ofcourse as time passes, things get slightly
less dense. For example the SCI serial port driver has an allocation of
4 minors, but in reality it supports up to 11 ports these days. Causing
it to overlap with the allocations for the AMBA PL010 serial port and
firmware console. While some other drivers are simply using minor
regions never allocated to them (both samsung and AMBA PL011 serial user
minor 64 and onwards while those are allocated to the Altix serial card
driver).

Cleary this doesn't scale.

Furthermore some other drivers rely upon the usage of a dynamic major
e.g. the tegra serial port driver. However as there is only a block of
20 major numbers reserved for dynamic assignment that isn't going to
scale either for multiplatform kernels (I can already easily build 18
different serial drivers on an arm64 kernel today).

This patch tries to address the issue adding a new to configuration
option which will let all serial ports use the "Low-density serial
ports" major and dynamically allocate minor ranges out of that rather
then using the driver defined areas. Given there are 20 bits worth of
minors available this should be enough for everyone... This option is
not enabled by default (for now) to not break setups with a static /dev.

This does not try to address device naming by making all serial ports be
ttyS<value> as that would first need a better way of deterministically
specifying serial console devices. While it would be an option to move
to consistent serial device naming while keeping the current console
names, having both not aligned would probably confuse everyone
massively.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

 drivers/tty/serial/Kconfig       | 10 ++++++++++
 drivers/tty/serial/serial_core.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h      |  6 ++++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 6117ac8da48f..65a7261f3060 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -7,6 +7,16 @@ if TTY
 menu "Serial drivers"
 	depends on HAS_IOMEM
 
+config SERIAL_DYNAMIC_MINORS
+	bool "Dynamic serial minors allocation"
+	help
+	  If you say Y here the serial subsystem will use dynamic minors for all
+	  serial devices, using the Low density serial port major. Note that
+	  this requires the system to a non-static /dev to support a getty on
+	  serial console.
+
+	  If you are unsure about this, say N here.
+
 config SERIAL_EARLYCON
 	bool
 	help
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3fe56894974a..37014c70dd69 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -44,6 +44,32 @@
  */
 static DEFINE_MUTEX(port_mutex);
 
+#ifdef CONFIG_SERIAL_DYNAMIC_MINORS
+/* List of uarts to allow for allocation of dynamic minor ranges*/
+LIST_HEAD(dynamic_uarts);
+DEFINE_MUTEX(dynamic_uarts_mutex);
+
+static void
+uart_setup_major_minor(struct uart_driver *drv)
+{
+	int start = 0;
+	struct uart_driver *d;
+
+	drv->major = LOW_DENSITY_UART_MAJOR;
+	mutex_lock(&dynamic_uarts_mutex);
+
+	list_for_each_entry(d, &dynamic_uarts, dynamic_uarts) {
+		if (start + drv->nr < d->minor)
+			break;
+		start = d->minor + d->nr;
+	}
+	list_add_tail(&drv->dynamic_uarts, &d->dynamic_uarts);
+	drv->minor = start;
+
+	mutex_unlock(&dynamic_uarts_mutex);
+}
+#endif
+
 /*
  * lockdep: port->lock is initialized in two places, but we
  *          want only one lock-class:
@@ -2458,6 +2484,11 @@ int uart_register_driver(struct uart_driver *drv)
 
 	BUG_ON(drv->state);
 
+#ifdef CONFIG_SERIAL_DYNAMIC_MINORS
+	INIT_LIST_HEAD(&drv->dynamic_uarts);
+	uart_setup_major_minor(drv);
+#endif
+
 	/*
 	 * Maybe we should be using a slab cache for this, especially if
 	 * we have a large number of ports to handle.
@@ -2527,6 +2558,13 @@ void uart_unregister_driver(struct uart_driver *drv)
 	put_tty_driver(p);
 	for (i = 0; i < drv->nr; i++)
 		tty_port_destroy(&drv->state[i].port);
+
+#ifdef CONFIG_SERIAL_DYNAMIC_MINORS
+	mutex_lock(&dynamic_uarts_mutex);
+	list_del(&drv->dynamic_uarts);
+	mutex_unlock(&dynamic_uarts_mutex);
+#endif
+
 	kfree(drv->state);
 	drv->state = NULL;
 	drv->tty_driver = NULL;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 58484fb35cc8..890bbefb3f90 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -31,6 +31,8 @@
 #include <linux/sysrq.h>
 #include <uapi/linux/serial_core.h>
 
+#define LOW_DENSITY_UART_MAJOR 204
+
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
 #define uart_console(port) \
 	((port)->cons && (port)->cons->index == (port)->line)
@@ -313,6 +315,10 @@ struct uart_driver {
 	 */
 	struct uart_state	*state;
 	struct tty_driver	*tty_driver;
+
+#ifdef CONFIG_SERIAL_DYNAMIC_MINORS
+	struct list_head	dynamic_uarts;
+#endif
 };
 
 void uart_write_wakeup(struct uart_port *port);
-- 
2.11.0
