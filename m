From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 3/6] ARM: sa1100/h3xxx: convert serial to gpiod APIs
Date: Fri, 31 May 2019 12:13:58 +0100
Message-ID: <E1hWfTy-0003fd-5R@rmk-PC.armlinux.org.uk>
References: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Convert the iPAQ H3xxx serial modem control signals to use the gpiod
APIs rather than custom callbacks into platform code.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/h3xxx.c | 64 ++++++++------------------------------------
 1 file changed, 11 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
index 36a78b0c106f..e7362292612a 100644
--- a/arch/arm/mach-sa1100/h3xxx.c
+++ b/arch/arm/mach-sa1100/h3xxx.c
@@ -87,57 +87,6 @@ static struct resource h3xxx_flash_resource =
 /*
  * H3xxx uart support
  */
-static struct gpio h3xxx_uart_gpio[] = {
-	{ H3XXX_GPIO_COM_DCD,	GPIOF_IN,		"COM DCD" },
-	{ H3XXX_GPIO_COM_CTS,	GPIOF_IN,		"COM CTS" },
-	{ H3XXX_GPIO_COM_RTS,	GPIOF_OUT_INIT_LOW,	"COM RTS" },
-};
-
-static bool h3xxx_uart_request_gpios(void)
-{
-	static bool h3xxx_uart_gpio_ok;
-	int rc;
-
-	if (h3xxx_uart_gpio_ok)
-		return true;
-
-	rc = gpio_request_array(h3xxx_uart_gpio, ARRAY_SIZE(h3xxx_uart_gpio));
-	if (rc)
-		pr_err("h3xxx_uart_request_gpios: error %d\n", rc);
-	else
-		h3xxx_uart_gpio_ok = true;
-
-	return h3xxx_uart_gpio_ok;
-}
-
-static void h3xxx_uart_set_mctrl(struct uart_port *port, u_int mctrl)
-{
-	if (port->mapbase == _Ser3UTCR0) {
-		if (!h3xxx_uart_request_gpios())
-			return;
-		gpio_set_value(H3XXX_GPIO_COM_RTS, !(mctrl & TIOCM_RTS));
-	}
-}
-
-static u_int h3xxx_uart_get_mctrl(struct uart_port *port)
-{
-	u_int ret = TIOCM_CD | TIOCM_CTS | TIOCM_DSR;
-
-	if (port->mapbase == _Ser3UTCR0) {
-		if (!h3xxx_uart_request_gpios())
-			return ret;
-		/*
-		 * DCD and CTS bits are inverted in GPLR by RS232 transceiver
-		 */
-		if (gpio_get_value(H3XXX_GPIO_COM_DCD))
-			ret &= ~TIOCM_CD;
-		if (gpio_get_value(H3XXX_GPIO_COM_CTS))
-			ret &= ~TIOCM_CTS;
-	}
-
-	return ret;
-}
-
 static void h3xxx_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 {
 	if (port->mapbase == _Ser3UTCR0) {
@@ -170,12 +119,20 @@ static int h3xxx_uart_set_wake(struct uart_port *port, u_int enable)
 }
 
 static struct sa1100_port_fns h3xxx_port_fns __initdata = {
-	.set_mctrl	= h3xxx_uart_set_mctrl,
-	.get_mctrl	= h3xxx_uart_get_mctrl,
 	.pm		= h3xxx_uart_pm,
 	.set_wake	= h3xxx_uart_set_wake,
 };
 
+static struct gpiod_lookup_table h3xxx_uart3_gpio_table = {
+	.dev_id = "sa11x0-uart.3",
+	.table = {
+		GPIO_LOOKUP("gpio", H3XXX_GPIO_COM_DCD, "dcd", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio", H3XXX_GPIO_COM_CTS, "cts", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio", H3XXX_GPIO_COM_RTS, "rts", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 /*
  * EGPIO
  */
@@ -283,6 +240,7 @@ static struct gpiod_lookup_table h3xxx_pcmcia_gpio_table = {
 void __init h3xxx_mach_init(void)
 {
 	gpiod_add_lookup_table(&h3xxx_pcmcia_gpio_table);
+	gpiod_add_lookup_table(&h3xxx_uart3_gpio_table);
 	sa1100_register_uart_fns(&h3xxx_port_fns);
 	sa11x0_register_mtd(&h3xxx_flash_data, &h3xxx_flash_resource, 1);
 	platform_add_devices(h3xxx_devices, ARRAY_SIZE(h3xxx_devices));
-- 
2.7.4
