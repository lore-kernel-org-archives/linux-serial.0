From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] serial: imx: Change cast to handle 64-bit resource_size_t
Date: Wed, 11 Sep 2013 21:27:53 -0700
Message-ID: <1378960073-15307-1-git-send-email-olof@lixom.net>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51733 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab3ILE2h (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Sep 2013 00:28:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so10099203pbb.33
        for <linux-serial@vger.kernel.org>; Wed, 11 Sep 2013 21:28:36 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Olof Johansson <olof@lixom.net>

This resolves a warning where resource_size_t is larger than void *:

  drivers/tty/serial/imx.c:1542:6: warning: cast to pointer from integer
  	of different size [-Wint-to-pointer-cast]

Since iomem_base is a void *, casting to unsigned long is safe.

It's unclear to me that this comparison is truly needed, but it's there
on several other drivers as well.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/tty/serial/imx.c |    2 +-
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
1.7.10.4

