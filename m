Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A2DEE49B2
	for <linux-serial@archiver.kernel.org>; Thu, 31 Aug 2023 22:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjHaW0g (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 31 Aug 2023 18:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjHaW0g (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 31 Aug 2023 18:26:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F31B5;
        Thu, 31 Aug 2023 15:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693520793; x=1725056793;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=unM5k75mL0PN6hQnk5H25AHrLOCYujwuZsO9n7FmSrE=;
  b=ixeU39XNIT9mpxAkEti1Bvlln2Ir3eHzP/9/Rh3FOZJIft7XMuld+k9b
   ax8eLdvM3bZJVJSd3J4DwcQkBeQ7R+e50vjAGoNsmdiGfdzRRSXRM0Ryg
   sPE55nOs6otZhyowIW2IyVXCtiRto6kPnYLetT8dZsjHL3ashLUKqzNqG
   Xd3na2AVX768soTwJ8Pu6qwvtQquSlmoGJ/Tx6OdiKEwx1Z3JmqT+xD5G
   l0CsrDOfIodcC6V1QGQizwcX7l4RKMCfBxTuk7Cl5kV9ntKeOOh84SHIJ
   ogo90btl/in6+sqAGa8CQd6M/1UDlh8rzRs9dZfKhAVjO0ErLFySNRh/r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="378813954"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="378813954"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 15:26:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854457434"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="854457434"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 31 Aug 2023 15:26:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 151EA3B5; Fri,  1 Sep 2023 01:26:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: 8250_port: Check IRQ data before use
Date:   Fri,  1 Sep 2023 01:25:55 +0300
Message-Id: <20230831222555.614426-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In case the leaf driver wants to use IRQ polling (irq = 0) and
IIR register shows that an interrupt happened in the 8250 hardware
the IRQ data can be NULL. In such a case we need to skip the wake
event as we came to this path from the timer interrupt and quite
likely system is already awake.

Without this fix we have got an Oops:

    serial8250: ttyS0 at I/O 0x3f8 (irq = 0, base_baud = 115200) is a 16550A
    ...
    BUG: kernel NULL pointer dereference, address: 0000000000000010
    RIP: 0010:serial8250_handle_irq+0x7c/0x240
    Call Trace:
     ? serial8250_handle_irq+0x7c/0x240
     ? __pfx_serial8250_timeout+0x10/0x10

Fixes: 0ba9e3a13c6a ("serial: 8250: Add missing wakeup event reporting")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fb891b67968f..141627370aab 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1936,7 +1936,10 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		skip_rx = true;
 
 	if (status & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
-		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
+		struct irq_data *d;
+
+		d = irq_get_irq_data(port->irq);
+		if (d && irqd_is_wakeup_set(d))
 			pm_wakeup_event(tport->tty->dev, 0);
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
-- 
2.40.0.1.gaa8946217a0b

