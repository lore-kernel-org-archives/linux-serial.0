Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003D5C3F68F
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 11:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D548F217F4
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 11:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgBNLnp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 06:43:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:15840 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbgBNLnp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 06:43:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 03:43:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,440,1574150400"; 
   d="scan'208";a="347943138"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2020 03:43:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9841528E; Fri, 14 Feb 2020 13:43:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/8] serial: core: use octal permissions on module param
Date:   Fri, 14 Feb 2020 13:43:34 +0200
Message-Id: <20200214114339.53897-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Symbolic permissions 'S_IRUSR | S_IRGRP' are not preferred.
Use octal permissions '0440'. This also makes code shorter.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index bb2287048108..7564bbd3061c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2749,19 +2749,19 @@ static ssize_t uart_get_attr_iomem_reg_shift(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.iomem_reg_shift);
 }
 
-static DEVICE_ATTR(type, S_IRUSR | S_IRGRP, uart_get_attr_type, NULL);
-static DEVICE_ATTR(line, S_IRUSR | S_IRGRP, uart_get_attr_line, NULL);
-static DEVICE_ATTR(port, S_IRUSR | S_IRGRP, uart_get_attr_port, NULL);
-static DEVICE_ATTR(irq, S_IRUSR | S_IRGRP, uart_get_attr_irq, NULL);
-static DEVICE_ATTR(flags, S_IRUSR | S_IRGRP, uart_get_attr_flags, NULL);
-static DEVICE_ATTR(xmit_fifo_size, S_IRUSR | S_IRGRP, uart_get_attr_xmit_fifo_size, NULL);
-static DEVICE_ATTR(uartclk, S_IRUSR | S_IRGRP, uart_get_attr_uartclk, NULL);
-static DEVICE_ATTR(close_delay, S_IRUSR | S_IRGRP, uart_get_attr_close_delay, NULL);
-static DEVICE_ATTR(closing_wait, S_IRUSR | S_IRGRP, uart_get_attr_closing_wait, NULL);
-static DEVICE_ATTR(custom_divisor, S_IRUSR | S_IRGRP, uart_get_attr_custom_divisor, NULL);
-static DEVICE_ATTR(io_type, S_IRUSR | S_IRGRP, uart_get_attr_io_type, NULL);
-static DEVICE_ATTR(iomem_base, S_IRUSR | S_IRGRP, uart_get_attr_iomem_base, NULL);
-static DEVICE_ATTR(iomem_reg_shift, S_IRUSR | S_IRGRP, uart_get_attr_iomem_reg_shift, NULL);
+static DEVICE_ATTR(type, 0440, uart_get_attr_type, NULL);
+static DEVICE_ATTR(line, 0440, uart_get_attr_line, NULL);
+static DEVICE_ATTR(port, 0440, uart_get_attr_port, NULL);
+static DEVICE_ATTR(irq, 0440, uart_get_attr_irq, NULL);
+static DEVICE_ATTR(flags, 0440, uart_get_attr_flags, NULL);
+static DEVICE_ATTR(xmit_fifo_size, 0440, uart_get_attr_xmit_fifo_size, NULL);
+static DEVICE_ATTR(uartclk, 0440, uart_get_attr_uartclk, NULL);
+static DEVICE_ATTR(close_delay, 0440, uart_get_attr_close_delay, NULL);
+static DEVICE_ATTR(closing_wait, 0440, uart_get_attr_closing_wait, NULL);
+static DEVICE_ATTR(custom_divisor, 0440, uart_get_attr_custom_divisor, NULL);
+static DEVICE_ATTR(io_type, 0440, uart_get_attr_io_type, NULL);
+static DEVICE_ATTR(iomem_base, 0440, uart_get_attr_iomem_base, NULL);
+static DEVICE_ATTR(iomem_reg_shift, 0440, uart_get_attr_iomem_reg_shift, NULL);
 
 static struct attribute *tty_dev_attrs[] = {
 	&dev_attr_type.attr,
-- 
2.25.0

