From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 4/9] tty: synclink: constify pci_device_id.
Date: Sun, 23 Jul 2017 15:31:04 +0530
Message-ID: <1500804069-11043-5-git-send-email-arvind.yadav.cs@gmail.com>
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
  51755	    400	    513	  52668	   cdbc	drivers/tty/synclink.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  51883	    304	    513	  52700	   cddc	drivers/tty/synclink.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/tty/synclink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 3fafc5a..3be9811 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -884,7 +884,7 @@ static int synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);
 static void synclink_remove_one (struct pci_dev *dev);
 
-static struct pci_device_id synclink_pci_tbl[] = {
+static const struct pci_device_id synclink_pci_tbl[] = {
 	{ PCI_VENDOR_ID_MICROGATE, PCI_DEVICE_ID_MICROGATE_USC, PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_MICROGATE, 0x0210, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, }, /* terminate list */
-- 
2.7.4
