From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 1/9] tty: mxser: constify pci_device_id.
Date: Sun, 23 Jul 2017 15:31:01 +0530
Message-ID: <1500804069-11043-2-git-send-email-arvind.yadav.cs@gmail.com>
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
  20253	   1184	  19904	  41341	   a17d	drivers/tty/mxser.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  21117	    300	  19904	  41341	   a17d	drivers/tty/mxser.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/tty/mxser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 8bd6fb6..1c0c955 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -145,7 +145,7 @@ static const struct mxser_cardinfo mxser_cards[] = {
 
 /* driver_data correspond to the lines in the structure above
    see also ISA probe function before you change something */
-static struct pci_device_id mxser_pcibrds[] = {
+static const struct pci_device_id mxser_pcibrds[] = {
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C168),	.driver_data = 3 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C104),	.driver_data = 4 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132),	.driver_data = 8 },
-- 
2.7.4
