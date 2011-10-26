From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 65/79] parport_pc: release IO region properly if unsupported ITE887x card is found
Date: Wed, 26 Oct 2011 14:13:10 +0200
Message-ID: <1319631204-23262-65-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32852 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932919Ab1JZMN6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:58 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Alan Cox <alan@linux.intel.com>, Joe Krahn <krahn@niehs.nih.gov>, Andrew Morton <akpm@google.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Kosina <jkosina@suse.cz>

sio_ite_8872_probe() bails out if it detects no-parallel (1S, 2S) or
unknown card.

It doesn't call release_region() on the previously allocated resource
though.  This causes

  (a) leak of the resource
  (b) kernel oops when parport module is removed and /proc/ioports is read. This
      is because the string that has been associated to the IO port region
      is a static char array inside the already removed module.

Let's call release_region() properly before baling out.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Acked-by: Niels de Vos <ndevos@redhat.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Joe Krahn <krahn@niehs.nih.gov>
Signed-off-by: Andrew Morton <akpm@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/parport/parport_pc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index d1cdb94..d0b597b 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2595,14 +2595,17 @@ static int __devinit sio_ite_8872_probe(struct pci_dev *pdev, int autoirq,
 		break;
 	case 0x6:
 		printk(KERN_INFO "parport_pc: ITE8873 found (1S)\n");
+		release_region(inta_addr[i], 32);
 		return 0;
 	case 0x8:
 		printk(KERN_INFO "parport_pc: ITE8874 found (2S)\n");
+		release_region(inta_addr[i], 32);
 		return 0;
 	default:
 		printk(KERN_INFO "parport_pc: unknown ITE887x\n");
 		printk(KERN_INFO "parport_pc: please mail 'lspci -nvv' "
 			"output to Rich.Liu@ite.com.tw\n");
+		release_region(inta_addr[i], 32);
 		return 0;
 	}
 
-- 
1.7.7

