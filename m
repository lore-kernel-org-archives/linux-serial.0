From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 47/87] tty: serial: remove memset after pci_alloc_consistent in icom.c
Date: Fri, 28 Jun 2019 01:41:35 +0800
Message-ID: <20190627174136.4451-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Fuqian Huang <huangfq.daxian@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

pci_alloc_consistent calls dma_alloc_coherent directly.
In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/tty/serial/icom.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index ad374f7c476d..624f3d541c68 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -207,8 +207,6 @@ static int get_port_memory(struct icom_port *icom_port)
 		return -ENOMEM;
 	}
 
-	memset(icom_port->statStg, 0, 4096);
-
 	/* FODs: Frame Out Descriptor Queue, this is a FIFO queue that
            indicates that frames are to be transmitted
 	*/
-- 
2.11.0
