From: Thomas Koeller <thomas.koeller@baslerweb.com>
Subject: Re: [PATCH] RM9000 serial driver
Date: Sat, 26 Aug 2006 00:38:13 +0200
Message-ID: <200608260038.13662.thomas.koeller@baslerweb.com>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608220057.52213.thomas.koeller@baslerweb.com> <20060822095942.4663a4cd.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail04.hansenet.de ([213.191.73.12]:32760 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP
	id S1751544AbWHYWis (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Aug 2006 18:38:48 -0400
In-Reply-To: <20060822095942.4663a4cd.yoichi_yuasa@tripeaks.co.jp>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: sshtylyov@ru.mvista.com, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org, Thomas =?iso-8859-1?q?K=F6ller?= <thomas.koeller@baslerweb.com>

On Tuesday 22 August 2006 02:59, Yoichi Yuasa wrote:
>
> If you have an another standard 8250 port. this driver cannot support it
> You should do as well as AU1X00.
>
> Yoichi

Hi Yoichi,

so far nobody commented on my recent mail, in which I explained why I
think that the AU1X00 code in 8250.c is not entirely correct, so I assume
nobody cares. I therefore modified my code to take the same approach,
although I still have my doubts about it. Here's the updated patch:



Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
---
832ac1406f2530b7971cb0d23d3ede20a6057fa1
 drivers/serial/8250.c       |   86 ++++++++++++++++++++++++++++++++++---------
 drivers/serial/Kconfig      |    9 +++++
 include/linux/serial_core.h |    3 +-
 3 files changed, 78 insertions(+), 20 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 0ae9ced..afe0e1f 100644
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
+static inline void _serial_dl_write(struct uart_8250_port *up, unsigned int value)
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
+static inline void serial_dl_write(struct uart_8250_port *up, unsigned int value)
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
-
-	serial_outp(p, UART_DLL, 0);
-	serial_outp(p, UART_DLM, 0);
-
-	id = serial_inp(p, UART_DLL) | serial_inp(p, UART_DLM) << 8;
+	serial_dl_write(p, 0);
+	id = serial_dl_read(p);
 
-	serial_outp(p, UART_DLL, old_dll);
-	serial_outp(p, UART_DLM, old_dlm);
+	serial_dl_write(p, old_dl);
 	serial_outp(p, UART_LCR, old_lcr);
 
 	return id;
@@ -1138,8 +1183,11 @@ static void serial8250_start_tx(struct u
 		if (up->bugs & UART_BUG_TXEN) {
 			unsigned char lsr, iir;
 			lsr = serial_in(up, UART_LSR);
-			iir = serial_in(up, UART_IIR);
-			if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT)
+			iir = serial_in(up, UART_IIR) & 0x0f;
+			if ((up->port.type == PORT_RM9000) ?
+			   	(lsr & UART_LSR_THRE &&
+				(iir == UART_IIR_NO_INT || iir == UART_IIR_THRI)) :
+				(lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT))
 				transmit_chars(up);
 		}
 	}
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 9799cce..dfb51ff 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -244,6 +244,15 @@ config SERIAL_8250_AU1X00
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
index 86501a3..8a97caf 100644
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
Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com
