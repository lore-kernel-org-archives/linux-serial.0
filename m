From: "Michael Doswald" <michael.doswald@gmx.net>
Subject: [PATCH] 3.19-rc4: Fix race condition in i.MX serial port driver
Date: Tue, 13 Jan 2015 17:07:08 +0100
Message-ID: <trinity-2ff5fec6-196c-4ecc-9ec2-f1b223f0ea25-1421165228466@3capp-gmx-bs70>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Under pressure, the imx.c device driver may transfer the same data mult=
iple
times.=20

Reason:=20
=46unction imx_dma_tx checks for an active DMA transfer by calling
dmaengine_tx_status. The return value may indicate that no transfer is=20
running while the dma_tx_callback function is still being executed. In=20
this case the xmit->tail pointer may not be updated to the correct valu=
e=20
when imx_dma_tx initiates a new DMA transfer, which will result in a DM=
A
transfer with the same base address as the previous one.

Patch:
Use existing dma_is_txing variable to guard DMA transfer initiation ins=
tead
of dmaengine_tx_status. Clear dma_is_txing at the end of the DMA callba=
ck
function therefore extending the critical section where the port lock i=
s
held. Critical section extension is in line with the callback function=20
of other drivers, e.g. serial-tegra.c (tegra_uart_tx_dma_complete).
=20
=20
Signed-off-by: Michael Doswald <michael.doswald@gmx.net>
---
 drivers/tty/serial/imx.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4c5e909..29e31b1 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -503,13 +503,10 @@ static void dma_tx_callback(void *data)
=20
 	dma_unmap_sg(sport->port.dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE=
);
=20
-	sport->dma_is_txing =3D 0;
-
 	/* update the stat */
 	spin_lock_irqsave(&sport->port.lock, flags);
 	xmit->tail =3D (xmit->tail + sport->tx_bytes) & (UART_XMIT_SIZE - 1);
 	sport->port.icount.tx +=3D sport->tx_bytes;
-	spin_unlock_irqrestore(&sport->port.lock, flags);
=20
 	dev_dbg(sport->port.dev, "we finish the TX DMA.\n");
=20
@@ -518,8 +515,10 @@ static void dma_tx_callback(void *data)
 	if (waitqueue_active(&sport->dma_wait)) {
 		wake_up(&sport->dma_wait);
 		dev_dbg(sport->port.dev, "exit in %s.\n", __func__);
-		return;
 	}
+
+	sport->dma_is_txing =3D 0;
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
=20
 static void imx_dma_tx(struct imx_port *sport)
@@ -529,11 +528,9 @@ static void imx_dma_tx(struct imx_port *sport)
 	struct dma_async_tx_descriptor *desc;
 	struct dma_chan	*chan =3D sport->dma_chan_tx;
 	struct device *dev =3D sport->port.dev;
-	enum dma_status status;
 	int ret;
=20
-	status =3D dmaengine_tx_status(chan, (dma_cookie_t)0, NULL);
-	if (DMA_IN_PROGRESS =3D=3D status)
+	if (sport->dma_is_txing)
 		return;
=20
 	sport->tx_bytes =3D uart_circ_chars_pending(xmit);
--=20
1.9.1


=C2=A0
=C2=A0
