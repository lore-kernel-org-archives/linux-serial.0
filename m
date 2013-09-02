From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] serial: imx: Use NULL as the last argument of add_preferred_console()
Date: Sun,  1 Sep 2013 22:24:35 -0300
Message-ID: <1378085075-25227-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ye0-f176.google.com ([209.85.213.176]:64188 "EHLO
	mail-ye0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117Ab3IBBYu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 1 Sep 2013 21:24:50 -0400
Received: by mail-ye0-f176.google.com with SMTP id m13so977286yen.35
        for <linux-serial@vger.kernel.org>; Sun, 01 Sep 2013 18:24:50 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: s.hauer@pengutronix.de, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Commit f7d2c0bbd (serial: i.MX: evaluate linux,stdout-path property) introduced
the following sparse warning:

drivers/tty/serial/imx.c:1916:77: warning: Using plain integer as NULL pointer

Pass NULL as the last argument of add_preferred_console() instead of zero.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 2c13155..9a66dc5 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1913,7 +1913,8 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 	sport->devdata = of_id->data;
 
 	if (of_device_is_stdout_path(np))
-		add_preferred_console(imx_reg.cons->name, sport->port.line, 0);
+		add_preferred_console(imx_reg.cons->name, sport->port.line,
+				      NULL);
 
 	return 0;
 }
-- 
1.8.1.2

