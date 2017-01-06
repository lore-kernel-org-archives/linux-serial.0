From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 6/9] dt/bindings: Add a serial/UART attached device binding
Date: Fri,  6 Jan 2017 10:26:32 -0600
Message-ID: <20170106162635.19677-7-robh@kernel.org>
References: <20170106162635.19677-1-robh@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170106162635.19677-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Add a common binding for describing serial/UART attached devices. Common
examples are Bluetooth, WiFi, NFC and GPS devices.

Serial attached devices are represented as child nodes of a UART node.
This may need to be extended for more complex devices with multiple
interfaces, but for the simple cases a child node is sufficient.

Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/serial/slave-device.txt    | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/slave-device.txt

diff --git a/Documentation/devicetree/bindings/serial/slave-device.txt b/Documentation/devicetree/bindings/serial/slave-device.txt
new file mode 100644
index 000000000000..9b7c2d651345
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/slave-device.txt
@@ -0,0 +1,34 @@
+Serial Slave Device DT binding
+
+This documents the binding structure and common properties for serial
+attached devices. Common examples include Bluetooth, WiFi, NFC and GPS
+devices.
+
+qSerial attached devices shall be a child node of the host UART device the
+slave device is attached to. It is expected that the attached device is
+the only child node of the UART device. The slave device node name shall
+reflect the generic type of device for the node.
+
+Required Properties:
+
+- compatible 	: A string reflecting the vendor and specific device the node
+		  represents.
+
+Optional Properties:
+
+- reg		: A single cell representing the port/line number of the
+		  host UART. Only used if the host UART is a single node
+		  with multiple ports.
+
+Example:
+
+serial@1234 {
+	compatible = "ns16550a";
+	interrupts = <1>;
+
+	bluetooth {
+		compatible = "brcm,bcm43341-bt";
+		interrupt-parent = <&gpio>;
+		interrupts = <10>;
+	};
+};
--
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
