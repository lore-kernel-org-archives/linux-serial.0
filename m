From: Helmut Klein <hgkr.klein@gmail.com>
Subject: [PATCH v2,
 3/3] tty/serial: meson_uart: add the core clock handling to the driver
Date: Tue, 28 Mar 2017 11:25:45 +0200
Message-ID: <20170328092545.4644-4-hgkr.klein@gmail.com>
References: <20170328092545.4644-1-hgkr.klein@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170328092545.4644-1-hgkr.klein@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, carlo@caione.org, khilman@baylibre.com
Cc: linux-amlogic@lists.infradead.org, Helmut Klein <hgkr.klein@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch gets the core clock as provided by the DT and enables it.
The code was taken from Amlogic's serial driver, and was tested on my
board.

Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
---
 drivers/tty/serial/meson_uart.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 60f16795d16b..cb99112288eb 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -600,6 +600,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	struct resource *res_mem, *res_irq;
 	struct uart_port *port;
 	struct clk *clk;
+	struct clk *core_clk;
 	int ret = 0;

 	if (pdev->dev.of_node)
@@ -625,6 +626,15 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;

+	core_clk = devm_clk_get(&pdev->dev, "core");
+	if (!IS_ERR(core_clk)) {
+		ret = clk_prepare_enable(core_clk);
+		if (ret) {
+			dev_err(&pdev->dev, "couldn't enable clkc\n");
+			return ret;
+		}
+	}
+
 	clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
--
2.11.0
