From: Josh Cartwright <josh.cartwright@ni.com>
Subject: [PATCH 6/8] serial: xilinx_uartps: kill CONFIG_OF conditional
Date: Tue, 30 Oct 2012 06:25:59 -0600
Message-ID: <61e872b2cd4abc25c2dab82668e5094b590571a0.1351721190.git.josh.cartwright@ni.com>
References: <cover.1351721190.git.josh.cartwright@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1351721190.git.josh.cartwright@ni.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@ti.com>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Linn <John.Linn@xilinx.com>, Michal Simek <michal.simek@xilinx.com>
Cc: Michal Simek <monstr@monstr.eu>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The Zynq platform requires the use of CONFIG_OF.  Remove the #ifdef
conditionals in the uartps driver.

Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
---
 drivers/tty/serial/xilinx_uartps.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index b627363..23efe17 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -946,15 +946,11 @@ static int __devinit xuartps_probe(struct platform_device *pdev)
 	struct resource *res, *res2;
 	int clk = 0;
 
-#ifdef CONFIG_OF
 	const unsigned int *prop;
 
 	prop = of_get_property(pdev->dev.of_node, "clock", NULL);
 	if (prop)
 		clk = be32_to_cpup(prop);
-#else
-	clk = *((unsigned int *)(pdev->dev.platform_data));
-#endif
 	if (!clk) {
 		dev_err(&pdev->dev, "no clock specified\n");
 		return -ENODEV;
@@ -1044,16 +1040,11 @@ static int xuartps_resume(struct platform_device *pdev)
 }
 
 /* Match table for of_platform binding */
-
-#ifdef CONFIG_OF
 static struct of_device_id xuartps_of_match[] __devinitdata = {
 	{ .compatible = "xlnx,xuartps", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, xuartps_of_match);
-#else
-#define xuartps_of_match NULL
-#endif
 
 static struct platform_driver xuartps_platform_driver = {
 	.probe   = xuartps_probe,		/* Probe method */
-- 
1.8.0
