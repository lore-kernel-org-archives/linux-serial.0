From: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: [PATCHv2 2/4] serial: 8250: of: Load TX FIFO Threshold from DT
Date: Thu, 22 Sep 2016 14:56:15 -0500
Message-ID: <1474574177-4984-3-git-send-email-tthayer@opensource.altera.com>
References: <1474574177-4984-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1474574177-4984-1-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, anton.wuerfel-d40JDW7QUjc@public.gmane.org, phillip.raffeck-d40JDW7QUjc@public.gmane.org, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org
Cc: peter.ujfalusi-l0cyMroinI0@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, dongsheng.wang-3arQi8VN3Tc@public.gmane.org, luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>

Initialize the tx_loadsz parameter from passed in devicetree
tx-threshold parameter.
The tx_loadsz is calculated as the number of bytes to fill FIFO
when tx-threshold is triggered.

Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
---
v2  Change from reading tx-loadsz parameter to reading
    tx-threshold and calculating tx_loadsz.
---
 drivers/tty/serial/8250/8250_of.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 38963d7..7a8b5fc 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -195,6 +195,7 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	switch (port_type) {
 	case PORT_8250 ... PORT_MAX_8250:
 	{
+		u32 tx_threshold;
 		struct uart_8250_port port8250;
 		memset(&port8250, 0, sizeof(port8250));
 		port8250.port = port;
@@ -202,6 +203,12 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 		if (port.fifosize)
 			port8250.capabilities = UART_CAP_FIFO;
 
+		/* Check for TX FIFO threshold & set tx_loadsz */
+		if ((of_property_read_u32(ofdev->dev.of_node, "tx-threshold",
+					  &tx_threshold) == 0) &&
+		    (tx_threshold < port.fifosize))
+			port8250.tx_loadsz = port.fifosize - tx_threshold;
+
 		if (of_property_read_bool(ofdev->dev.of_node,
 					  "auto-flow-control"))
 			port8250.capabilities |= UART_CAP_AFE;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
