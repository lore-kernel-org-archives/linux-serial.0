From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support
Date: Thu, 24 Dec 2015 11:24:48 +0100
Message-ID: <1450952688-20573-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Yoshinori Sato <ysato@users.sourceforge.jp>

"earlyprintk" is architecture specific option.
General "earlycon" option support is much better.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
[uli: preserve other SCSCR bits when asserting RE and TE]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
[geert: rewording, #ifdef rework]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on commit e1dd3bef6d03c908 ("serial: earlycon: Add missing
spinlock initialization"), which is now in v4.4-rc6.

I applies to tty-next with and without merging the pending pull request of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git \
scif-clk-sck-brg-for-v4.5
---
 drivers/tty/serial/Kconfig  |  6 ++++
 drivers/tty/serial/sh-sci.c | 77 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 1aec4404062d8f19..5ff8c64304665903 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -742,6 +742,12 @@ config SERIAL_SH_SCI_CONSOLE
 	depends on SERIAL_SH_SCI=y
 	select SERIAL_CORE_CONSOLE
 
+config SERIAL_SH_SCI_EARLYCON
+	bool "Support for early console on SuperH SCI(F)"
+	depends on SERIAL_SH_SCI=y
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+
 config SERIAL_SH_SCI_DMA
 	bool "DMA support"
 	depends on SERIAL_SH_SCI && DMA_ENGINE
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 960e50a97558cff5..b296d0783f72199d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -580,7 +580,8 @@ static void sci_clear_SCxSR(struct uart_port *port, unsigned int mask)
 	}
 }
 
-#if defined(CONFIG_CONSOLE_POLL) || defined(CONFIG_SERIAL_SH_SCI_CONSOLE)
+#if defined(CONFIG_CONSOLE_POLL) || defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
+    defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
 
 #ifdef CONFIG_CONSOLE_POLL
 static int sci_poll_get_char(struct uart_port *port)
@@ -621,7 +622,8 @@ static void sci_poll_put_char(struct uart_port *port, unsigned char c)
 	serial_port_out(port, SCxTDR, c);
 	sci_clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
 }
-#endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE */
+#endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE ||
+	  CONFIG_SERIAL_SH_SCI_EARLYCON */
 
 static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 {
@@ -2411,7 +2413,8 @@ static void sci_cleanup_single(struct sci_port *port)
 	pm_runtime_disable(port->port.dev);
 }
 
-#ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
+#if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
+    defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
 static void serial_console_putchar(struct uart_port *port, int ch)
 {
 	sci_poll_put_char(port, ch);
@@ -2431,9 +2434,12 @@ static void serial_console_write(struct console *co, const char *s,
 	int locked = 1;
 
 	local_irq_save(flags);
+#if defined(SUPPORT_SYSRQ)
 	if (port->sysrq)
 		locked = 0;
-	else if (oops_in_progress)
+	else
+#endif
+	if (oops_in_progress)
 		locked = spin_trylock(&port->lock);
 	else
 		spin_lock(&port->lock);
@@ -2541,7 +2547,7 @@ static inline int sci_probe_earlyprintk(struct platform_device *pdev)
 
 #define SCI_CONSOLE	NULL
 
-#endif /* CONFIG_SERIAL_SH_SCI_CONSOLE */
+#endif /* CONFIG_SERIAL_SH_SCI_CONSOLE || CONFIG_SERIAL_SH_SCI_EARLYCON */
 
 static const char banner[] __initconst = "SuperH (H)SCI(F) driver initialized";
 
@@ -2789,6 +2795,67 @@ static void __exit sci_exit(void)
 early_platform_init_buffer("earlyprintk", &sci_driver,
 			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
 #endif
+#ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
+static struct __init plat_sci_port port_cfg;
+
+static int __init early_console_setup(struct earlycon_device *device,
+				      int type)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->port.serial_in = sci_serial_in;
+	device->port.serial_out	= sci_serial_out;
+	device->port.type = type;
+	memcpy(&sci_ports[0].port, &device->port, sizeof(struct uart_port));
+	sci_ports[0].cfg = &port_cfg;
+	sci_ports[0].cfg->type = type;
+	sci_probe_regmap(sci_ports[0].cfg);
+	port_cfg.scscr = sci_serial_in(&sci_ports[0].port, SCSCR) |
+			 SCSCR_RE | SCSCR_TE;
+	sci_serial_out(&sci_ports[0].port, SCSCR, port_cfg.scscr);
+
+	device->con->write = serial_console_write;
+	return 0;
+}
+static int __init sci_early_console_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	return early_console_setup(device, PORT_SCI);
+}
+static int __init scif_early_console_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	return early_console_setup(device, PORT_SCIF);
+}
+static int __init scifa_early_console_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	return early_console_setup(device, PORT_SCIFA);
+}
+static int __init scifb_early_console_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	return early_console_setup(device, PORT_SCIFB);
+}
+static int __init hscif_early_console_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	return early_console_setup(device, PORT_HSCIF);
+}
+
+EARLYCON_DECLARE(sci, sci_early_console_setup);
+OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
+EARLYCON_DECLARE(scif, scif_early_console_setup);
+OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
+EARLYCON_DECLARE(scifa, scifa_early_console_setup);
+OF_EARLYCON_DECLARE(scifa, "renesas,scifa", scifa_early_console_setup);
+EARLYCON_DECLARE(scifb, scifb_early_console_setup);
+OF_EARLYCON_DECLARE(scifb, "renesas,scifb", scifb_early_console_setup);
+EARLYCON_DECLARE(hscif, hscif_early_console_setup);
+OF_EARLYCON_DECLARE(hscif, "renesas,hscif", hscif_early_console_setup);
+#endif /* CONFIG_SERIAL_SH_SCI_EARLYCON */
+
 module_init(sci_init);
 module_exit(sci_exit);
 
-- 
1.9.1

