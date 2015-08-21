From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 21/33] serial: sh-sci: Switch to generic DMA residue handling
Date: Fri, 21 Aug 2015 20:02:45 +0200
Message-ID: <1440180177-6924-22-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Convert the SCI driver from the SHDMAE-specific partial DMA transfer
handling to the generic dmaengine residual data framework.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Use "%u" to format "unsigned int",

v2:
  - New.
---
 drivers/tty/serial/Kconfig  |  2 +-
 drivers/tty/serial/sh-sci.c | 16 +++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index ed299b9e63752b4e..e9abde75179d3c1a 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -743,7 +743,7 @@ config SERIAL_SH_SCI_CONSOLE
 
 config SERIAL_SH_SCI_DMA
 	bool "DMA support"
-	depends on SERIAL_SH_SCI && SH_DMAE
+	depends on SERIAL_SH_SCI && DMA_ENGINE
 
 config SERIAL_PNX8XXX
 	bool "Enable PNX8XXX SoCs' UART Support"
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 294b283f5c8535c3..049036dfb6ddf32c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1438,6 +1438,8 @@ static void work_fn_rx(struct work_struct *work)
 	struct sci_port *s = container_of(work, struct sci_port, work_rx);
 	struct uart_port *port = &s->port;
 	struct dma_async_tx_descriptor *desc;
+	struct dma_tx_state state;
+	enum dma_status status;
 	int new;
 
 	if (s->active_rx == s->cookie_rx[0]) {
@@ -1451,21 +1453,21 @@ static void work_fn_rx(struct work_struct *work)
 	}
 	desc = s->desc_rx[new];
 
-	if (dma_async_is_tx_complete(s->chan_rx, s->active_rx, NULL, NULL) !=
-	    DMA_COMPLETE) {
+	status = dmaengine_tx_status(s->chan_rx, s->active_rx, &state);
+	if (status != DMA_COMPLETE) {
 		/* Handle incomplete DMA receive */
 		struct dma_chan *chan = s->chan_rx;
-		struct shdma_desc *sh_desc = container_of(desc,
-					struct shdma_desc, async_tx);
 		unsigned long flags;
+		unsigned int read;
 		int count;
 
 		dmaengine_terminate_all(chan);
-		dev_dbg(port->dev, "Read %zu bytes with cookie %d\n",
-			sh_desc->partial, sh_desc->cookie);
+		read = sg_dma_len(&s->sg_rx[new]) - state.residue;
+		dev_dbg(port->dev, "Read %u bytes with cookie %d\n", read,
+			s->active_rx);
 
 		spin_lock_irqsave(&port->lock, flags);
-		count = sci_dma_rx_push(s, sh_desc->partial);
+		count = sci_dma_rx_push(s, read);
 		spin_unlock_irqrestore(&port->lock, flags);
 
 		if (count)
-- 
1.9.1

