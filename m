From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH v2] serial: fsl-lpuart: disable interrupt when suspend
Date: Fri, 23 Jan 2015 17:48:54 +0800
Message-ID: <1422006534-16264-1-git-send-email-yao.yuan@freescale.com>
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
To: gregkh@linuxfoundation.org, shawn.guo@linaro.org, jslaby@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

For power management support, we should disable TX and
TX interrupt so that kernel can prepare for deep sleep.

Retain RX and RX interrupt for wakeup the kernel when
receive the input character.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
---

Changed in v2: 
	- Retain RX and RX interrupt for wakeup the kernel when
 receive the input character.
 drivers/tty/serial/fsl_lpuart.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 1c5d020..b195cfc 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1449,6 +1449,19 @@ static int lpuart_remove(struct platform_device *pdev)
 static int lpuart_suspend(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
+	unsigned long temp;
+
+	if (sport->lpuart32) {
+		/* disable Rx/Tx and interrupts */
+		temp = lpuart32_read(sport->port.membase + UARTCTRL);
+		temp &= ~(UARTCTRL_TE | UARTCTRL_TIE | UARTCTRL_TCIE);
+		lpuart32_write(temp, sport->port.membase + UARTCTRL);
+	} else {
+		/* disable Rx/Tx and interrupts */
+		temp = readb(sport->port.membase + UARTCR2);
+		temp &= ~(UARTCR2_TE | UARTCR2_TIE | UARTCR2_TCIE);
+		writeb(temp, sport->port.membase + UARTCR2);
+	}
 
 	uart_suspend_port(&lpuart_reg, &sport->port);
 
-- 
2.1.0.27.g96db324
