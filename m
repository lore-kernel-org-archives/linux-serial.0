From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] serial: altera: Make of_device_id arrays const
Date: Tue,  5 Aug 2014 09:14:35 +0200
Message-ID: <1407222875-29381-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:58647 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756006AbaHEHOk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Aug 2014 03:14:40 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, nios2-dev@lists.rocketboards.org

Make the of_device_id arrays const, as it is handled as const by all OF
functions.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/altera_jtaguart.c | 2 +-
 drivers/tty/serial/altera_uart.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index d22e3d9..932e019 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -462,7 +462,7 @@ static int altera_jtaguart_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_OF
-static struct of_device_id altera_jtaguart_match[] = {
+static const struct of_device_id altera_jtaguart_match[] = {
 	{ .compatible = "ALTR,juart-1.0", },
 	{ .compatible = "altr,juart-1.0", },
 	{},
diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 6a24323..1cb2cdb 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -610,7 +610,7 @@ static int altera_uart_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_OF
-static struct of_device_id altera_uart_match[] = {
+static const struct of_device_id altera_uart_match[] = {
 	{ .compatible = "ALTR,uart-1.0", },
 	{ .compatible = "altr,uart-1.0", },
 	{},
-- 
2.0.1


