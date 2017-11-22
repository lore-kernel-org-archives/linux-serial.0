From: Matt Redfearn <matt.redfearn@mips.com>
Subject: [PATCH 1/2] serial: 8250_early: Only set divisor if valid clk & baud
Date: Wed, 22 Nov 2017 09:57:28 +0000
Message-ID: <1511344649-27612-1-git-send-email-matt.redfearn@mips.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, linux-serial@vger.kernel.org, linux-mips@linux-mips.org, Matt Redfearn <matt.redfearn@mips.com>, "stable # 4 . 14" <stable@vger.kernel.org>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>
List-Id: linux-serial@vger.kernel.org

If either uartclk or baud are 0, avoid calculating and setting a divisor
based on them since the output will almost certainly be garbage.

This also allows platforms such as the MIPS generic kernel, which has no
way to know a valid BASE_BASE for the board it is actually booted on at
compile time, to set BASE_BAUD to 0 and avoid early_8250 setting a bad
divisor.

This fixes a regression caused by commit 31cb9a8575ca ("earlycon:
initialise baud field of earlycon device structure"), which changed the
behavior of of_setup_earlycon such that it sets a baud rate in the
earlycon structure where previously it was left as 0. All boards
supported by the MIPS generic kernel started outputting garbage from the
boot console due to an incorrect divisor being set.

Fixes: 31cb9a8575ca ("earlycon: initialise baud field of earlycon device structure")
Cc: stable <stable@vger.kernel.org> # 4.14
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 drivers/tty/serial/8250/8250_early.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index af72ec32e404..f135c1846477 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -125,12 +125,14 @@ static void __init init_port(struct earlycon_device *device)
 	serial8250_early_out(port, UART_FCR, 0);	/* no fifo */
 	serial8250_early_out(port, UART_MCR, 0x3);	/* DTR + RTS */
 
-	divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
-	c = serial8250_early_in(port, UART_LCR);
-	serial8250_early_out(port, UART_LCR, c | UART_LCR_DLAB);
-	serial8250_early_out(port, UART_DLL, divisor & 0xff);
-	serial8250_early_out(port, UART_DLM, (divisor >> 8) & 0xff);
-	serial8250_early_out(port, UART_LCR, c & ~UART_LCR_DLAB);
+	if (port->uartclk && device->baud) {
+		divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
+		c = serial8250_early_in(port, UART_LCR);
+		serial8250_early_out(port, UART_LCR, c | UART_LCR_DLAB);
+		serial8250_early_out(port, UART_DLL, divisor & 0xff);
+		serial8250_early_out(port, UART_DLM, (divisor >> 8) & 0xff);
+		serial8250_early_out(port, UART_LCR, c & ~UART_LCR_DLAB);
+	}
 }
 
 int __init early_serial8250_setup(struct earlycon_device *device,
-- 
2.7.4
