From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 5/9] tty: moxa: constify pci_device_id.
Date: Sun, 23 Jul 2017 15:31:05 +0530
Message-ID: <1500804069-11043-6-git-send-email-arvind.yadav.cs@gmail.com>
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
  14201	    656	   1760	  16617	   40e9	drivers/tty/moxa.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  14329	    528	   1760	  16617	   40e9	drivers/tty/moxa.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/tty/moxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 3b251f4e..7f3d4cb 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -88,7 +88,7 @@ static char *moxa_brdname[] =
 };
 
 #ifdef CONFIG_PCI
-static struct pci_device_id moxa_pcibrds[] = {
+static const struct pci_device_id moxa_pcibrds[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C218),
 		.driver_data = MOXA_BOARD_C218_PCI },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C320),
-- 
2.7.4
