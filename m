From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V2 1/2] dt/bindings: serial: bcm2835: add binding documentation for bcm2835-aux-uart
Date: Sat,  9 Jan 2016 13:07:32 +0000
Message-ID: <1452344854-2576-2-git-send-email-kernel@martin.sperl.org>
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452344854-2576-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Add binding documentation for the bcm2835-aux-uart driver.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 .../bindings/serial/brcm,bcm2835-aux-uart.txt        |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt
new file mode 100644
index 0000000..2defe5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt
@@ -0,0 +1,18 @@
+* BCM2835 AUXILIAR UART
+
+Required properties:
+
+- compatible: "brcm,bcm2835-aux-uart"
+- reg: The base address of the UART register bank.
+- interrupts: A single interrupt specifier.
+- clocks: Clock driving the hardware; used to figure out the baud rate
+  divisor.
+
+Example:
+
+	uart1: uart@7e215040 {
+		compatible = "brcm,bcm2835-aux-uart";
+		reg = <0x7e215040 0x40>;
+		interrupts = <1 29>;
+		clocks = <&aux BCM2835_AUX_CLOCK_UART>;
+	};
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
