Return-Path: <SRS0=hEVs=4Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46E7C10F27
	for <linux-serial@archiver.kernel.org>; Sun,  8 Mar 2020 16:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA45208C3
	for <linux-serial@archiver.kernel.org>; Sun,  8 Mar 2020 16:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCHQcy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:32:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:44926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgCHQcw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 8 Mar 2020 12:32:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D376DB1ED;
        Sun,  8 Mar 2020 16:32:49 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Wells=20Lu=20=E5=91=82=E8=8A=B3=E9=A8=B0?= 
        <wells.lu@sunplus.com>, Dvorkin Dmitry <dvorkin@tibbo.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [RFC 08/11] tty: serial: sunplus: Implement full UART driver
Date:   Sun,  8 Mar 2020 17:32:26 +0100
Message-Id: <20200308163230.4002-9-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200308163230.4002-1-afaerber@suse.de>
References: <20200308163230.4002-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/tty/serial/Kconfig        |   4 +-
 drivers/tty/serial/sunplus-uart.c | 680 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/serial_core.h  |   3 +
 3 files changed, 685 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index ac6dce75c2f3..a178500a6bb5 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1563,7 +1563,7 @@ config SERIAL_MILBEAUT_USIO_CONSOLE
 	  single user mode).
 
 config SERIAL_PLUS1
-	bool "Sunplus Plus1 serial port support"
+	tristate "Sunplus Plus1 serial port support"
 	depends on ARCH_SUNPLUS || COMPILE_TEST
 	select SERIAL_CORE
 	help
@@ -1579,7 +1579,7 @@ config SERIAL_PLUS1_CONSOLE
 	default y
 	help
 	  Say 'Y' here if you wish to use Sunplus SP7021 UART
-	  as the system console. Only earlycon is implemented currently.
+	  as the system console.
 
 endmenu
 
diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
index 959dfab5e07b..9b9442acde9a 100644
--- a/drivers/tty/serial/sunplus-uart.c
+++ b/drivers/tty/serial/sunplus-uart.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -11,11 +12,71 @@
 #include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+
+#define PLUS1_UART_PORT_NUM 5
+#define PLUS1_UART_DEV_NAME "ttySP"
 
 #define REG_DATA		0x00
 #define REG_LSR			0x04
+#define REG_MSR			0x08
+#define REG_LCR			0x0c
+#define REG_MCR			0x10
+#define REG_DIV_L		0x14
+#define REG_DIV_H		0x18
+#define REG_ISC			0x1c
+#define REG_TX_RESIDUE		0x20
+#define REG_RX_RESIDUE		0x24
+#define REG_RX_THRESHOLD	0x28
+#define REG_CLK_SRC		0x2c
 
 #define PLUS1_UART_LSR_TX	BIT(0)
+#define PLUS1_UART_LSR_RX	BIT(1)
+#define PLUS1_UART_LSR_PE	BIT(2)
+#define PLUS1_UART_LSR_OE	BIT(3)
+#define PLUS1_UART_LSR_FE	BIT(4)
+#define PLUS1_UART_LSR_BC	BIT(5)
+#define PLUS1_UART_LSR_TXE	BIT(6)
+
+#define PLUS1_UART_LCR_WL_MASK	GENMASK(1, 0)
+#define PLUS1_UART_LCR_WL5	(0x0 << 0)
+#define PLUS1_UART_LCR_WL6	(0x1 << 0)
+#define PLUS1_UART_LCR_WL7	(0x2 << 0)
+#define PLUS1_UART_LCR_WL8	(0x3 << 0)
+#define PLUS1_UART_LCR_ST	BIT(2)
+#define PLUS1_UART_LCR_PE	BIT(3)
+#define PLUS1_UART_LCR_PR	BIT(4)
+#define PLUS1_UART_LCR_BC	BIT(5)
+
+#define PLUS1_UART_MCR_DTS	BIT(0)
+#define PLUS1_UART_MCR_RTS	BIT(1)
+#define PLUS1_UART_MCR_DCD	BIT(2)
+#define PLUS1_UART_MCR_RI	BIT(3)
+#define PLUS1_UART_MCR_LB	BIT(4)
+#define PLUS1_UART_MCR_AR	BIT(5)
+#define PLUS1_UART_MCR_AC	BIT(6)
+#define PLUS1_UART_MCR_AT	BIT(7)
+
+#define PLUS1_UART_ISC_TX	BIT(0)
+#define PLUS1_UART_ISC_RX	BIT(1)
+#define PLUS1_UART_ISC_LS	BIT(2)
+#define PLUS1_UART_ISC_MS	BIT(3)
+#define PLUS1_UART_ISC_TXM	BIT(4)
+#define PLUS1_UART_ISC_RXM	BIT(5)
+#define PLUS1_UART_ISC_LSM	BIT(6)
+#define PLUS1_UART_ISC_MSM	BIT(7)
+
+static struct uart_driver plus1_uart_driver;
+
+struct plus1_uart_port {
+	struct uart_port port;
+	struct clk *clk;
+};
+
+#define to_plus1_uart_port(prt) container_of(prt, struct plus1_uart_port, prt)
+
+static struct plus1_uart_port *plus1_uart_ports[PLUS1_UART_PORT_NUM];
 
 static inline void plus1_uart_write(struct uart_port *port, unsigned int off, u32 val)
 {
@@ -27,6 +88,447 @@ static inline u32 plus1_uart_read(struct uart_port *port, unsigned int off)
 	return readl_relaxed(port->membase + off);
 }
 
+static void plus1_uart_break_ctl(struct uart_port *port, int ctl)
+{
+	unsigned long flags;
+	u32 lcr;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	lcr = plus1_uart_read(port, REG_LCR);
+	if (ctl)
+		lcr |= PLUS1_UART_LCR_BC;
+	else
+		lcr &= ~PLUS1_UART_LCR_BC;
+	plus1_uart_write(port, REG_LCR, lcr);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void plus1_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	u32 mcr;
+
+	mcr = plus1_uart_read(port, REG_MCR);
+
+	if (mctrl & TIOCM_DTR)
+		mcr |= PLUS1_UART_MCR_DTS;
+	else
+		mcr &= ~PLUS1_UART_MCR_DTS;
+
+	if (mctrl & TIOCM_RTS)
+		mcr |= PLUS1_UART_MCR_RTS;
+	else
+		mcr &= ~PLUS1_UART_MCR_RTS;
+
+	if (mctrl & TIOCM_CAR)
+		mcr |= PLUS1_UART_MCR_DCD;
+	else
+		mcr &= ~PLUS1_UART_MCR_DCD;
+
+	if (mctrl & TIOCM_RI)
+		mcr |= PLUS1_UART_MCR_RI;
+	else
+		mcr &= ~PLUS1_UART_MCR_RI;
+
+	if (mctrl & TIOCM_LOOP)
+		mcr |= PLUS1_UART_MCR_LB;
+	else
+		mcr &= ~PLUS1_UART_MCR_LB;
+
+	plus1_uart_write(port, REG_MCR, mcr);
+}
+
+static unsigned int plus1_uart_get_mctrl(struct uart_port *port)
+{
+	unsigned int mctrl = 0;
+	u32 mcr;
+
+	mcr = plus1_uart_read(port, REG_MCR);
+	if (mcr & PLUS1_UART_MCR_DTS)
+		mctrl |= TIOCM_DTR;
+	if (mcr & PLUS1_UART_MCR_RTS)
+		mctrl |= TIOCM_RTS;
+	if (mcr & PLUS1_UART_MCR_DCD)
+		mctrl |= TIOCM_CAR;
+	if (mcr & PLUS1_UART_MCR_RI)
+		mctrl |= TIOCM_RI;
+	if (mcr & PLUS1_UART_MCR_LB)
+		mctrl |= TIOCM_LOOP;
+	if (mcr & PLUS1_UART_MCR_AC)
+		mctrl |= TIOCM_CTS;
+	return mctrl;
+}
+
+static unsigned int plus1_uart_tx_empty(struct uart_port *port)
+{
+	unsigned long flags;
+	unsigned int ret;
+	u32 lsr;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	lsr = plus1_uart_read(port, REG_LSR);
+	ret = (lsr & PLUS1_UART_LSR_TXE) ? TIOCSER_TEMT : 0;
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return ret;
+}
+
+static void plus1_uart_stop_rx(struct uart_port *port)
+{
+	u32 isc;
+
+	isc = plus1_uart_read(port, REG_ISC);
+	isc &= ~PLUS1_UART_ISC_RXM;
+	plus1_uart_write(port, REG_ISC, isc);
+}
+
+static void plus1_uart_stop_tx(struct uart_port *port)
+{
+	u32 isc;
+
+	isc = plus1_uart_read(port, REG_ISC);
+	isc &= ~PLUS1_UART_ISC_TXM;
+	plus1_uart_write(port, REG_ISC, isc);
+}
+
+static void plus1_uart_start_tx(struct uart_port *port)
+{
+	u32 isc;
+
+	if (uart_tx_stopped(port)) {
+		plus1_uart_stop_tx(port);
+		return;
+	}
+
+	isc = plus1_uart_read(port, REG_ISC);
+	isc |= PLUS1_UART_ISC_TXM;
+	plus1_uart_write(port, REG_ISC, isc);
+}
+
+static void plus1_uart_send_chars(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned int ch;
+
+	if (uart_tx_stopped(port))
+		return;
+
+	if (port->x_char) {
+		//while (!(plus1_uart_read(port, REG_LSR) & PLUS1_UART_LSR_TX))
+		//	cpu_relax();
+		plus1_uart_write(port, REG_DATA, port->x_char);
+		port->icount.tx++;
+		port->x_char = 0;
+	}
+
+	while (plus1_uart_read(port, REG_LSR) & PLUS1_UART_LSR_TX) {
+		if (uart_circ_empty(xmit))
+			break;
+
+		ch = xmit->buf[xmit->tail];
+		plus1_uart_write(port, REG_DATA, ch);
+		xmit->tail = (xmit->tail + 1) & (SERIAL_XMIT_SIZE - 1);
+		port->icount.tx++;
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (uart_circ_empty(xmit))
+		plus1_uart_stop_tx(port);
+}
+
+static void plus1_uart_receive_chars(struct uart_port *port)
+{
+	u32 lsr, val;
+
+	lsr = plus1_uart_read(port, REG_LSR);
+	while (lsr & PLUS1_UART_LSR_RX) {
+		char flag = TTY_NORMAL;
+
+		if (lsr & PLUS1_UART_LSR_OE)
+			port->icount.overrun++;
+
+		if (lsr & PLUS1_UART_LSR_BC) {
+			port->icount.brk++;
+			flag = TTY_BREAK;
+		} else if (lsr & PLUS1_UART_LSR_PE) {
+			port->icount.parity++;
+			flag = TTY_PARITY;
+		} else if (lsr & PLUS1_UART_LSR_FE) {
+			port->icount.frame++;
+
+			lsr &= port->read_status_mask;
+			if (lsr & PLUS1_UART_LSR_FE)
+				flag = TTY_PARITY;
+		} else
+			port->icount.rx++;
+
+		val = plus1_uart_read(port, REG_DATA);
+		val &= 0xff;
+
+		if ((lsr & port->ignore_status_mask) == 0)
+			tty_insert_flip_char(&port->state->port, val, flag);
+
+		lsr = plus1_uart_read(port, REG_LSR);
+	}
+
+	spin_unlock(&port->lock);
+	tty_flip_buffer_push(&port->state->port);
+	spin_lock(&port->lock);
+}
+
+static irqreturn_t plus1_uart_irq(int irq, void *dev_id)
+{
+	struct uart_port *port = dev_id;
+	unsigned long flags;
+	u32 isc;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	isc = plus1_uart_read(port, REG_ISC);
+	if (isc & PLUS1_UART_ISC_RX)
+		plus1_uart_receive_chars(port);
+
+	isc = plus1_uart_read(port, REG_ISC);
+	if (isc & PLUS1_UART_ISC_TX)
+		plus1_uart_send_chars(port);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static void plus1_uart_shutdown(struct uart_port *port)
+{
+	unsigned long flags;
+	u32 mcr;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	plus1_uart_write(port, REG_ISC, 0);
+
+	mcr = plus1_uart_read(port, REG_MCR);
+	mcr &= ~PLUS1_UART_MCR_AC;
+	plus1_uart_write(port, REG_MCR, mcr);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	free_irq(port->irq, port);
+}
+
+static int plus1_uart_startup(struct uart_port *port)
+{
+	unsigned long flags;
+	int ret;
+
+	ret = request_irq(port->irq, plus1_uart_irq, IRQF_TRIGGER_NONE,
+			  "plus1-uart", port);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	plus1_uart_write(port, REG_ISC, PLUS1_UART_ISC_RXM);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return 0;
+}
+
+static void plus1_uart_change_baudrate(struct plus1_uart_port *sp_port,
+				       unsigned long baud)
+{
+	struct uart_port *port = &sp_port->port;
+	unsigned int clk;
+	unsigned int div, ext;
+
+	plus1_uart_write(port, REG_CLK_SRC, (baud > 115200) ? 0 : BIT(0));
+	if (baud > 115200)
+		clk = 202500000;
+	else
+		clk = port->uartclk;
+	clk += baud >> 1;
+	div = clk / baud;
+	ext = div & 0xf;
+	div >>= 4;
+	div--;
+	plus1_uart_write(port, REG_DIV_L, (ext << 12) | (div & 0xff));
+	plus1_uart_write(port, REG_DIV_H, div >> 8);
+}
+
+static void plus1_uart_set_termios(struct uart_port *port,
+				   struct ktermios *termios,
+				   struct ktermios *old)
+{
+	struct plus1_uart_port *sp_port = to_plus1_uart_port(port);
+	unsigned int baud;
+	u32 lcr, mcr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	lcr = plus1_uart_read(port, REG_LCR);
+
+	lcr &= ~PLUS1_UART_LCR_WL_MASK;
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		lcr |= PLUS1_UART_LCR_WL5;
+		break;
+	case CS6:
+		lcr |= PLUS1_UART_LCR_WL6;
+		break;
+	case CS7:
+		lcr |= PLUS1_UART_LCR_WL7;
+		break;
+	case CS8:
+	default:
+		lcr |= PLUS1_UART_LCR_WL8;
+		break;
+	}
+
+	if (termios->c_cflag & CSTOPB)
+		lcr |= PLUS1_UART_LCR_ST;
+	else
+		lcr &= ~PLUS1_UART_LCR_ST;
+
+	if (termios->c_cflag & PARENB) {
+		lcr |= PLUS1_UART_LCR_PE;
+	} else
+		lcr &= ~PLUS1_UART_LCR_PE;
+
+	if ((termios->c_cflag & PARENB) && !(termios->c_cflag & PARODD))
+		lcr |= PLUS1_UART_LCR_PR;
+	else
+		lcr &= ~PLUS1_UART_LCR_PR;
+
+	plus1_uart_write(port, REG_LCR, lcr);
+
+	mcr = plus1_uart_read(port, REG_MCR);
+
+	if (termios->c_cflag & CRTSCTS)
+		mcr |= PLUS1_UART_MCR_AC | PLUS1_UART_MCR_AR;
+	else
+		mcr &= ~(PLUS1_UART_MCR_AC | PLUS1_UART_MCR_AR);
+
+	plus1_uart_write(port, REG_MCR, mcr);
+
+	baud = uart_get_baud_rate(port, termios, old, 0, 202500000 >> 4);
+	plus1_uart_change_baudrate(sp_port, baud);
+
+	/* Don't rewrite B0 */
+	if (tty_termios_baud_rate(termios))
+		tty_termios_encode_baud_rate(termios, baud, baud);
+
+	port->read_status_mask = 0;
+	if (termios->c_iflag & INPCK)
+		port->read_status_mask |= PLUS1_UART_LSR_PE | PLUS1_UART_LSR_FE;
+	if ((termios->c_iflag & BRKINT) || (termios->c_iflag & PARMRK))
+		port->read_status_mask |= PLUS1_UART_LSR_BC;
+
+	port->ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		port->ignore_status_mask |= PLUS1_UART_LSR_PE | PLUS1_UART_LSR_FE;
+	if (termios->c_iflag & IGNBRK) {
+		port->ignore_status_mask |= PLUS1_UART_LSR_BC;
+		if (termios->c_iflag & IGNPAR)
+			port->ignore_status_mask |= PLUS1_UART_LSR_OE;
+	}
+
+	if (!(termios->c_cflag & CREAD))
+		plus1_uart_write(port, REG_RX_RESIDUE, 0);
+
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void plus1_uart_release_port(struct uart_port *port)
+{
+	struct platform_device *pdev = to_platform_device(port->dev);
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return;
+
+	if (port->flags & UPF_IOREMAP) {
+		devm_release_mem_region(port->dev, port->mapbase,
+			resource_size(res));
+		devm_iounmap(port->dev, port->membase);
+		port->membase = NULL;
+	}
+}
+
+static int plus1_uart_request_port(struct uart_port *port)
+{
+	struct platform_device *pdev = to_platform_device(port->dev);
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENXIO;
+
+	if (!devm_request_mem_region(port->dev, port->mapbase,
+			resource_size(res), dev_name(port->dev)))
+		return -EBUSY;
+
+	if (port->flags & UPF_IOREMAP) {
+		port->membase = devm_ioremap(port->dev, port->mapbase,
+				resource_size(res));
+		if (!port->membase)
+			return -EBUSY;
+	}
+
+	return 0;
+}
+
+static const char *plus1_uart_type(struct uart_port *port)
+{
+	return (port->type == PORT_PLUS1) ? "plus1-uart" : NULL;
+}
+
+static int plus1_uart_verify_port(struct uart_port *port,
+				  struct serial_struct *ser)
+{
+	if (port->type != PORT_PLUS1)
+		return -EINVAL;
+
+	if (port->irq != ser->irq)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void plus1_uart_config_port(struct uart_port *port, int flags)
+{
+	if (flags & UART_CONFIG_TYPE) {
+		port->type = PORT_PLUS1;
+		plus1_uart_request_port(port);
+	}
+}
+
+static const struct uart_ops plus1_uart_ops = {
+	.break_ctl	= plus1_uart_break_ctl,
+	.set_mctrl	= plus1_uart_set_mctrl,
+	.get_mctrl	= plus1_uart_get_mctrl,
+	.tx_empty	= plus1_uart_tx_empty,
+	.start_tx	= plus1_uart_start_tx,
+	.stop_rx	= plus1_uart_stop_rx,
+	.stop_tx	= plus1_uart_stop_tx,
+	.startup	= plus1_uart_startup,
+	.shutdown	= plus1_uart_shutdown,
+	.set_termios	= plus1_uart_set_termios,
+	.type		= plus1_uart_type,
+	.config_port	= plus1_uart_config_port,
+	.request_port	= plus1_uart_request_port,
+	.release_port	= plus1_uart_release_port,
+	.verify_port	= plus1_uart_verify_port,
+};
+
 #ifdef CONFIG_SERIAL_PLUS1_CONSOLE
 
 static void plus1_console_putchar(struct uart_port *port, int ch)
@@ -65,6 +567,57 @@ static void plus1_uart_port_write(struct uart_port *port, const char *s,
 	local_irq_restore(flags);
 }
 
+static void plus1_uart_console_write(struct console *co, const char *s,
+				     u_int count)
+{
+	struct plus1_uart_port *sp_port;
+
+	sp_port = plus1_uart_ports[co->index];
+	if (!sp_port)
+		return;
+
+	plus1_uart_port_write(&sp_port->port, s, count);
+}
+
+static int plus1_uart_console_setup(struct console *co, char *options)
+{
+	struct plus1_uart_port *sp_port;
+	int baud = 115200;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	if (co->index < 0 || co->index >= PLUS1_UART_PORT_NUM)
+		return -EINVAL;
+
+	sp_port = plus1_uart_ports[co->index];
+	if (!sp_port || !sp_port->port.membase)
+		return -ENODEV;
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(&sp_port->port, co, baud, parity, bits, flow);
+}
+
+static struct console plus1_uart_console = {
+	.name = PLUS1_UART_DEV_NAME,
+	.write = plus1_uart_console_write,
+	.device = uart_console_device,
+	.setup = plus1_uart_console_setup,
+	.flags = CON_PRINTBUFFER,
+	.index = -1,
+	.data = &plus1_uart_driver,
+};
+
+static int __init plus1_uart_console_init(void)
+{
+	register_console(&plus1_uart_console);
+
+	return 0;
+}
+console_initcall(plus1_uart_console_init);
+
 static void plus1_uart_early_console_write(struct console *co,
 					   const char *s,
 					   u_int count)
@@ -87,4 +640,131 @@ plus1_uart_early_console_setup(struct earlycon_device *device, const char *opt)
 OF_EARLYCON_DECLARE(sunplus, "sunplus,sp7021-uart",
 		    plus1_uart_early_console_setup);
 
+#define PLUS1_UART_CONSOLE (&plus1_uart_console)
+#else
+#define PLUS1_UART_CONSOLE NULL
 #endif
+
+static struct uart_driver plus1_uart_driver = {
+	.owner = THIS_MODULE,
+	.driver_name = "plus1-uart",
+	.dev_name = PLUS1_UART_DEV_NAME,
+	.nr = PLUS1_UART_PORT_NUM,
+	.cons = PLUS1_UART_CONSOLE,
+};
+
+static int plus1_uart_probe(struct platform_device *pdev)
+{
+	struct resource *res_mem;
+	struct plus1_uart_port *sp_port;
+	int ret, irq;
+
+	if (pdev->dev.of_node)
+		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
+
+	if (pdev->id < 0 || pdev->id >= PLUS1_UART_PORT_NUM) {
+		dev_err(&pdev->dev, "id %d out of range\n", pdev->id);
+		return -EINVAL;
+	}
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res_mem) {
+		dev_err(&pdev->dev, "could not get mem\n");
+		return -ENODEV;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	if (plus1_uart_ports[pdev->id]) {
+		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
+		return -EBUSY;
+	}
+
+	sp_port = devm_kzalloc(&pdev->dev, sizeof(*sp_port), GFP_KERNEL);
+	if (!sp_port)
+		return -ENOMEM;
+
+	sp_port->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(sp_port->clk)) {
+		dev_err(&pdev->dev, "could not get clk\n");
+		return PTR_ERR(sp_port->clk);
+	}
+
+	sp_port->port.dev = &pdev->dev;
+	sp_port->port.line = pdev->id;
+	sp_port->port.type = PORT_PLUS1;
+	sp_port->port.iotype = UPIO_MEM;
+	sp_port->port.mapbase = res_mem->start;
+	sp_port->port.irq = irq;
+	sp_port->port.uartclk = clk_get_rate(sp_port->clk);
+	if (sp_port->port.uartclk == 0) {
+		dev_err(&pdev->dev, "clock rate is zero\n");
+		return -EINVAL;
+	}
+	sp_port->port.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP | UPF_LOW_LATENCY;
+	sp_port->port.x_char = 0;
+	sp_port->port.fifosize = 16;
+	sp_port->port.ops = &plus1_uart_ops;
+
+	plus1_uart_ports[pdev->id] = sp_port;
+	platform_set_drvdata(pdev, sp_port);
+
+	ret = uart_add_one_port(&plus1_uart_driver, &sp_port->port);
+	if (ret)
+		plus1_uart_ports[pdev->id] = NULL;
+
+	return ret;
+}
+
+static int plus1_uart_remove(struct platform_device *pdev)
+{
+	struct plus1_uart_port *sp_port = platform_get_drvdata(pdev);
+
+	uart_remove_one_port(&plus1_uart_driver, &sp_port->port);
+	plus1_uart_ports[pdev->id] = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id plus1_uart_dt_matches[] = {
+	{ .compatible = "sunplus,sp7021-uart" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, plus1_uart_dt_matches);
+
+static struct platform_driver plus1_uart_platform_driver = {
+	.probe = plus1_uart_probe,
+	.remove = plus1_uart_remove,
+	.driver = {
+		.name = "plus1-uart",
+		.of_match_table = plus1_uart_dt_matches,
+	},
+};
+
+static int __init plus1_uart_init(void)
+{
+	int ret;
+
+	ret = uart_register_driver(&plus1_uart_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&plus1_uart_platform_driver);
+	if (ret)
+		uart_unregister_driver(&plus1_uart_driver);
+
+	return ret;
+}
+
+static void __exit plus1_uart_exit(void)
+{
+	platform_driver_unregister(&plus1_uart_platform_driver);
+	uart_unregister_driver(&plus1_uart_driver);
+}
+
+module_init(plus1_uart_init);
+module_exit(plus1_uart_exit);
+
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 8ec3dd742ea4..54c611b06735 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -293,4 +293,7 @@
 /* Freescale LINFlexD UART */
 #define PORT_LINFLEXUART	122
 
+/* SunPlus Plus1 UART */
+#define PORT_PLUS1	123
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.16.4

