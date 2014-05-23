From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 01/22] serial: 8250_dw: Add optional reset control support
Date: Fri, 23 May 2014 15:51:04 +0800
Message-ID: <1400831485-28576-2-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400831485-28576-1-git-send-email-wens@csie.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Mike Turquette <mturquette@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Luc Verhaegen <libv@skynet.be>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The Allwinner A31 and A23 SoCs have a reset controller
maintaining the UART in reset by default.

This patch adds optional reset support to the driver.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt |  1 +
 drivers/tty/serial/8250/8250_dw.c                             | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
index f13f1c5..cb9af84 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
@@ -7,6 +7,7 @@ Required properties:
 - clock-frequency : the input clock frequency for the UART.
 
 Optional properties:
+- resets : phandle to the parent reset controller.
 - reg-shift : quantity to shift the register offsets by.  If this property is
   not present then the register offsets are not shifted.
 - reg-io-width : the size (in bytes) of the IO accesses that should be
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index ed31135..d0c6d080 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/clk.h>
+#include <linux/reset.h>
 #include <linux/pm_runtime.h>
 
 #include <asm/byteorder.h>
@@ -59,6 +60,7 @@ struct dw8250_data {
 	int			last_mcr;
 	int			line;
 	struct clk		*clk;
+	struct reset_control	*rst;
 	struct uart_8250_dma	dma;
 };
 
@@ -259,6 +261,8 @@ static int dw8250_probe_of(struct uart_port *p,
 	if (!of_property_read_u32(np, "reg-shift", &val))
 		p->regshift = val;
 
+	data->rst = devm_reset_control_get_optional(p->dev, NULL);
+
 	/* clock got configured through clk api, all done */
 	if (p->uartclk)
 		return 0;
@@ -362,6 +366,9 @@ static int dw8250_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (!IS_ERR_OR_NULL(data->rst))
+		reset_control_deassert(data->rst);
+
 	data->line = serial8250_register_8250_port(&uart);
 	if (data->line < 0)
 		return data->line;
@@ -382,6 +389,9 @@ static int dw8250_remove(struct platform_device *pdev)
 
 	serial8250_unregister_port(data->line);
 
+	if (!IS_ERR_OR_NULL(data->rst))
+		reset_control_assert(data->rst);
+
 	if (!IS_ERR(data->clk))
 		clk_disable_unprepare(data->clk);
 
-- 
2.0.0.rc2
