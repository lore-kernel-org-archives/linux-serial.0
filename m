From: Michal Simek <monstr@monstr.eu>
Subject: [PATCH 2/2] serial: 8250pci: Recast inb return value
Date: Tue, 17 Aug 2010 09:59:07 +0200
Message-ID: <1282031947-16483-2-git-send-email-monstr@monstr.eu>
References: <1282031947-16483-1-git-send-email-monstr@monstr.eu>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36166 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab0HQH7Q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Aug 2010 03:59:16 -0400
In-Reply-To: <1282031947-16483-1-git-send-email-monstr@monstr.eu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: michal.simek@petalogix.com
Cc: Michal Simek <monstr@monstr.eu>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Lennert Buytenhek <buytenh@wantstofly.org>, Lytochkin Boris <lytboris@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

inb returns u8 that's why is necessary to do recast.

Compilation warning:
  CC      drivers/serial/8250_pci.o
drivers/serial/8250_pci.c: In function 'pci_ite887x_init':
drivers/serial/8250_pci.c:825: warning: cast to pointer from integer of different size

Signed-off-by: Michal Simek <monstr@monstr.eu>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Greg Kroah-Hartman <gregkh@suse.de>
CC: Alan Cox <alan@linux.intel.com>
CC: Lennert Buytenhek <buytenh@wantstofly.org>
CC: Lytochkin Boris <lytboris@gmail.com>
CC: linux-serial@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/serial/8250_pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 53be4d3..cc11faa 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -822,7 +822,7 @@ static int pci_ite887x_init(struct pci_dev *dev)
 			/* write INTCBAR - ioport */
 			pci_write_config_dword(dev, ITE_887x_INTCBAR,
 								inta_addr[i]);
-			ret = inb(inta_addr[i]);
+			ret = (int) inb(inta_addr[i]);
 			if (ret != 0xff) {
 				/* ioport connected */
 				break;
-- 
1.5.5.6

