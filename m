From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 06/12] serial: clps711x: Return valid modem controls for port that not support it
Date: Sun, 14 Oct 2012 11:05:28 +0400
Message-ID: <1350198334-18737-6-git-send-email-shc_work@mail.ru>
References: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp17.mail.ru ([94.100.176.154]:44951 "EHLO smtp17.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab2JNHGM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 03:06:12 -0400
In-Reply-To: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index d374609..7b0e539 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -191,12 +191,9 @@ static unsigned int clps711xuart_tx_empty(struct uart_port *port)
 
 static unsigned int clps711xuart_get_mctrl(struct uart_port *port)
 {
-	unsigned int port_addr;
-	unsigned int result = 0;
-	unsigned int status;
+	unsigned int status, result = 0;
 
-	port_addr = SYSFLG(port);
-	if (port_addr == SYSFLG1) {
+	if (port->line == 0) {
 		status = clps_readl(SYSFLG1);
 		if (status & SYSFLG1_DCD)
 			result |= TIOCM_CAR;
@@ -204,7 +201,8 @@ static unsigned int clps711xuart_get_mctrl(struct uart_port *port)
 			result |= TIOCM_DSR;
 		if (status & SYSFLG1_CTS)
 			result |= TIOCM_CTS;
-	}
+	} else
+		result = TIOCM_DSR | TIOCM_CTS | TIOCM_CAR;
 
 	return result;
 }
-- 
1.7.8.6

