From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] serial: MIPS: lantiq: use devm_iounmap instead of iounmap
Date: Thu,  6 Nov 2014 19:00:42 +0530
Message-ID: <1415280642-3761-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:44439 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbaKFNav (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 08:30:51 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

port->membase was allocated using devm_ioremap_nocache, so ideally
we should unmap it using devm_iounmap. but it was using iounmap.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

hi,
just a small problem here.I could not build test this as I do not have a
MIPS crosscompiler.I know i should not send without a minimum build test,
but this change should not break the build (or maybe i am wrong)..

 drivers/tty/serial/lantiq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 4675fe1..18c3844 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -497,8 +497,10 @@ lqasc_type(struct uart_port *port)
 static void
 lqasc_release_port(struct uart_port *port)
 {
+	struct platform_device *pdev = to_platform_device(port->dev);
+
 	if (port->flags & UPF_IOREMAP) {
-		iounmap(port->membase);
+		devm_iounmap(&pdev->dev, port->membase);
 		port->membase = NULL;
 	}
 }
-- 
1.8.1.2

