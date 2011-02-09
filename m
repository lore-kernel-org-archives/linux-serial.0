From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 1/4] tty: serial: altera_uart: Handle pdev->id == -1 in altera_uart_remove
Date: Wed,  9 Feb 2011 10:56:52 +0100
Message-ID: <9212990ebdb34f2b80d6858a9ba2a88b4d53a207.1297245277.git.tklauser@distanz.ch>
References: <cover.1297245277.git.tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:64677 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753568Ab1BIJ4x (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Feb 2011 04:56:53 -0500
In-Reply-To: <cover.1297245277.git.tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: nios2-dev@sopc.et.ntust.edu.tw, linux-kernel@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>

Commit 6b5756f176568a710d008d3b478128fafb6707f0 introduced the
possibility for pdev->id being -1 but the change was not done equally in
altera_uart_remove. This patch fixes this.

Cc: Anton Vorontsov <cbouatmailru@gmail.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
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
1.7.0.4

