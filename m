Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019FBC433E9
	for <linux-serial@archiver.kernel.org>; Fri, 12 Feb 2021 19:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99B464E13
	for <linux-serial@archiver.kernel.org>; Fri, 12 Feb 2021 19:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhBLT6t (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Feb 2021 14:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhBLT6f (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Feb 2021 14:58:35 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C5AC0613D6;
        Fri, 12 Feb 2021 11:57:55 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id nm1so225110pjb.3;
        Fri, 12 Feb 2021 11:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MUz0oUdovbO8d0ebf9jsJluBlVblXvuF16cfwJbkWvs=;
        b=QKDS2pyBopC2n+oQ438dbbOS95l3SaUaeaXaiIO2CaQ3Q3LGJf75/uB6BBIoX/VMeY
         cIkOut01+PpnURz/1bioCNlng1KIAywCy/8JFzTFY3XzWgH/HwF1O9A4n7+Xxl7XOMXl
         WX6e/wD6OiFuPo4hFf1y6sC3A8UirkjN7cWyEUwsgdCzihSEWlL86XbIJu1p2w4b5eP9
         QHJnMa55/JiIvDdTJ3dMlo9DW3if9FWgSHQ27WlhXCCUxN1MR+u9LvRK0sZ/v3aq9xHN
         E9AEm+xqdJ3zyITXbKvUbO2ZCEjHUDiHDSrfwIOhrBFbPTX9Li+TdRIpMhI+84inezU4
         5bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MUz0oUdovbO8d0ebf9jsJluBlVblXvuF16cfwJbkWvs=;
        b=pjgmgoDCyYBNrDz4laDcl72AiCpzv0EnaVplqErXID3Jj+EDWJwxsqw1jxwF9h39Wq
         iWm/xlttPxxOJ6uXGdzqJt5I3TpRIinrjrPFQj9pB11akMhxlLNhtMvcZ/nFC0qZlvsn
         O5AhppQ6YK46Y2vNG1PJ3GIw1o7yLrbv9nFXl0x4vlCNuiloOfKN7Pehtc5Qj6ByhVhZ
         IXc6gW8/aVYpBU0Fcurt0GMi+Qh6+yakyHM7hOYJ7WnZiygiLWBstIGERSD45GH3TE2P
         IKxaa4wlqs0VSXVdjzZGGGLlpBGpHnwpOy5m4M7H5PrjFXTn74QZb+C/Uogm6pZVnRbW
         rZTA==
X-Gm-Message-State: AOAM531Qje6+cU5rkiYkh8P8SqVu3F27NTGhfXU3qdMT7hR8i5sAsvIj
        8kI4PCWIRLT4ujgSOlirizMwSmwe3Hs=
X-Google-Smtp-Source: ABdhPJyrTndtrhiNRiaPlR4eV9pLxkky6uiZzl+OLY14vH5EQQm637YsCu7Ov6fp7ro0IUu7F/UDZw==
X-Received: by 2002:a17:90a:ad81:: with SMTP id s1mr4122101pjq.9.1613159873954;
        Fri, 12 Feb 2021 11:57:53 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id t25sm10003819pgo.87.2021.02.12.11.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 11:57:53 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 2/2] serial: 8250: Add new 8250-core based Broadcom STB driver
Date:   Fri, 12 Feb 2021 14:57:36 -0500
Message-Id: <20210212195736.45328-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212195736.45328-1-alcooperx@gmail.com>
References: <20210212195736.45328-1-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a UART driver for the new Broadcom 8250 based STB UART. The new
UART is backward compatible with the standard 8250, but has some
additional features. The new features include a high accuracy baud
rate clock system and DMA support.

The driver will use the new optional BAUD MUX clock to select the best
one of the four master clocks (81MHz, 108MHz, 64MHz and 48MHz) to feed
the baud rate selection logic for any requested baud rate.  This allows
for more accurate BAUD rates when high speed baud rates are selected.

The driver will use the new UART DMA hardware if the UART DMA registers
are specified in Device Tree "reg" property.

The driver also sets the UPSTAT_AUTOCTS flag when hardware flow control
is enabled. This flag is needed for UARTs that don't assert a CTS
changed interrupt when CTS changes and AFE (Hardware Flow Control) is
enabled.

The driver also contains a workaround for a bug in the Synopsis 8250
core. The problem is that at high baud rates, the RX partial FIFO
timeout interrupt can occur but there is no RX data (DR not set in
the LSR register). In this case the driver will not read the Receive
Buffer Register, which clears the interrupt, and the system will get
continuous UART interrupts until the next RX character arrives. The
fix originally suggested by Synopsis was to read the Receive Buffer
Register and discard the character when the DR bit in the LSR was
not set, to clear the interrupt. The problem was that occasionally
a character would arrive just after the DR bit check and a valid
character would be discarded. The fix that was added will clear
receive interrupts to stop the interrupt, deassert RTS to insure
that no new data can arrive, wait for 1.5 character times for the
sender to react to RTS and then check for data and either do a dummy
read or a valid read. Sysfs error counters were also added and were
used to help create test software that would cause the error condition.
The counters can be found at:
/sys/devices/platform/rdb/*serial/rx_bad_timeout_late_char
/sys/devices/platform/rdb/*serial/rx_bad_timeout_no_char

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 MAINTAINERS                            |    8 +
 drivers/tty/serial/8250/8250_bcm7271.c | 1099 ++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig        |   11 +
 drivers/tty/serial/8250/Makefile       |    1 +
 drivers/tty/serial/8250/bcm7271_uart.h |  158 ++++
 5 files changed, 1277 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_bcm7271.c
 create mode 100644 drivers/tty/serial/8250/bcm7271_uart.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 64c7169db617..bb6ad2fc4376 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3582,6 +3582,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml
 F:	drivers/i2c/busses/i2c-brcmstb.c
 
+BROADCOM BRCMSTB UART DRIVER
+M:	Al Cooper <alcooperx@gmail.com>
+L:	linux-usb@vger.kernel.org
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
+F:	drivers/tty/serial/8250/8250_bcm7271.c
+
 BROADCOM BRCMSTB USB EHCI DRIVER
 M:	Al Cooper <alcooperx@gmail.com>
 L:	linux-usb@vger.kernel.org
diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
new file mode 100644
index 000000000000..49fdb20f4d8c
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -0,0 +1,1099 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2020, Broadcom */
+/*
+ * 8250-core based driver for Broadcom ns16550a UARTs
+ *
+ * This driver uses the standard 8250 driver core but adds additional
+ * optional features including the ability to use a baud rate clock
+ * mux for more accurate high speed baud rate selection and also
+ * an optional DMA engine.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/tty.h>
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/dma-mapping.h>
+#include <linux/tty_flip.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+
+#include "8250.h"
+#include "bcm7271_uart.h"
+
+#define REGS_8250 0
+#define REGS_DMA_RX 1
+#define REGS_DMA_TX 2
+#define REGS_DMA_ISR 3
+#define REGS_DMA_ARB 4
+#define REGS_MAX 5
+
+#define TX_BUF_SIZE 4096
+#define RX_BUF_SIZE 4096
+#define RX_BUFS_COUNT 2
+#define KHZ    1000
+#define MHZ(x) ((x) * KHZ * KHZ)
+
+static const u32 brcmstb_rate_table[] = {
+	MHZ(81),
+	MHZ(108),
+	MHZ(64),		/* Actually 64285715 for some chips */
+	MHZ(48),
+};
+
+static const u32 brcmstb_rate_table_7278[] = {
+	MHZ(81),
+	MHZ(108),
+	0,
+	MHZ(48),
+};
+
+struct brcmuart_priv {
+	int		line;
+	struct clk	*baud_mux_clk;
+	unsigned long	default_mux_rate;
+	u32		real_rates[ARRAY_SIZE(brcmstb_rate_table)];
+	const u32	*rate_table;
+	ktime_t		char_wait;
+	struct uart_port *up;
+	struct hrtimer	hrt;
+	u32		flags;
+#define BRCMUART_PRIV_FLAGS_SHUTDOWN 1
+	bool		dma_enabled;
+	struct uart_8250_dma dma;
+	void __iomem	*regs[REGS_MAX];
+	dma_addr_t	rx_addr;
+	void		*rx_bufs;
+	size_t		rx_size;
+	int		rx_next_buf;
+	dma_addr_t	tx_addr;
+	void		*tx_buf;
+	size_t		tx_size;
+	bool		tx_running;
+	bool		rx_running;
+
+	/* sysfs attributes */
+	u64		dma_rx_partial_buf;
+	u64		dma_rx_full_buf;
+	u32		rx_bad_timeout_late_char;
+	u32		rx_bad_timeout_no_char;
+	u32		rx_missing_close_timeout;
+};
+
+/*
+ * Register access routines
+ */
+static u32 udma_readl(struct brcmuart_priv *priv,
+		int reg_type, int offset)
+{
+	return readl(priv->regs[reg_type] + offset);
+}
+
+static void udma_writel(struct brcmuart_priv *priv,
+			int reg_type, int offset, u32 value)
+{
+	writel(value, priv->regs[reg_type] + offset);
+}
+
+static void udma_set(struct brcmuart_priv *priv,
+		int reg_type, int offset, u32 bits)
+{
+	void __iomem *reg = priv->regs[reg_type] + offset;
+	u32 value;
+
+	value = readl(reg);
+	value |= bits;
+	writel(value, reg);
+}
+
+static void udma_unset(struct brcmuart_priv *priv,
+		int reg_type, int offset, u32 bits)
+{
+	void __iomem *reg = priv->regs[reg_type] + offset;
+	u32 value;
+
+	value = readl(reg);
+	value &= ~bits;
+	writel(value, reg);
+}
+
+/*
+ * The UART DMA engine hardware can be used by multiple UARTS, but
+ * only one at a time. Sharing is not currently supported so
+ * the first UART to request the DMA engine will get it and any
+ * subsequent requests by other UARTS will fail.
+ */
+static int brcmuart_arbitration(struct brcmuart_priv *priv, bool acquire)
+{
+	u32 rx_grant;
+	u32 tx_grant;
+	int waits;
+	int ret = 0;
+
+	if (acquire) {
+		udma_set(priv, REGS_DMA_ARB, UDMA_ARB_RX, UDMA_ARB_REQ);
+		udma_set(priv, REGS_DMA_ARB, UDMA_ARB_TX, UDMA_ARB_REQ);
+
+		waits = 1;
+		while (1) {
+			rx_grant = udma_readl(priv, REGS_DMA_ARB, UDMA_ARB_RX);
+			tx_grant = udma_readl(priv, REGS_DMA_ARB, UDMA_ARB_TX);
+			if (rx_grant & tx_grant & UDMA_ARB_GRANT)
+				return 0;
+			if (waits-- == 0)
+				break;
+			msleep(1);
+		}
+		ret = 1;
+	}
+
+	udma_unset(priv, REGS_DMA_ARB, UDMA_ARB_RX, UDMA_ARB_REQ);
+	udma_unset(priv, REGS_DMA_ARB, UDMA_ARB_TX, UDMA_ARB_REQ);
+	return ret;
+}
+
+static void brcmuart_init_dma_hardware(struct brcmuart_priv *priv)
+{
+	u32 daddr;
+	u32 value;
+	int x;
+
+	/* Start with all interrupts disabled */
+	udma_writel(priv, REGS_DMA_ISR, UDMA_INTR_MASK_SET, 0xffffffff);
+
+	udma_writel(priv, REGS_DMA_RX, UDMA_RX_BUFFER_SIZE, RX_BUF_SIZE);
+
+	/*
+	 * Setup buffer close to happen when 32 character times have
+	 * elapsed since the last character was received.
+	 */
+	udma_writel(priv, REGS_DMA_RX, UDMA_RX_BUFFER_CLOSE, 16*10*32);
+	value = (RX_BUFS_COUNT << UDMA_RX_CTRL_NUM_BUF_USED_SHIFT)
+		| UDMA_RX_CTRL_BUF_CLOSE_MODE
+		| UDMA_RX_CTRL_BUF_CLOSE_ENA;
+	udma_writel(priv, REGS_DMA_RX, UDMA_RX_CTRL, value);
+
+	udma_writel(priv, REGS_DMA_RX, UDMA_RX_BLOCKOUT_COUNTER, 0);
+	daddr = priv->rx_addr;
+	for (x = 0; x < RX_BUFS_COUNT; x++) {
+
+		/* Set RX transfer length to 0 for unknown */
+		udma_writel(priv, REGS_DMA_RX, UDMA_RX_TRANSFER_LEN, 0);
+
+		udma_writel(priv, REGS_DMA_RX, UDMA_RX_BUFx_PTR_LO(x),
+			    lower_32_bits(daddr));
+		udma_writel(priv, REGS_DMA_RX, UDMA_RX_BUFx_PTR_HI(x),
+			    upper_32_bits(daddr));
+		daddr += RX_BUF_SIZE;
+	}
+
+	daddr = priv->tx_addr;
+	udma_writel(priv, REGS_DMA_TX, UDMA_TX_BUFx_PTR_LO(0),
+		    lower_32_bits(daddr));
+	udma_writel(priv, REGS_DMA_TX, UDMA_TX_BUFx_PTR_HI(0),
+		    upper_32_bits(daddr));
+	udma_writel(priv, REGS_DMA_TX, UDMA_TX_CTRL,
+		    UDMA_TX_CTRL_NUM_BUF_USED_1);
+
+	/* clear all interrupts then enable them */
+	udma_writel(priv, REGS_DMA_ISR, UDMA_INTR_CLEAR, 0xffffffff);
+	udma_writel(priv, REGS_DMA_ISR, UDMA_INTR_MASK_CLEAR,
+		UDMA_RX_INTERRUPTS | UDMA_TX_INTERRUPTS);
+
+}
+
+static int start_rx_dma(struct uart_8250_port *p)
+{
+	struct brcmuart_priv *priv = p->port.private_data;
+	struct device *dev = p->port.dev;
+	int x;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	udma_unset(priv, REGS_DMA_RX, UDMA_RX_CTRL, UDMA_RX_CTRL_ENA);
+
+	/* Clear the RX ready bit for all buffers */
+	for (x = 0; x < RX_BUFS_COUNT; x++)
+		udma_unset(priv, REGS_DMA_RX, UDMA_RX_BUFx_STATUS(x),
+			UDMA_RX_BUFX_STATUS_DATA_RDY);
+
+	/* always start with buffer 0 */
+	udma_unset(priv, REGS_DMA_RX, UDMA_RX_STATUS,
+		   UDMA_RX_STATUS_ACTIVE_BUF_MASK);
+	priv->rx_next_buf = 0;
+
+	udma_set(priv, REGS_DMA_RX, UDMA_RX_CTRL, UDMA_RX_CTRL_ENA);
+	priv->rx_running = true;
+	return 0;
+}
+
+static int stop_rx_dma(struct uart_8250_port *p)
+{
+	struct brcmuart_priv *priv = p->port.private_data;
+	struct device *dev = p->port.dev;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	/* If RX is running, set the RX ABORT */
+	if (priv->rx_running)
+		udma_set(priv, REGS_DMA_RX, UDMA_RX_CTRL, UDMA_RX_CTRL_ABORT);
+	return 0;
+}
+
+static int stop_tx_dma(struct uart_8250_port *p)
+{
+	struct brcmuart_priv *priv = p->port.private_data;
+	struct device *dev = p->port.dev;
+	u32 value;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	/* If TX is running, set the TX ABORT */
+	value = udma_readl(priv, REGS_DMA_TX, UDMA_TX_CTRL);
+	if (value & UDMA_TX_CTRL_ENA)
+		udma_set(priv, REGS_DMA_TX, UDMA_TX_CTRL, UDMA_TX_CTRL_ABORT);
+	priv->tx_running = false;
+	return 0;
+}
+
+/*
+ * NOTE: printk's in this routine will hang the system if this is
+ * the console tty
+ */
+static int brcmuart_tx_dma(struct uart_8250_port *p)
+{
+	struct brcmuart_priv *priv = p->port.private_data;
+	struct circ_buf *xmit = &p->port.state->xmit;
+	struct device *dev = p->port.dev;
+	u32 tx_size;
+
+	if (uart_tx_stopped(&p->port) || priv->tx_running ||
+		uart_circ_empty(xmit)) {
+		return 0;
+	}
+	tx_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
+
+	dev_dbg(dev, "%s: size: %d\n", __func__, tx_size);
+
+	priv->dma.tx_err = 0;
+	memcpy(priv->tx_buf, &xmit->buf[xmit->tail], tx_size);
+	xmit->tail += tx_size;
+	xmit->tail &= UART_XMIT_SIZE - 1;
+	p->port.icount.tx += tx_size;
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&p->port);
+
+	udma_writel(priv, REGS_DMA_TX, UDMA_TX_TRANSFER_LEN, tx_size);
+	udma_writel(priv, REGS_DMA_TX, UDMA_TX_BUF0_DATA_LEN, tx_size);
+	udma_unset(priv, REGS_DMA_TX, UDMA_TX_BUF0_STATUS, UDMA_TX_BUFX_EMPTY);
+	udma_set(priv, REGS_DMA_TX, UDMA_TX_CTRL, UDMA_TX_CTRL_ENA);
+	priv->tx_running = true;
+
+	return 0;
+}
+
+static void brcmuart_rx_buf_done_isr(struct uart_port *up, int index)
+{
+	struct brcmuart_priv *priv = up->private_data;
+	struct tty_port *tty_port = &up->state->port;
+	u32 status;
+	u32 length;
+	u32 copied;
+
+	/* Make sure we're still in sync with the hardware */
+	status = udma_readl(priv, REGS_DMA_RX, UDMA_RX_BUFx_STATUS(index));
+	length = udma_readl(priv, REGS_DMA_RX, UDMA_RX_BUFx_DATA_LEN(index));
+
+	if ((status & UDMA_RX_BUFX_STATUS_DATA_RDY) == 0) {
+		dev_err(up->dev, "RX done interrupt but DATA_RDY not found\n");
+		return;
+	}
+	if (status & (UDMA_RX_BUFX_STATUS_OVERRUN_ERR |
+		      UDMA_RX_BUFX_STATUS_FRAME_ERR |
+		      UDMA_RX_BUFX_STATUS_PARITY_ERR)) {
+		if (status & UDMA_RX_BUFX_STATUS_OVERRUN_ERR) {
+			up->icount.overrun++;
+			dev_warn(up->dev, "RX OVERRUN Error\n");
+		}
+		if (status & UDMA_RX_BUFX_STATUS_FRAME_ERR) {
+			up->icount.frame++;
+			dev_warn(up->dev, "RX FRAMING Error\n");
+		}
+		if (status & UDMA_RX_BUFX_STATUS_PARITY_ERR) {
+			up->icount.parity++;
+			dev_warn(up->dev, "RX PARITY Error\n");
+		}
+	}
+	copied = (u32)tty_insert_flip_string(
+		tty_port,
+		priv->rx_bufs + (index * RX_BUF_SIZE),
+		length);
+	if (copied != length) {
+		dev_warn(up->dev, "Flip buffer overrun of %d bytes\n",
+			 length - copied);
+		up->icount.overrun += length - copied;
+	}
+	up->icount.rx += length;
+	if (status & UDMA_RX_BUFX_STATUS_CLOSE_EXPIRED)
+		priv->dma_rx_partial_buf++;
+	else if (length != RX_BUF_SIZE)
+		/*
+		 * This is a bug in the controller that doesn't cause
+		 * any problems but will be fixed in the future.
+		 */
+		priv->rx_missing_close_timeout++;
+	else
+		priv->dma_rx_full_buf++;
+
+	tty_flip_buffer_push(tty_port);
+
+	dev_dbg(up->dev, "RX: %d chars, chan %d, stat: 0x%x, 0x%x\n",
+		length, index, status,
+		(unsigned int)((unsigned char *)priv->rx_bufs)[index *
+							       RX_BUF_SIZE]);
+}
+
+static void brcmuart_rx_isr(struct uart_port *up, u32 rx_isr)
+{
+	struct brcmuart_priv *priv = up->private_data;
+	struct device *dev = up->dev;
+	u32 rx_done_isr;
+	u32 check_isr;
+	char seq_err[] = "RX buffer ready out of sequence, restarting RX DMA\n";
+
+	rx_done_isr = (rx_isr & UDMA_INTR_RX_READY_MASK);
+	dev_dbg(dev, "Got RX interrupt: 0x%x, next: %d\n", rx_done_isr,
+		priv->rx_next_buf);
+	while (rx_done_isr) {
+		check_isr = UDMA_INTR_RX_READY_BUF0 << priv->rx_next_buf;
+		if (check_isr & rx_done_isr) {
+			brcmuart_rx_buf_done_isr(up, priv->rx_next_buf);
+		} else {
+			dev_err(dev, seq_err);
+			start_rx_dma(up_to_u8250p(up));
+			break;
+		}
+		if (rx_isr & UDMA_RX_ERR_INTERRUPTS) {
+			if (rx_isr & UDMA_INTR_RX_ERROR)
+				dev_dbg(dev, "RX FRAME/OVERRUN/PARITY Error\n");
+			if (rx_isr & UDMA_INTR_RX_TIMEOUT)
+				dev_err(dev, "RX TIMEOUT Error\n");
+			if (rx_isr & UDMA_INTR_RX_ABORT)
+				dev_dbg(dev, "RX ABORT\n");
+			priv->rx_running = false;
+		}
+		/* If not ABORT, re-enable RX buffer */
+		if (!(rx_isr & UDMA_INTR_RX_ABORT))
+			udma_unset(priv, REGS_DMA_RX,
+				   UDMA_RX_BUFx_STATUS(priv->rx_next_buf),
+				   UDMA_RX_BUFX_STATUS_DATA_RDY);
+		dev_dbg(dev, "RX interrupt DONE for channel %d\n",
+			priv->rx_next_buf);
+		rx_done_isr &= ~check_isr;
+		priv->rx_next_buf++;
+		if (priv->rx_next_buf == RX_BUFS_COUNT)
+			priv->rx_next_buf = 0;
+	}
+}
+
+static void brcmuart_tx_isr(struct uart_port *up, u32 isr)
+{
+	struct brcmuart_priv *priv = up->private_data;
+	struct device *dev = up->dev;
+	struct uart_8250_port *port_8250 = up_to_u8250p(up);
+	struct circ_buf	*xmit = &port_8250->port.state->xmit;
+	int length;
+
+	length = udma_readl(priv, REGS_DMA_TX, UDMA_TX_TRANSFER_TOTAL);
+	dev_dbg(dev, "Got TX interrupt, length %d\n", length);
+
+	if (isr & UDMA_INTR_TX_ABORT) {
+		if (priv->tx_running)
+			dev_err(dev, "Unexpected TX_ABORT interrupt\n");
+		return;
+	}
+	priv->tx_running = false;
+	if (!uart_circ_empty(xmit) && !uart_tx_stopped(up))
+		brcmuart_tx_dma(port_8250);
+}
+
+static irqreturn_t brcmuart_isr(int irq, void *dev_id)
+{
+	struct uart_port *up = dev_id;
+	struct device *dev = up->dev;
+	struct brcmuart_priv *priv = up->private_data;
+	unsigned long flags;
+	u32 interrupts;
+	u32 rval;
+	u32 tval;
+
+	interrupts = udma_readl(priv, REGS_DMA_ISR, UDMA_INTR_STATUS);
+	dev_dbg(up->dev, "ISR: interrupts: 0x%x\n", interrupts);
+	if (interrupts == 0)
+		return IRQ_NONE;
+
+	spin_lock_irqsave(&up->lock, flags);
+
+	/* Clear all interrupts */
+	udma_writel(priv, REGS_DMA_ISR, UDMA_INTR_CLEAR, interrupts);
+
+	rval = UDMA_IS_RX_INTERRUPT(interrupts);
+	if (rval)
+		brcmuart_rx_isr(up, rval);
+	tval = UDMA_IS_TX_INTERRUPT(interrupts);
+	if (tval)
+		brcmuart_tx_isr(up, tval);
+	if ((rval | tval) == 0)
+		dev_warn(dev, "Spurious interrupt: 0x%x\n", interrupts);
+
+	spin_unlock_irqrestore(&up->lock, flags);
+	return IRQ_HANDLED;
+}
+
+static int brcmuart_startup(struct uart_port *port)
+{
+	int res;
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct brcmuart_priv *priv = up->port.private_data;
+	struct device *dev = port->dev;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	priv->flags &= ~BRCMUART_PRIV_FLAGS_SHUTDOWN;
+
+	/*
+	 * prevent serial8250_do_startup() from allocating non-existent
+	 * DMA resources
+	 */
+	up->dma = NULL;
+
+	res = serial8250_do_startup(port);
+	if (!priv->dma_enabled)
+		return res;
+	/*
+	 * Disable the Receive Data Interrupt because the DMA engine
+	 * will handle this.
+	 */
+	up->ier &= ~UART_IER_RDI;
+	serial_port_out(port, UART_IER, up->ier);
+
+	priv->tx_running = false;
+	priv->dma.rx_dma = NULL;
+	priv->dma.tx_dma = brcmuart_tx_dma;
+	up->dma = &priv->dma;
+
+	brcmuart_init_dma_hardware(priv);
+	start_rx_dma(up);
+	return res;
+}
+
+static void brcmuart_shutdown(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct brcmuart_priv *priv = up->port.private_data;
+	struct device *dev = port->dev;
+	unsigned long flags;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	spin_lock_irqsave(&port->lock, flags);
+	priv->flags |= BRCMUART_PRIV_FLAGS_SHUTDOWN;
+	if (priv->dma_enabled) {
+		stop_rx_dma(up);
+		stop_tx_dma(up);
+		/* disable all interrupts */
+		udma_writel(priv, REGS_DMA_ISR, UDMA_INTR_MASK_SET,
+			UDMA_RX_INTERRUPTS | UDMA_TX_INTERRUPTS);
+	}
+
+	/*
+	 * prevent serial8250_do_shutdown() from trying to free
+	 * DMA resources that we never alloc'd for this driver.
+	 */
+	up->dma = NULL;
+
+	spin_unlock_irqrestore(&port->lock, flags);
+	serial8250_do_shutdown(port);
+}
+
+/*
+ * Not all clocks run at the exact specified rate, so set each requested
+ * rate and then get the actual rate.
+ */
+static void init_real_clk_rates(struct device *dev, struct brcmuart_priv *priv)
+{
+	int x;
+	int rc;
+
+	priv->default_mux_rate = clk_get_rate(priv->baud_mux_clk);
+	dev_dbg(dev, "Default BAUD MUX Clock rate is %lu\n",
+		priv->default_mux_rate);
+
+	for (x = 0; x < ARRAY_SIZE(priv->real_rates); x++) {
+		if (priv->rate_table[x] == 0) {
+			priv->real_rates[x] = 0;
+			continue;
+		}
+		rc = clk_set_rate(priv->baud_mux_clk, priv->rate_table[x]);
+		if (rc) {
+			dev_err(dev, "Error selecting BAUD MUX clock for %u\n",
+				priv->rate_table[x]);
+			priv->real_rates[x] = priv->rate_table[x];
+		} else {
+			priv->real_rates[x] = clk_get_rate(priv->baud_mux_clk);
+		}
+	}
+	 clk_set_rate(priv->baud_mux_clk, priv->default_mux_rate);
+}
+
+static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
+			u32 baud)
+{
+	u32 percent;
+	u32 best_percent = UINT_MAX;
+	u32 quot;
+	u32 best_quot = 1;
+	u32 rate;
+	int best_index = -1;
+	u64 hires_rate;
+	u64 hires_baud;
+	u64 hires_err;
+	int rc;
+	int i;
+	int real_baud;
+
+	/* If the Baud Mux Clock was not specified, just return */
+	if (priv->baud_mux_clk == NULL)
+		return;
+
+	/* Find the closest match for specified baud */
+	for (i = 0; i < ARRAY_SIZE(priv->real_rates); i++) {
+		if (priv->real_rates[i] == 0)
+			continue;
+		rate = priv->real_rates[i] / 16;
+		quot = DIV_ROUND_CLOSEST(rate, baud);
+		if (!quot)
+			continue;
+
+		/* increase resolution to get xx.xx percent */
+		hires_rate = (u64)rate * 10000;
+		hires_baud = (u64)baud * 10000;
+
+		hires_err = div_u64(hires_rate, (u64)quot);
+
+		/* get the delta */
+		if (hires_err > hires_baud)
+			hires_err = (hires_err - hires_baud);
+		else
+			hires_err = (hires_baud - hires_err);
+
+		percent = (unsigned long)DIV_ROUND_CLOSEST_ULL(hires_err, baud);
+		dev_dbg(up->dev,
+			"Baud rate: %u, MUX Clk: %u, Error: %u.%u%%\n",
+			baud, priv->real_rates[i], percent / 100,
+			percent % 100);
+		if (percent < best_percent) {
+			best_percent = percent;
+			best_index = i;
+			best_quot = quot;
+		}
+	}
+	if (best_index == -1) {
+		dev_err(up->dev, "Error, %d BAUD rate is too fast.\n", baud);
+		return;
+	}
+	rate = priv->real_rates[best_index];
+	rc = clk_set_rate(priv->baud_mux_clk, rate);
+	if (rc)
+		dev_err(up->dev, "Error selecting BAUD MUX clock\n");
+
+	/* Error over 3 percent will cause data errors */
+	if (best_percent > 300)
+		dev_err(up->dev, "Error, baud: %d has %u.%u%% error\n",
+			baud, percent / 100, percent % 100);
+
+	real_baud = rate / 16 / best_quot;
+	dev_dbg(up->dev, "Selecting BAUD MUX rate: %u\n", rate);
+	dev_dbg(up->dev, "Requested baud: %u, Actual baud: %u\n",
+		baud, real_baud);
+
+	/* calc nanoseconds for 1.5 characters time at the given baud rate */
+	i = 1000000000 / real_baud / 10;
+	i += (i / 2);
+	priv->char_wait = ns_to_ktime(i);
+
+	up->uartclk = rate;
+}
+
+static void brcmstb_set_termios(struct uart_port *up,
+				struct ktermios *termios,
+				struct ktermios *old)
+{
+	struct uart_8250_port *p8250 = up_to_u8250p(up);
+	struct brcmuart_priv *priv = up->private_data;
+
+	if (priv->dma_enabled)
+		stop_rx_dma(p8250);
+	set_clock_mux(up, priv, tty_termios_baud_rate(termios));
+	serial8250_do_set_termios(up, termios, old);
+	if (p8250->mcr & UART_MCR_AFE)
+		p8250->port.status |= UPSTAT_AUTOCTS;
+	if (priv->dma_enabled)
+		start_rx_dma(p8250);
+}
+
+static int brcmuart_handle_irq(struct uart_port *p)
+{
+	unsigned int iir = serial_port_in(p, UART_IIR);
+	struct brcmuart_priv *priv = p->private_data;
+	struct uart_8250_port *up = up_to_u8250p(p);
+	unsigned int status;
+	unsigned long flags;
+	unsigned int ier;
+	unsigned int mcr;
+	int handled = 0;
+
+	/*
+	 * There's a bug in some 8250 cores where we get a timeout
+	 * interrupt but there is no data ready.
+	 */
+	if (((iir & UART_IIR_ID) == UART_IIR_RX_TIMEOUT) &&
+	    ((priv->flags & BRCMUART_PRIV_FLAGS_SHUTDOWN) == 0)) {
+		spin_lock_irqsave(&p->lock, flags);
+		status = serial_port_in(p, UART_LSR);
+		if ((status & UART_LSR_DR) == 0) {
+
+			ier = serial_port_in(p, UART_IER);
+			/*
+			 * if Receive Data Interrupt is enabled and
+			 * we're uing hardware flow control, deassert
+			 * RTS and wait for any chars in the pipline to
+			 * arrive and then check for DR again.
+			 */
+			if ((ier & UART_IER_RDI) && (up->mcr & UART_MCR_AFE)) {
+				ier &= ~(UART_IER_RLSI | UART_IER_RDI);
+				serial_port_out(p, UART_IER, ier);
+				mcr = serial_port_in(p, UART_MCR);
+				mcr &= ~UART_MCR_RTS;
+				serial_port_out(p, UART_MCR, mcr);
+				hrtimer_start(&priv->hrt, priv->char_wait,
+					      HRTIMER_MODE_REL);
+			} else {
+				serial_port_in(p, UART_RX);
+			}
+
+			handled = 1;
+		}
+		spin_unlock_irqrestore(&p->lock, flags);
+		if (handled)
+			return 1;
+	}
+	return serial8250_handle_irq(p, iir);
+}
+
+static enum hrtimer_restart brcmuart_hrtimer_func(struct hrtimer *t)
+{
+	struct brcmuart_priv *priv = container_of(t, struct brcmuart_priv, hrt);
+	struct uart_port *p = priv->up;
+	struct uart_8250_port *up = up_to_u8250p(p);
+	unsigned int status;
+	unsigned long flags;
+
+	if (priv->flags & BRCMUART_PRIV_FLAGS_SHUTDOWN)
+		return HRTIMER_NORESTART;
+
+	spin_lock_irqsave(&p->lock, flags);
+	status = serial_port_in(p, UART_LSR);
+
+	/*
+	 * If a character did not arrive after the timeout, clear the false
+	 * receive timeout.
+	 */
+	if ((status & UART_LSR_DR) == 0) {
+		serial_port_in(p, UART_RX);
+		priv->rx_bad_timeout_no_char++;
+	} else {
+		priv->rx_bad_timeout_late_char++;
+	}
+
+	/* re-enable receive unless upper layer has disabled it */
+	if ((up->ier & (UART_IER_RLSI | UART_IER_RDI)) ==
+	    (UART_IER_RLSI | UART_IER_RDI)) {
+		status = serial_port_in(p, UART_IER);
+		status |= (UART_IER_RLSI | UART_IER_RDI);
+		serial_port_out(p, UART_IER, status);
+		status = serial_port_in(p, UART_MCR);
+		status |= UART_MCR_RTS;
+		serial_port_out(p, UART_MCR, status);
+	}
+	spin_unlock_irqrestore(&p->lock, flags);
+	return HRTIMER_NORESTART;
+}
+
+static ssize_t rx_bad_timeout_no_char_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct brcmuart_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", priv->rx_bad_timeout_no_char);
+}
+static DEVICE_ATTR_RO(rx_bad_timeout_no_char);
+
+static ssize_t rx_bad_timeout_late_char_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct brcmuart_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", priv->rx_bad_timeout_late_char);
+}
+static DEVICE_ATTR_RO(rx_bad_timeout_late_char);
+
+static ssize_t rx_missing_close_timeout_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct brcmuart_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", priv->rx_missing_close_timeout);
+}
+static DEVICE_ATTR_RO(rx_missing_close_timeout);
+
+static ssize_t dma_rx_partial_buf_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct brcmuart_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%lld\n", priv->dma_rx_partial_buf);
+}
+static DEVICE_ATTR_RO(dma_rx_partial_buf);
+
+static ssize_t dma_rx_full_buf_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct brcmuart_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%lld\n", priv->dma_rx_full_buf);
+}
+static DEVICE_ATTR_RO(dma_rx_full_buf);
+
+static struct attribute *brcmuart_dev_attrs[] = {
+	&dev_attr_rx_bad_timeout_no_char.attr,
+	&dev_attr_rx_bad_timeout_late_char.attr,
+	&dev_attr_rx_missing_close_timeout.attr,
+	&dev_attr_dma_rx_partial_buf.attr,
+	&dev_attr_dma_rx_full_buf.attr,
+	NULL,
+};
+
+static const struct attribute_group brcmuart_dev_attr_group = {
+	.attrs = brcmuart_dev_attrs,
+};
+
+static const struct of_device_id brcmuart_dt_ids[] = {
+	{
+		.compatible = "brcm,bcm7278-uart",
+		.data = brcmstb_rate_table_7278,
+	},
+	{
+		.compatible = "brcm,bcm7271-uart",
+		.data = brcmstb_rate_table,
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, brcmuart_dt_ids);
+
+static void brcmuart_free_bufs(struct device *dev, struct brcmuart_priv *priv)
+{
+	if (priv->rx_bufs)
+		dma_free_coherent(dev, priv->rx_size, priv->rx_bufs,
+				  priv->rx_addr);
+	if (priv->tx_buf)
+		dma_free_coherent(dev, priv->tx_size, priv->tx_buf,
+				  priv->tx_addr);
+}
+
+static void brcmuart_throttle(struct uart_port *port)
+{
+	struct brcmuart_priv *priv = port->private_data;
+
+	dev_dbg(port->dev, "%s\n", __func__);
+
+	udma_writel(priv, REGS_DMA_ISR, UDMA_INTR_MASK_SET, UDMA_RX_INTERRUPTS);
+}
+
+static void brcmuart_unthrottle(struct uart_port *port)
+{
+	struct brcmuart_priv *priv = port->private_data;
+
+	dev_dbg(port->dev, "%s\n", __func__);
+
+	udma_writel(priv, REGS_DMA_ISR, UDMA_INTR_MASK_CLEAR,
+		    UDMA_RX_INTERRUPTS);
+}
+
+static int brcmuart_probe(struct platform_device *pdev)
+{
+	struct resource *regs;
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id = NULL;
+	struct uart_8250_port *new_port;
+	struct device *dev = &pdev->dev;
+	struct brcmuart_priv *priv;
+	struct clk *baud_mux_clk;
+	struct uart_8250_port up;
+	struct resource *irq;
+	void __iomem *membase = 0;
+	resource_size_t mapbase = 0;
+	u32 clk_rate = 0;
+	int ret;
+	int x;
+	int dma_irq;
+	static const char * const reg_names[REGS_MAX] = {
+		"uart", "dma_rx", "dma_tx", "dma_intr2", "dma_arb"
+	};
+
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!irq) {
+		dev_err(dev, "missing irq\n");
+		return -EINVAL;
+	}
+	priv = devm_kzalloc(dev, sizeof(struct brcmuart_priv),
+			GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	of_id = of_match_node(brcmuart_dt_ids, np);
+	if (!of_id || !of_id->data)
+		priv->rate_table = brcmstb_rate_table;
+	else
+		priv->rate_table = of_id->data;
+
+	for (x = 0; x < REGS_MAX; x++) {
+		regs = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						reg_names[x]);
+		if (!regs)
+			break;
+		priv->regs[x] =	devm_ioremap(dev, regs->start,
+					     resource_size(regs));
+		if (IS_ERR(priv->regs[x]))
+			return PTR_ERR(priv->regs[x]);
+		if (x == REGS_8250) {
+			mapbase = regs->start;
+			membase = priv->regs[x];
+		}
+	}
+
+	/* We should have just the uart base registers or all the registers */
+	if (x != 1 && x != REGS_MAX) {
+		dev_warn(dev, "%s registers not specified\n", reg_names[x]);
+		return -EINVAL;
+	}
+
+	/* if the DMA registers were specified, try to enable DMA */
+	if (x > REGS_DMA_RX) {
+		if (brcmuart_arbitration(priv, 1) == 0) {
+			u32 txrev = 0;
+			u32 rxrev = 0;
+
+			txrev = udma_readl(priv, REGS_DMA_RX, UDMA_RX_REVISION);
+			rxrev = udma_readl(priv, REGS_DMA_TX, UDMA_TX_REVISION);
+			if ((txrev >= UDMA_TX_REVISION_REQUIRED) &&
+				(rxrev >= UDMA_RX_REVISION_REQUIRED)) {
+
+				/* Enable the use of the DMA hardware */
+				priv->dma_enabled = true;
+			} else {
+				brcmuart_arbitration(priv, 0);
+				dev_err(dev,
+					"Unsupported DMA Hardware Revision\n");
+			}
+		} else {
+			dev_err(dev,
+				"Timeout arbitrating for UART DMA hardware\n");
+		}
+	}
+
+	of_property_read_u32(np, "clock-frequency", &clk_rate);
+
+	/* See if a Baud clock has been specified */
+	baud_mux_clk = of_clk_get_by_name(np, "sw_baud");
+	if (IS_ERR(baud_mux_clk)) {
+		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_info(dev, "BAUD MUX clock not specified\n");
+	} else {
+		dev_info(dev, "BAUD MUX clock found\n");
+		ret = clk_prepare_enable(baud_mux_clk);
+		if (ret)
+			return ret;
+		priv->baud_mux_clk = baud_mux_clk;
+		init_real_clk_rates(dev, priv);
+		clk_rate = priv->default_mux_rate;
+	}
+
+	if (clk_rate == 0) {
+		dev_err(dev, "clock-frequency or clk not defined\n");
+		return -EINVAL;
+	}
+
+	dev_info(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
+
+	memset(&up, 0, sizeof(up));
+	up.port.type = PORT_16550A;
+	up.port.uartclk = clk_rate;
+	up.port.dev = dev;
+	up.port.mapbase = mapbase;
+	up.port.membase = membase;
+	up.port.irq = irq->start;
+	up.port.handle_irq = brcmuart_handle_irq;
+	up.port.regshift = 2;
+	up.port.iotype = of_device_is_big_endian(np) ?
+		UPIO_MEM32BE : UPIO_MEM32;
+	up.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
+		| UPF_FIXED_PORT | UPF_FIXED_TYPE;
+	up.port.dev = dev;
+	up.port.private_data = priv;
+	up.capabilities = UART_CAP_FIFO | UART_CAP_AFE;
+	up.port.fifosize = 32;
+
+	/* Check for a fixed line number */
+	ret = of_alias_get_id(np, "serial");
+	if (ret >= 0)
+		up.port.line = ret;
+
+	/* setup HR timer */
+	hrtimer_init(&priv->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	priv->hrt.function = brcmuart_hrtimer_func;
+
+	up.port.shutdown = brcmuart_shutdown;
+	up.port.startup = brcmuart_startup;
+	up.port.throttle = brcmuart_throttle;
+	up.port.unthrottle = brcmuart_unthrottle;
+	up.port.set_termios = brcmstb_set_termios;
+
+	if (priv->dma_enabled) {
+		priv->rx_size = RX_BUF_SIZE * RX_BUFS_COUNT;
+		priv->rx_bufs = dma_alloc_coherent(dev,
+						   priv->rx_size,
+						   &priv->rx_addr, GFP_KERNEL);
+		if (!priv->rx_bufs)
+			goto err;
+		priv->tx_size = UART_XMIT_SIZE;
+		priv->tx_buf = dma_alloc_coherent(dev,
+						  priv->tx_size,
+						  &priv->tx_addr, GFP_KERNEL);
+		if (!priv->tx_buf)
+			goto err;
+	}
+
+	ret = serial8250_register_8250_port(&up);
+	if (ret < 0) {
+		dev_err(dev, "unable to register 8250 port\n");
+		goto err;
+	}
+	priv->line = ret;
+	new_port = serial8250_get_port(ret);
+	priv->up = &new_port->port;
+	if (priv->dma_enabled) {
+		dma_irq = platform_get_irq_byname(pdev,  "dma");
+		if (dma_irq < 0) {
+			dev_err(dev, "no IRQ resource info\n");
+			goto err1;
+		}
+		ret = devm_request_irq(dev, dma_irq, brcmuart_isr,
+				IRQF_SHARED, "uart DMA irq", &new_port->port);
+		if (ret) {
+			dev_err(dev, "unable to register IRQ handler\n");
+			goto err1;
+		}
+	}
+	platform_set_drvdata(pdev, priv);
+	ret = sysfs_create_group(&dev->kobj, &brcmuart_dev_attr_group);
+	if (ret)
+		dev_warn(dev, "Error creating sysfs attributes\n");
+
+	return 0;
+
+err1:
+	serial8250_unregister_port(priv->line);
+err:
+	brcmuart_free_bufs(dev, priv);
+	brcmuart_arbitration(priv, 0);
+	return -ENODEV;
+}
+
+static int brcmuart_remove(struct platform_device *pdev)
+{
+	struct brcmuart_priv *priv = platform_get_drvdata(pdev);
+
+	sysfs_remove_group(&pdev->dev.kobj, &brcmuart_dev_attr_group);
+	hrtimer_cancel(&priv->hrt);
+	serial8250_unregister_port(priv->line);
+	brcmuart_free_bufs(&pdev->dev, priv);
+	brcmuart_arbitration(priv, 0);
+	return 0;
+}
+
+static int __maybe_unused brcmuart_suspend(struct device *dev)
+{
+	struct brcmuart_priv *priv = dev_get_drvdata(dev);
+
+	serial8250_suspend_port(priv->line);
+	clk_disable_unprepare(priv->baud_mux_clk);
+
+	return 0;
+}
+
+static int __maybe_unused brcmuart_resume(struct device *dev)
+{
+	struct brcmuart_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(priv->baud_mux_clk);
+	if (ret)
+		dev_err(dev, "Error enabling BAUD MUX clock\n");
+
+	/*
+	 * The hardware goes back to it's default after suspend
+	 * so get the "clk" back in sync.
+	 */
+	ret = clk_set_rate(priv->baud_mux_clk, priv->default_mux_rate);
+	if (ret)
+		dev_err(dev, "Error restoring default BAUD MUX clock\n");
+	if (priv->dma_enabled) {
+		brcmuart_arbitration(priv, 1);
+		brcmuart_init_dma_hardware(priv);
+		start_rx_dma(serial8250_get_port(priv->line));
+	}
+	serial8250_resume_port(priv->line);
+	return 0;
+}
+
+static const struct dev_pm_ops brcmuart_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(brcmuart_suspend, brcmuart_resume)
+};
+
+static struct platform_driver brcmuart_platform_driver = {
+	.driver = {
+		.name	= "bcm7271-uart",
+		.pm		= &brcmuart_dev_pm_ops,
+		.of_match_table = brcmuart_dt_ids,
+	},
+	.probe		= brcmuart_probe,
+	.remove		= brcmuart_remove,
+};
+module_platform_driver(brcmuart_platform_driver);
+
+MODULE_AUTHOR("Al Cooper");
+MODULE_DESCRIPTION("Broadcom NS16550A compatible serial port driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 603137da4736..436a686bf7fd 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -501,6 +501,7 @@ config SERIAL_8250_PXA
 	  applicable to both devicetree and legacy boards, and early console is
 	  part of its support.
 
+
 config SERIAL_8250_TEGRA
 	tristate "8250 support for Tegra serial ports"
 	default SERIAL_8250
@@ -510,6 +511,16 @@ config SERIAL_8250_TEGRA
 	  Select this option if you have machine with an NVIDIA Tegra SoC and
 	  wish to enable 8250 serial driver for the Tegra serial interfaces.
 
+config SERIAL_8250_BCM7271
+	bool "Broadcom 8250 based serial port"
+	depends on SERIAL_8250 && (ARCH_BRCMSTB || COMPILE_TEST)
+	default ARCH_BRCMSTB
+	help
+	  If you have a Broadcom STB based board and want to use the
+	  enhanced features of the Broadcom 8250 based serial port,
+	  including DMA support and high accuracy BAUD rates, say
+	  Y to this option. If unsure, say N.
+
 config SERIAL_OF_PLATFORM
 	tristate "Devicetree based probing for 8250 ports"
 	depends on SERIAL_8250 && OF
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index a8bfb654d490..b9bcd73c8997 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
 obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
 obj-$(CONFIG_SERIAL_8250_TEGRA)		+= 8250_tegra.o
+obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
diff --git a/drivers/tty/serial/8250/bcm7271_uart.h b/drivers/tty/serial/8250/bcm7271_uart.h
new file mode 100644
index 000000000000..78cce03f9e17
--- /dev/null
+++ b/drivers/tty/serial/8250/bcm7271_uart.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2020, Broadcom */
+#ifndef __BCM7271_UART_H__
+#define __BCM7271_UART_H__
+
+/* Register definitions for UART DMA block. Version 1.1 or later. */
+#define UDMA_ARB_RX		0x00
+#define UDMA_ARB_TX		0x04
+#define		UDMA_ARB_REQ				0x00000001
+#define		UDMA_ARB_GRANT				0x00000002
+
+#define UDMA_RX_REVISION	0x00
+#define UDMA_RX_REVISION_REQUIRED			0x00000101
+#define UDMA_RX_CTRL		0x04
+#define		UDMA_RX_CTRL_BUF_CLOSE_MODE		0x00010000
+#define		UDMA_RX_CTRL_MASK_WR_DONE		0x00008000
+#define		UDMA_RX_CTRL_ENDIAN_OVERRIDE		0x00004000
+#define		UDMA_RX_CTRL_ENDIAN			0x00002000
+#define		UDMA_RX_CTRL_OE_IS_ERR			0x00001000
+#define		UDMA_RX_CTRL_PE_IS_ERR			0x00000800
+#define		UDMA_RX_CTRL_FE_IS_ERR			0x00000400
+#define		UDMA_RX_CTRL_NUM_BUF_USED_MASK		0x000003c0
+#define		UDMA_RX_CTRL_NUM_BUF_USED_SHIFT	6
+#define		UDMA_RX_CTRL_BUF_CLOSE_CLK_SEL_SYS	0x00000020
+#define		UDMA_RX_CTRL_BUF_CLOSE_ENA		0x00000010
+#define		UDMA_RX_CTRL_TIMEOUT_CLK_SEL_SYS	0x00000008
+#define		UDMA_RX_CTRL_TIMEOUT_ENA		0x00000004
+#define		UDMA_RX_CTRL_ABORT			0x00000002
+#define		UDMA_RX_CTRL_ENA			0x00000001
+#define UDMA_RX_STATUS		0x08
+#define		UDMA_RX_STATUS_ACTIVE_BUF_MASK		0x0000000f
+#define UDMA_RX_TRANSFER_LEN	0x0c
+#define UDMA_RX_TRANSFER_TOTAL	0x10
+#define UDMA_RX_BUFFER_SIZE	0x14
+#define UDMA_RX_SRC_ADDR	0x18
+#define UDMA_RX_TIMEOUT		0x1c
+#define UDMA_RX_BUFFER_CLOSE	0x20
+#define UDMA_RX_BLOCKOUT_COUNTER 0x24
+#define UDMA_RX_BUF0_PTR_LO	0x28
+#define UDMA_RX_BUF0_PTR_HI	0x2c
+#define UDMA_RX_BUF0_STATUS	0x30
+#define		UDMA_RX_BUFX_STATUS_OVERRUN_ERR		0x00000010
+#define		UDMA_RX_BUFX_STATUS_FRAME_ERR		0x00000008
+#define		UDMA_RX_BUFX_STATUS_PARITY_ERR		0x00000004
+#define		UDMA_RX_BUFX_STATUS_CLOSE_EXPIRED	0x00000002
+#define		UDMA_RX_BUFX_STATUS_DATA_RDY		0x00000001
+#define UDMA_RX_BUF0_DATA_LEN	0x34
+#define UDMA_RX_BUF1_PTR_LO	0x38
+#define UDMA_RX_BUF1_PTR_HI	0x3c
+#define UDMA_RX_BUF1_STATUS	0x40
+#define UDMA_RX_BUF1_DATA_LEN	0x44
+
+#define UDMA_TX_REVISION	0x00
+#define UDMA_TX_REVISION_REQUIRED			0x00000101
+#define UDMA_TX_CTRL		0x04
+#define		UDMA_TX_CTRL_ENDIAN_OVERRIDE		0x00000080
+#define		UDMA_TX_CTRL_ENDIAN			0x00000040
+#define		UDMA_TX_CTRL_NUM_BUF_USED_MASK		0x00000030
+#define		UDMA_TX_CTRL_NUM_BUF_USED_1		0x00000010
+#define		UDMA_TX_CTRL_ABORT			0x00000002
+#define		UDMA_TX_CTRL_ENA			0x00000001
+#define UDMA_TX_DST_ADDR	0x08
+#define UDMA_TX_BLOCKOUT_COUNTER 0x10
+#define UDMA_TX_TRANSFER_LEN	0x14
+#define UDMA_TX_TRANSFER_TOTAL	0x18
+#define UDMA_TX_STATUS		0x20
+#define UDMA_TX_BUF0_PTR_LO	0x24
+#define UDMA_TX_BUF0_PTR_HI	0x28
+#define UDMA_TX_BUF0_STATUS	0x2c
+#define		UDMA_TX_BUFX_LAST			0x00000002
+#define		UDMA_TX_BUFX_EMPTY			0x00000001
+#define UDMA_TX_BUF0_DATA_LEN	0x30
+#define UDMA_TX_BUF0_DATA_SENT	0x34
+#define UDMA_TX_BUF1_PTR_LO	0x38
+
+#define UDMA_INTR_STATUS	0x00
+#define		UDMA_INTR_ARB_TX_GRANT			0x00040000
+#define		UDMA_INTR_ARB_RX_GRANT			0x00020000
+#define		UDMA_INTR_TX_ALL_EMPTY			0x00010000
+#define		UDMA_INTR_TX_EMPTY_BUF1			0x00008000
+#define		UDMA_INTR_TX_EMPTY_BUF0			0x00004000
+#define		UDMA_INTR_TX_ABORT			0x00002000
+#define		UDMA_INTR_TX_DONE			0x00001000
+#define		UDMA_INTR_RX_ERROR			0x00000800
+#define		UDMA_INTR_RX_TIMEOUT			0x00000400
+#define		UDMA_INTR_RX_READY_BUF7			0x00000200
+#define		UDMA_INTR_RX_READY_BUF6			0x00000100
+#define		UDMA_INTR_RX_READY_BUF5			0x00000080
+#define		UDMA_INTR_RX_READY_BUF4			0x00000040
+#define		UDMA_INTR_RX_READY_BUF3			0x00000020
+#define		UDMA_INTR_RX_READY_BUF2			0x00000010
+#define		UDMA_INTR_RX_READY_BUF1			0x00000008
+#define		UDMA_INTR_RX_READY_BUF0			0x00000004
+#define		UDMA_INTR_RX_READY_MASK			0x000003fc
+#define		UDMA_INTR_RX_READY_SHIFT		2
+#define		UDMA_INTR_RX_ABORT			0x00000002
+#define		UDMA_INTR_RX_DONE			0x00000001
+#define UDMA_INTR_SET		0x04
+#define UDMA_INTR_CLEAR		0x08
+#define UDMA_INTR_MASK_STATUS	0x0c
+#define UDMA_INTR_MASK_SET	0x10
+#define UDMA_INTR_MASK_CLEAR	0x14
+
+
+#define UDMA_RX_INTERRUPTS ( \
+	UDMA_INTR_RX_ERROR | \
+	UDMA_INTR_RX_TIMEOUT | \
+	UDMA_INTR_RX_READY_BUF0 | \
+	UDMA_INTR_RX_READY_BUF1 | \
+	UDMA_INTR_RX_READY_BUF2 | \
+	UDMA_INTR_RX_READY_BUF3 | \
+	UDMA_INTR_RX_READY_BUF4 | \
+	UDMA_INTR_RX_READY_BUF5 | \
+	UDMA_INTR_RX_READY_BUF6 | \
+	UDMA_INTR_RX_READY_BUF7 | \
+	UDMA_INTR_RX_ABORT | \
+	UDMA_INTR_RX_DONE)
+
+#define UDMA_RX_ERR_INTERRUPTS ( \
+	UDMA_INTR_RX_ERROR | \
+	UDMA_INTR_RX_TIMEOUT | \
+	UDMA_INTR_RX_ABORT | \
+	UDMA_INTR_RX_DONE)
+
+#define UDMA_TX_INTERRUPTS ( \
+	UDMA_INTR_TX_ABORT | \
+	UDMA_INTR_TX_DONE)
+
+#define UDMA_IS_RX_INTERRUPT(status) ((status) & UDMA_RX_INTERRUPTS)
+#define UDMA_IS_TX_INTERRUPT(status) ((status) & UDMA_TX_INTERRUPTS)
+
+
+/* Current devices have 8 sets of RX buffer registers */
+#define UDMA_RX_BUFS_COUNT	8
+#define UDMA_RX_BUFS_REG_OFFSET (UDMA_RX_BUF1_PTR_LO - UDMA_RX_BUF0_PTR_LO)
+#define UDMA_RX_BUFx_PTR_LO(x)	(UDMA_RX_BUF0_PTR_LO + \
+				 ((x) * UDMA_RX_BUFS_REG_OFFSET))
+#define UDMA_RX_BUFx_PTR_HI(x)	(UDMA_RX_BUF0_PTR_HI + \
+				 ((x) * UDMA_RX_BUFS_REG_OFFSET))
+#define UDMA_RX_BUFx_STATUS(x)	(UDMA_RX_BUF0_STATUS + \
+				 ((x) * UDMA_RX_BUFS_REG_OFFSET))
+#define UDMA_RX_BUFx_DATA_LEN(x) (UDMA_RX_BUF0_DATA_LEN + \
+				  ((x) * UDMA_RX_BUFS_REG_OFFSET))
+
+/* Current devices have 2 sets of TX buffer registers */
+#define UDMA_TX_BUFS_COUNT	2
+#define UDMA_TX_BUFS_REG_OFFSET (UDMA_TX_BUF1_PTR_LO - UDMA_TX_BUF0_PTR_LO)
+#define UDMA_TX_BUFx_PTR_LO(x)	(UDMA_TX_BUF0_PTR_LO + \
+				 ((x) * UDMA_TX_BUFS_REG_OFFSET))
+#define UDMA_TX_BUFx_PTR_HI(x)	(UDMA_TX_BUF0_PTR_HI + \
+				 ((x) * UDMA_TX_BUFS_REG_OFFSET))
+#define UDMA_TX_BUFx_STATUS(x)	(UDMA_TX_BUF0_STATUS + \
+				 ((x) * UDMA_TX_BUFS_REG_OFFSET))
+#define UDMA_TX_BUFx_DATA_LEN(x) (UDMA_TX_BUF0_DATA_LEN + \
+				  ((x) * UDMA_TX_BUFS_REG_OFFSET))
+#define UDMA_TX_BUFx_DATA_SENT(x) (UDMA_TX_BUF0_DATA_SENT + \
+				   ((x) * UDMA_TX_BUFS_REG_OFFSET))
+#endif /* __BCM7271_UART_H__ */
-- 
2.17.1

