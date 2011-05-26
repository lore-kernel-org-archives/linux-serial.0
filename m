From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] tty/serial: (8250) Fix initialization warning
Date: Thu, 26 May 2011 00:01:13 -0700
Message-ID: <1306393273-6081-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.195]:53132 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab1EZHIC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 May 2011 03:08:02 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

This commit fixes the following build warning by updating the offending
function parameter of pci_omegapci_setup().

drivers/tty/serial/8250_pci.c:1457: warning: initialization from incompatible pointer type

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
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
1.7.1

