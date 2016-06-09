From: Nandor Han <nandor.han@ge.com>
Subject: [PATCH RFC 4/4] serial: imx-serial - update RX error counters when DMA is used
Date: Thu,  9 Jun 2016 15:16:33 +0300
Message-ID: <c306bad562720ca90d33b5b8e47b404f81f7d03b.1465456640.git.nandor.han@ge.com>
References: <cover.1465456639.git.nandor.han@ge.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1465456639.git.nandor.han@ge.com>
In-Reply-To: <cover.1465456639.git.nandor.han@ge.com>
References: <cover.1465456639.git.nandor.han@ge.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Nandor Han <nandor.han@ge.com>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Update error couters when DMA is used for receiving data. Do
this by using DMA transaction error event instead error interrupts
to reduce interrupt load.

Signed-off-by: Nandor Han <nandor.han@ge.com>
---
 drivers/tty/serial/imx.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1912136..08ccfe1 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -704,6 +704,7 @@ out:
 	return IRQ_HANDLED;
 }
 
+static void clear_rx_errors(struct imx_port *sport);
 static int start_rx_dma(struct imx_port *sport);
 /*
  * If the RXFIFO is filled with some data, and then we
@@ -729,6 +730,11 @@ static void imx_dma_rxint(struct imx_port *sport)
 		temp &= ~(UCR2_ATEN);
 		writel(temp, sport->port.membase + UCR2);
 
+		/* disable the rx errors interrupts */
+		temp = readl(sport->port.membase + UCR4);
+		temp &= ~UCR4_OREN;
+		writel(temp, sport->port.membase + UCR4);
+
 		/* tell the DMA to receive the data. */
 		start_rx_dma(sport);
 	}
@@ -961,6 +967,7 @@ static void dma_rx_callback(void *data)
 
 	if (status == DMA_ERROR) {
 		dev_err(sport->port.dev, "DMA transaction error.\n");
+		clear_rx_errors(sport);
 		return;
 	}
 
@@ -1057,6 +1064,31 @@ static int start_rx_dma(struct imx_port *sport)
 	return 0;
 }
 
+static void clear_rx_errors(struct imx_port *sport)
+{
+	unsigned int status_usr1, status_usr2;
+
+	status_usr1 = readl(sport->port.membase + USR1);
+	status_usr2 = readl(sport->port.membase + USR2);
+
+	if (status_usr2 & USR2_BRCD) {
+		sport->port.icount.brk++;
+		writel(USR2_BRCD, sport->port.membase + USR2);
+	} else if (status_usr1 & USR1_FRAMERR) {
+		sport->port.icount.frame++;
+		writel(USR1_FRAMERR, sport->port.membase + USR1);
+	} else if (status_usr1 & USR1_PARITYERR) {
+		sport->port.icount.parity++;
+		writel(USR1_PARITYERR, sport->port.membase + USR1);
+	}
+
+	if (status_usr2 & USR2_ORE) {
+		sport->port.icount.overrun++;
+		writel(USR2_ORE, sport->port.membase + USR2);
+	}
+
+}
+
 #define TXTL_DEFAULT 2 /* reset default */
 #define RXTL_DEFAULT 1 /* reset default */
 #define TXTL_DMA 8 /* DMA burst setting */
-- 
2.8.3
