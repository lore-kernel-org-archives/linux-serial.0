From: Qian Cai <cai@lca.pw>
Subject: [PATCH] tty/amba-pl011: fix a -Wunused-function warning
Date: Tue, 17 Sep 2019 09:19:00 -0400
Message-ID: <1568726340-4518-1-git-send-email-cai@lca.pw>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
List-Id: linux-serial@vger.kernel.org

pl011_dma_probe() is only used in pl011_dma_startup() which does only
exist when CONFIG_DMA_ENGINE=y, so remove the unused dummy version to
silence the warning.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/tty/serial/amba-pl011.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5921a33b2a07..91b59f1cd3e6 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1236,10 +1236,6 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
 
 #else
 /* Blank functions if the DMA engine is not available */
-static inline void pl011_dma_probe(struct uart_amba_port *uap)
-{
-}
-
 static inline void pl011_dma_remove(struct uart_amba_port *uap)
 {
 }
-- 
1.8.3.1
