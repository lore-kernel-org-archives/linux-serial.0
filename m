From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v6 1/2] serial: xuartps: Add new compatible string for ZynqMP
Date: Wed, 12 Oct 2016 13:17:27 +0530
Message-ID: <1476258448-20483-1-git-send-email-navam@xilinx.com>
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
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, jslaby@suse.com, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, punnaia@xilinx.com
Cc: Nava kishore Manne <navam@xilinx.com>
List-Id: linux-serial@vger.kernel.org

This patch Adds the new compatible string for ZynqMP SoC.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
Changes for v6:
		-Added New patch.

 drivers/tty/serial/xilinx_uartps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index f37edaa..dd4c02f 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1200,6 +1200,7 @@ static int __init cdns_early_console_setup(struct earlycon_device *device,
 OF_EARLYCON_DECLARE(cdns, "xlnx,xuartps", cdns_early_console_setup);
 OF_EARLYCON_DECLARE(cdns, "cdns,uart-r1p8", cdns_early_console_setup);
 OF_EARLYCON_DECLARE(cdns, "cdns,uart-r1p12", cdns_early_console_setup);
+OF_EARLYCON_DECLARE(cdns, "xlnx,zynqmp-uart", cdns_early_console_setup);
 
 /**
  * cdns_uart_console_write - perform write operation
@@ -1438,6 +1439,7 @@ static const struct of_device_id cdns_uart_of_match[] = {
 	{ .compatible = "xlnx,xuartps", },
 	{ .compatible = "cdns,uart-r1p8", },
 	{ .compatible = "cdns,uart-r1p12", .data = &zynqmp_uart_def },
+	{ .compatible = "xlnx,zynqmp-uart", .data = &zynqmp_uart_def },
 	{}
 };
 MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
-- 
2.1.1
