From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/5] serial: sa1100: delete .set_wake callback
Date: Tue, 15 Oct 2013 15:07:34 +0100
Message-ID: <20131015140733.GC25034@n2100.arm.linux.org.uk>
References: <1381821626-19441-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41219 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759191Ab3JOOHp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Oct 2013 10:07:45 -0400
Content-Disposition: inline
In-Reply-To: <1381821626-19441-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue, Oct 15, 2013 at 09:20:26AM +0200, Linus Walleij wrote:
> This callback is unused by the serial core since pre-git days
> and is not coming back. Delete it. Enabling wakeup on the
> SA1100 platforms should be done in the suspend() callback
> so the platform hook is left in the serial port struct for
> later enablement.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This is only used by the old iPAQ stuff for serial 3.  If we push gpio
layer support into the serial driver for CTS/DCD signalling, then we can
kill this set_wake off entirely.

Through looking at this, there's a side effect of your removal of the
gpio stuff in mach/gpio.h for SA11x0 - these platforms will now spit
warnings about GPIOs being used without first being registered.  I
think I need to drop your patch, and then we need to sort that out
first.

How about something like this?  If we push the other platforms to put
their mctrl stuff under gpiolib, then there is a candidate here for
further cleanup.  Only tested on the Assabet.

 arch/arm/mach-sa1100/badge4.c               |    2 -
 arch/arm/mach-sa1100/h3xxx.c                |   47 +-------------
 drivers/tty/serial/sa1100.c                 |   91 +++++++++++++++++++++++++-
 include/linux/platform_data/sa11x0-serial.h |    3 +-
 4 files changed, 91 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index 63361b6..17d28b4 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -315,8 +315,6 @@ badge4_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 }
 
 static struct sa1100_port_fns badge4_port_fns __initdata = {
-	//.get_mctrl	= badge4_get_mctrl,
-	//.set_mctrl	= badge4_set_mctrl,
 	.pm		= badge4_uart_pm,
 };
 
diff --git a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
index f17e738..efe34ca 100644
--- a/arch/arm/mach-sa1100/h3xxx.c
+++ b/arch/arm/mach-sa1100/h3xxx.c
@@ -116,30 +116,6 @@ static struct resource h3xxx_flash_resource =
 /*
  * H3xxx uart support
  */
-static void h3xxx_uart_set_mctrl(struct uart_port *port, u_int mctrl)
-{
-	if (port->mapbase == _Ser3UTCR0) {
-		gpio_set_value(H3XXX_GPIO_COM_RTS, !(mctrl & TIOCM_RTS));
-	}
-}
-
-static u_int h3xxx_uart_get_mctrl(struct uart_port *port)
-{
-	u_int ret = TIOCM_CD | TIOCM_CTS | TIOCM_DSR;
-
-	if (port->mapbase == _Ser3UTCR0) {
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
@@ -153,29 +129,8 @@ static void h3xxx_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 	}
 }
 
-/*
- * Enable/Disable wake up events for this serial port.
- * Obviously, we only support this on the normal COM port.
- */
-static int h3xxx_uart_set_wake(struct uart_port *port, u_int enable)
-{
-	int err = -EINVAL;
-
-	if (port->mapbase == _Ser3UTCR0) {
-		if (enable)
-			PWER |= PWER_GPIO23 | PWER_GPIO25; /* DCD and CTS */
-		else
-			PWER &= ~(PWER_GPIO23 | PWER_GPIO25); /* DCD and CTS */
-		err = 0;
-	}
-	return err;
-}
-
 static struct sa1100_port_fns h3xxx_port_fns __initdata = {
-	.set_mctrl	= h3xxx_uart_set_mctrl,
-	.get_mctrl	= h3xxx_uart_get_mctrl,
 	.pm		= h3xxx_uart_pm,
-	.set_wake	= h3xxx_uart_set_wake,
 };
 
 /*
@@ -289,6 +244,8 @@ void __init h3xxx_map_io(void)
 	iotable_init(h3600_io_desc, ARRAY_SIZE(h3600_io_desc));
 
 	sa1100_register_uart(0, 3); /* Common serial port */
+	sa1100_set_uart_gpios(0, H3XXX_GPIO_COM_RTS, H3XXX_GPIO_COM_CTS,
+			      H3XXX_GPIO_COM_DCD);
 //	sa1100_register_uart(1, 1); /* Microcontroller on 3100/3600 */
 
 	/* Ensure those pins are outputs and driving low  */
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index ba25722..d4f266a 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -25,8 +25,10 @@
 #endif
 
 #include <linux/module.h>
+#include <linux/gpio.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/platform_data/sa11x0-serial.h>
@@ -90,6 +92,9 @@ struct sa1100_port {
 	struct uart_port	port;
 	struct timer_list	timer;
 	unsigned int		old_status;
+	int			gpio_rts;
+	int			gpio_cts;
+	int			gpio_dcd;
 };
 
 /*
@@ -330,11 +335,23 @@ static unsigned int sa1100_tx_empty(struct uart_port *port)
 
 static unsigned int sa1100_get_mctrl(struct uart_port *port)
 {
-	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+	struct sa1100_port *sport = (struct sa1100_port *)port;
+	unsigned int mctrl = TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+
+	if (gpio_is_valid(sport->gpio_cts) && gpio_get_value(sport->gpio_cts))
+		mctrl &= ~TIOCM_CTS;
+	if (gpio_is_valid(sport->gpio_dcd) && gpio_get_value(sport->gpio_dcd))
+		mctrl &= ~TIOCM_CD;
+
+	return mctrl;
 }
 
 static void sa1100_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
+	struct sa1100_port *sport = (struct sa1100_port *)port;
+
+	if (gpio_is_valid(sport->gpio_rts))
+		gpio_set_value(sport->gpio_rts, !(mctrl & TIOCM_RTS));
 }
 
 /*
@@ -613,6 +630,7 @@ static struct sa1100_port sa1100_ports[NR_PORTS];
  */
 static void __init sa1100_init_ports(void)
 {
+	struct gpio gpios[3];
 	static int first = 1;
 	int i;
 
@@ -621,6 +639,8 @@ static void __init sa1100_init_ports(void)
 	first = 0;
 
 	for (i = 0; i < NR_PORTS; i++) {
+		unsigned j;
+
 		sa1100_ports[i].port.uartclk   = 3686400;
 		sa1100_ports[i].port.ops       = &sa1100_pops;
 		sa1100_ports[i].port.fifosize  = 8;
@@ -629,6 +649,28 @@ static void __init sa1100_init_ports(void)
 		init_timer(&sa1100_ports[i].timer);
 		sa1100_ports[i].timer.function = sa1100_timeout;
 		sa1100_ports[i].timer.data     = (unsigned long)&sa1100_ports[i];
+
+		j = 0;
+		if (gpio_is_valid(sa1100_ports[i].gpio_rts)) {
+			gpios[j].gpio = sa1100_ports[i].gpio_rts;
+			gpios[j].flags = GPIOF_OUT_INIT_HIGH;
+			j++;
+		}
+		if (gpio_is_valid(sa1100_ports[i].gpio_cts)) {
+			gpios[j].gpio = sa1100_ports[i].gpio_cts;
+			gpios[j].flags = GPIOF_IN;
+			j++;
+		}
+		if (gpio_is_valid(sa1100_ports[i].gpio_dcd)) {
+			gpios[j].gpio = sa1100_ports[i].gpio_dcd;
+			gpios[j].flags = GPIOF_IN;
+			j++;
+		}
+		if (gpio_request_array(gpios, j)) {
+			sa1100_ports[i].gpio_rts = -EINVAL;
+			sa1100_ports[i].gpio_cts = -EINVAL;
+			sa1100_ports[i].gpio_dcd = -EINVAL;
+		}
 	}
 
 	/*
@@ -647,7 +689,18 @@ void sa1100_register_uart_fns(struct sa1100_port_fns *fns)
 		sa1100_pops.set_mctrl = fns->set_mctrl;
 
 	sa1100_pops.pm       = fns->pm;
-	sa1100_pops.set_wake = fns->set_wake;
+}
+
+void __init sa1100_set_uart_gpios(int idx, int rts, int cts, int dcd)
+{
+	if (idx >= NR_PORTS) {
+		printk(KERN_ERR "%s: bad index number %d\n", __func__, idx);
+		return;
+	}
+
+	sa1100_ports[idx].gpio_rts = rts;
+	sa1100_ports[idx].gpio_cts = cts;
+	sa1100_ports[idx].gpio_dcd = dcd;
 }
 
 void __init sa1100_register_uart(int idx, int port)
@@ -657,6 +710,10 @@ void __init sa1100_register_uart(int idx, int port)
 		return;
 	}
 
+	sa1100_ports[idx].gpio_rts = -EINVAL;
+	sa1100_ports[idx].gpio_cts = -EINVAL;
+	sa1100_ports[idx].gpio_dcd = -EINVAL;
+
 	switch (port) {
 	case 1:
 		sa1100_ports[idx].port.membase = (void __iomem *)&Ser1UTCR0;
@@ -823,9 +880,22 @@ static int sa1100_serial_suspend(struct platform_device *dev, pm_message_t state
 {
 	struct sa1100_port *sport = platform_get_drvdata(dev);
 
-	if (sport)
+	if (sport) {
 		uart_suspend_port(&sa1100_reg, &sport->port);
 
+		if (device_can_wakeup(&dev->dev)) {
+			int irq;
+
+			if (gpio_is_valid(sport->gpio_cts) &&
+			    (irq = gpio_to_irq(sport->gpio_cts)) > 0)
+				enable_irq_wake(irq);
+				
+			if (gpio_is_valid(sport->gpio_dcd) &&
+			    (irq = gpio_to_irq(sport->gpio_dcd)) > 0)
+				enable_irq_wake(irq);
+		}
+	}
+
 	return 0;
 }
 
@@ -833,8 +903,21 @@ static int sa1100_serial_resume(struct platform_device *dev)
 {
 	struct sa1100_port *sport = platform_get_drvdata(dev);
 
-	if (sport)
+	if (sport) {
+		if (device_can_wakeup(&dev->dev)) {
+			int irq;
+
+			if (gpio_is_valid(sport->gpio_cts) &&
+			    (irq = gpio_to_irq(sport->gpio_cts)) > 0)
+				disable_irq_wake(irq);
+				
+			if (gpio_is_valid(sport->gpio_dcd) &&
+			    (irq = gpio_to_irq(sport->gpio_dcd)) > 0)
+				disable_irq_wake(irq);
+		}
+
 		uart_resume_port(&sa1100_reg, &sport->port);
+	}
 
 	return 0;
 }
diff --git a/include/linux/platform_data/sa11x0-serial.h b/include/linux/platform_data/sa11x0-serial.h
index 4504d5d..941af67 100644
--- a/include/linux/platform_data/sa11x0-serial.h
+++ b/include/linux/platform_data/sa11x0-serial.h
@@ -19,15 +19,16 @@ struct sa1100_port_fns {
 	void	(*set_mctrl)(struct uart_port *, u_int);
 	u_int	(*get_mctrl)(struct uart_port *);
 	void	(*pm)(struct uart_port *, u_int, u_int);
-	int	(*set_wake)(struct uart_port *, u_int);
 };
 
 #ifdef CONFIG_SERIAL_SA1100
 void sa1100_register_uart_fns(struct sa1100_port_fns *fns);
 void sa1100_register_uart(int idx, int port);
+void sa1100_set_uart_gpios(int idx, int rts, int cts, int dcd);
 #else
 #define sa1100_register_uart_fns(fns) do { } while (0)
 #define sa1100_register_uart(idx,port) do { } while (0)
+#define sa1100_set_uart_gpios(idx,rts,cts,dcd) do { } while (0)
 #endif
 
 #endif

