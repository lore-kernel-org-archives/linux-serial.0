From: Ed Blake <ed.blake@imgtec.com>
Subject: [PATCH 1/2] serial: 8250: Expose set_ldisc function
Date: Thu, 27 Oct 2016 17:37:27 +0100
Message-ID: <1477586247-15698-1-git-send-email-ed.blake@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, andriy.shevchenko@linux.intel.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, peter@hurleysoftware.com, alexander.sverdlin@nokia.com, yegorslists@googlemail.com, matwey@sai.msu.ru, yamada.masahiro@socionext.com, tthayer@opensource.altera.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, james.hartley@imgtec.com, Ed Blake <ed.blake@imgtec.com>
List-Id: linux-serial@vger.kernel.org

Expose set_ldisc() function so that it can be overridden with a
platform specific implementation.

Signed-off-by: Ed Blake <ed.blake@imgtec.com>
---
 drivers/tty/serial/8250/8250_core.c |  3 +++
 drivers/tty/serial/8250/8250_port.c | 12 ++++++++++--
 include/linux/serial_8250.h         |  4 ++++
 include/linux/serial_core.h         |  2 ++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 240a361..3ad8c80 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -830,6 +830,7 @@ static int serial8250_probe(struct platform_device *dev)
 		uart.port.handle_irq	= p->handle_irq;
 		uart.port.handle_break	= p->handle_break;
 		uart.port.set_termios	= p->set_termios;
+		uart.port.set_ldisc	= p->set_ldisc;
 		uart.port.get_mctrl	= p->get_mctrl;
 		uart.port.pm		= p->pm;
 		uart.port.dev		= &dev->dev;
@@ -1023,6 +1024,8 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		/*  Possibly override set_termios call */
 		if (up->port.set_termios)
 			uart->port.set_termios = up->port.set_termios;
+		if (up->port.set_ldisc)
+			uart->port.set_ldisc = up->port.set_ldisc;
 		if (up->port.get_mctrl)
 			uart->port.get_mctrl = up->port.get_mctrl;
 		if (up->port.set_mctrl)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1bfb6fd..38c5856 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2690,8 +2690,7 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 		serial8250_do_set_termios(port, termios, old);
 }
 
-static void
-serial8250_set_ldisc(struct uart_port *port, struct ktermios *termios)
+void serial8250_do_set_ldisc(struct uart_port *port, struct ktermios *termios)
 {
 	if (termios->c_line == N_PPS) {
 		port->flags |= UPF_HARDPPS_CD;
@@ -2707,7 +2706,16 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 		}
 	}
 }
+EXPORT_SYMBOL(serial8250_do_set_ldisc);
 
+static void
+serial8250_set_ldisc(struct uart_port *port, struct ktermios *termios)
+{
+	if (port->set_ldisc)
+		port->set_ldisc(port, termios);
+	else
+		serial8250_do_set_ldisc(port, termios);
+}
 
 void serial8250_do_pm(struct uart_port *port, unsigned int state,
 		      unsigned int oldstate)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 48ec765..f350bf4 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -36,6 +36,8 @@ struct plat_serial8250_port {
 	void		(*set_termios)(struct uart_port *,
 			               struct ktermios *new,
 			               struct ktermios *old);
+	void		(*set_ldisc)(struct uart_port *,
+				     struct ktermios *);
 	unsigned int	(*get_mctrl)(struct uart_port *);
 	int		(*handle_irq)(struct uart_port *);
 	void		(*pm)(struct uart_port *, unsigned int state,
@@ -149,6 +151,8 @@ extern int early_serial8250_setup(struct earlycon_device *device,
 					 const char *options);
 extern void serial8250_do_set_termios(struct uart_port *port,
 		struct ktermios *termios, struct ktermios *old);
+extern void serial8250_do_set_ldisc(struct uart_port *port,
+				    struct ktermios *termios);
 extern unsigned int serial8250_do_get_mctrl(struct uart_port *port);
 extern int serial8250_do_startup(struct uart_port *port);
 extern void serial8250_do_shutdown(struct uart_port *port);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 3442014..5d49488 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -123,6 +123,8 @@ struct uart_port {
 	void			(*set_termios)(struct uart_port *,
 				               struct ktermios *new,
 				               struct ktermios *old);
+	void			(*set_ldisc)(struct uart_port *,
+					     struct ktermios *);
 	unsigned int		(*get_mctrl)(struct uart_port *);
 	void			(*set_mctrl)(struct uart_port *, unsigned int);
 	int			(*startup)(struct uart_port *port);
-- 
1.9.1
