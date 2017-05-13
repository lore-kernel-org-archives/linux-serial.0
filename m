From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/8] serial: exar: Preconfigure xr17v35x MPIOs as output
Date: Sat, 13 May 2017 09:28:59 +0200
Message-ID: <6155891d19531be018d30fd55ffd6d42493af8c1.1494660546.git.jan.kiszka@siemens.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1494660546.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1494660546.git.jan.kiszka@siemens.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

This is the safe default for GPIOs with unknown external wiring.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tty/serial/8250/8250_exar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 1270ff163f63..b4fa585156c7 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -177,13 +177,13 @@ static void setup_gpio(u8 __iomem *p)
 	writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
 	writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
 	writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
-	writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
+	writeb(0xff, p + UART_EXAR_MPIOSEL_7_0);
 	writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
 	writeb(0x00, p + UART_EXAR_MPIOINT_15_8);
 	writeb(0x00, p + UART_EXAR_MPIOLVL_15_8);
 	writeb(0x00, p + UART_EXAR_MPIO3T_15_8);
 	writeb(0x00, p + UART_EXAR_MPIOINV_15_8);
-	writeb(0x00, p + UART_EXAR_MPIOSEL_15_8);
+	writeb(0xff, p + UART_EXAR_MPIOSEL_15_8);
 	writeb(0x00, p + UART_EXAR_MPIOOD_15_8);
 }
 
-- 
2.12.0
