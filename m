From: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
Subject: [PATCHv3 2/2] tty: of_serial: support for 32 bit accesses
Date: Mon, 27 Jun 2011 13:32:34 +0100
Message-ID: <1309177954-8786-2-git-send-email-jamie@jamieiles.com>
References: <1309177954-8786-1-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1309177954-8786-1-git-send-email-jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Some platforms e.g. TI Davinci require 32-bit accesses to the UARTs.
The of_serial driver currently registers all UARTs as UPIO_MEM.  Add a
new attribute "io-width" to allow the port to be registered with
different IO width requirements.

Acked-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Signed-off-by: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
---
 .../devicetree/bindings/tty/serial/of-serial.txt   |    3 +++
 drivers/tty/serial/of_serial.c                     |   17 +++++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/of-serial.txt b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
index 35e53ae..93260d0 100644
--- a/Documentation/devicetree/bindings/tty/serial/of-serial.txt
+++ b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
@@ -21,6 +21,9 @@ Optional properties:
 - reg-shift : quantity to shift the register offsets by.
 - used-by-rtas : set to indicate that the port is in use by the OpenFirmware
   RTAS and should not be registered.
+- io-width : the size (in bytes) of the IO accesses that should be performed
+  on the device.  There are some systems that require 32-bit accesses to the
+  UART (e.g. TI davinci).
 
 Example:
 
diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index c911b24..dfcad6f 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -65,6 +65,23 @@ static int __devinit of_platform_serial_setup(struct platform_device *ofdev,
 
 	port->irq = irq_of_parse_and_map(np, 0);
 	port->iotype = UPIO_MEM;
+	prop = of_get_property(np, "io-width", &prop_size);
+	if (prop && (prop_size == sizeof(u32))) {
+		switch (be32_to_cpup(prop)) {
+		case 1:
+			port->iotype = UPIO_MEM;
+			break;
+		case 4:
+			port->iotype = UPIO_MEM32;
+			break;
+		default:
+			dev_warn(&ofdev->dev,
+				 "unsupported io width (%d bytes)\n",
+				 be32_to_cpup(prop));
+			return -EINVAL;
+		}
+	}
+
 	port->type = type;
 	port->uartclk = be32_to_cpup(clk);
 	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
-- 
1.7.4.1
