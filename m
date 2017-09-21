From: Martyn Welch <martyn.welch@collabora.co.uk>
Subject: [PATCH v3 1/6] serial: imx: remove CTSC and CTS handling from imx_disable_dma
Date: Thu, 21 Sep 2017 17:18:12 +0100
Message-ID: <1506010697-22114-2-git-send-email-martyn.welch@collabora.co.uk>
References: <1506010697-22114-1-git-send-email-martyn.welch@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506010697-22114-1-git-send-email-martyn.welch@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nandor Han <nandor.han@ge.com>, Romain Perier <romain.perier@collabora.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Martyn Welch <martyn.welch@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

From: Nandor Han <nandor.han@ge.com>

The CTSC and CTS bits affect operation of the CTS/RTS hardware flow
control signal (depending on whether the device is in DCE or DTE mode) and
are not related to DMA. When in RS-232 mode, the driver is using the
automatic CTSC control based on a rxFIFO fill level unless the state of
the CTS signal is explictly set via an ioctl call.

Previous improvements to the imx serial driver have resulted on
imx_disable_dma() only being called on shutdown, by which point the
serial core has already correctly deasserted CTS.

Testing shows that without this handling in imx_disable_dma() the CTS
signal state is set correctly when the device is open and TIOCM_RTS is
set/cleared via the TIOCMGET ioctl. The CTS signal is also correctly
deasserted when the device file is closed.

When in RS-485 mode, the driver uses the CTS signal very differently and
appears to control it via calls to imx_port_rts_active() and
imx_port_rts_inactive().

This configuration of the CTSC and CTS bits are therefore not needed.

Signed-off-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
---
 drivers/tty/serial/imx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index fe368a4..d90dae3 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1225,11 +1225,6 @@ static void imx_disable_dma(struct imx_port *sport)
 	temp &= ~(UCR1_RDMAEN | UCR1_TDMAEN | UCR1_ATDMAEN);
 	writel(temp, sport->port.membase + UCR1);
 
-	/* clear UCR2 */
-	temp = readl(sport->port.membase + UCR2);
-	temp &= ~(UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
-	writel(temp, sport->port.membase + UCR2);
-
 	imx_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
 
 	sport->dma_is_enabled = 0;
-- 
1.8.3.1
