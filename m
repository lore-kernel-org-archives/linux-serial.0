From: kernel@martin.sperl.org
Subject: [PATCH] serial: bcm2835: fix unsigned int issue with irq
Date: Tue,  9 Feb 2016 11:47:16 +0000
Message-ID: <1455018437-2405-1-git-send-email-kernel@martin.sperl.org>
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
To: dan.carpenter@oracle.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Martin Sperl <kernel@martin.sperl.org>
List-Id: linux-serial@vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

Fixes error condition check when requesting the irq,
that would not trigger because of uart_port.irq being
defined as unsigned int.

Reported by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index ecf89f1..e10f124 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -59,12 +59,12 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	}
 
 	/* get the interrupt */
-	data->uart.port.irq = platform_get_irq(pdev, 0);
-	if (data->uart.port.irq < 0) {
-		dev_err(&pdev->dev, "irq not found - %i",
-			data->uart.port.irq);
-		return data->uart.port.irq;
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "irq not found - %i", ret);
+		return ret;
 	}
+	data->uart.port.irq = ret;
 
 	/* map the main registers */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.10.4
