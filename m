From: Mans Rullgard <mans@mansr.com>
Subject: [RESEND][PATCH] serial: 8250: simplify ralink/alchemy register remap selection
Date: Fri,  2 Oct 2015 11:15:59 +0100
Message-ID: <1443780960-6519-1-git-send-email-mans@mansr.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Some SoCs, including Ralink/Mediatek and Alchemy Au1xxx, have a
16550-like UART with a non-standard register layout.  These are
supported by a simple mapping table in 8250_port.c  Rather than
list every SoC type using this access mode in the ifdefs there,
allow selecting the SERIAL_8250_RT288X Kconfig option with any
system and default it to y for the known cases needing it.  The
help text is reworded accordingly.

This change simplifies adding support for other SoCs also using
the same UART.

The name of the option is a little misleading, but not knowing
the true origin of this UART, it is as good a choice as any.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/tty/serial/8250/8250_port.c | 4 ++--
 drivers/tty/serial/8250/Kconfig     | 9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 54e6c8d..a2ff31c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -276,7 +276,7 @@ static void default_serial_dl_write(struct uart_8250_port *up, int value)
 	serial_out(up, UART_DLM, value >> 8 & 0xff);
 }
 
-#if defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_SERIAL_8250_RT288X)
+#ifdef CONFIG_SERIAL_8250_RT288X
 
 /* Au1x00/RT288x UART hardware has a weird register layout */
 static const s8 au_io_in_map[8] = {
@@ -427,7 +427,7 @@ static void set_io_from_upio(struct uart_port *p)
 		p->serial_out = mem32be_serial_out;
 		break;
 
-#if defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_SERIAL_8250_RT288X)
+#ifdef CONFIG_SERIAL_8250_RT288X
 	case UPIO_AU:
 		p->serial_in = au_serial_in;
 		p->serial_out = au_serial_out;
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index e1de118..a51c75c 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -294,11 +294,12 @@ config SERIAL_8250_EM
 
 config SERIAL_8250_RT288X
 	bool "Ralink RT288x/RT305x/RT3662/RT3883 serial port support"
-	depends on SERIAL_8250 && (SOC_RT288X || SOC_RT305X || SOC_RT3883 || SOC_MT7620)
+	depends on SERIAL_8250
+	default y if MIPS_ALCHEMY || SOC_RT288X || SOC_RT305X || SOC_RT3883 || SOC_MT7620
 	help
-	  If you have a Ralink RT288x/RT305x SoC based board and want to use the
-	  serial port, say Y to this option. The driver can handle up to 2 serial
-	  ports. If unsure, say N.
+	  Selecting this option will add support for the alternate register
+	  layout used by Ralink RT288x/RT305x, Alchemy Au1xxx, and some others.
+	  If unsure, say N.
 
 config SERIAL_8250_OMAP
 	tristate "Support for OMAP internal UART (8250 based driver)"
-- 
2.5.3
