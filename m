From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 30/33] serial: sh-sci: Fix NULL pointer dereference if HIGHMEM is enabled
Date: Fri, 21 Aug 2015 20:02:54 +0200
Message-ID: <1440180177-6924-31-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch fixes an issue that this driver causes a NULL pointer
dereference in the following conditions:
 - CONFIG_HIGHMEM and CONFIG_SERIAL_SH_SCI_DMA are enabled
 - This driver runs on the sci_dma_rx_push()

This issue was caused by virt_to_page(buf) in the sci_request_dma()
because this driver didn't check if the "buf" was valid or not.  So,
this patch uses the "buf" from dma_alloc_coherent() as is, not page.

This patch also fixes a WARNING issue in sci_rx_dma_release():

    WARNING: CPU: 0 PID: 1328 at lib/dma-debug.c:1125 check_unmap+0x444/0x848()
    rcar-dmac e6700000.dma-controller: DMA-API: device driver frees DMA memory with different CPU address [device address=0x000000006dd89000] [size=64 bytes] [cpu alloc address=0x000000016189c000] [cpu free address=0x0000000080000000]

    WARNING: CPU: 1 PID: 1 at drivers/base/dma-mapping.c:334 dma_common_free_remap+0x48/0x6c()
    trying to free invalid coherent area:   (null)

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[geert] Rebased
[geert] Reworded
[geert] Dropped .rx_chunk, as it's always identical to .rx_buf[0]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Assimilated into my series.
---
 drivers/tty/serial/sh-sci.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 681e52a087c2e821..70e16f402e3108f4 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -110,6 +110,7 @@ struct sci_port {
 	dma_addr_t			tx_dma_addr;
 	unsigned int			tx_dma_len;
 	struct scatterlist		sg_rx[2];
+	void				*rx_buf[2];
 	size_t				buf_len_rx;
 	struct sh_dmae_slave		param_tx;
 	struct sh_dmae_slave		param_rx;
@@ -1301,14 +1302,13 @@ static void sci_dma_tx_complete(void *arg)
 }
 
 /* Locking: called with port lock held */
-static int sci_dma_rx_push(struct sci_port *s, struct scatterlist *sg,
-			   size_t count)
+static int sci_dma_rx_push(struct sci_port *s, void *buf, size_t count)
 {
 	struct uart_port *port = &s->port;
 	struct tty_port *tport = &port->state->port;
 	int copied;
 
-	copied = tty_insert_flip_string(tport, sg_virt(sg), count);
+	copied = tty_insert_flip_string(tport, buf, count);
 	if (copied < count) {
 		dev_warn(port->dev, "Rx overrun: dropping %zu bytes\n",
 			 count - copied);
@@ -1347,7 +1347,7 @@ static void sci_dma_rx_complete(void *arg)
 
 	active = sci_dma_rx_find_active(s);
 	if (active >= 0)
-		count = sci_dma_rx_push(s, &s->sg_rx[active], s->buf_len_rx);
+		count = sci_dma_rx_push(s, s->rx_buf[active], s->buf_len_rx);
 
 	mod_timer(&s->rx_timer, jiffies + s->rx_timeout);
 
@@ -1370,8 +1370,8 @@ static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
 	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
 	spin_unlock_irqrestore(&port->lock, flags);
 	dmaengine_terminate_all(chan);
-	dma_free_coherent(chan->device->dev, s->buf_len_rx * 2,
-			  sg_virt(&s->sg_rx[0]), sg_dma_address(&s->sg_rx[0]));
+	dma_free_coherent(chan->device->dev, s->buf_len_rx * 2, s->rx_buf[0],
+			  sg_dma_address(&s->sg_rx[0]));
 	dma_release_channel(chan);
 	if (enable_pio)
 		sci_start_rx(port);
@@ -1464,7 +1464,7 @@ static void work_fn_rx(struct work_struct *work)
 		dev_dbg(port->dev, "Read %u bytes with cookie %d\n", read,
 			s->active_rx);
 
-		count = sci_dma_rx_push(s, &s->sg_rx[new], read);
+		count = sci_dma_rx_push(s, s->rx_buf[new], read);
 
 		if (count)
 			tty_flip_buffer_push(&port->state->port);
@@ -1756,9 +1756,9 @@ static void sci_request_dma(struct uart_port *port)
 			struct scatterlist *sg = &s->sg_rx[i];
 
 			sg_init_table(sg, 1);
-			sg_set_page(sg, virt_to_page(buf), s->buf_len_rx,
-				    (uintptr_t)buf & ~PAGE_MASK);
+			s->rx_buf[i] = buf;
 			sg_dma_address(sg) = dma;
+			sg->length = s->buf_len_rx;
 
 			buf += s->buf_len_rx;
 			dma += s->buf_len_rx;
-- 
1.9.1

