From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] serial_core: fix printk format warnings
Date: Sun, 21 Sep 2008 05:11:31 +0400
Message-ID: <20080921011131.GA16153@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:3686 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbYIUBLn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 20 Sep 2008 21:11:43 -0400
Received: by mu-out-0910.google.com with SMTP id g7so846775muf.1
        for <linux-serial@vger.kernel.org>; Sat, 20 Sep 2008 18:11:41 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk

drivers/serial/serial_core.c:2158: warning: format '%x' expects type
'unsigned int', but argument 4 has type 'long unsigned int'
drivers/serial/serial_core.c:2162: warning: format '%x' expects type
'unsigned int', but argument 4 has type 'long unsigned int

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 drivers/serial/serial_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index effd0bd..d531ae9 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2155,11 +2155,11 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
 	switch (port->iotype) {
 	case UPIO_PORT:
 		snprintf(address, sizeof(address),
-			 "I/O 0x%x", port->iobase);
+			 "I/O 0x%lx", port->iobase);
 		break;
 	case UPIO_HUB6:
 		snprintf(address, sizeof(address),
-			 "I/O 0x%x offset 0x%x", port->iobase, port->hub6);
+			 "I/O 0x%lx offset 0x%x", port->iobase, port->hub6);
 		break;
 	case UPIO_MEM:
 	case UPIO_MEM32:
