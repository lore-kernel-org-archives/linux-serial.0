From: Karthik Manamcheri <karthik.manamcheri@gmail.com>
Subject: [PATCH] serial: 8250: Make SERIAL8250_CONFIG_RUNTIME_UARTS work correctly
Date: Thu, 28 Mar 2013 15:20:43 -0500
Message-ID: <1364502043-13018-1-git-send-email-karthik.manamcheri@ni.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:64221 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab3C1UU6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Mar 2013 16:20:58 -0400
Received: by mail-qc0-f169.google.com with SMTP id t2so4409148qcq.14
        for <linux-serial@vger.kernel.org>; Thu, 28 Mar 2013 13:20:57 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Karthik Manamcheri <karthik.manamcheri@ni.com>

Currently, if you set SERIAL8250_CONFIG_RUNTIME_UARTS
to 0, you cannot get any working ports. This change
will enable serial8250_register_port to successfully
register a port even if SERIAL8250_CONFIG_RUNTIME_UARTS
is 0. If you need legacy ports, you will set the
SERIAL8250_CONFIG_RUNTIME_UARTS to the number of legacy
ports you need created at boot time.

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

