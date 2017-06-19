From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH v5 07/26] dt-bindings: serial: Document Actions Semi Owl UARTs
Date: Mon, 19 Jun 2017 03:46:39 +0200
Message-ID: <20170619014640.6829-1-afaerber@suse.de>
References: <7fff8813-cea4-0530-bf7b-3d0ad50d6e93@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7fff8813-cea4-0530-bf7b-3d0ad50d6e93-l3A5Bk7waGM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mp-cs-/sSyCTpAT0ql5r2w9Jh5Rg@public.gmane.org, Thomas Liau <thomas.liau-/sSyCTpAT0ql5r2w9Jh5Rg@public.gmane.org>, =?UTF-8?q?=E5=BC=A0=E4=B8=9C=E9=A3=8E?= <zhangdf-/sSyCTpAT0ql5r2w9Jh5Rg@public.gmane.org>, =?UTF-8?q?=E5=88=98=E7=82=9C?= <liuwei-/sSyCTpAT0ql5r2w9Jh5Rg@public.gmane.org>, =?UTF-8?q?=E5=BC=A0=E5=A4=A9=E7=9B=8A?= <tyzhang-/sSyCTpAT0ql5r2w9Jh5Rg@public.gmane.org>, 96boards-Ty1hIZOCd2XuufBYgWm87A@public.gmane.org, support-8Vy/tIz7429AfugRpC6u6w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This UART is found on S500 and S900 SoCs.

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Andreas Färber <afaerber-l3A5Bk7waGM@public.gmane.org>
---
 v2 -> v3 -> v4 -> v5: Unchanged
 
 v1 -> v2:
 * Adopted "actions" vendor prefix
 
 .../devicetree/bindings/serial/actions,owl-uart.txt      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/actions,owl-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/actions,owl-uart.txt b/Documentation/devicetree/bindings/serial/actions,owl-uart.txt
new file mode 100644
index 000000000000..aa873eada02d
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
2.12.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
