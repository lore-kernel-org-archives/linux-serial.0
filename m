From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 33/34] __initdata cleanup - serial
Date: Fri, 9 Feb 2007 17:35:10 +0200
Message-ID: <200702091735.10675.alon.barlev@gmail.com>
References: <200702091711.34441.alon.barlev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:2436 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946580AbXBIPfU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Feb 2007 10:35:20 -0500
Received: by ug-out-1314.google.com with SMTP id 44so806249uga
        for <linux-serial@vger.kernel.org>; Fri, 09 Feb 2007 07:35:18 -0800 (PST)
In-Reply-To: <200702091711.34441.alon.barlev@gmail.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, akpm@osdl.org, bwalle@suse.de, rmk+lkml@arm.linux.org.uk, linux-serial@vger.kernel.org


Trivial.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
Signed-off-by: Bernhard Walle <bwalle@suse.de>

---

diff -urNp linux-2.6.20-rc6-mm3.org/drivers/serial/8250_early.c linux-2.6.20-rc6-mm3/drivers/serial/8250_early.c
--- linux-2.6.20-rc6-mm3.org/drivers/serial/8250_early.c	2007-01-25 04:19:28.000000000 +0200
+++ linux-2.6.20-rc6-mm3/drivers/serial/8250_early.c	2007-01-31 22:19:30.000000000 +0200
@@ -41,8 +41,8 @@ struct early_uart_device {
 	unsigned int baud;
 };
 
-static struct early_uart_device early_device __initdata;
-static int early_uart_registered __initdata;
+static struct early_uart_device early_device __initdata = {{{{0}}}};
+static int early_uart_registered __initdata = 0;
 
 static unsigned int __init serial_in(struct uart_port *port, int offset)
 {
