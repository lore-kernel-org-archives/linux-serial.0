From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 9/9] tty: synclink_gt: constify pci_device_id.
Date: Sun, 23 Jul 2017 15:31:09 +0530
Message-ID: <1500804069-11043-10-git-send-email-arvind.yadav.cs@gmail.com>
References: <1500804069-11043-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500804069-11043-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jirislaby@gmail.com, jslaby@suse.com, gpiccoli@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

pci_device_id are not supposed to change at runtime. All functions
working with pci_device_id provided by <linux/pci.h> work with
const pci_device_id. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
  41180	    480	    185	  41845	   a375	drivers/tty/synclink_gt.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  41340	    320	    185	  41845	   a375	drivers/tty/synclink_gt.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/tty/synclink_gt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 529c6e3..636b8ae 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -95,7 +95,7 @@ MODULE_LICENSE("GPL");
 #define MGSL_MAGIC 0x5401
 #define MAX_DEVICES 32
 
-static struct pci_device_id pci_table[] = {
+static const struct pci_device_id pci_table[] = {
 	{PCI_VENDOR_ID_MICROGATE, SYNCLINK_GT_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{PCI_VENDOR_ID_MICROGATE, SYNCLINK_GT2_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{PCI_VENDOR_ID_MICROGATE, SYNCLINK_GT4_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
-- 
2.7.4
