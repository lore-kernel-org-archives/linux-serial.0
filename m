From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: [RFC 2/2] serial: 8250: Add OF alias support
Date: Tue,  8 Nov 2011 14:35:07 +0100
Message-ID: <1320759307-24877-3-git-send-email-monstr@monstr.eu>
References: <1320759307-24877-1-git-send-email-monstr@monstr.eu>
 <1320759307-24877-2-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1320759307-24877-2-git-send-email-monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michal.simek-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, john.williams-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Follow alias number for OF driven boards.
For example:
	aliases {
		serial2 = &RS232_Uart_1;
	} ;

Setup port->line number in of_platform_serial_probe from alias node.

Fixing serial8250_find_match_or_unused function is more complicated
because it is key function which check which port is available.

This was probably done for any ancient ISA support where all ports are
registered first in serial8250_register_ports (serial8250_isa_init_ports).
and then, if they are usused, unregistered and registered with
proper setting. Not sure if this is needed.

If port entry matches, it is used. If not, code looks first at entry
at port->line number to be able to assign ttySX number according
port->line setup from of_platform_serial_probe. If this port is used
code looks for the first free entry as before.

The only one change is to check entry on port->line first.

This patch requires more testing because there are several usage of
standard 8250 compatible driver.

Signed-off-by: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
---
 drivers/tty/serial/8250.c      |    7 +++++++
 drivers/tty/serial/of_serial.c |   15 +++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 7f50999..ade3c77 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -3212,6 +3212,13 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
 		if (uart_match_port(&serial8250_ports[i].port, port))
 			return &serial8250_ports[i];
 
+	/* Look at setup port->line port first. If is available, use it */
+	if (port->line >= 0 && port->line < nr_uarts)
+		if (serial8250_ports[port->line].port.type == PORT_UNKNOWN &&
+		    serial8250_ports[port->line].port.iobase == 0) {
+			return &serial8250_ports[port->line];
+		}
+
 	/*
 	 * We didn't find a matching entry, so look for the first
 	 * free entry.  We look for one which hasn't been previously
diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 24aa67c..486f2bd 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -98,6 +98,7 @@ static int __devinit of_platform_serial_probe(struct platform_device *ofdev)
 	struct uart_port port;
 	int port_type;
 	int ret;
+	int id;
 
 	match = of_match_device(of_platform_serial_table, &ofdev->dev);
 	if (!match)
@@ -115,6 +116,20 @@ static int __devinit of_platform_serial_probe(struct platform_device *ofdev)
 	if (ret)
 		goto out;
 
+	id = of_alias_get_id(ofdev->dev.of_node, "serial");
+	if (id < 0) {
+		dev_warn(&ofdev->dev, "FAILED to find out alias id\n");
+	} else {
+		if (id < CONFIG_SERIAL_8250_RUNTIME_UARTS)
+			port.line = id;
+		else {
+			dev_warn(&ofdev->dev,
+				"FAILED to register serial driver with id %d\n",
+									id);
+			goto out;
+		}
+	}
+
 	switch (port_type) {
 #ifdef CONFIG_SERIAL_8250
 	case PORT_8250 ... PORT_MAX_8250:
-- 
1.7.5.4
