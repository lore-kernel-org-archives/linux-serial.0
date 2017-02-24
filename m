From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH v2 07/17] dt-bindings: serial: Document Actions Semi Owl UARTs
Date: Fri, 24 Feb 2017 04:40:45 +0100
Message-ID: <20170224034055.18807-8-afaerber@suse.de>
References: <20170224034055.18807-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170224034055.18807-1-afaerber-l3A5Bk7waGM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mp-cs-/sSyCTpAT0ql5r2w9Jh5Rg@public.gmane.org, 96boards-Ty1hIZOCd2XuufBYgWm87A@public.gmane.org, support-8Vy/tIz7429AfugRpC6u6w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This UART is found on S500 and S900 SoCs.

Signed-off-by: Andreas Färber <afaerber-l3A5Bk7waGM@public.gmane.org>
---
 v1 -> v2:
 * Adopted "actions" vendor prefix
 
 .../devicetree/bindings/serial/actions,owl-uart.txt      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/actions,owl-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/actions,owl-uart.txt b/Documentation/devicetree/bindings/serial/actions,owl-uart.txt
new file mode 100644
index 0000000..aa873ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/actions,owl-uart.txt
@@ -0,0 +1,16 @@
+Actions Semi Owl UART
+
+Required properties:
+- compatible :  "actions,s500-uart", "actions,owl-uart" for S500
+                "actions,s900-uart", "actions,owl-uart" for S900
+- reg        :  Offset and length of the register set for the device.
+- interrupts :  Should contain UART interrupt.
+
+
+Example:
+
+		uart3: serial@b0126000 {
+			compatible = "actions,s500-uart", "actions,owl-uart";
+			reg = <0xb0126000 0x1000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		};
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
