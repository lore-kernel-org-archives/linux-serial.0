From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH v2] tty: atmel_serial: fix a NULL pointer dereference
Date: Fri, 15 Mar 2019 02:27:09 -0500
Message-ID: <20190315072709.22811-1-kjlu@umn.edu>
References: <CAMuHMdX=XwxVFb1eLupmyHBOMBGzB+=RXxcUCH9D-J1+YKiq5w@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdX=XwxVFb1eLupmyHBOMBGzB+=RXxcUCH9D-J1+YKiq5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Fixes: 34df42f59a60 ("serial: at91: add rx dma support")

In case dmaengine_prep_dma_cyclic fails, the fix returns a proper
error code to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>

---
V2: simplified the patch as suggested by
Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 05147fe24343..41b728d223d1 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1288,6 +1288,10 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 					 sg_dma_len(&atmel_port->sg_rx)/2,
 					 DMA_DEV_TO_MEM,
 					 DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(port->dev, "Preparing DMA cyclic failed\n");
+		goto chan_err;
+	}
 	desc->callback = atmel_complete_rx_dma;
 	desc->callback_param = port;
 	atmel_port->desc_rx = desc;
-- 
2.17.1
