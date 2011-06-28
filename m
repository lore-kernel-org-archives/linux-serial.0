From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 02/12] serial: ioremap warning fix for jsm driver.
Date: Tue, 28 Jun 2011 09:03:39 -0700
Message-ID: <1309277029-1532-2-git-send-email-gregkh@suse.de>
References: <20110628153856.GB32710@kroah.com>
 <1309277029-1532-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:40722 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758925Ab1F1QDy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Jun 2011 12:03:54 -0400
In-Reply-To: <1309277029-1532-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Greg Kroah-Hartman <gregkh@suse.de>

From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>

I saw a warning about ioremap from the jsm driver on a system which
looked like this:

resource map sanity check conflict: 0xe0200800 0xe02017ff 0xe0200800 0xe0200fff 0000:01:08.0

Turns out the warning is valid.  The jsm driver has been asking to ioremap
0x1000 forever, but in fact only 8 port chips have 0x1000 bytes of memory.
4 port chips have 0x800 and 2 port chips have 0x400 according to the
data sheet.  It makes more sense to map the size of the region rather
than a hard coded value.  If you happen to have the region legitimately
mapped to a base address that is not 4K aligned, ioremap complains
otherwise.

Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/jsm/jsm_driver.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_driver.c b/drivers/tty/serial/jsm/jsm_driver.c
index 18f5484..96da178 100644
--- a/drivers/tty/serial/jsm/jsm_driver.c
+++ b/drivers/tty/serial/jsm/jsm_driver.c
@@ -125,7 +125,7 @@ static int __devinit jsm_probe_one(struct pci_dev *pdev, const struct pci_device
 	brd->bd_uart_offset = 0x200;
 	brd->bd_dividend = 921600;
 
-	brd->re_map_membase = ioremap(brd->membase, 0x1000);
+	brd->re_map_membase = ioremap(brd->membase, pci_resource_len(pdev, 0));
 	if (!brd->re_map_membase) {
 		dev_err(&pdev->dev,
 			"card has no PCI Memory resources, "
-- 
1.7.5.4

