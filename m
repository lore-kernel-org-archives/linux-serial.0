From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] serial: sh-sci: Fix panic when serial console and DMA are enabled
Date: Mon, 27 Feb 2017 15:56:31 +0900
Message-ID: <1488178591-20408-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-serial@vger.kernel.org

From: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>

This patch fixes an issue that kernel panic happens when DMA is enabled
and we press enter key while the kernel booting on the serial console.

* An interrupt may occur after sci_request_irq().
* DMA transfer area is initialized by setup_timer() in sci_request_dma()
  and used in interrupt.

If an interrupt occurred between sci_request_irq() and setup_timer() in
sci_request_dma(), DMA transfer area has not been initialized yet.
So, this patch changes the order of sci_request_irq() and
sci_request_dma().

Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
Signed-off-by: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>
[Shimoda changes the commit log]
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch is based on the following repo and tag:
  - renesas-drivers.git / renesas-drivers-2017-02-21-v4.10 tag

 drivers/tty/serial/sh-sci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1d6f953..681e469 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1985,11 +1985,13 @@ static int sci_startup(struct uart_port *port)
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
+	sci_request_dma(port);
+
 	ret = sci_request_irq(s);
-	if (unlikely(ret < 0))
+	if (unlikely(ret < 0)) {
+		sci_free_dma(port);
 		return ret;
-
-	sci_request_dma(port);
+	}
 
 	return 0;
 }
@@ -2021,8 +2023,8 @@ static void sci_shutdown(struct uart_port *port)
 	}
 #endif
 
-	sci_free_dma(port);
 	sci_free_irq(s);
+	sci_free_dma(port);
 }
 
 static int sci_sck_calc(struct sci_port *s, unsigned int bps,
-- 
1.9.1
