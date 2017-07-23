From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 3/9] tty: synclinkmp: constify pci_device_id.
Date: Sun, 23 Jul 2017 15:31:03 +0530
Message-ID: <1500804069-11043-4-git-send-email-arvind.yadav.cs@gmail.com>
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
  44660	    432	    104	  45196	   b08c	drivers/tty/synclinkmp.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  44756	    336	    104	  45196	   b08c	drivers/tty/synclinkmp.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/tty/synclinkmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 9b4fb02..4fed9e7 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -479,7 +479,7 @@ static char *driver_version = "$Revision: 4.38 $";
 static int synclinkmp_init_one(struct pci_dev *dev,const struct pci_device_id *ent);
 static void synclinkmp_remove_one(struct pci_dev *dev);
 
-static struct pci_device_id synclinkmp_pci_tbl[] = {
+static const struct pci_device_id synclinkmp_pci_tbl[] = {
 	{ PCI_VENDOR_ID_MICROGATE, PCI_DEVICE_ID_MICROGATE_SCA, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, }, /* terminate list */
 };
-- 
2.7.4
