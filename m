From: Rob Herring <robh@kernel.org>
Subject: [PATCH 2/3] tty/serial: of_serial: add support for PXA/MMP uarts
Date: Mon, 26 Jan 2015 22:50:08 -0600
Message-ID: <1422334209-23125-2-git-send-email-robh@kernel.org>
References: <1422334209-23125-1-git-send-email-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422334209-23125-1-git-send-email-robh@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Add mrvl,pxa-uart and mrvl,mmp-uart compatible strings for the of_serial
driver. These are 8250 variants which have a port type of PORT_XSCALE.

There is also the serial driver pxa.c with these compatible strings
already. However, it can be replaced with the common 8250 driver. It has
some issues like it cannot coexist with the 8250 driver due to tty name
collision. That also means adding these compatible strings here should
not case a problem.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/of_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 3194b42..fbb719c 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -335,6 +335,10 @@ static struct of_device_id of_platform_serial_table[] = {
 		.data = (void *)PORT_ALTR_16550_F64, },
 	{ .compatible = "altr,16550-FIFO128",
 		.data = (void *)PORT_ALTR_16550_F128, },
+	{ .compatible = "mrvl,mmp-uart",
+		.data = (void *)PORT_XSCALE, },
+	{ .compatible = "mrvl,pxa-uart",
+		.data = (void *)PORT_XSCALE, },
 #ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL
 	{ .compatible = "ibm,qpace-nwp-serial",
 		.data = (void *)PORT_NWPSERIAL, },
-- 
2.1.0
