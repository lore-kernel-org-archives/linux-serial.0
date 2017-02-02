From: Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/5] dt/bindings: Add a serial/UART attached device binding
Date: Thu,  2 Feb 2017 13:48:06 -0600
Message-ID: <20170202194809.18274-3-robh@kernel.org>
References: <20170202194809.18274-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170202194809.18274-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add a common binding for describing serial/UART attached devices. Common
examples are Bluetooth, WiFi, NFC and GPS devices.

Serial attached devices are represented as child nodes of a UART node.
This may need to be extended for more complex devices with multiple
interfaces, but for the simple cases a child node is sufficient.

Tested-By: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v4:
- no change
v3:
- no change

v2:
- Drop reg property
- Add max-speed property

 .../devicetree/bindings/serial/slave-device.txt    | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/slave-device.txt

diff --git a/Documentation/devicetree/bindings/serial/slave-device.txt b/Documentation/devicetree/bindings/serial/slave-device.txt
new file mode 100644
index 000000000000..f66037928f5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/slave-device.txt
@@ -0,0 +1,36 @@
+Serial Slave Device DT binding
+
+This documents the binding structure and common properties for serial
+attached devices. Common examples include Bluetooth, WiFi, NFC and GPS
+devices.
+
+Serial attached devices shall be a child node of the host UART device the
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
+- max-speed	: The maximum baud rate the device operates at. This should
+		  only be present if the maximum is less than the slave device
+		  can support. For example, a particular board has some signal
+		  quality issue or the host processor can't support higher
+		  baud rates.
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
