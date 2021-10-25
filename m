Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DA3C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 25 Oct 2021 12:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A90660E08
	for <linux-serial@archiver.kernel.org>; Mon, 25 Oct 2021 12:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhJYMo5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Oct 2021 08:44:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:26935 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233101AbhJYMo5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Oct 2021 08:44:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="229910448"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="229910448"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 05:41:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="536500508"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 25 Oct 2021 05:41:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AD78DE7; Mon, 25 Oct 2021 15:41:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] serial: 8250_port: properly handle runtime PM in IRQ
Date:   Mon, 25 Oct 2021 15:41:42 +0300
Message-Id: <20211025124142.18041-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025124142.18041-1-andriy.shevchenko@linux.intel.com>
References: <20211025124142.18041-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We can't and basically don't need to call runtime PM in IRQ handler. If IRQ is
ours, device must be powered on. Otherwise check if the device is powered off
and return immediately.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5775cbff8f6e..89387d86d495 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1939,17 +1939,19 @@ EXPORT_SYMBOL_GPL(serial8250_handle_irq);
 
 static int serial8250_default_handle_irq(struct uart_port *port)
 {
-	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned int iir;
-	int ret;
 
-	serial8250_rpm_get(up);
+	/*
+	 * The IRQ might be shared with other peripherals so we must first
+	 * check that are we RPM suspended or not. If we are we assume that
+	 * the IRQ was not for us (we shouldn't be RPM suspended when the
+	 * interrupt is enabled).
+	 */
+	if (pm_runtime_suspended(port->dev))
+		return 0;
 
 	iir = serial_port_in(port, UART_IIR);
-	ret = serial8250_handle_irq(port, iir);
-
-	serial8250_rpm_put(up);
-	return ret;
+	return serial8250_handle_irq(port, iir);
 }
 
 /*
-- 
2.33.0

