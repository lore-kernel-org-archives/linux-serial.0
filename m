From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [RFC v1 8/8] dt-bindings: net: bluetooth: add support for Realtek Bluetooth chips
Date: Fri, 17 Nov 2017 23:35:43 +0100
Message-ID: <20171117223543.32429-9-martin.blumenstingl@googlemail.com>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171117223543.32429-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

This adds the documentation for Bluetooth functionality of the Realtek
RTL8723BS and RTL8723DS.
Both are SDIO wifi chips with an additional Bluetooth module which is
connected via UART to the host.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 .../devicetree/bindings/net/realtek-bluetooth.txt  | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt

diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
new file mode 100644
index 000000000000..c919e06469f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.txt
@@ -0,0 +1,31 @@
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
+- disable-gpios: GPIO specifier, used to enable/disable the BT module
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
+		disable-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
+	};
+};
-- 
2.15.0
