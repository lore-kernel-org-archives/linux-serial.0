From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] serial: omap: fix DeviceTree boot
Date: Fri,  7 Sep 2012 21:10:33 +0300
Message-ID: <1347041433-11723-1-git-send-email-balbi@ti.com>
References: <20120907175721.GD1303@atomide.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:60812 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753388Ab2IGSPB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Sep 2012 14:15:01 -0400
Received: by lagy9 with SMTP id y9so2021736lag.19
        for <linux-serial@vger.kernel.org>; Fri, 07 Sep 2012 11:14:58 -0700 (PDT)
In-Reply-To: <20120907175721.GD1303@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

OMAP Architecture code, passes a few function
pointers for UART driver to use in order to
properly implement Power Management and Wakeup
capabilities.

The problem is that those function pointers,
which are passed (ab)using platform_data on
non-DT kernels, can't be passed down to drivers
through DT.

commit e5b57c0 (serial: omap: define helpers
for pdata function pointers) failed to take DT
kernels into consideration and caused a regression
to DT kernel boot.

Fix that by (re-)adding a check for valid pdata
pointer together with valid pdata->$FUNCTION
pointer.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Tony, does this solve the issue ?

 drivers/tty/serial/omap-serial.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 0a6e78e..743e8e1 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -143,7 +143,7 @@ static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
 {
 	struct omap_uart_port_info *pdata = up->dev->platform_data;
 
-	if (!pdata->get_context_loss_count)
+	if (!pdata || !pdata->get_context_loss_count)
 		return 0;
 
 	return pdata->get_context_loss_count(up->dev);
@@ -153,24 +153,30 @@ static void serial_omap_set_forceidle(struct uart_omap_port *up)
 {
 	struct omap_uart_port_info *pdata = up->dev->platform_data;
 
-	if (pdata->set_forceidle)
-		pdata->set_forceidle(up->dev);
+	if (!pdata || !pdata->set_forceidle)
+		return;
+
+	pdata->set_forceidle(up->dev);
 }
 
 static void serial_omap_set_noidle(struct uart_omap_port *up)
 {
 	struct omap_uart_port_info *pdata = up->dev->platform_data;
 
-	if (pdata->set_noidle)
-		pdata->set_noidle(up->dev);
+	if (!pdata || !pdata->set_noidle)
+		return;
+
+	pdata->set_noidle(up->dev);
 }
 
 static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
 {
 	struct omap_uart_port_info *pdata = up->dev->platform_data;
 
-	if (pdata->enable_wakeup)
-		pdata->enable_wakeup(up->dev, enable);
+	if (!pdata || !pdata->enable_wakeup)
+		return;
+
+	pdata->enable_wakeup(up->dev, enable);
 }
 
 /*
-- 
1.7.12.rc3

