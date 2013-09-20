From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] serial: imx: Fix build warning when CONFIG_LPAE=y
Date: Fri, 20 Sep 2013 20:47:45 -0300
Message-ID: <1379720865-6951-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:39013 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab3ITXsT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 20 Sep 2013 19:48:19 -0400
Received: by mail-yh0-f46.google.com with SMTP id c41so477060yho.5
        for <linux-serial@vger.kernel.org>; Fri, 20 Sep 2013 16:48:19 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: khilman@linaro.org, olof@lixom.net, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Building multi_v7_defconfig with CONFIG_LPAE=y leads to the following build 
warning:

drivers/tty/serial/imx.c: In function 'imx_verify_port':
drivers/tty/serial/imx.c:1542:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]

Fix the casting to get rid of the warning.

Reported-by: Kevin Hilman <khilman@linaro.org>
Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a0ebbc9..dd5e583 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1539,7 +1539,7 @@ imx_verify_port(struct uart_port *port, struct serial_struct *ser)
 		ret = -EINVAL;
 	if (sport->port.uartclk / 16 != ser->baud_base)
 		ret = -EINVAL;
-	if ((void *)sport->port.mapbase != ser->iomem_base)
+	if (sport->port.mapbase != (unsigned long)ser->iomem_base)
 		ret = -EINVAL;
 	if (sport->port.iobase != ser->port)
 		ret = -EINVAL;
-- 
1.8.1.2

