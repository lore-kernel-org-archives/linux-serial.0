From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] serial: pch_uart: use offset_in_page() macro
Date: Sat, 22 Apr 2017 09:21:11 +0800
Message-ID: <dd629376828f23645aff2d8ba663ed1340ec33e9.1492759587.git.geliangtang@gmail.com>
References: <4dbc77ccaaed98b183cf4dba58a4fa325fd65048.1492758503.git.geliangtang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4dbc77ccaaed98b183cf4dba58a4fa325fd65048.1492758503.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use offset_in_page() macro instead of open-coding.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/tty/serial/pch_uart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 42caccb..d3796dc 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -878,8 +878,7 @@ static int dma_handle_rx(struct eg20t_port *priv)
 	sg_dma_len(sg) = priv->trigger_level;
 
 	sg_set_page(&priv->sg_rx, virt_to_page(priv->rx_buf_virt),
-		     sg_dma_len(sg), (unsigned long)priv->rx_buf_virt &
-		     ~PAGE_MASK);
+		     sg_dma_len(sg), offset_in_page(priv->rx_buf_virt));
 
 	sg_dma_address(sg) = priv->rx_buf_dma;
 
-- 
2.9.3
