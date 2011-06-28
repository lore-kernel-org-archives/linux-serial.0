From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 04/12] 8250_pci: Fix missing const from merges
Date: Tue, 28 Jun 2011 09:03:41 -0700
Message-ID: <1309277029-1532-4-git-send-email-gregkh@suse.de>
References: <20110628153856.GB32710@kroah.com>
 <1309277029-1532-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:33703 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759208Ab1F1QD5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Jun 2011 12:03:57 -0400
In-Reply-To: <1309277029-1532-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.jf.intel.com>, Alan Cox <alan@linux.intel.com>, Antony Pavlov <antony@niisi.msk.ru>, Borislav Petkov <bp@alien8.de>, Vasily Averin <vvs@sw.ru>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@suse.de>

From: Alan Cox <alan@linux.jf.intel.com>

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Antony Pavlov <antony@niisi.msk.ru>
Signed-off-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Vasily Averin <vvs@sw.ru>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/8250_pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pci.c
index d7dc513..f41b425 100644
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
1.7.5.4

