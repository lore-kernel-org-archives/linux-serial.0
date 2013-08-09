From: John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 1/2] serial: MIPS: lantiq: add clk_enable() call to driver
Date: Fri,  9 Aug 2013 20:54:30 +0200
Message-ID: <1376074471-29404-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:33307 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030740Ab3HITBl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Aug 2013 15:01:41 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.org, Thomas Langer <thomas.langer@lantiq.com>

From: Thomas Langer <thomas.langer@lantiq.com>

Enable the clock if one is present when setting up the console.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Acked-by: John Crispin <blogic@openwrt.org>
---
Changes in V2:
* make use of IS_ERR()

 drivers/tty/serial/lantiq.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 15733da..93ac046 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -636,6 +636,9 @@ lqasc_console_setup(struct console *co, char *options)
 
 	port = &ltq_port->port;
 
+	if (!IS_ERR(ltq_port->clk))
+		clk_enable(ltq_port->clk);
+
 	port->uartclk = clk_get_rate(ltq_port->fpiclk);
 
 	if (options)
-- 
1.7.10.4

