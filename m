From: Karthik Manamcheri <karthik.manamcheri@gmail.com>
Subject: [PATCH] serial: 8250: Make SERIAL_8250_RUNTIME_UARTS work correctly
Date: Thu, 28 Mar 2013 17:33:20 -0500
Message-ID: <1364510000-1261-1-git-send-email-karthik.manamcheri@ni.com>
References: <1364501015-12785-1-git-send-email-karthik.manamcheri@ni.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:60280 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab3C1Wdi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Mar 2013 18:33:38 -0400
Received: by mail-qc0-f172.google.com with SMTP id b25so15140qca.3
        for <linux-serial@vger.kernel.org>; Thu, 28 Mar 2013 15:33:37 -0700 (PDT)
In-Reply-To: <1364501015-12785-1-git-send-email-karthik.manamcheri@ni.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Karthik Manamcheri <karthik.manamcheri@ni.com>

Consider a situation where I have an ARM based system
and therefore no legacy ports. Say, I have two
memory-mapped ports. I use device tree to describe the
ports. What would be the config options I set so that
I get only the two ports in my system? I do not want
legacy ports being created automatically and I want
it to be flexible enough that it creates the devices
based only on the device tree. I expected setting
SERIAL_8250_RUNTIME_UARTS = 0 to work because the
description said, "Set this to the maximum number of
serial ports you want the kernel to register at boot
time." Unfortunately, even though SERIAL_8250_NR_UARTS
was set to the default value of 4, I did not get any device
nodes (because SERIAL_8250_RUNTIME_UARTS was 0). This
is what this change is addressing.

SERIAL_8250_NR_UARTS controls the maximum number of ports
you can support. SERIAL_8250_RUNTIME_UARTS specifies the
number of ports you want to create automatically for legacy
ports at boot time. All other ports will be created
when serial8250_register_port is called (and if does not exceed
the total number of supported ports as specified by
SERIAL_8250_NR_UARTS).

Signed-off-by: Karthik Manamcheri <karthik.manamcheri@ni.com>
---
 drivers/tty/serial/8250/8250.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index cf6a538..65f1478 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -2755,7 +2755,7 @@ static void __init serial8250_isa_init_ports(void)
 	if (nr_uarts > UART_NR)
 		nr_uarts = UART_NR;
 
-	for (i = 0; i < nr_uarts; i++) {
+	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 		struct uart_port *port = &up->port;
 
@@ -2916,7 +2916,7 @@ static int __init serial8250_console_setup(struct console *co, char *options)
 	 * if so, search for the first available port that does have
 	 * console support.
 	 */
-	if (co->index >= nr_uarts)
+	if (co->index >= UART_NR)
 		co->index = 0;
 	port = &serial8250_ports[co->index].port;
 	if (!port->iobase && !port->membase)
@@ -2957,7 +2957,7 @@ int serial8250_find_port(struct uart_port *p)
 	int line;
 	struct uart_port *port;
 
-	for (line = 0; line < nr_uarts; line++) {
+	for (line = 0; line < UART_NR; line++) {
 		port = &serial8250_ports[line].port;
 		if (uart_match_port(p, port))
 			return line;
@@ -3110,7 +3110,7 @@ static int serial8250_remove(struct platform_device *dev)
 {
 	int i;
 
-	for (i = 0; i < nr_uarts; i++) {
+	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
 		if (up->port.dev == &dev->dev)
@@ -3178,7 +3178,7 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
 	/*
 	 * First, find a port entry which matches.
 	 */
-	for (i = 0; i < nr_uarts; i++)
+	for (i = 0; i < UART_NR; i++)
 		if (uart_match_port(&serial8250_ports[i].port, port))
 			return &serial8250_ports[i];
 
@@ -3187,7 +3187,7 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
 	 * free entry.  We look for one which hasn't been previously
 	 * used (indicated by zero iobase).
 	 */
-	for (i = 0; i < nr_uarts; i++)
+	for (i = 0; i < UART_NR; i++)
 		if (serial8250_ports[i].port.type == PORT_UNKNOWN &&
 		    serial8250_ports[i].port.iobase == 0)
 			return &serial8250_ports[i];
@@ -3196,7 +3196,7 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
 	 * That also failed.  Last resort is to find any entry which
 	 * doesn't have a real port associated with it.
 	 */
-	for (i = 0; i < nr_uarts; i++)
+	for (i = 0; i < UART_NR; i++)
 		if (serial8250_ports[i].port.type == PORT_UNKNOWN)
 			return &serial8250_ports[i];
 
-- 
1.8.1.4

