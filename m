From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/9] tty: isicom: constify pci_device_id.
Date: Sun, 23 Jul 2017 15:31:02 +0530
Message-ID: <1500804069-11043-3-git-send-email-arvind.yadav.cs@gmail.com>
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
  12176	   1520	  25864	  39560	   9a88	drivers/tty/isicom.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  12528	   1168	  25864	  39560	   9a88	drivers/tty/isicom.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/tty/isicom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index b70187b..61ecdd6 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -150,7 +150,7 @@
 static int isicom_probe(struct pci_dev *, const struct pci_device_id *);
 static void isicom_remove(struct pci_dev *);
 
-static struct pci_device_id isicom_pci_tbl[] = {
+static const struct pci_device_id isicom_pci_tbl[] = {
 	{ PCI_DEVICE(VENDOR_ID, 0x2028) },
 	{ PCI_DEVICE(VENDOR_ID, 0x2051) },
 	{ PCI_DEVICE(VENDOR_ID, 0x2052) },
-- 
2.7.4
