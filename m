Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649D93F410C
	for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781090952; cv=none; b=knAtXtx9B15ZGBvv+DWdoUXf+TcQtFujrQ0MS1OVSKyssY+1OYpB/775GOp0L5AU2J/XdHB8msxtFxWXRIUECq97qO/Vsy5FulWlMp1+h8e4XGYDd2e65vGbBrPjbeOWf+ARcMyumCPL2vDdWmudlLcJDmClWfgHYxBeQ9rse8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781090952; c=relaxed/simple;
	bh=Bn8fAQEmtWN3+dSFXVn4dkP7nOh03bwZrIfNZ3hPnV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s6RhZTPqDVZHokPLnieboKiyK/XU079+dvwvqUJXsalzpICHZtrBb9ckfqn2gUrLfowQu3pvt1SOtzmg43AJke6d0yx9Sh/LqE2FBJFmG4VLYQVGIKjDMgaT+CGmc0CPN8wFghpgG1NlX+zdqjTus4zfOOaXceA3PqBrYQTJxN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0ZUbsRr; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0ZUbsRr"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so7168592a91.3
        for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 04:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781090949; x=1781695749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCrW1VRFVws3dzzbHFVtnFmbHXSMZbOXCvW32uQBIsM=;
        b=c0ZUbsRrLQvN+zCWR07q2MquT8MCXeFWoYSZVu6TbNNRqMb3hXDpfBjjTLG32u1hqU
         3QhQ+7Fwssqsk5E0u1Va5YmTmId0wFpHK4ByUAYz+WmjX2bj2BPnL3ZBNckhBGaefnl1
         LE9Ds3ZeWOiyFJmuKMPLUPJhHRjIDBFeqh1+2NpQmkGNhlFXgxk1SEEjMmo9c9BbnsBw
         9eLlQI/37iRZlR5nucc2h7kxu0wWp8mt1WjzdExywNeHF8n6fmXUs0Qaw3+CggU9S60u
         Ub9cThT6NDK2IWEUmrYaG3jxQEnAlROBswbm5Tjig296ebG/9x2Bt5Ahu2d3us/z0ZM2
         h6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781090949; x=1781695749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yCrW1VRFVws3dzzbHFVtnFmbHXSMZbOXCvW32uQBIsM=;
        b=hk6xPr+KIXlkrfSffR9xjqUspUh8IJkK1FL76dpBp3zD2Fqva6cSC2LryVTtHW5URj
         /pJeVO0/wFV5+CDx0yeWbjN/Lj1ZFl7QpkHWwS199HnJrc3JnbgJw4zU6XoFxXPbKNP2
         UCZt/08pvS64Wv1H5cw27ZHyzUgdI59+MRYtXJBS7A9lfvAb8uH97tp0jcd1xsrwaluZ
         ni6gF6qRFOZVegpgezuvGU3wZXRFv2ho+RjyPlKBbrLMaWDaymsoefkQbdML2pYA/BrH
         iH9X69529T6Ef0bbs+ZxsCvSFtWOHD+kPWxQn0QQLXrusIsHlMTSzV9He7X/T3ecazGL
         L8Uw==
X-Forwarded-Encrypted: i=1; AFNElJ/IMAuJ46Qx359MXAzAQmABHcV1pfpHnYrJxHeSqAic7S5z7o3wU10DySy5CcgoYhGQ40Su9m4KY5+zhZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVFLHCuOvBbzEvDTI4RxHhwHbhr2Zx3lrS9MtpBfGK2WOHdy4Q
	JElZIXCJ1+ko50LmR/H4Pvbvp2h64gPYjcmRluispQoEcMGhKRT+3KVz
X-Gm-Gg: Acq92OFGeBqBkdSMbCpzwZ5rgQ+JyDcneiUvDm1ai0QEYvMI4TSiLU50hiTurJDLIxP
	tq9CGeOUt5mhQtmUNR9sE5e+TBXZmttUBOiMOnyN9hj/nqqunyogwM6gJZ08LZvYeksmGg5bJ/x
	gZEVX+7BoFnKKuxmO2dm5SVlGausGg6h8V7vvT21Q+rAJEjOaGa3EgqGQBOeGGtIxL+sgq2uz3k
	N7LU2OVqIlkwuB5Z5Xx/AUeUC4pGPpZ07QAA8lnTJiSAiXWJts45kOBPberl8ixc0/3yzS5O1pf
	uHDi8CMTQ9IUdadXRKaa1ZYUs2FYl7jZybW1YK4HAceqaGJjQXA4zRVm9VchlYFKXIeLTb5zns0
	EMTg3Bsy/8rC79x73pCU2+rh2JsEaPoTJrUygetDc8Slrkzb9mM//qFhdzWWqiUURO/1HcCzjcF
	hTO/VSZSsHC8zDFdLV/AOtrKaw+Icg+ZTIbQYTjFtTqwbtdU67L1UlSg==
X-Received: by 2002:a17:90a:e185:b0:36b:95f7:564e with SMTP id 98e67ed59e1d1-370ee344778mr26262318a91.2.1781090948606;
        Wed, 10 Jun 2026 04:29:08 -0700 (PDT)
Received: from hc-pb-01.realtek.com ([123.51.179.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-376460ee14fsm2027651a91.1.2026.06.10.04.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:29:08 -0700 (PDT)
From: Jason Li <jason.lee651024@gmail.com>
X-Google-Original-From: Jason Li <jason.li@cortina-access.com>
To: jason.li@cortina-access.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] tty: serial: Add UART driver for Cortina-Access platform
Date: Wed, 10 Jun 2026 19:28:20 +0800
Message-Id: <20260610112821.3030099-4-jason.li@cortina-access.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260610112821.3030099-1-jason.li@cortina-access.com>
References: <20260610112821.3030099-1-jason.li@cortina-access.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver supports Cortina Access UART IP integrated
in most CAXXXX line of SoCs. Earlycon is also supported.

Signed-off-by: Jason Li <jason.li@cortina-access.com>
Assisted-by: Claude:claude-opus-4-8
---
 MAINTAINERS                                |   6 +
 drivers/tty/serial/Kconfig                 |  21 +
 drivers/tty/serial/Makefile                |   1 +
 drivers/tty/serial/serial_cortina-access.c | 755 +++++++++++++++++++++
 4 files changed, 783 insertions(+)
 create mode 100644 drivers/tty/serial/serial_cortina-access.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cc261888fae0..515d89d96472 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6687,6 +6687,12 @@ S:	Maintained
 F:	Documentation/hwmon/corsair-psu.rst
 F:	drivers/hwmon/corsair-psu.c
 
+CORTINA-ACCESS SERIAL CONSOLE DRIVER
+M:	Jason Li <jason.li@cortina-access.com>
+L:	linux-serial@vger.kernel.org
+S:	Supported
+F:	drivers/tty/serial/serial_cortina-access.c
+
 COUNTER SUBSYSTEM
 M:	William Breathitt Gray <wbg@kernel.org>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index cf7dba473b20..99a1c9308395 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1592,6 +1592,27 @@ config SERIAL_NUVOTON_MA35D1_CONSOLE
 	  but you can alter that using a kernel command line option such as
 	  "console=ttyNVTx".
 
+config SERIAL_CORTINA_ACCESS
+	tristate "Cortina-Access serial port support"
+	depends on OF
+	select SERIAL_CORE
+	help
+	  This driver is for the Cortina-Access SoC UART, present in the
+	  CA8289 (Venus) and related CAXXXX family of SoCs. If you have a
+	  machine based on the Cortina-Access SoC and wish to use the serial
+	  port, say 'Y' here. Otherwise, say 'N'.
+
+config SERIAL_CORTINA_ACCESS_CONSOLE
+	bool "Console on Cortina-Access serial port"
+	depends on SERIAL_CORTINA_ACCESS=y
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	help
+	  Say 'Y' here if you wish to use the Cortina-Access UART as the system
+	  console (the device which receives all kernel messages and warnings
+	  and which allows logins in single user mode).
+	  /dev/ttyS* is the default device node.
+
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index bba7b21a4a1d..54866c419714 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -98,3 +98,4 @@ obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
 
 obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
 obj-$(CONFIG_SERIAL_NUVOTON_MA35D1) += ma35d1_serial.o
+obj-$(CONFIG_SERIAL_CORTINA_ACCESS) += serial_cortina-access.o
diff --git a/drivers/tty/serial/serial_cortina-access.c b/drivers/tty/serial/serial_cortina-access.c
new file mode 100644
index 000000000000..f25eae987ccd
--- /dev/null
+++ b/drivers/tty/serial/serial_cortina-access.c
@@ -0,0 +1,755 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  UART driver for Cortina-Access SoC platform
+ *  Copyright (C) 2026 Cortina-Access Inc.
+ */
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/sysrq.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+
+/***************************************
+ *	UART Related registers
+ ****************************************/
+/* register definitions */
+#define	CFG			0x00
+#define	FC			0x04
+#define	RX_SAMPLE		0x08
+#define	RT_TUNE			0x0C
+#define	TX_DAT			0x10
+#define	RX_DAT			0x14
+#define	INFO			0x18
+#define	IE			0x1C
+#define	INT			0x24
+#define	STATUS			0x2C
+
+/* CFG */
+#define	CFG_STOP_2BIT		BIT(2)
+#define	CFG_PARITY_EVEN		BIT(3)
+#define	CFG_PARITY_EN		BIT(4)
+#define	CFG_TX_EN		BIT(5)
+#define	CFG_RX_EN		BIT(6)
+#define	CFG_UART_EN		BIT(7)
+#define	CFG_BAUD_SART_SHIFT	8
+
+/* INFO */
+#define	INFO_TX_EMPTY		BIT(3)
+#define	INFO_TX_FULL		BIT(2)
+#define	INFO_RX_EMPTY		BIT(1)
+#define	INFO_RX_FULL		BIT(0)
+
+/* Interrupt */
+#define	RX_BREAK		BIT(7)
+#define	RX_FIFO_NONEMPTYE	BIT(6)
+#define	TX_FIFO_EMPTYE		BIT(5)
+#define	RX_FIFO_UNDERRUNE	BIT(4)
+#define	RX_FIFO_OVERRUNE	BIT(3)
+#define	RX_PARITY_ERRE		BIT(2)
+#define	RX_STOP_ERRE		BIT(1)
+#define	TX_FIFO_OVERRUNE	BIT(0)
+
+#define TX_TIMEOUT		5000
+#define UART_NR			4
+#define CA_UART_NAME_LEN	32
+
+struct cortina_uart_port {
+	struct uart_port uart;
+	char name[CA_UART_NAME_LEN];
+	char has_bi;
+	unsigned int may_wakeup;
+};
+
+static struct cortina_uart_port *cortina_uart_ports;
+
+static irqreturn_t cortina_uart_interrupt(int irq, void *dev_id);
+static inline void cortina_uart_interrupt_tx_chars(struct uart_port *port);
+
+/* Return uart_port pointer based on index */
+static struct cortina_uart_port *cortina_uart_get_port(unsigned int index)
+{
+	struct cortina_uart_port *pca_port = cortina_uart_ports;
+
+	if (index >= UART_NR)
+		index = 0;
+
+	pca_port += index;
+
+	return pca_port;
+}
+
+/* uart_ops functions */
+static unsigned int cortina_uart_tx_empty(struct uart_port *port)
+{
+	/* Return 0 on FIFO full condition, TIOCSER_TEMT otherwise */
+	return (readl(port->membase + INFO) & INFO_TX_EMPTY) ? TIOCSER_TEMT : 0;
+}
+
+static void cortina_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	/*
+	 * Even if we do not support configuring the modem control lines, this
+	 * function must be provided to the serial core.
+	 * port->ops->set_mctrl() is called in uart_configure_port()
+	 */
+}
+
+static unsigned int cortina_uart_get_mctrl(struct uart_port *port)
+{
+	/* Unimplemented signals asserted, per Documentation/serial/driver */
+	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+}
+
+static void cortina_uart_stop_tx(struct uart_port *port)
+{
+	/* Turn off Tx interrupts. The port lock is held at this point */
+	unsigned int reg_v;
+
+	reg_v = readl(port->membase + IE);
+	writel(reg_v & ~TX_FIFO_EMPTYE, port->membase + IE);
+}
+
+static void cortina_uart_start_tx(struct uart_port *port)
+{
+	/* Turn on Tx interrupts. The port lock is held at this point */
+	unsigned int reg_v;
+
+	reg_v = readl(port->membase + IE);
+	writel(reg_v | TX_FIFO_EMPTYE, port->membase + IE);
+
+	reg_v = readl(port->membase + CFG);
+	writel(reg_v | CFG_TX_EN, port->membase + CFG);
+
+	/*
+	 * If TX FIFO is already empty the TX_FIFO_EMPTY interrupt may be
+	 * edge-triggered and won't fire again.  Kick-start the transmission
+	 * explicitly so the first character is not lost.
+	 */
+	if (readl(port->membase + INFO) & INFO_TX_EMPTY)
+		cortina_uart_interrupt_tx_chars(port);
+}
+
+static void cortina_uart_stop_rx(struct uart_port *port)
+{
+	/* Turn off Rx interrupts. The port lock is held at this point */
+	unsigned int reg_v;
+
+	reg_v = readl(port->membase + IE);
+	writel(reg_v & ~RX_FIFO_NONEMPTYE, port->membase + IE);
+}
+
+static void cortina_uart_enable_ms(struct uart_port *port)
+{
+	/* Nope, you really can't hope to attach a modem to this */
+}
+
+static int cortina_uart_startup(struct uart_port *port)
+{
+	unsigned int reg_v;
+	int retval;
+	unsigned long flags;
+
+	/* Disable interrupts */
+	writel(0, port->membase + IE);
+
+	retval = request_irq(port->irq, cortina_uart_interrupt, 0,
+			     "cortina_uart", port);
+	if (retval)
+		return retval;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	reg_v = readl(port->membase + CFG);
+	reg_v |= (CFG_UART_EN | CFG_TX_EN | CFG_RX_EN | 0x3 /* 8-bits data */);
+	writel(reg_v, port->membase + CFG);
+	reg_v = readl(port->membase + IE);
+	writel(reg_v | RX_FIFO_NONEMPTYE | TX_FIFO_EMPTYE, port->membase + IE);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+	return 0;
+}
+
+static void cortina_uart_shutdown(struct uart_port *port)
+{
+	cortina_uart_stop_tx(port);
+	cortina_uart_stop_rx(port);
+	free_irq(port->irq, port);
+}
+
+static void cortina_uart_set_termios(struct uart_port *port,
+				     struct ktermios *termios,
+				     const struct ktermios *old)
+{
+	unsigned long flags;
+	int baud;
+	unsigned int reg_v, sample_freq = 0;
+
+	baud = uart_get_baud_rate(port, termios, old, 0, 230400);
+	reg_v = readl(port->membase + CFG);
+	/* mask off the baud settings */
+	reg_v &= 0xff;
+	reg_v |= (port->uartclk / baud) << CFG_BAUD_SART_SHIFT;
+
+	/* Sampling rate should be half of baud count */
+	sample_freq = (reg_v >> CFG_BAUD_SART_SHIFT) / 2;
+
+	/* See include/uapi/asm-generic/termbits.h for CSIZE definition */
+	/* mask off the data width */
+	reg_v &= 0xfffffffc;
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		reg_v |= 0x0;
+		break;
+	case CS6:
+		reg_v |= 0x1;
+		break;
+	case CS7:
+		reg_v |= 0x2;
+		break;
+	case CS8:
+	default:
+		reg_v |= 0x3;
+		break;
+	}
+
+	/* mask off Stop bits */
+	reg_v &= ~(CFG_STOP_2BIT);
+	if (termios->c_cflag & CSTOPB)
+		reg_v |= CFG_STOP_2BIT;
+
+	/* Parity */
+	reg_v &= ~(CFG_PARITY_EN);
+	reg_v |= CFG_PARITY_EVEN;
+	if (termios->c_cflag & PARENB) {
+		reg_v |= CFG_PARITY_EN;
+		if (termios->c_cflag & PARODD)
+			reg_v &= ~(CFG_PARITY_EVEN);
+	}
+
+	spin_lock_irqsave(&port->lock, flags);
+	writel(reg_v, port->membase + CFG);
+	writel(sample_freq, port->membase + RX_SAMPLE);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static const char *cortina_uart_type(struct uart_port *port)
+{
+	return container_of(port, struct cortina_uart_port, uart)->name;
+}
+
+static void cortina_uart_config_port(struct uart_port *port, int flags)
+{
+	/*
+	 * Driver core for serial ports forces a non-zero value for port type.
+	 * Write an arbitrary value here to accommodate the serial core driver,
+	 * as ID part of UAPI is redundant.
+	 */
+	port->type = 1;
+}
+
+static int cortina_uart_verify_port(struct uart_port *port,
+				    struct serial_struct *ser)
+{
+	if (ser->type != PORT_UNKNOWN && ser->type != 1)
+		return -EINVAL;
+	return 0;
+}
+
+static void cortina_access_power(struct uart_port *port, unsigned int state,
+				 unsigned int oldstate)
+{
+	unsigned int reg_v;
+
+	reg_v = readl(port->membase + CFG);
+	switch (state) {
+	case UART_PM_STATE_ON:
+		reg_v |= CFG_UART_EN;
+		break;
+	case UART_PM_STATE_OFF:
+		reg_v &= ~CFG_UART_EN;
+		break;
+	default:
+		pr_err("cortina-access serial: Unknown PM state %d\n", state);
+	}
+	writel(reg_v, port->membase + CFG);
+}
+
+#ifdef CONFIG_CONSOLE_POLL
+static int cortina_poll_get_char(struct uart_port *port)
+{
+	if (readl(port->membase + INFO) & INFO_RX_EMPTY)
+		return NO_POLL_CHAR;
+
+	return readl(port->membase + RX_DAT);
+}
+
+static void cortina_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	unsigned long time_out;
+
+	time_out = jiffies + usecs_to_jiffies(TX_TIMEOUT);
+
+	while (time_before(jiffies, time_out) &&
+	       (readl(port->membase + INFO) & INFO_TX_FULL))
+		cpu_relax();
+
+	/* Give up if FIFO stuck! */
+	if (readl(port->membase + INFO) & INFO_TX_FULL)
+		return;
+
+	writel(c, port->membase + TX_DAT);
+}
+#endif /* CONFIG_CONSOLE_POLL */
+
+static const struct uart_ops cortina_uart_ops = {
+	.tx_empty	= cortina_uart_tx_empty,
+	.set_mctrl	= cortina_uart_set_mctrl,
+	.get_mctrl	= cortina_uart_get_mctrl,
+	.stop_tx	= cortina_uart_stop_tx,
+	.start_tx	= cortina_uart_start_tx,
+	.stop_rx	= cortina_uart_stop_rx,
+	.enable_ms	= cortina_uart_enable_ms,
+	.startup	= cortina_uart_startup,
+	.shutdown	= cortina_uart_shutdown,
+	.set_termios	= cortina_uart_set_termios,
+	.type		= cortina_uart_type,
+	.config_port	= cortina_uart_config_port,
+	.verify_port	= cortina_uart_verify_port,
+	.pm		= cortina_access_power,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= cortina_poll_get_char,
+	.poll_put_char	= cortina_poll_put_char,
+#endif
+};
+
+static inline void cortina_uart_interrupt_rx_chars(struct uart_port *port,
+						   unsigned long status)
+{
+	struct tty_port *ttyport = &port->state->port;
+	unsigned int ch;
+	unsigned int rx, flg;
+	struct cortina_uart_port *pca_port;
+
+	rx = readl(port->membase + INFO);
+	if (INFO_RX_EMPTY & rx)
+		return;
+
+	if (status & RX_FIFO_OVERRUNE)
+		port->icount.overrun++;
+
+	pca_port = cortina_uart_get_port(port->line);
+
+	/* Read characters while FIFO is not empty */
+	do {
+		flg = TTY_NORMAL;
+		port->icount.rx++;
+		ch = readl(port->membase + RX_DAT);
+		if (status & RX_PARITY_ERRE) {
+			port->icount.parity++;
+			flg = TTY_PARITY;
+		}
+
+		if (pca_port->has_bi) {
+			if (status & RX_BREAK) {
+				port->icount.brk++;
+				if (uart_handle_break(port))
+					goto ignore;
+			}
+		} else {
+			/* Treat stop err as BI */
+			if (status & RX_STOP_ERRE) {
+				port->icount.brk++;
+				if (uart_handle_break(port))
+					goto ignore;
+			}
+		}
+		if (!(ch & 0x100)) /* RX char is not valid */
+			goto ignore;
+
+		if (uart_handle_sysrq_char(port, (unsigned char)ch))
+			goto ignore;
+
+		tty_insert_flip_char(ttyport, ch, flg);
+ignore:
+		rx = readl(port->membase + INFO);
+	} while (!(INFO_RX_EMPTY & rx));
+
+	spin_unlock(&port->lock);
+	tty_flip_buffer_push(ttyport);
+	spin_lock(&port->lock);
+}
+
+static inline void cortina_uart_interrupt_tx_chars(struct uart_port *port)
+{
+	u8 ch;
+
+	/*
+	 * uart_port_tx() drains the kfifo xmit buffer, handles x_char,
+	 * calls uart_write_wakeup() and stop_tx() when the buffer empties.
+	 */
+	uart_port_tx(port, ch,
+		     !(readl(port->membase + INFO) & INFO_TX_FULL),
+		     writel(ch, port->membase + TX_DAT));
+}
+
+static irqreturn_t cortina_uart_interrupt(int irq, void *dev_id)
+{
+	struct uart_port *port = (struct uart_port *)dev_id;
+	unsigned int irq_status;
+
+	spin_lock(&port->lock);
+
+	/* Clear interrupt */
+	irq_status = readl(port->membase + INT);
+	writel(irq_status, port->membase + INT);
+
+	/* Process any Rx chars first */
+	cortina_uart_interrupt_rx_chars(port, irq_status);
+	/* Then use any Tx space */
+	cortina_uart_interrupt_tx_chars(port);
+
+	spin_unlock(&port->lock);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_SERIAL_CORTINA_ACCESS_CONSOLE
+static void cortina_console_write(struct console *co, const char *s,
+				  unsigned int count)
+{
+	struct uart_port *port;
+	struct cortina_uart_port *pca_port;
+	unsigned int i, previous;
+	unsigned long flags;
+	int locked;
+
+	pca_port = cortina_uart_get_port(co->index);
+	port = &pca_port->uart;
+
+	local_irq_save(flags);
+	if (port->sysrq) {
+		locked = 0;
+	} else if (oops_in_progress) {
+		locked = spin_trylock(&port->lock);
+	} else {
+		spin_lock(&port->lock);
+		locked = 1;
+	}
+
+	/* Save current state */
+	previous = readl(port->membase + IE);
+	/* Disable Tx interrupts so this all goes out in one go */
+	cortina_uart_stop_tx(port);
+
+	/* Write all the chars */
+	for (i = 0; i < count; i++) {
+		/* Wait for the TX buffer to be empty */
+		while (!(readl(port->membase + INFO) & INFO_TX_EMPTY))
+			cpu_relax();
+
+		writel(*s, port->membase + TX_DAT);
+
+		/* CR/LF handling */
+		if (*s++ == '\n') {
+			while (!(readl(port->membase + INFO) & INFO_TX_EMPTY))
+				cpu_relax();
+			writel('\r', port->membase + TX_DAT);
+		}
+	}
+
+	writel(previous, port->membase + IE);	/* Restore interrupt state */
+
+	if (locked)
+		spin_unlock(&port->lock);
+	local_irq_restore(flags);
+}
+
+static int __init cortina_console_setup(struct console *co, char *options)
+{
+	struct uart_port *port;
+	struct cortina_uart_port *pca_port;
+	int baud = 115200;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	if (co->index < 0 || co->index >= UART_NR)
+		return -ENODEV;
+
+	pca_port = cortina_uart_get_port(co->index);
+	port = &pca_port->uart;
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(port, co, baud, parity, bits, flow);
+}
+
+static struct uart_driver cortina_uart_driver;
+
+static struct console cortina_console = {
+	.name	= "ttyS",
+	.write	= cortina_console_write,
+	.device	= uart_console_device,
+	.setup	= cortina_console_setup,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
+	.data	= &cortina_uart_driver,
+};
+
+#define CORTINA_CONSOLE (&cortina_console)
+
+/* Support EARLYCON */
+static void cortina_putc(struct uart_port *port, unsigned char c)
+{
+	unsigned int tmout = TX_TIMEOUT;
+
+	/* No jiffies at early boot stage; wait up to TX_TIMEOUT us */
+	while (--tmout) {
+		if (!(readl(port->membase + INFO) & INFO_TX_FULL))
+			break;
+		udelay(1);
+	}
+
+	/* Give up if FIFO stuck */
+	if (readl(port->membase + INFO) & INFO_TX_FULL)
+		return;
+
+	writel(c, port->membase + TX_DAT);
+}
+
+static void cortina_early_write(struct console *con, const char *s,
+				unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, cortina_putc);
+}
+
+static int __init cortina_early_console_setup(struct earlycon_device *device,
+					      const char *opt)
+{
+	u32 reg_v;
+
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = cortina_early_write;
+
+	/*
+	 * If the bootloader did not enable the UART, initialise it here
+	 * at 115200 baud so that early boot messages are not lost.
+	 * The magic constant mirrors the reference BSP setting:
+	 *   CFG[31:8] = baud divisor for 115200, CFG[7] = UART_EN,
+	 *   CFG[6:5]  = RX_EN|TX_EN, CFG[1:0] = 8-bit data.
+	 */
+	reg_v = readl(device->port.membase + CFG);
+	if (!(reg_v & CFG_UART_EN)) {
+		writel(0x00043de3, device->port.membase + CFG);
+		writel(0x00043d / 2, device->port.membase + RX_SAMPLE);
+	}
+
+	return 0;
+}
+
+EARLYCON_DECLARE(ca_serial, cortina_early_console_setup);
+OF_EARLYCON_DECLARE(ca_serial, "cortina-access,serial",
+		    cortina_early_console_setup);
+#else
+#define CORTINA_CONSOLE	NULL
+#endif /* CONFIG_SERIAL_CORTINA_ACCESS_CONSOLE */
+
+static struct uart_driver cortina_uart_driver = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "cortina-access_uart",
+	.dev_name	= "ttyS",
+	.major		= TTY_MAJOR,
+	.minor		= 64,
+	.nr		= UART_NR,
+	.cons		= CORTINA_CONSOLE,
+};
+
+/* Match table for of_platform binding */
+static const struct of_device_id cortina_uart_of_match[] = {
+	{ .compatible = "cortina-access,serial" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cortina_uart_of_match);
+
+static int serial_cortina_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct cortina_uart_port *port;
+	struct resource *res;
+	struct clk *pclk_info;
+	int uart_idx;
+	int irq;
+	int ret;
+
+	if (!cortina_uart_ports) {
+		cortina_uart_ports = kcalloc(UART_NR, sizeof(*cortina_uart_ports),
+					     GFP_KERNEL);
+		if (!cortina_uart_ports)
+			return -ENOMEM;
+	}
+
+	port = cortina_uart_ports;
+	for (uart_idx = 0; uart_idx < UART_NR; ++uart_idx) {
+		/* Find first empty slot */
+		if (strlen(port->name) == 0)
+			break;
+		port++;
+	}
+
+	if (uart_idx >= UART_NR)
+		return -ENODEV;
+
+	snprintf(port->name, sizeof(port->name),
+		 "Cortina-Access UART%d", uart_idx);
+
+	/* Retrieve HW base address and reserve the I/O region */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	port->uart.mapbase = res->start;
+	port->uart.membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(port->uart.membase))
+		return PTR_ERR(port->uart.membase);
+
+	/* Retrieve IRQ */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	port->uart.irq = irq;
+
+	pclk_info = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(pclk_info)) {
+		dev_err(&pdev->dev, "failed to get clock\n");
+		return PTR_ERR(pclk_info);
+	}
+
+	port->uart.uartclk	= clk_get_rate(pclk_info);
+	port->uart.ops		= &cortina_uart_ops;
+	port->uart.dev		= &pdev->dev;
+	port->uart.line		= uart_idx;
+	port->uart.iotype	= UPIO_MEM32;
+	port->uart.type		= 1;
+	port->uart.has_sysrq	= IS_ENABLED(CONFIG_SERIAL_CORTINA_ACCESS_CONSOLE);
+
+	if (of_property_read_bool(np, "wakeup-source"))
+		port->may_wakeup = true;
+	if (of_property_read_bool(np, "break-indicator"))
+		port->has_bi = true;
+
+	if (port->may_wakeup)
+		device_init_wakeup(&pdev->dev, true);
+
+	ret = uart_add_one_port(&cortina_uart_driver, &port->uart);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, port);
+
+	return 0;
+}
+
+static void serial_cortina_remove(struct platform_device *pdev)
+{
+	struct cortina_uart_port *pca_port = platform_get_drvdata(pdev);
+
+	if (pca_port) {
+		memset(pca_port->name, 0, CA_UART_NAME_LEN);
+		uart_remove_one_port(&cortina_uart_driver, &pca_port->uart);
+	}
+
+	platform_set_drvdata(pdev, NULL);
+
+	/*
+	 * Free the port array when the last port is removed, i.e. when
+	 * all slots are empty again.
+	 */
+	if (cortina_uart_ports) {
+		int i;
+
+		for (i = 0; i < UART_NR; i++) {
+			if (strlen(cortina_uart_ports[i].name) != 0)
+				return;
+		}
+		kfree(cortina_uart_ports);
+		cortina_uart_ports = NULL;
+	}
+}
+
+#ifdef CONFIG_PM
+static int serial_cortina_suspend(struct platform_device *pdev,
+				  pm_message_t state)
+{
+	struct cortina_uart_port *p = platform_get_drvdata(pdev);
+
+	uart_suspend_port(&cortina_uart_driver, &p->uart);
+
+	return 0;
+}
+
+static int serial_cortina_resume(struct platform_device *pdev)
+{
+	struct cortina_uart_port *p = platform_get_drvdata(pdev);
+
+	uart_resume_port(&cortina_uart_driver, &p->uart);
+
+	return 0;
+}
+#else
+#define serial_cortina_suspend	NULL
+#define serial_cortina_resume	NULL
+#endif
+
+static struct platform_driver serial_cortina_driver = {
+	.probe		= serial_cortina_probe,
+	.remove		= serial_cortina_remove,
+#ifdef CONFIG_PM
+	.suspend	= serial_cortina_suspend,
+	.resume		= serial_cortina_resume,
+#endif
+	.driver = {
+		.name		= "cortina-access_serial",
+		.of_match_table	= cortina_uart_of_match,
+	},
+};
+
+static int __init cortina_uart_init(void)
+{
+	int ret;
+
+	ret = uart_register_driver(&cortina_uart_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&serial_cortina_driver);
+	if (ret)
+		uart_unregister_driver(&cortina_uart_driver);
+
+	return ret;
+}
+
+static void __exit cortina_uart_exit(void)
+{
+	platform_driver_unregister(&serial_cortina_driver);
+	uart_unregister_driver(&cortina_uart_driver);
+}
+
+module_init(cortina_uart_init);
+module_exit(cortina_uart_exit);
+
+MODULE_AUTHOR("Cortina-Access Inc.");
+MODULE_DESCRIPTION("Cortina-Access UART driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5

