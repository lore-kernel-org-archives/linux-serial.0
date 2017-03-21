From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 08/11] dt-bindings: net: bluetooth: Add nokia-bluetooth
Date: Tue, 21 Mar 2017 23:32:13 +0100
Message-ID: <20170321223216.11733-9-sre@kernel.org>
References: <20170321223216.11733-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170321223216.11733-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add binding document for serial bluetooth chips using
Nokia H4+ protocol.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
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
