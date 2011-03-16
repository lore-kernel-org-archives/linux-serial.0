From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 31/76] tty: serial: altera_uart: Handle pdev->id == -1 in altera_uart_remove
Date: Wed, 16 Mar 2011 14:12:01 -0700
Message-ID: <1300309966-5745-31-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33047 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753635Ab1CPVN5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:13:57 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tobias Klauser <tklauser@distanz.ch>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tobias Klauser <tklauser@distanz.ch>

Commit 6b5756f176568a710d008d3b478128fafb6707f0 introduced the
possibility for pdev->id being -1 but the change was not done equally in
altera_uart_remove. This patch fixes this.

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/altera_uart.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 7212162..dee7a0e 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -561,9 +561,15 @@ static int __devinit altera_uart_probe(struct platform_device *pdev)
 
 static int __devexit altera_uart_remove(struct platform_device *pdev)
 {
-	struct uart_port *port = &altera_uart_ports[pdev->id].port;
+	struct uart_port *port;
+	int i = pdev->id;
 
+	if (i == -1)
+		i = 0;
+
+	port = &altera_uart_ports[i].port;
 	uart_remove_one_port(&altera_uart_driver, port);
+
 	return 0;
 }
 
-- 
1.7.4.1

