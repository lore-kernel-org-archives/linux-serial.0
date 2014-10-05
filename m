From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 07/13 linux-next] tty: use container_of to resolve uart_pmac_port from uart_port
Date: Sun,  5 Oct 2014 19:01:08 +0200
Message-ID: <1412528475-1449-8-git-send-email-fabf@skynet.be>
References: <1412528475-1449-1-git-send-email-fabf@skynet.be>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:49635 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751625AbaJERLN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 5 Oct 2014 13:11:13 -0400
In-Reply-To: <1412528475-1449-1-git-send-email-fabf@skynet.be>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

Use container_of instead of casting first structure member.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/tty/serial/pmac_zilog.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index abbfedb..4aca322 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1352,7 +1352,8 @@ static int pmz_verify_port(struct uart_port *port, struct serial_struct *ser)
 
 static int pmz_poll_get_char(struct uart_port *port)
 {
-	struct uart_pmac_port *uap = (struct uart_pmac_port *)port;
+	struct uart_pmac_port *uap =
+		container_of(port, struct uart_pmac_port, port);
 	int tries = 2;
 
 	while (tries) {
@@ -1367,7 +1368,8 @@ static int pmz_poll_get_char(struct uart_port *port)
 
 static void pmz_poll_put_char(struct uart_port *port, unsigned char c)
 {
-	struct uart_pmac_port *uap = (struct uart_pmac_port *)port;
+	struct uart_pmac_port *uap =
+		container_of(port, struct uart_pmac_port, port);
 
 	/* Wait for the transmit buffer to empty. */
 	while ((read_zsreg(uap, R0) & Tx_BUF_EMP) == 0)
@@ -1954,7 +1956,8 @@ static void __exit exit_pmz(void)
 
 static void pmz_console_putchar(struct uart_port *port, int ch)
 {
-	struct uart_pmac_port *uap = (struct uart_pmac_port *)port;
+	struct uart_pmac_port *uap =
+		container_of(port, struct uart_pmac_port, port);
 
 	/* Wait for the transmit buffer to empty. */
 	while ((read_zsreg(uap, R0) & Tx_BUF_EMP) == 0)
-- 
1.9.1

