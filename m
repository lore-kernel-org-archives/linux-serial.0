From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATH] serial-uartlite: Support multiple devices
Date: Wed, 15 Nov 2006 21:14:46 +0100
Message-ID: <87lkmcbh6x.fsf@slug.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outmx001.isp.belgacom.be ([195.238.5.51]:31893 "EHLO
	outmx001.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030576AbWKOUPE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Nov 2006 15:15:04 -0500
Received: from outmx001.isp.belgacom.be (localhost [127.0.0.1])
        by outmx001.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id kAFKF0j3017093
        for <linux-serial@vger.kernel.org>; Wed, 15 Nov 2006 21:15:00 +0100
        (envelope-from <jacmet@sunsite.dk>)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@osdl.org
Cc: linux-serial@vger.kernel.org, olof@lixom.net

Hi Andrew,

Set port->line in probe() so multiple devices can be used.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
Acked-by: Olof Johansson <olof@lixom.net>

--- linux-mm.orig/drivers/serial/uartlite.c
+++ linux-mm/drivers/serial/uartlite.c
@@ -437,6 +437,7 @@
 	port->flags	= UPF_BOOT_AUTOCONF;
 	port->dev	= &pdev->dev;
 	port->type	= PORT_UNKNOWN;
+	port->line	= pdev->id;
 
 	uart_add_one_port(&ulite_uart_driver, port);
 	platform_set_drvdata(pdev, port);

-- 
Bye, Peter Korsgaard
