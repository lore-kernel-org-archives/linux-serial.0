From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 2/6] ARM: sa1100/assabet: convert serial to gpiod APIs
Date: Fri, 31 May 2019 12:13:53 +0100
Message-ID: <E1hWfTt-0003fW-22@rmk-PC.armlinux.org.uk>
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

Convert the Assabet serial modem control signals to use the gpiod APIs
rather than custom callbacks into platform code.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c | 91 +++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index d09c3f236186..bc035821a42b 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -522,6 +522,29 @@ static const struct gpio_keys_platform_data assabet_keys_pdata = {
 	.rep = 0,
 };
 
+static struct gpiod_lookup_table assabet_uart1_gpio_table = {
+	.dev_id = "sa11x0-uart.1",
+	.table = {
+		GPIO_LOOKUP("assabet", 16, "dtr", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("assabet", 17, "rts", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("assabet", 25, "dcd", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("assabet", 26, "cts", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("assabet", 27, "dsr", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
+static struct gpiod_lookup_table assabet_uart3_gpio_table = {
+	.dev_id = "sa11x0-uart.3",
+	.table = {
+		GPIO_LOOKUP("assabet", 28, "cts", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("assabet", 29, "dsr", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("assabet", 30, "dcd", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("assabet", 31, "rng", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 static void __init assabet_init(void)
 {
 	/*
@@ -568,7 +591,10 @@ static void __init assabet_init(void)
 			neponset_resources, ARRAY_SIZE(neponset_resources));
 #endif
 	} else {
+		gpiod_add_lookup_table(&assabet_uart1_gpio_table);
+		gpiod_add_lookup_table(&assabet_uart3_gpio_table);
 		gpiod_add_lookup_table(&assabet_cf_vcc_gpio_table);
+
 		sa11x0_register_fixed_regulator(0, &assabet_cf_vcc_pdata,
 					assabet_cf_vcc_consumers,
 					ARRAY_SIZE(assabet_cf_vcc_consumers),
@@ -658,74 +684,13 @@ static void assabet_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 {
 	if (port->mapbase == _Ser1UTCR0) {
 		if (state)
-			ASSABET_BCR_clear(ASSABET_BCR_RS232EN |
-					  ASSABET_BCR_COM_RTS |
-					  ASSABET_BCR_COM_DTR);
-		else
-			ASSABET_BCR_set(ASSABET_BCR_RS232EN |
-					ASSABET_BCR_COM_RTS |
-					ASSABET_BCR_COM_DTR);
-	}
-}
-
-/*
- * Assabet uses COM_RTS and COM_DTR for both UART1 (com port)
- * and UART3 (radio module).  We only handle them for UART1 here.
- */
-static void assabet_set_mctrl(struct uart_port *port, u_int mctrl)
-{
-	if (port->mapbase == _Ser1UTCR0) {
-		u_int set = 0, clear = 0;
-
-		if (mctrl & TIOCM_RTS)
-			clear |= ASSABET_BCR_COM_RTS;
+			ASSABET_BCR_clear(ASSABET_BCR_RS232EN);
 		else
-			set |= ASSABET_BCR_COM_RTS;
-
-		if (mctrl & TIOCM_DTR)
-			clear |= ASSABET_BCR_COM_DTR;
-		else
-			set |= ASSABET_BCR_COM_DTR;
-
-		ASSABET_BCR_clear(clear);
-		ASSABET_BCR_set(set);
-	}
-}
-
-static u_int assabet_get_mctrl(struct uart_port *port)
-{
-	u_int ret = 0;
-	u_int bsr = ASSABET_BSR;
-
-	/* need 2 reads to read current value */
-	bsr = ASSABET_BSR;
-
-	if (port->mapbase == _Ser1UTCR0) {
-		if (bsr & ASSABET_BSR_COM_DCD)
-			ret |= TIOCM_CD;
-		if (bsr & ASSABET_BSR_COM_CTS)
-			ret |= TIOCM_CTS;
-		if (bsr & ASSABET_BSR_COM_DSR)
-			ret |= TIOCM_DSR;
-	} else if (port->mapbase == _Ser3UTCR0) {
-		if (bsr & ASSABET_BSR_RAD_DCD)
-			ret |= TIOCM_CD;
-		if (bsr & ASSABET_BSR_RAD_CTS)
-			ret |= TIOCM_CTS;
-		if (bsr & ASSABET_BSR_RAD_DSR)
-			ret |= TIOCM_DSR;
-		if (bsr & ASSABET_BSR_RAD_RI)
-			ret |= TIOCM_RI;
-	} else {
-		ret = TIOCM_CD | TIOCM_CTS | TIOCM_DSR;
+			ASSABET_BCR_set(ASSABET_BCR_RS232EN);
 	}
-
-	return ret;
 }
 
 static struct sa1100_port_fns assabet_port_fns __initdata = {
-	.set_mctrl	= assabet_set_mctrl,
-	.get_mctrl	= assabet_get_mctrl,
 	.pm		= assabet_uart_pm,
 };
 
-- 
2.7.4
