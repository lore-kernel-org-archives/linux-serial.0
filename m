From: Thomas Koeller <thomas.koeller@baslerweb.com>
Subject: [PATCH] RM9000 serial driver
Date: Mon, 12 Feb 2007 02:57:27 +0200
Message-ID: <200702120157.27449.thomas.koeller@baslerweb.com>
References: <45CE0CFF.1000105@ru.mvista.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <45CE0CFF.1000105@ru.mvista.com>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: akpm@osdl.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-serial@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-serial@vger.kernel.org

This patch adds support for the integrated serial ports of the MIPS RM9122
processor and its relatives. There has been some discussion about this
patch. The interesting part starts here:

http://marc.theaimsgroup.com/?l=linux-mips&m=115620115100412&w=2

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
---
 arch/mips/Kconfig           |    3 +
 drivers/serial/8250.c       |  102 +++++++++++++++++++++++++++++++-----------
 drivers/serial/Kconfig      |    9 ++++
 include/linux/serial_core.h |    3 +-
 4 files changed, 89 insertions(+), 28 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 34a52c8..5317ebb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1004,6 +1004,9 @@ config SOC_AU1X00
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
 
+config SERIAL_RM9000
+	bool
+
 config PNX8550
 	bool
 	select SOC_PNX8550
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 5261f0a..3f0fec4 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -251,9 +251,16 @@ static const struct serial8250_config ua
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO | UART_CAP_UUE,
 	},
+	[PORT_RM9000] = {
+		.name		= "RM9000",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
-#ifdef CONFIG_SERIAL_8250_AU1X00
+#if defined (CONFIG_SERIAL_8250_AU1X00)
 
 /* Au1x00 UART hardware has a weird register layout */
 static const u8 au_io_in_map[] = {
@@ -289,6 +296,36 @@ static inline int map_8250_out_reg(struc
 	return au_io_out_map[offset];
 }
 
+#elif defined (CONFIG_SERIAL_8250_RM9K)
+
+static const u8
+	regmap_in[8] = {
+		[UART_RX]	= 0x00,
+		[UART_IER]	= 0x0c,
+		[UART_IIR]	= 0x14,
+		[UART_LCR]	= 0x1c,
+		[UART_MCR]	= 0x20,
+		[UART_LSR]	= 0x24,
+		[UART_MSR]	= 0x28,
+		[UART_SCR]	= 0x2c
+	},
+	regmap_out[8] = {
+		[UART_TX] 	= 0x04,
+		[UART_IER]	= 0x0c,
+		[UART_FCR]	= 0x18,
+		[UART_LCR]	= 0x1c,
+		[UART_MCR]	= 0x20,
+		[UART_LSR]	= 0x24,
+		[UART_MSR]	= 0x28,
+		[UART_SCR]	= 0x2c
+	};
+
+#define map_8250_in_reg(up, offset) \
+	(((up)->port.type == PORT_RM9000) ? regmap_in[offset] : (offset))
+#define map_8250_out_reg(up, offset) \
+	(((up)->port.type == PORT_RM9000) ? regmap_out[offset] : (offset))
+
+
 #else
 
 /* sane hardware needs no mapping */
@@ -374,21 +411,21 @@ #define serial_inp(up, offset)		serial_i
 #define serial_outp(up, offset, value)	serial_out(up, offset, value)
 
 /* Uart divisor latch read */
-static inline int _serial_dl_read(struct uart_8250_port *up)
+static inline unsigned int _serial_dl_read(struct uart_8250_port *up)
 {
 	return serial_inp(up, UART_DLL) | serial_inp(up, UART_DLM) << 8;
 }
 
 /* Uart divisor latch write */
-static inline void _serial_dl_write(struct uart_8250_port *up, int value)
+static inline void _serial_dl_write(struct uart_8250_port *up, unsigned int 
value)
 {
 	serial_outp(up, UART_DLL, value & 0xff);
 	serial_outp(up, UART_DLM, value >> 8 & 0xff);
 }
 
-#ifdef CONFIG_SERIAL_8250_AU1X00
+#if defined (CONFIG_SERIAL_8250_AU1X00)
 /* Au1x00 haven't got a standard divisor latch */
-static int serial_dl_read(struct uart_8250_port *up)
+static unsigned int serial_dl_read(struct uart_8250_port *up)
 {
 	if (up->port.iotype == UPIO_AU)
 		return __raw_readl(up->port.membase + 0x28);
@@ -396,13 +433,26 @@ static int serial_dl_read(struct uart_82
 		return _serial_dl_read(up);
 }
 
-static void serial_dl_write(struct uart_8250_port *up, int value)
+static void serial_dl_write(struct uart_8250_port *up, unsigned int value)
 {
 	if (up->port.iotype == UPIO_AU)
 		__raw_writel(value, up->port.membase + 0x28);
 	else
 		_serial_dl_write(up, value);
 }
+#elif defined (CONFIG_SERIAL_8250_RM9K)
+static inline unsigned int serial_dl_read(struct uart_8250_port *up)
+{
+	return
+		((readl(up->port.membase + 0x10) << 8) |
+		(readl(up->port.membase + 0x08) & 0xff)) & 0xffff;
+}
+
+static inline void serial_dl_write(struct uart_8250_port *up, unsigned int 
value)
+{
+	writel(value, up->port.membase + 0x08);
+	writel(value >> 8, up->port.membase + 0x10);
+}
 #else
 #define serial_dl_read(up) _serial_dl_read(up)
 #define serial_dl_write(up, value) _serial_dl_write(up, value)
@@ -576,22 +626,17 @@ static int size_fifo(struct uart_8250_po
  */
 static unsigned int autoconfig_read_divisor_id(struct uart_8250_port *p)
 {
-	unsigned char old_dll, old_dlm, old_lcr;
-	unsigned int id;
+	unsigned char old_lcr;
+	unsigned int id, old_dl;
 
 	old_lcr = serial_inp(p, UART_LCR);
 	serial_outp(p, UART_LCR, UART_LCR_DLAB);
+	old_dl = _serial_dl_read(p);
 
-	old_dll = serial_inp(p, UART_DLL);
-	old_dlm = serial_inp(p, UART_DLM);
+	serial_dl_write(p, 0);
+	id = serial_dl_read(p);
 
-	serial_outp(p, UART_DLL, 0);
-	serial_outp(p, UART_DLM, 0);
-
-	id = serial_inp(p, UART_DLL) | serial_inp(p, UART_DLM) << 8;
-
-	serial_outp(p, UART_DLL, old_dll);
-	serial_outp(p, UART_DLM, old_dlm);
+	serial_dl_write(p, old_dl);
 	serial_outp(p, UART_LCR, old_lcr);
 
 	return id;
@@ -604,7 +649,7 @@ static unsigned int autoconfig_read_divi
  * its clones.  (We treat the broken original StarTech 16650 V1 as a
  * 16550, and why not?  Startech doesn't seem to even acknowledge its
  * existence.)
- * 
+ *
  * What evil have men's minds wrought...
  */
 static void autoconfig_has_efr(struct uart_8250_port *up)
@@ -657,7 +702,7 @@ static void autoconfig_has_efr(struct ua
 			up->bugs |= UART_BUG_QUOT;
 		return;
 	}
-	
+
 	/*
 	 * We check for a XR16C850 by setting DLL and DLM to 0, and then
 	 * reading back DLL and DLM.  The chip type depends on the DLM
@@ -800,7 +845,7 @@ static void autoconfig_16550a(struct uar
 			status1 &= ~0xB0; /* Disable LOCK, mask out PRESL[01] */
 			status1 |= 0x10;  /* 1.625 divisor for baud_base --> 921600 */
 			serial_outp(up, 0x04, status1);
-			
+
 			serial_dl_write(up, quot);
 
 			serial_outp(up, UART_LCR, 0);
@@ -905,7 +950,7 @@ static void autoconfig(struct uart_8250_
 		/*
 		 * Do a simple existence test first; if we fail this,
 		 * there's no point trying anything else.
-		 * 
+		 *
 		 * 0x80 is used as a nonsense port to prevent against
 		 * false positives due to ISA bus float.  The
 		 * assumption is that 0x80 is a non-existent port;
@@ -940,7 +985,7 @@ #endif
 	save_mcr = serial_in(up, UART_MCR);
 	save_lcr = serial_in(up, UART_LCR);
 
-	/* 
+	/*
 	 * Check to see if a UART is really there.  Certain broken
 	 * internal modems based on the Rockwell chipset fail this
 	 * test, because they apparently don't implement the loopback
@@ -1047,7 +1092,7 @@ #endif
 	else
 		serial_outp(up, UART_IER, 0);
 
- out:	
+ out:
 	spin_unlock_irqrestore(&up->port.lock, flags);
 //	restore_flags(flags);
 	DEBUG_AUTOCONF("type=%s\n", uart_config[up->port.type].name);
@@ -1073,7 +1118,7 @@ static void autoconfig_irq(struct uart_8
 	save_mcr = serial_inp(up, UART_MCR);
 	save_ier = serial_inp(up, UART_IER);
 	serial_outp(up, UART_MCR, UART_MCR_OUT1 | UART_MCR_OUT2);
-	
+
 	irqs = probe_irq_on();
 	serial_outp(up, UART_MCR, 0);
 	udelay (10);
@@ -1138,8 +1183,11 @@ static void serial8250_start_tx(struct u
 		if (up->bugs & UART_BUG_TXEN) {
 			unsigned char lsr, iir;
 			lsr = serial_in(up, UART_LSR);
-			iir = serial_in(up, UART_IIR);
-			if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT)
+			iir = serial_in(up, UART_IIR) & 0x0f;
+			if ((up->port.type == PORT_RM9000) ?
+				(lsr & UART_LSR_THRE &&
+				(iir == UART_IIR_NO_INT || iir == UART_IIR_THRI)) :
+				(lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT))
 				transmit_chars(up);
 		}
 	}
@@ -1801,7 +1849,7 @@ #endif
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
+	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
 	quot = serial8250_get_divisor(port, baud);
 
 	/*
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 9ddfb84..228ae12 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -254,6 +254,15 @@ config SERIAL_8250_AU1X00
 	  to this option.  The driver can handle 1 or 2 serial ports.
 	  If unsure, say N.
 
+config SERIAL_8250_RM9K
+	bool "Support for MIPS RM9xxx integrated serial port"
+	depends on SERIAL_8250 != n && SERIAL_RM9000
+	select SERIAL_8250_SHARE_IRQ
+	help
+	  Selecting this option will add support for the integrated serial
+	  port hardware found on MIPS RM9122 and similar processors.
+	  If unsure, say N.
+
 comment "Non-8250 serial port support"
 
 config SERIAL_AMBA_PL010
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index cf23813..275392f 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -39,7 +39,8 @@ #define PORT_16850	12
 #define PORT_RSA	13
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
-#define PORT_MAX_8250	15	/* max port ID */
+#define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
+#define PORT_MAX_8250	16	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
-- 
1.4.3
