From: Darren Hart <dvhart@linux.intel.com>
Subject: [PATCH 2/4] pch_uart: Add Fish River Island II uart clock quirks
Date: Tue, 21 Feb 2012 17:59:31 -0800
Message-ID: <4982ca7a73cfe208a2a5ff0a7e0da54b99ca2d2e.1329875301.git.dvhart@linux.intel.com>
References: <26a433d1bdb5805cac69efb20d3e32dbf790339b.1329875301.git.dvhart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <26a433d1bdb5805cac69efb20d3e32dbf790339b.1329875301.git.dvhart@linux.intel.com>
In-Reply-To: <cover.1329875301.git.dvhart@linux.intel.com>
References: <cover.1329875301.git.dvhart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Darren Hart <dvhart@linux.intel.com>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Feng Tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add support for the Fish River Island II (FRI2) 64MHz UART clock following
the CM-iTC quirk handling mechanism.

Add similar UART clock quirk handling to the pch_console_setup() function
to enable kernel messages on boards with non-standard UART clocks.

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
CC: Tomoya MORINAGA <tomoya.rohm@gmail.com>
CC: Feng Tang <feng.tang@intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Alan Cox <alan@linux.intel.com>
CC: linux-serial@vger.kernel.org
---
 drivers/tty/serial/pch_uart.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index c565817..b070a4a 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -203,7 +203,9 @@ enum {
 
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
 
-#define DEFAULT_UARTCLK 1843200 /* 1.8432MHz */
+#define DEFAULT_UARTCLK  1843200 /*   1.8432 MHz */
+#define CMITC_UARTCLK  192000000 /* 192.0000 MHz */
+#define FRI2_UARTCLK    64000000 /*  64.0000 MHz */
 
 struct pch_uart_buffer {
 	unsigned char *buf;
@@ -1488,11 +1490,13 @@ pch_console_write(struct console *co, const char *s, unsigned int count)
 
 static int __init pch_console_setup(struct console *co, char *options)
 {
+	const char *board_name;
 	struct uart_port *port;
 	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
+	int uartclk;
 
 	/*
 	 * Check whether an invalid uart number has been specified, and
@@ -1506,8 +1510,18 @@ static int __init pch_console_setup(struct console *co, char *options)
 	if (!port || (!port->iobase && !port->membase))
 		return -ENODEV;
 
-	/* setup uartclock */
-	port->uartclk = DEFAULT_UARTCLK;
+	/* Setup UART clock, checking for board specific clocks. */
+	uartclk = DEFAULT_UARTCLK;
+
+	board_name = dmi_get_system_info(DMI_BOARD_NAME);
+	if (board_name && strstr(board_name, "CM-iTC"))
+		uartclk = CMITC_UARTCLK;
+
+	board_name = dmi_get_system_info(DMI_PRODUCT_NAME);
+	if (board_name && strstr(board_name, "Fish River Island II"))
+		uartclk = FRI2_UARTCLK;
+
+	port->uartclk = uartclk;
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -1566,12 +1580,16 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	if (!rxbuf)
 		goto init_port_free_txbuf;
 
+	/* Setup UART clock, checking for board specific clocks. */
 	uartclk = DEFAULT_UARTCLK;
 
-	/* quirk for CM-iTC board */
 	board_name = dmi_get_system_info(DMI_BOARD_NAME);
 	if (board_name && strstr(board_name, "CM-iTC"))
-		uartclk = 192000000; /* 192.0MHz */
+		uartclk = CMITC_UARTCLK;
+
+	board_name = dmi_get_system_info(DMI_PRODUCT_NAME);
+	if (board_name && strstr(board_name, "Fish River Island II"))
+		uartclk = FRI2_UARTCLK;
 
 	switch (port_type) {
 	case PORT_UNKNOWN:
-- 
1.7.6.5
