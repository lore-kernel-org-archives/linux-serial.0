From: Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 08/15] of_serial: support for UARTs on I/O ports
Date: Fri, 22 May 2015 16:51:07 +0100
Message-ID: <1432309875-9712-9-git-send-email-paul.burton@imgtec.com>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Paul Burton <paul.burton@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

If the address provided for the UART is of an I/O port rather than
a regular memory address, then set the port iotype appropriately and
write the address to iobase rather than mapbase.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/tty/serial/of_serial.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 137381e..ccff9ba 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -110,7 +110,12 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	port->irq = irq_of_parse_and_map(np, 0);
 	port->iotype = UPIO_MEM;
-	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
+
+	if (resource.flags & IORESOURCE_IO) {
+		port->iotype = UPIO_PORT;
+		port->iobase = port->mapbase;
+		port->mapbase = 0;
+	} else if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
 		switch (prop) {
 		case 1:
 			port->iotype = UPIO_MEM;
-- 
2.4.1
