From: Darren Hart <dvhart@linux.intel.com>
Subject: [PATCH 3/4] pch_uart: Add user_uartclk parameter
Date: Tue, 21 Feb 2012 17:59:32 -0800
Message-ID: <aed18117ee95e87a4663a8d1408f12625fe53d7c.1329875301.git.dvhart@linux.intel.com>
References: <26a433d1bdb5805cac69efb20d3e32dbf790339b.1329875301.git.dvhart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <26a433d1bdb5805cac69efb20d3e32dbf790339b.1329875301.git.dvhart@linux.intel.com>
In-Reply-To: <cover.1329875301.git.dvhart@linux.intel.com>
References: <cover.1329875301.git.dvhart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Darren Hart <dvhart@linux.intel.com>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Feng Tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

For cases where boards with non-default clocks are not yet added to the kernel
or when the clock varies across hardware revisions, it is useful to be
able to specify the UART clock on the kernel command line.

Add the user_uartclk parameter and prefer it, if set, to the default and
board specific UART clock settings. Specify user_uartclock on the command-line
with "pch_uart.user_uartclk=48000000".

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
CC: Tomoya MORINAGA <tomoya.rohm@gmail.com>
CC: Feng Tang <feng.tang@intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Alan Cox <alan@linux.intel.com>
CC: linux-serial@vger.kernel.org
---
 drivers/tty/serial/pch_uart.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index b070a4a..d00b75c 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -289,6 +289,7 @@ static struct pch_uart_driver_data drv_dat[] = {
 static struct eg20t_port *pch_uart_ports[PCH_UART_NR];
 #endif
 static unsigned int default_baud = 9600;
+static unsigned int user_uartclk = 0;
 static const int trigger_level_256[4] = { 1, 64, 128, 224 };
 static const int trigger_level_64[4] = { 1, 16, 32, 56 };
 static const int trigger_level_16[4] = { 1, 4, 8, 14 };
@@ -1521,7 +1522,7 @@ static int __init pch_console_setup(struct console *co, char *options)
 	if (board_name && strstr(board_name, "Fish River Island II"))
 		uartclk = FRI2_UARTCLK;
 
-	port->uartclk = uartclk;
+	port->uartclk = user_uartclk ? user_uartclk : uartclk;
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -1591,6 +1592,8 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	if (board_name && strstr(board_name, "Fish River Island II"))
 		uartclk = FRI2_UARTCLK;
 
+	uartclk = user_uartclk ? user_uartclk : uartclk;
+
 	switch (port_type) {
 	case PORT_UNKNOWN:
 		fifosize = 256; /* EG20T/ML7213: UART0 */
@@ -1803,3 +1806,4 @@ module_exit(pch_uart_module_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel EG20T PCH UART PCI Driver");
 module_param(default_baud, uint, S_IRUGO);
+module_param(user_uartclk, uint, S_IRUGO);
-- 
1.7.6.5
