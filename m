From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH RESEND] serial: imx: Enable RTSD only when needed
Date: Wed, 28 Jun 2017 15:59:36 +0200
Message-ID: <20170628135936.30537-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Romain Perier <romain.perier@collabora.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Nandor Han <nandor.han@ge.com>
List-Id: linux-serial@vger.kernel.org

From: Nandor Han <nandor.han@ge.com>

Currently, this IRQ is always enabled. Some devices might mux these pins
to other I/Os, like I2C. This could lead to spurious interrupts.

This commit makes this IRQ optional, by using the field have_rtscts.

Signed-off-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/tty/serial/imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7327477..5437b34 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1302,7 +1302,9 @@ static int imx_startup(struct uart_port *port)
 		imx_enable_dma(sport);
 
 	temp = readl(sport->port.membase + UCR1);
-	temp |= UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN;
+	temp |= UCR1_RRDYEN | UCR1_UARTEN;
+	if (sport->have_rtscts)
+			temp |= UCR1_RTSDEN;
 
 	writel(temp, sport->port.membase + UCR1);
 
-- 
1.8.3.1
