From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 -next 07/13] serial: 8250_early: Assume uart already initialized if no baud option
Date: Sun,  1 Mar 2015 11:05:52 -0500
Message-ID: <1425225958-17908-8-git-send-email-peter@hurleysoftware.com>
References: <1425225958-17908-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425225958-17908-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The <baud><parity><bit> option string is not supplied if the earlycon
is started via devicetree and OF_EARLYCON_DECLARE(). The option string
is also not required if started via kernel command line parameters of
the form:
  earlycon=uart,mmio,<addr>
  console=uart,mmio,<addr>

If earlycon_device->baud is 0, then an option string was not supplied.
In this case, assume the uart has already been initialized by the
bootloader or firmware.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_early.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index d7b831b..1701d00 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -149,12 +149,18 @@ static int __init early_serial8250_setup(struct earlycon_device *device,
 		return 0;
 
 	if (!device->baud) {
+		struct uart_port *port = &device->port;
+		unsigned int ier;
+
 		device->baud = probe_baud(&device->port);
 		snprintf(device->options, sizeof(device->options), "%u",
 			 device->baud);
-	}
 
-	init_port(device);
+		/* assume the device was initialized, only mask interrupts */
+		ier = serial8250_early_in(port, UART_IER);
+		serial8250_early_out(port, UART_IER, ier & UART_IER_UUE);
+	} else
+		init_port(device);
 
 	device->con->write = early_serial8250_write;
 	return 0;
-- 
2.3.0
