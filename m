From: Mao Wenan <maowenan@huawei.com>
Subject: [PATCH linux-next] tty: serial: add dependence for CONFIG_SERIAL_FSL_LINFLEXUART
Date: Tue, 20 Aug 2019 20:40:15 +0800
Message-ID: <20190820124015.28409-1-maowenan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Mao Wenan <maowenan@huawei.com>
List-Id: linux-serial@vger.kernel.org

When CONFIG_SERIAL_FSL_LINFLEXUART=y and CONFIG_PRINTK is not set,
one compilation error is found as below:
drivers/tty/serial/fsl_linflexuart.c: In function linflex_earlycon_putchar:
drivers/tty/serial/fsl_linflexuart.c:608:31: error: CONFIG_LOG_BUF_SHIFT undeclared
(first use in this function); did you mean CONFIG_ISA_BUS_API?
  if (earlycon_buf.len >= 1 << CONFIG_LOG_BUF_SHIFT)
                               ^~~~~~~~~~~~~~~~~~~~
                               CONFIG_ISA_BUS_API
This because CONFIG_LOG_BUF_SHIFT is depended on CONFIG_PRINTK, fix this
by adding dependence for CONFIG_SERIAL_FSL_LINFLEXUART.

Fixes: b953815b819b ("tty: serial: Add linflexuart driver for S32V234")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index d9caf3242b25..4789b5d62f63 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1392,6 +1392,7 @@ config SERIAL_FSL_LPUART_CONSOLE
 
 config SERIAL_FSL_LINFLEXUART
 	tristate "Freescale linflexuart serial port support"
+	depends on PRINTK
 	select SERIAL_CORE
 	help
 	  Support for the on-chip linflexuart on some Freescale SOCs.
-- 
2.20.1
