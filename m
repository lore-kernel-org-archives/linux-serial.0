Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E93FC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 11 Apr 2022 08:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343851AbiDKIgE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Apr 2022 04:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343854AbiDKIgB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Apr 2022 04:36:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D03EA80
        for <linux-serial@vger.kernel.org>; Mon, 11 Apr 2022 01:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649666028; x=1681202028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0kH8vIyFENGtdjuxSU+mU/Y72tpjY+qAd1ZW1CvDfVE=;
  b=Aw85+elSv5Igx20CNavqLsHHokTSTv35tvCNF03h+VYeqI2NJPD7mPCC
   2G4WL/8a6IzlVz8Wixw3cL5z1WglPNR9C5/htxpC4UzzYy8OtcMVn4mXo
   N8G+D2jbjCqUcHQLEejJB31VelUydPgGn/e+7petnLGEtUzpg5LIAvHMx
   5ih9/8sNhkOxHTB3j7psYPCQEQwZw0qKvSnKAv7UtBKaT2kDSMXFDEC8f
   kHLQyzOQNQlnkf8qFarm3avUa7qYWHTpuPukSe9xM485Rkn4MRvu6SB+S
   UBbfS3NYqbiKYwDM6Gr7UsOB3p3mXc8uVU4J+/VyJKlz7hPs5GeWJz3/z
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="322511554"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="322511554"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:33:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572028628"
Received: from azahoner-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:33:45 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>
Subject: [PATCH v3 03/12] serial: 8250_dwlib: RS485 HW half & full duplex support
Date:   Mon, 11 Apr 2022 11:33:12 +0300
Message-Id: <20220411083321.9131-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The Synopsys DesignWare UART can be configured to have HW
support for the RS485 protocol from IP version 4.0 onward.
Add support for hardware-controlled half duplex and full
duplex modes.

HW will take care of managing DE and RE, the driver just gives
it permission to use either by setting both to 1.

To ask for full duplex mode, userspace sets SER_RS485_RX_DURING_TX
flag and HW will take care of the rest.

Set delay_rts_before_send and delay_rts_after_send to zero for now.
The granularity of that ABI is too coarse to be useful.

Co-developed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Co-developed-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Raymond Tan <raymond.tan@intel.com>
Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 85 +++++++++++++++++++++++++++-
 drivers/tty/serial/8250/8250_dwlib.h |  3 +
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 622d3b0d89e7..08432e2fe511 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -2,19 +2,33 @@
 /* Synopsys DesignWare 8250 library. */
 
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/property.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
 
 #include "8250_dwlib.h"
 
 /* Offsets for the DesignWare specific registers */
+#define DW_UART_TCR	0xac /* Transceiver Control Register (RS485) */
+#define DW_UART_DE_EN	0xb0 /* Driver Output Enable Register */
+#define DW_UART_RE_EN	0xb4 /* Receiver Output Enable Register */
 #define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
 #define DW_UART_CPR	0xf4 /* Component Parameter Register */
 #define DW_UART_UCV	0xf8 /* UART Component Version */
 
+/* Transceiver Control Register bits */
+#define DW_UART_TCR_RS485_EN		BIT(0)
+#define DW_UART_TCR_RE_POL		BIT(1)
+#define DW_UART_TCR_DE_POL		BIT(2)
+#define DW_UART_TCR_XFER_MODE		GENMASK(4, 3)
+#define DW_UART_TCR_XFER_MODE_DE_DURING_RE	FIELD_PREP(DW_UART_TCR_XFER_MODE, 0)
+#define DW_UART_TCR_XFER_MODE_SW_DE_OR_RE	FIELD_PREP(DW_UART_TCR_XFER_MODE, 1)
+#define DW_UART_TCR_XFER_MODE_DE_OR_RE		FIELD_PREP(DW_UART_TCR_XFER_MODE, 2)
+
 /* Component Parameter Register bits */
 #define DW_UART_CPR_ABP_DATA_WIDTH	(3 << 0)
 #define DW_UART_CPR_AFCE_MODE		(1 << 4)
@@ -87,11 +101,80 @@ void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, struct
 }
 EXPORT_SYMBOL_GPL(dw8250_do_set_termios);
 
+static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
+{
+	u32 tcr;
+
+	tcr = dw8250_readl_ext(p, DW_UART_TCR);
+	tcr &= ~DW_UART_TCR_XFER_MODE;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		/* Clear unsupported flags. */
+		rs485->flags &= SER_RS485_ENABLED | SER_RS485_RX_DURING_TX |
+				SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND;
+		tcr |= DW_UART_TCR_RS485_EN;
+
+		if (rs485->flags & SER_RS485_RX_DURING_TX) {
+			tcr |= DW_UART_TCR_XFER_MODE_DE_DURING_RE;
+		} else {
+			/* HW does not support same DE level for tx and rx */
+			if (!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
+			    !(rs485->flags & SER_RS485_RTS_AFTER_SEND))
+				return -EINVAL;
+
+			tcr |= DW_UART_TCR_XFER_MODE_DE_OR_RE;
+		}
+		dw8250_writel_ext(p, DW_UART_DE_EN, 1);
+		dw8250_writel_ext(p, DW_UART_RE_EN, 1);
+	} else {
+		rs485->flags = 0;
+
+		tcr &= ~DW_UART_TCR_RS485_EN;
+	}
+
+	/* Reset to default polarity */
+	tcr |= DW_UART_TCR_DE_POL;
+	tcr &= ~DW_UART_TCR_RE_POL;
+
+	if (!(rs485->flags & SER_RS485_RTS_ON_SEND))
+		tcr &= ~DW_UART_TCR_DE_POL;
+	if (device_property_read_bool(p->dev, "rs485-rx-active-high"))
+		tcr |= DW_UART_TCR_RE_POL;
+
+	dw8250_writel_ext(p, DW_UART_TCR, tcr);
+
+	rs485->delay_rts_before_send = 0;
+	rs485->delay_rts_after_send = 0;
+
+	p->rs485 = *rs485;
+
+	return 0;
+}
+
+/*
+ * Tests if RE_EN register can have non-zero value to see if RS-485 HW support
+ * is present.
+ */
+static bool dw8250_detect_rs485_hw(struct uart_port *p)
+{
+	u32 reg;
+
+	dw8250_writel_ext(p, DW_UART_RE_EN, 1);
+	reg = dw8250_readl_ext(p, DW_UART_RE_EN);
+	dw8250_writel_ext(p, DW_UART_RE_EN, 0);
+	return reg;
+}
+
 void dw8250_setup_port(struct uart_port *p)
 {
+	struct dw8250_port_data *d = p->private_data;
 	struct uart_8250_port *up = up_to_u8250p(p);
 	u32 reg;
 
+	d->hw_rs485_support = dw8250_detect_rs485_hw(p);
+	if (d->hw_rs485_support)
+		p->rs485_config = dw8250_rs485_config;
+
 	/*
 	 * If the Component Version Register returns zero, we know that
 	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
@@ -108,8 +191,6 @@ void dw8250_setup_port(struct uart_port *p)
 	dw8250_writel_ext(p, DW_UART_DLF, 0);
 
 	if (reg) {
-		struct dw8250_port_data *d = p->private_data;
-
 		d->dlf_size = fls(reg);
 		p->get_divisor = dw8250_get_divisor;
 		p->set_divisor = dw8250_set_divisor;
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 83d528e5cc21..a8fa020ca544 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -14,6 +14,9 @@ struct dw8250_port_data {
 
 	/* Hardware configuration */
 	u8			dlf_size;
+
+	/* RS485 variables */
+	bool			hw_rs485_support;
 };
 
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, struct ktermios *old);
-- 
2.30.2

