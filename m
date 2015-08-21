From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 19/33] serial: sh-sci: Fix TX buffer mapping leak
Date: Fri, 21 Aug 2015 20:02:43 +0200
Message-ID: <1440180177-6924-20-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The mapped transmit buffer is never unmapped. This leaks quite some
mappings, as the mapping is done in uart_ops.startup(), i.e. every time
the device is opened. Unmap the buffer on device close.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Rebased on top of "serial: sh-sci: Switch to dma_map_single() for
    DMA transmission", and thus converted from scatterlist to buffer.

v2:
  - Add TODO.
---
 drivers/tty/serial/sh-sci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5a528b8985052017..4345aa422eed43a1 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1384,6 +1384,8 @@ static void sci_tx_dma_release(struct sci_port *s, bool enable_pio)
 
 	s->chan_tx = NULL;
 	s->cookie_tx = -EINVAL;
+	dma_unmap_single(chan->device->dev, s->tx_dma_addr, UART_XMIT_SIZE,
+			 DMA_TO_DEVICE);
 	dma_release_channel(chan);
 	if (enable_pio)
 		sci_start_tx(port);
-- 
1.9.1

