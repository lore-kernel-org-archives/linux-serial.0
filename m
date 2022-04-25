Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DE9C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 25 Apr 2022 14:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiDYOkD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Apr 2022 10:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242419AbiDYOkC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Apr 2022 10:40:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C5713EA1
        for <linux-serial@vger.kernel.org>; Mon, 25 Apr 2022 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650897418; x=1682433418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=His87S4+EY/T/CrgooNywg5mDe55vTpZc1+L5cNp40k=;
  b=XV+oUo72jy1h+BrYd63oQdA/HDnpKjU51mPCIy+clqU5xELBB0niuVF7
   BZBQ2g4Wdr1iKkqZY6a9ogSnOLxoT4NaF8l9XpnOXghVyttHzZfmVF6on
   7eiNqqI6iwbG1prIgmAIFKQ9rtQHIFSf0IMcUdpRfqMk060Pe3TpnKBR+
   1eFrt9wxbBwG7rbGXxxgC9IOiP/hZX1YSE5Pjo26bV9xEqcGb/T5bMYBX
   qKzIFil5kkfX7HOWGk4x1OTIRoqaeP8x4zEpR9MM1CXDe0mqlEAjPpIJ8
   600+12zoFiEqfari2manG2zB5FfA9LFQsuVl8PVtnj2QHjxPyTqa9Qh/M
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264113468"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="264113468"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:36:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="579316516"
Received: from lpuglia-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.217.93])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:36:51 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vicente Bergas <vicencb@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>
Subject: [PATCH v4 13/13] serial: 8250_dwlib: Support for 9th bit multipoint addressing
Date:   Mon, 25 Apr 2022 17:34:10 +0300
Message-Id: <20220425143410.12703-14-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
References: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This change adds 9th bit multipoint addressing mode for DW UART using
the new ioctls introduced in the previous change. 9th bit addressing
can be used only when HW RS485 is available.

Updating RAR (receive address register) is bit tricky because busy
indication is not be available when DW UART is strictly 16550
compatible, which is the case with the hardware I was testing with. RAR
should not be updated while receive is in progress which is now
achieved by deasserting RE and waiting for one frame (in case rx would
be in progress, the driver seems to have no way of knowing it w/o busy
indication).

Co-developed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Co-developed-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Raymond Tan <raymond.tan@intel.com>
Co-developed-by: Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 142 +++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_dwlib.h |   2 +
 2 files changed, 144 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 04852af4c024..413cdb426536 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -3,9 +3,11 @@
 
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/property.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
@@ -17,9 +19,18 @@
 #define DW_UART_DE_EN	0xb0 /* Driver Output Enable Register */
 #define DW_UART_RE_EN	0xb4 /* Receiver Output Enable Register */
 #define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
+#define DW_UART_RAR	0xc4 /* Receive Address Register */
+#define DW_UART_TAR	0xc8 /* Transmit Address Register */
+#define DW_UART_LCR_EXT	0xcc /* Line Extended Control Register */
 #define DW_UART_CPR	0xf4 /* Component Parameter Register */
 #define DW_UART_UCV	0xf8 /* UART Component Version */
 
+/* Receive / Transmit Address Register bits */
+#define DW_UART_ADDR_MASK		GENMASK(7, 0)
+
+/* Line Status Register bits */
+#define DW_UART_LSR_ADDR_RCVD		BIT(8)
+
 /* Transceiver Control Register bits */
 #define DW_UART_TCR_RS485_EN		BIT(0)
 #define DW_UART_TCR_RE_POL		BIT(1)
@@ -29,6 +40,12 @@
 #define DW_UART_TCR_XFER_MODE_SW_DE_OR_RE	FIELD_PREP(DW_UART_TCR_XFER_MODE, 1)
 #define DW_UART_TCR_XFER_MODE_DE_OR_RE		FIELD_PREP(DW_UART_TCR_XFER_MODE, 2)
 
+/* Line Extended Control Register bits */
+#define DW_UART_LCR_EXT_DLS_E		BIT(0)
+#define DW_UART_LCR_EXT_ADDR_MATCH	BIT(1)
+#define DW_UART_LCR_EXT_SEND_ADDR	BIT(2)
+#define DW_UART_LCR_EXT_TRANSMIT_MODE	BIT(3)
+
 /* Component Parameter Register bits */
 #define DW_UART_CPR_ABP_DATA_WIDTH	(3 << 0)
 #define DW_UART_CPR_AFCE_MODE		(1 << 4)
@@ -91,18 +108,132 @@ static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 	serial8250_do_set_divisor(p, baud, quot, quot_frac);
 }
 
+/*
+ * Wait until re is de-asserted for sure. An ongoing receive will keep
+ * re asserted until end of frame. Without BUSY indication available,
+ * only available course of action is to wait for the time it takes to
+ * receive one frame (there might nothing to receive but w/o BUSY the
+ * driver cannot know).
+ */
+static void dw8250_wait_re_deassert(struct uart_port *p)
+{
+	udelay(p->frame_time);
+}
+
+static void dw8250_update_rar(struct uart_port *p, u32 addr)
+{
+	u32 re_en = dw8250_readl_ext(p, DW_UART_RE_EN);
+
+	/*
+	 * RAR shouldn't be changed while receiving. Thus, de-assert RE_EN
+	 * if asserted and wait.
+	 */
+	if (re_en)
+		dw8250_writel_ext(p, DW_UART_RE_EN, 0);
+	dw8250_wait_re_deassert(p);
+	dw8250_writel_ext(p, DW_UART_RAR, addr);
+	if (re_en)
+		dw8250_writel_ext(p, DW_UART_RE_EN, re_en);
+}
+
+static void dw8250_addrmode_setup(struct uart_port *p, bool enable_addrmode)
+{
+	struct dw8250_port_data *d = p->private_data;
+
+	if (enable_addrmode) {
+		/* Clear RAR & TAR of any previous values */
+		dw8250_writel_ext(p, DW_UART_RAR, 0);
+		dw8250_writel_ext(p, DW_UART_TAR, 0);
+		dw8250_writel_ext(p, DW_UART_LCR_EXT, DW_UART_LCR_EXT_DLS_E);
+	} else {
+		dw8250_writel_ext(p, DW_UART_LCR_EXT, 0);
+	}
+
+	d->addrmode = enable_addrmode;
+}
+
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, struct ktermios *old)
 {
+	struct dw8250_port_data *d = p->private_data;
+
 	p->status &= ~UPSTAT_AUTOCTS;
 	if (termios->c_cflag & CRTSCTS)
 		p->status |= UPSTAT_AUTOCTS;
 
+	if (!(p->rs485.flags & SER_RS485_ENABLED) || !d->hw_rs485_support)
+		termios->c_cflag &= ~ADDRB;
+
+	if (!old || (termios->c_cflag ^ old->c_cflag) & ADDRB)
+		dw8250_addrmode_setup(p, termios->c_cflag & ADDRB);
+
 	serial8250_do_set_termios(p, termios, old);
+
+	if (d->addrmode) {
+		p->ignore_status_mask |= DW_UART_LSR_ADDR_RCVD;
+		p->read_status_mask |= DW_UART_LSR_ADDR_RCVD;
+	}
 }
 EXPORT_SYMBOL_GPL(dw8250_do_set_termios);
 
+static int dw8250_rs485_set_addr(struct uart_port *p, struct serial_addr *addr)
+{
+	struct dw8250_port_data *d = p->private_data;
+	u32 lcr;
+
+	if (!(p->rs485.flags & SER_RS485_ENABLED) || !d->addrmode)
+		return -EINVAL;
+
+	addr->flags &= SER_ADDR_RECV | SER_ADDR_RECV_CLEAR | SER_ADDR_DEST;
+	if (!addr->flags)
+		return -EINVAL;
+
+	lcr = dw8250_readl_ext(p, DW_UART_LCR_EXT);
+	if (addr->flags & SER_ADDR_RECV) {
+		dw8250_update_rar(p, addr->addr & DW_UART_ADDR_MASK);
+		lcr |= DW_UART_LCR_EXT_ADDR_MATCH;
+		addr->flags &= ~SER_ADDR_RECV_CLEAR;
+	} else if (addr->flags & SER_ADDR_RECV_CLEAR) {
+		lcr &= DW_UART_LCR_EXT_ADDR_MATCH;
+	}
+	if (addr->flags & SER_ADDR_DEST) {
+		dw8250_writel_ext(p, DW_UART_TAR, addr->addr & DW_UART_ADDR_MASK);
+		lcr |= DW_UART_LCR_EXT_SEND_ADDR;
+	}
+	dw8250_writel_ext(p, DW_UART_LCR_EXT, lcr);
+
+	return 0;
+}
+
+static int dw8250_rs485_get_addr(struct uart_port *p, struct serial_addr *addr)
+{
+	struct dw8250_port_data *d = p->private_data;
+
+	if (!(p->rs485.flags & SER_RS485_ENABLED) || !d->addrmode)
+		return -EINVAL;
+
+	if (addr->flags == SER_ADDR_DEST) {
+		addr->addr = dw8250_readl_ext(p, DW_UART_TAR) & DW_UART_ADDR_MASK;
+		return 0;
+	}
+	if (addr->flags == SER_ADDR_RECV) {
+		u32 lcr = dw8250_readl_ext(p, DW_UART_LCR_EXT);
+
+		if (!(lcr & DW_UART_LCR_EXT_ADDR_MATCH)) {
+			addr->flags = SER_ADDR_RECV_CLEAR;
+			addr->addr = 0;
+		} else {
+			addr->addr = dw8250_readl_ext(p, DW_UART_RAR) & DW_UART_ADDR_MASK;
+		}
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
 {
+	struct dw8250_port_data *d = p->private_data;
 	u32 tcr;
 
 	tcr = dw8250_readl_ext(p, DW_UART_TCR);
@@ -127,6 +258,14 @@ static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
 		dw8250_writel_ext(p, DW_UART_DE_EN, 1);
 		dw8250_writel_ext(p, DW_UART_RE_EN, 1);
 	} else {
+		/*
+		 * Don't allow disabling RS485 when address mode is enabled.
+		 * Clearing address mode would require clearing ADDRB in
+		 * termios.
+		 */
+		if (d->addrmode)
+			return -EINVAL;
+
 		rs485->flags = 0;
 
 		tcr &= ~DW_UART_TCR_RS485_EN;
@@ -174,6 +313,9 @@ void dw8250_setup_port(struct uart_port *p)
 	d->hw_rs485_support = dw8250_detect_rs485_hw(p);
 	if (d->hw_rs485_support) {
 		p->rs485_config = dw8250_rs485_config;
+		p->set_addr = dw8250_rs485_set_addr;
+		p->get_addr = dw8250_rs485_get_addr;
+		up->lsr_save_mask = LSR_SAVE_FLAGS | DW_UART_LSR_ADDR_RCVD;
 	} else {
 		p->rs485_config = serial8250_em485_config;
 		up->rs485_start_tx = serial8250_em485_start_tx;
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index a8fa020ca544..c616d5b29f66 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -17,6 +17,8 @@ struct dw8250_port_data {
 
 	/* RS485 variables */
 	bool			hw_rs485_support;
+	/* 9-bit framing (9th bit is address indicator) */
+	bool			addrmode;
 };
 
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, struct ktermios *old);
-- 
2.30.2

