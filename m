From: David Vrabel <dvrabel@arcom.com>
Subject: Request resources if not autoconfiguring new ports
Date: Fri, 24 Sep 2004 09:23:56 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <4153D99C.1000503@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from webapps.arcom.com ([194.200.159.168]:10758 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S268582AbUIXIX5
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 Sep 2004 04:23:57 -0400
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

Serial core doesn't request resources when adding new ports if the port 
isn't to be autoconfigured (UPF_BOOT_AUTOCONF is not set).  This also 
means the UPF_IOREMAP flag doesn't work.

--- linux-2.6-armbe.orig/drivers/serial/serial_core.c	2004-09-23 
15:04:08.000000000 +0100
+++ linux-2.6-armbe/drivers/serial/serial_core.c	2004-09-23 
17:43:57.000000000 +0100
@@ -2007,7 +2007,8 @@
  	if (port->flags & UPF_BOOT_AUTOCONF) {
  		port->type = PORT_UNKNOWN;
  		port->ops->config_port(port, flags);
-	}
+	} else
+                port->ops->request_port(port);

  	if (port->type != PORT_UNKNOWN) {
  		unsigned long flags;

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
