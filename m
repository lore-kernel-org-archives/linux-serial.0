From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 08/12] serial/8250_pci: delete duplicate data definition
Date: Fri, 26 Aug 2011 13:58:17 -0700
Message-ID: <1314392301-25140-8-git-send-email-gregkh@suse.de>
References: <20110826191143.GC5557@kroah.com>
 <1314392301-25140-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37788 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754149Ab1HZU7B (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 16:59:01 -0400
In-Reply-To: <1314392301-25140-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>

Data definiton "VendorID=10DB, device_id=800D" is already defined.
This patch deletes the duplicate definition.

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/8250_pci.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pci.c
index f652a7b..3abeca2 100644
--- a/drivers/tty/serial/8250_pci.c
+++ b/drivers/tty/serial/8250_pci.c
@@ -1599,11 +1599,6 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device         = 0x800D,
 		.init		= pci_eg20t_init,
 	},
-	{
-		.vendor         = 0x10DB,
-		.device         = 0x800D,
-		.init		= pci_eg20t_init,
-	},
 	/*
 	 * Cronyx Omega PCI (PLX-chip based)
 	 */
-- 
1.7.6.1

