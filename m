From: Niels de Vos <ndevos@redhat.com>
Subject: [RESEND, PATCH v2] parport_pc.c: correctly release the requested
 region for the IT887x
Date: Mon, 18 Apr 2011 15:26:03 +0100
Message-ID: <4DAC49FB.5060004@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36178 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754577Ab1DRO0a (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Apr 2011 10:26:30 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Julia Lawall <julia@diku.dk>, trivial@kernel.org

Replace release_resource() by release_region() and also fix the
inconsistency in the size of the requested/released region.

The size of the resource should be 32, not 0x8 like it was corrected in
commit e7c310c36e5fdf1b83a459e5db167bfbd86137db already.

CC: linux-serial@vger.kernel.org
Reported-by: Julia Lawall <julia@diku.dk>
Signed-off-by: Niels de Vos <ndevos@redhat.com>

---
This is a followup/improvement on https://lkml.org/lkml/2011/4/11/37
that was posted by Julia earlier. I've updated the subject to reflect
the corrections made.

There is currently no maintainer for the drivers/parport/ tree. As the
IT887x also (can) provide a serial port, I'm adding linux-serial@ to the
list of CCs.

 drivers/parport/parport_pc.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 8d62fb7..be8b5ac 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2550,7 +2550,6 @@ static int __devinit sio_ite_8872_probe(struct pci_dev *pdev, int autoirq,
 					 const struct parport_pc_via_data *via)
 {
 	short inta_addr[6] = { 0x2A0, 0x2C0, 0x220, 0x240, 0x1E0 };
-	struct resource *base_res;
 	u32 ite8872set;
 	u32 ite8872_lpt, ite8872_lpthi;
 	u8 ite8872_irq, type;
@@ -2561,8 +2560,7 @@ static int __devinit sio_ite_8872_probe(struct pci_dev *pdev, int autoirq,
 
 	/* make sure which one chip */
 	for (i = 0; i < 5; i++) {
-		base_res = request_region(inta_addr[i], 32, "it887x");
-		if (base_res) {
+		if (request_region(inta_addr[i], 32, "it887x")) {
 			int test;
 			pci_write_config_dword(pdev, 0x60,
 						0xe5000000 | inta_addr[i]);
@@ -2571,7 +2569,7 @@ static int __devinit sio_ite_8872_probe(struct pci_dev *pdev, int autoirq,
 			test = inb(inta_addr[i]);
 			if (test != 0xff)
 				break;
-			release_region(inta_addr[i], 0x8);
+			release_region(inta_addr[i], 32);
 		}
 	}
 	if (i >= 5) {
@@ -2635,7 +2633,7 @@ static int __devinit sio_ite_8872_probe(struct pci_dev *pdev, int autoirq,
 	/*
 	 * Release the resource so that parport_pc_probe_port can get it.
 	 */
-	release_resource(base_res);
+	release_region(inta_addr[i], 32);
 	if (parport_pc_probe_port(ite8872_lpt, ite8872_lpthi,
 				   irq, PARPORT_DMA_NONE, &pdev->dev, 0)) {
 		printk(KERN_INFO
-- 
1.7.4



