From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCHv3 09/10] dt-bindings: net: bluetooth: Add nokia-bluetooth
Date: Tue, 28 Mar 2017 17:59:38 +0200
Message-ID: <20170328155939.31566-10-sre@kernel.org>
References: <20170328155939.31566-1-sre@kernel.org>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170328155939.31566-1-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Samuel Thibault <samuel.thibault-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Add binding document for serial bluetooth chips using
Nokia H4+ protocol.

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Changes since PATCHv1:
 * change compatible strings
 * mention active high/low state for GPIOs
---
 .../devicetree/bindings/net/nokia-bluetooth.txt    | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetooth.txt

diff --git a/Documentation/devicetree/bindings/net/nokia-bluetooth.txt b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
new file mode 100644
index 000000000000..42be7dc9a70b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
@@ -0,0 +1,51 @@
+Nokia Bluetooth Chips
+---------------------
+
+Nokia phones often come with UART connected bluetooth chips from different
+vendors and modified device API. Those devices speak a protocol named H4+
+(also known as h4p) by Nokia, which is similar to the H4 protocol from the
+Bluetooth standard. In addition to the H4 protocol it specifies two more
+UART status lines for wakeup of UART transceivers to improve power management
+and a few new packet types used to negotiate uart speed.
+
+Required properties:
+
+ - compatible: should contain "nokia,h4p-bluetooth" as well as one of the following:
+   * "brcm,bcm2048-nokia"
+   * "ti,wl1271-bluetooth-nokia"
+ - reset-gpios: GPIO specifier, used to reset the BT module (active low)
+ - bluetooth-wakeup-gpios: GPIO specifier, used to wakeup the BT module (active high)
+ - host-wakeup-gpios: GPIO specifier, used to wakeup the host processor (active high)
+ - clock-names: should be "sysclk"
+ - clocks: should contain a clock specifier for every name in clock-names
+
+Optional properties:
+
+ - None
+
+Example:
+
+/ {
+       /* controlled (enabled/disabled) directly by BT module */
+       bluetooth_clk: vctcxo {
+               compatible = "fixed-clock";
+               #clock-cells = <0>;
+               clock-frequency = <38400000>;
+       };
+};
+
+&uart2 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&uart2_pins>;
+
+       bluetooth {
+               compatible = "ti,wl1271-bluetooth-nokia", "nokia,h4p-bluetooth";
+
+               reset-gpios = <&gpio1 26 GPIO_ACTIVE_LOW>; /* gpio26 */
+               host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* gpio101 */
+               bluetooth-wakeup-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* gpio37 */
+
+               clocks = <&bluetooth_clk>;
+               clock-names = "sysclk";
+       };
+};
-- 
2.11.0
