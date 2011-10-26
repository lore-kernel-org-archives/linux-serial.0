From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 54/79] serial: mfd: Initconst section fixes
Date: Wed, 26 Oct 2011 14:12:59 +0200
Message-ID: <1319631204-23262-54-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32819 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932919Ab1JZMNx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:53 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>, gregkh@suse.de

From: Andi Kleen <ak@linux.intel.com>

Cc: gregkh@suse.de
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/mfd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index cfa7501..286c386 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -1467,7 +1467,7 @@ static void serial_hsu_remove(struct pci_dev *pdev)
 }
 
 /* First 3 are UART ports, and the 4th is the DMA */
-static const struct pci_device_id pci_ids[] __devinitdata = {
+static const struct pci_device_id pci_ids[] __devinitconst = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x081B) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x081C) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x081D) },
-- 
1.7.7

