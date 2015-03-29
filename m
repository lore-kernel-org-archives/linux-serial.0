From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 64/86] tty/serial: comment update
Date: Sun, 29 Mar 2015 15:42:15 +0200
Message-ID: <1427635734-24786-65-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Wang YanQing <udknight@gmail.com>, Aaron Sierra <asierra@xes-inc.com>, Sergej Pupykin <ml@sergej.pp.ru>, Peter Hung <hpeter@gmail.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
update comment to list the correct header.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/tty/serial/8250/8250_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 892eb32..7dc6d5f 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1882,7 +1882,7 @@ pci_wch_ch38x_setup(struct serial_private *priv,
 #define PCIE_DEVICE_ID_WCH_CH382_2S1P	0x3250
 #define PCIE_DEVICE_ID_WCH_CH384_4S	0x3470
 
-/* Unknown vendors/cards - this should not be in linux/pci_ids.h */
+/* Unknown vendors/cards - this should not be in uapi/linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1588	0x1588
 
-- 
MST
