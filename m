From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH] BUG: atmel_serial: Interrupts not disabled on close
Date: Mon, 12 Sep 2016 15:34:41 +0200
Message-ID: <20160912133441.14597-1-richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>
List-Id: linux-serial@vger.kernel.org

Since commit 18dfef9c7f87 ("serial: atmel: convert to irq handling
provided mctrl-gpio"), interrupts from GPIOs are not disabled any more
when the serial port is closed, leading to an oops when the one of the
input pin is toggled (CTS/DSR/DCD/RNG).

This is only the case if those pins are used as GPIOs, i.e. declared
like that:
usart1: serial@f8020000 {
        /* CTS and DTS will be handled by GPIO */
        status = "okay";
        rts-gpios = <&pioB 17 GPIO_ACTIVE_LOW>;
        cts-gpios = <&pioB 16 GPIO_ACTIVE_LOW>;
        dtr-gpios = <&pioB 14 GPIO_ACTIVE_LOW>;
        dsr-gpios = <&pioC 31 GPIO_ACTIVE_LOW>;
        rng-gpios = <&pioB 12 GPIO_ACTIVE_LOW>;
        dcd-gpios = <&pioB 15 GPIO_ACTIVE_LOW>;
};

That's because modem interrupts used to be freed in atmel_shutdown().
After commit 18dfef9c7f87 ("serial: atmel: convert to irq handling
provided mctrl-gpio"), this code was just removed.
Calling atmel_disable_ms() disables the interrupts and everything works
fine again.

Tested on at91sam9g35-cm

(This patch doesn't apply on -stable kernels, fixes for 4.4 and 4.7 will
be sent after this one is applied.)

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Fixes: 18dfef9c7f87 ("serial: atmel: convert to irq handling provided mctrl-gpio")
---
 drivers/tty/serial/atmel_serial.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 2eaa18ddef61..8bbde52db376 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1929,6 +1929,9 @@ static void atmel_shutdown(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
+	/* Disable modem control lines interrupts */
+	atmel_disable_ms(port);
+
 	/* Disable interrupts at device level */
 	atmel_uart_writel(port, ATMEL_US_IDR, -1);
 
@@ -1979,8 +1982,6 @@ static void atmel_shutdown(struct uart_port *port)
 	 */
 	free_irq(port->irq, port);
 
-	atmel_port->ms_irq_enabled = false;
-
 	atmel_flush_buffer(port);
 }
 
