From: John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/2] serial: MIPS: lantiq: add clk_enable() call to driver
Date: Thu,  8 Aug 2013 15:31:26 +0200
Message-ID: <1375968687-8704-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:42761 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757833Ab3HHNif (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 09:38:35 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.org, Thomas Langer <thomas.langer@lantiq.com>

From: Thomas Langer <thomas.langer@lantiq.com>

Enable the clock if one is present when setting up the console.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Acked-by: John Crispin <blogic@openwrt.org>
---
 drivers/tty/serial/lantiq.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 15733da..ce1ea35 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -636,6 +636,9 @@ lqasc_console_setup(struct console *co, char *options)
 
 	port = &ltq_port->port;
 
+	if (ltq_port->clk)
+		clk_enable(ltq_port->clk);
+
 	port->uartclk = clk_get_rate(ltq_port->fpiclk);
 
 	if (options)
-- 
1.7.10.4

