From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFT PATCH 2/2] serial: pnx8xxx: Fix coding style
Date: Tue, 31 May 2016 16:19:32 +0200
Message-ID: <1464704372-17668-2-git-send-email-k.kozlowski@samsung.com>
References: <1464704372-17668-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-reply-to: <1464704372-17668-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Tobias Klauser <tklauser@distanz.ch>, Russell King <linux@armlinux.org.uk>, Nicolas Ferre <nicolas.ferre@atmel.com>, Sonic Zhang <sonic.zhang@analog.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Barry Song <baohua@kernel.org>, "David S. Miller" <davem@davemloft.net>, Tony Prisk <linux@prisktech.co.nz>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, nios2-dev@lists.rocketboards.org, adi-buildroo
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-serial@vger.kernel.org

Definition of function should start from new line.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/tty/serial/pnx8xxx_uart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pnx8xxx_uart.c b/drivers/tty/serial/pnx8xxx_uart.c
index 84c4efdde8dc..9eaedd6a049e 100644
--- a/drivers/tty/serial/pnx8xxx_uart.c
+++ b/drivers/tty/serial/pnx8xxx_uart.c
@@ -690,7 +690,8 @@ static void pnx8xxx_console_putchar(struct uart_port *port, int ch)
 
 /*
  * Interrupts are disabled on entering
- */static void
+ */
+static void
 pnx8xxx_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct pnx8xxx_port *sport = &pnx8xxx_ports[co->index];
-- 
1.9.1
