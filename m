From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 33/36] Allow port type to specify bugs that are not probed for.
Date: Mon, 27 Oct 2008 17:04:10 -0700
Message-ID: <1225152251-3367-4-git-send-email-ddaney@caviumnetworks.com>
References: <490655B6.4030406@caviumnetworks.com>
 <1225152251-3367-1-git-send-email-ddaney@caviumnetworks.com>
 <1225152251-3367-2-git-send-email-ddaney@caviumnetworks.com>
 <1225152251-3367-3-git-send-email-ddaney@caviumnetworks.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5558 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbYJ1AFK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Oct 2008 20:05:10 -0400
In-Reply-To: <1225152251-3367-3-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, akpm@linux-foundation.org, David Daney <ddaney@caviumnetworks.com>

Add a bugs field to the serial8250_config and propagate it to the
port's bugs field when the port is registered and configured.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/serial/8250.c |    2 ++
 drivers/serial/8250.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 9d16abb..474ab89 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1212,6 +1212,7 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 	up->port.fifosize = uart_config[up->port.type].fifo_size;
 	up->capabilities = uart_config[up->port.type].flags;
 	up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
+	up->bugs |= uart_config[up->port.type].bugs;
 
 	if (up->port.type == PORT_UNKNOWN)
 		goto out;
@@ -3062,6 +3063,7 @@ int serial8250_register_port(struct uart_port *port)
 			uart->port.fifosize = uart_config[port->type].fifo_size;
 			uart->capabilities = uart_config[port->type].flags;
 			uart->tx_loadsz = uart_config[port->type].tx_loadsz;
+			uart->bugs = uart_config[port->type].bugs;
 		}
 
 		set_io_fns_from_upio(&uart->port);
diff --git a/drivers/serial/8250.h b/drivers/serial/8250.h
index 5202603..c9b3002 100644
--- a/drivers/serial/8250.h
+++ b/drivers/serial/8250.h
@@ -34,6 +34,7 @@ struct serial8250_config {
 	const char	*name;
 	unsigned short	fifo_size;
 	unsigned short	tx_loadsz;
+	unsigned short	bugs;
 	unsigned char	fcr;
 	unsigned int	flags;
 };
-- 
1.5.6.5

