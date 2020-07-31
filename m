Return-Path: <SRS0=+g8y=BK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A0DC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 31 Jul 2020 12:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5312221D95
	for <linux-serial@archiver.kernel.org>; Fri, 31 Jul 2020 12:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbgGaMhh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:37:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:39756 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733020AbgGaMhg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 Jul 2020 08:37:36 -0400
IronPort-SDR: u9mgh/nOXS3EC76LsZJmYI6CN1HOj9bMCMhNDACQO4Hl/t5Y4Gp4uk0TSBPPn8iAoDXo0PiRjv
 d6MDTA0xEnuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="149232880"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="149232880"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 05:37:36 -0700
IronPort-SDR: MUsnFWbifaBxOJerS8My9QxHzfF3sfpzkdCKDi0986QxIV1BCOHhxLl+Uk22C6hTdZsuGuA4Yl
 JO2K2THoOlTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="313786295"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2020 05:37:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 55E1C166; Fri, 31 Jul 2020 15:37:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] serial: 8250: Explicitly show we initialise ISA ports only once
Date:   Fri, 31 Jul 2020 15:37:33 +0300
Message-Id: <20200731123733.22754-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731123733.22754-1-andriy.shevchenko@linux.intel.com>
References: <20200731123733.22754-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

serial8250_isa_init_ports() uses home grown approach to make itself
a singleton. Instead, explicitly show that we initialise ISA ports
once by providing a helper function which calls the original function
via DO_ONCE() macro.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index cae61d1ebec5..9c0d6693f745 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -22,6 +22,7 @@
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/delay.h>
+#include <linux/once.h>
 #include <linux/platform_device.h>
 #include <linux/tty.h>
 #include <linux/ratelimit.h>
@@ -495,13 +496,8 @@ static inline void serial8250_apply_quirks(struct uart_8250_port *up)
 static void __init serial8250_isa_init_ports(void)
 {
 	struct uart_8250_port *up;
-	static int first = 1;
 	int i, irqflag = 0;
 
-	if (!first)
-		return;
-	first = 0;
-
 	if (nr_uarts > UART_NR)
 		nr_uarts = UART_NR;
 
@@ -555,6 +551,11 @@ static void __init serial8250_isa_init_ports(void)
 	}
 }
 
+static void __init serial8250_isa_init_ports_once(void)
+{
+	DO_ONCE(serial8250_isa_init_ports);
+}
+
 static void __init
 serial8250_register_ports(struct uart_driver *drv, struct device *dev)
 {
@@ -686,7 +687,7 @@ static int __init univ8250_console_init(void)
 	if (nr_uarts == 0)
 		return -ENODEV;
 
-	serial8250_isa_init_ports();
+	serial8250_isa_init_ports_once();
 	register_console(&univ8250_console);
 	return 0;
 }
@@ -719,7 +720,7 @@ int __init early_serial_setup(struct uart_port *port)
 	if (port->line >= ARRAY_SIZE(serial8250_ports) || nr_uarts == 0)
 		return -ENODEV;
 
-	serial8250_isa_init_ports();
+	serial8250_isa_init_ports_once();
 	p = &serial8250_ports[port->line].port;
 	p->iobase       = port->iobase;
 	p->membase      = port->membase;
@@ -1170,7 +1171,7 @@ static int __init serial8250_init(void)
 	if (nr_uarts == 0)
 		return -ENODEV;
 
-	serial8250_isa_init_ports();
+	serial8250_isa_init_ports_once();
 
 	pr_info("Serial: 8250/16550 driver, %d ports, IRQ sharing %sabled\n",
 		nr_uarts, share_irqs ? "en" : "dis");
-- 
2.27.0

