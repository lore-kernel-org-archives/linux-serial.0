From: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] In absence of braces, port and NULL are missed
Date: Mon, 14 Oct 2013 23:21:15 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1310142027370.11060@Z>
References: <1381703376-31380-1-git-send-email-roel.kluin@gmail.com> <20131014125449.GB31708@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:34683 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab3JNVVU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Oct 2013 17:21:20 -0400
In-Reply-To: <20131014125449.GB31708@e106331-lin.cambridge.arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Roel Kluin <roel.kluin@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Prisk <linux@prisktech.co.nz>, linux-serial@vger.kernel.org

Hi Mark,

On Mon, 14 Oct 2013, Mark Rutland wrote:

> While this looks like a good fix, the commit message is a bit confusing.

I like your suggestion, however I feel the commit message fails to 
appreciate the error path this patch addresses as well, so I adapted your 
suggested commit message to the following:

---
[PATCH] serial: vt8500: add missing braces

    Due to missing braces on an if statement, in presence of a device_node
    a port was always assigned -1, regardless of any alias entries in the 
    device tree. Conversely, if device_node was NULL, an unitialized port
    ended up being used.

    This patch adds the missing braces, fixing the issues.

    Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
    Acked-by: Tony Prisk <linux@prisktech.co.nz>

diff --git a/drivers/tty/serial/vt8500_serial.c 
b/drivers/tty/serial/vt8500_serial.c
index 93b697a..4cf71c0 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -561,12 +561,13 @@ static int vt8500_serial_probe(struct 
platform_device *pdev)
 	if (!mmres || !irqres)
 		return -ENODEV;
 
-	if (np)
+	if (np) {
 		port = of_alias_get_id(np, "serial");
 		if (port >= VT8500_MAX_PORTS)
 			port = -1;
-	else
+        } else {
 		port = -1;
+        }
 
 	if (port < 0) {
 		/* calculate the port id */

