Return-Path: <SRS0=zFmD=YE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40324ECE58C
	for <linux-serial@archiver.kernel.org>; Fri, 11 Oct 2019 11:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCAA206CD
	for <linux-serial@archiver.kernel.org>; Fri, 11 Oct 2019 11:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfJKL4O (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:56:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:24480 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfJKL4O (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Oct 2019 07:56:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 04:56:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; 
   d="scan'208";a="197559763"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2019 04:56:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 25A4648B; Fri, 11 Oct 2019 14:56:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Robert Middleton <robert.middleton@rm5248.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH v1] serial: 8250_exar: Move Exar pieces to custom ->startup()
Date:   Fri, 11 Oct 2019 14:56:10 +0300
Message-Id: <20191011115610.81507-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is a one more step to consolidate Exar bits under 8250_exar umbrella.
This time we introduce a custom ->startup() callback where the Exar specific
settings are applied.

Cc: Robert Middleton <robert.middleton@rm5248.com>
Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Aaron Sierra <asierra@xes-inc.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 19 +++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c | 14 --------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 597eb9d16f21..108cd55f9c4d 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -166,6 +166,23 @@ static void xr17v35x_set_divisor(struct uart_port *p, unsigned int baud,
 	serial_port_out(p, 0x2, quot_frac);
 }
 
+static int xr17v35x_startup(struct uart_port *port)
+{
+	/*
+	 * First enable access to IER [7:5], ISR [5:4], FCR [5:4],
+	 * MCR [7:5] and MSR [7:0]
+	 */
+	serial_port_out(port, UART_XR_EFR, UART_EFR_ECB);
+
+	/*
+	 * Make sure all interrups are masked until initialization is
+	 * complete and the FIFOs are cleared
+	 */
+	serial_port_out(port, UART_IER, 0);
+
+	return serial8250_do_startup(port);
+}
+
 static void exar_shutdown(struct uart_port *port)
 {
 	unsigned char lsr;
@@ -212,6 +229,8 @@ static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 
 		port->port.get_divisor = xr17v35x_get_divisor;
 		port->port.set_divisor = xr17v35x_set_divisor;
+
+		port->port.startup = xr17v35x_startup;
 	} else {
 		port->port.type = PORT_XR17D15X;
 	}
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8407166610ce..90655910b0c7 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2114,20 +2114,6 @@ int serial8250_do_startup(struct uart_port *port)
 	enable_rsa(up);
 #endif
 
-	if (port->type == PORT_XR17V35X) {
-		/*
-		 * First enable access to IER [7:5], ISR [5:4], FCR [5:4],
-		 * MCR [7:5] and MSR [7:0]
-		 */
-		serial_port_out(port, UART_XR_EFR, UART_EFR_ECB);
-
-		/*
-		 * Make sure all interrups are masked until initialization is
-		 * complete and the FIFOs are cleared
-		 */
-		serial_port_out(port, UART_IER, 0);
-	}
-
 	/*
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
-- 
2.23.0

