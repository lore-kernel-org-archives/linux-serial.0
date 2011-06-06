From: Vasily Averin <vvs@parallels.com>
Subject: [PATCH] serial: 8250_pci: corrected definition pci_omegapci_setup()
Date: Mon, 06 Jun 2011 11:49:06 +0400
Message-ID: <4DEC8672.6090900@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.232.25]:23293 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014Ab1FFHtU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Jun 2011 03:49:20 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Antony Pavlov <antony@niisi.msk.ru>

fixed compilation warning
drivers/tty/serial/8250_pci.c:1457:3: warning:
 initialization from incompatible pointer type

Signed-off-by: Vasily Averin <vvs@sw.ru>
---
 drivers/tty/serial/8250_pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pci.c
index 4b4968a..78e98a5 100644
--- a/drivers/tty/serial/8250_pci.c
+++ b/drivers/tty/serial/8250_pci.c
@@ -973,7 +973,7 @@ ce4100_serial_setup(struct serial_private *priv,

 static int
 pci_omegapci_setup(struct serial_private *priv,
-		      struct pciserial_board *board,
+		      const struct pciserial_board *board,
 		      struct uart_port *port, int idx)
 {
 	return setup_port(priv, port, 2, idx * 8, 0);
-- 
1.7.4.1

