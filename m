Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15340E7AD60
	for <linux-serial@archiver.kernel.org>; Tue,  3 Oct 2023 14:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbjJCOXz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Oct 2023 10:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239596AbjJCOXy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Oct 2023 10:23:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE181B0;
        Tue,  3 Oct 2023 07:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696343031; x=1727879031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/BaRwNkxcnjqUjZLYpeWw1A1HPoRDJh3QoyajTVpBcE=;
  b=ZXwtyiU5/jWt5ntqVlSdia39xJSl9Xabs2Usj0GJEZjXMg1IPQ2CwPWa
   Dv/1N29hGsND5BP/T0SySdvM10ebahECLAXtlboxroQYiD255Ph/O0rT7
   FvFTXhWhrnP8kiNNH5ZvyETuKrte7+V+kHOVF5dgO5yCLqdLqIwH8zzl9
   8ynhCxVW2YFB9L8cDKoXox56dxhmvF4gennPdXvyTn3LQa3nabS6A0cov
   8zA+CWZDZWXuxvAiXIDWAX/VHmaDsbw+0mCgok63f94YbiZF18rUGr9+R
   syGiWUE1rpGsWQiRgyRJ+lXViNe7WDZJUaE1PfiK1pEIpo+XXGTYDtB0j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="382794534"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="382794534"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:23:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="894497807"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="894497807"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Oct 2023 07:22:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A495818AE; Tue,  3 Oct 2023 17:23:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: core: Simplify uart_get_rs485_mode()
Date:   Tue,  3 Oct 2023 17:23:46 +0300
Message-Id: <20231003142346.3072929-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Simplify uart_get_rs485_mode() by using temporary variable for
the GPIO descriptor. With that, use proper type for the flags
of the GPIO descriptor.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b32bbd7aa3d3..70bf2bec875c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3559,9 +3559,10 @@ int uart_get_rs485_mode(struct uart_port *port)
 {
 	struct serial_rs485 *rs485conf = &port->rs485;
 	struct device *dev = port->dev;
+	enum gpiod_flags dflags;
+	struct gpio_desc *desc;
 	u32 rs485_delay[2];
 	int ret;
-	int rx_during_tx_gpio_flag;
 
 	ret = device_property_read_u32_array(dev, "rs485-rts-delay",
 					     rs485_delay, 2);
@@ -3600,26 +3601,19 @@ int uart_get_rs485_mode(struct uart_port *port)
 	 * bus participants enable it, no communication is possible at all.
 	 * Works fine for short cables and users may enable for longer cables.
 	 */
-	port->rs485_term_gpio = devm_gpiod_get_optional(dev, "rs485-term",
-							GPIOD_OUT_LOW);
-	if (IS_ERR(port->rs485_term_gpio)) {
-		ret = PTR_ERR(port->rs485_term_gpio);
-		port->rs485_term_gpio = NULL;
-		return dev_err_probe(dev, ret, "Cannot get rs485-term-gpios\n");
-	}
+	desc = devm_gpiod_get_optional(dev, "rs485-term", GPIOD_OUT_LOW);
+	if (IS_ERR(desc))
+		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-term-gpios\n");
+	port->rs485_term_gpio = desc;
 	if (port->rs485_term_gpio)
 		port->rs485_supported.flags |= SER_RS485_TERMINATE_BUS;
 
-	rx_during_tx_gpio_flag = (rs485conf->flags & SER_RS485_RX_DURING_TX) ?
-				 GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
-	port->rs485_rx_during_tx_gpio = devm_gpiod_get_optional(dev,
-								"rs485-rx-during-tx",
-								rx_during_tx_gpio_flag);
-	if (IS_ERR(port->rs485_rx_during_tx_gpio)) {
-		ret = PTR_ERR(port->rs485_rx_during_tx_gpio);
-		port->rs485_rx_during_tx_gpio = NULL;
-		return dev_err_probe(dev, ret, "Cannot get rs485-rx-during-tx-gpios\n");
-	}
+	dflags = (rs485conf->flags & SER_RS485_RX_DURING_TX) ?
+		 GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	desc = devm_gpiod_get_optional(dev, "rs485-rx-during-tx", dflags);
+	if (IS_ERR(desc))
+		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-rx-during-tx-gpios\n");
+	port->rs485_rx_during_tx_gpio = desc;
 
 	return 0;
 }
-- 
2.40.0.1.gaa8946217a0b

