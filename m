Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543D0C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 14:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD3861B29
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 14:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbhKQO6L (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:58:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:42179 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbhKQO6K (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Nov 2021 09:58:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="233793088"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="233793088"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 06:55:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="506950640"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 17 Nov 2021 06:55:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1EE32557; Wed, 17 Nov 2021 16:55:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v2 2/2] serial: 8250_pci: rewrite pericom_do_set_divisor()
Date:   Wed, 17 Nov 2021 16:55:02 +0200
Message-Id: <20211117145502.43645-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211117145502.43645-1-andriy.shevchenko@linux.intel.com>
References: <20211117145502.43645-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Jay Dolan <jay.dolan@accesio.com>

Have pericom_do_set_divisor() use the uartclk instead of a hard coded
value to work with different speed crystals. Tested with 14.7456 and 24
MHz crystals.

Have pericom_do_set_divisor() always calculate the divisor rather than
call serial8250_do_set_divisor() for rates below baud_base.

Do not write registers or call serial8250_do_set_divisor() if valid
divisors could not be found.

Fixes: 6bf4e42f1d19 ("serial: 8250: Add support for higher baud rates to Pericom chips")
Signed-off-by: Jay Dolan <jay.dolan@accesio.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pci.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index b793d848aeb6..8b29a9381c74 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1324,29 +1324,33 @@ pericom_do_set_divisor(struct uart_port *port, unsigned int baud,
 {
 	int scr;
 	int lcr;
-	int actual_baud;
-	int tolerance;
 
-	for (scr = 5 ; scr <= 15 ; scr++) {
-		actual_baud = 921600 * 16 / scr;
-		tolerance = actual_baud / 50;
+	for (scr = 16; scr > 4; scr--) {
+		unsigned int maxrate = port->uartclk / scr;
+		unsigned int divisor = maxrate / baud;
+		int delta = maxrate / divisor - baud;
 
-		if ((baud < actual_baud + tolerance) &&
-			(baud > actual_baud - tolerance)) {
+		if (baud > maxrate + baud / 50)
+			continue;
 
+		if (divisor == 0 || delta > baud / 50)
+			divisor++;
+
+		if (divisor > 0xffff)
+			continue;
+
+		/* Update delta due to possible divisor change */
+		delta = maxrate / divisor - baud;
+		if (abs(delta) < baud / 50) {
 			lcr = serial_port_in(port, UART_LCR);
 			serial_port_out(port, UART_LCR, lcr | 0x80);
-
-			serial_port_out(port, UART_DLL, 1);
-			serial_port_out(port, UART_DLM, 0);
+			serial_port_out(port, UART_DLL, divisor & 0xff);
+			serial_port_out(port, UART_DLM, divisor >> 8 & 0xff);
 			serial_port_out(port, 2, 16 - scr);
 			serial_port_out(port, UART_LCR, lcr);
 			return;
-		} else if (baud > actual_baud) {
-			break;
 		}
 	}
-	serial8250_do_set_divisor(port, baud, quot, quot_frac);
 }
 static int pci_pericom_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
-- 
2.33.0

