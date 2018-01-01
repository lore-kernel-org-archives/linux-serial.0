From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [RFC v2 2/9] dt-bindings: net: bluetooth: add support for Realtek Bluetooth chips
Date: Mon,  1 Jan 2018 21:42:10 +0100
Message-ID: <20180101204217.26165-3-martin.blumenstingl@googlemail.com>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180101204217.26165-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org, carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

This adds the documentation for Bluetooth functionality of the Realtek
RTL8723BS and RTL8723DS.
Both are SDIO wifi chips with an additional Bluetooth module which is
connected via UART to the host.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 .../devicetree/bindings/net/realtek-bluetooth.txt  | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt

diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
new file mode 100644
index 000000000000..1491329c4cd1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
@@ -0,0 +1,41 @@
+Realtek Bluetooth Chips
+-----------------------
+
+This documents the binding structure and common properties for serial
+attached Realtek devices.
+
+Serial attached Realtek devices shall be a child node of the host UART
+device the slave device is attached to. See ../serial/slave-device.txt
+for more information
+
+Required properties:
+- compatible: should contain one of the following:
+    * "realtek,rtl8723bs-bluetooth"
+    * "realtek,rtl8723ds-bluetooth"
+
+Optional properties:
+- realtek,config-data: Bluetooth chipset configuration data which is
+			needed for communication (it typically contains
+			board specific settings like the baudrate and
+			whether flow-control is used).
+			This is an array of u8 values.
+- enable-gpios: GPIO specifier, used to enable/disable the BT module
+- reset-gpios: GPIO specifier, used to reset the BT module
+
+
+Example:
+
+&uart {
+	...
+
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bluetooth";
+		enable-gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
+		realtek,config-data = /bits/ 8 <
+			0x55 0xab 0x23 0x87 0x29 0x00 0xf4 0x00 0x01 0x01 0xf6 0x00
+			0x02 0x81 0x00 0xfa 0x00 0x02 0x12 0x80 0x0c 0x00 0x10 0x02
+			0x80 0x92 0x04 0x50 0xc5 0xea 0x19 0xe1 0x1b 0xfd 0xaf 0x5f
+			0x01 0xa4 0x0b 0xd9 0x00 0x01 0x0f 0xe4 0x00 0x01 0x08>;
+	};
+};
-- 
2.15.1
