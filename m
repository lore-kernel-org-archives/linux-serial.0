From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] serial: 8250_early: Setup divider when uartclk is passed
Date: Mon, 23 Apr 2018 11:18:11 +0200
Message-ID: <93a7871c8654a6273b1ab35a8071e9f830e2a0c8.1524475087.git.michal.simek@xilinx.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: stable <stable@vger.kernel.org>, Matt Redfearn <matt.redfearn@mips.com>, Jiri Slaby <jslaby@suse.com>, Douglas Anderson <dianders@chromium.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeffy Chen <jeffy.chen@rock-chips.com>
List-Id: linux-serial@vger.kernel.org

device->baud is always non zero value because it is checked already in
early_serial8250_setup() before init_port is called.

Fixes: 0ff3ab701963 ("serial: 8250_early: Only set divisor if valid clk & baud")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/8250/8250_early.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index ae6a256524d8..5cd8c36c8fcc 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -122,7 +122,7 @@ static void __init init_port(struct earlycon_device *device)
 	serial8250_early_out(port, UART_FCR, 0);	/* no fifo */
 	serial8250_early_out(port, UART_MCR, 0x3);	/* DTR + RTS */
 
-	if (port->uartclk && device->baud) {
+	if (port->uartclk) {
 		divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
 		c = serial8250_early_in(port, UART_LCR);
 		serial8250_early_out(port, UART_LCR, c | UART_LCR_DLAB);
-- 
2.17.0
