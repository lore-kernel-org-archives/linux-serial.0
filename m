From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 7/7] ARM: meson: update documentation (uart, timer and vendors)
Date: Sun, 17 Aug 2014 12:49:54 +0200
Message-ID: <1408272594-10814-8-git-send-email-carlo@caione.org>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1408272594-10814-1-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

New UART and timer bindings are documented. A new vendor is added to the
vendors list.

Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/serial/amlogic,meson-uart.txt   | 17 +++++++++++++++++
 .../devicetree/bindings/timer/amlogic,meson6-timer.txt  | 16 ++++++++++++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt   |  1 +
 3 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
 create mode 100644 Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
new file mode 100644
index 0000000..fa1935a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
@@ -0,0 +1,17 @@
+Amlogic Meson UART
+
+Required properties:
+- compatible : Should be "amlogic,meson-uart"
+- reg : Address and length of the register set
+- interrupts : Should contain uart interrupt
+- clocks: phandle to the source clock
+
+Example:
+
+uart0: serial@c81004c0 {
+	compatible = "amlogic,meson-uart";
+	reg = <0xc81004c0 0x14>;
+	interrupts = <0 90 1>;
+	clocks = <&clk81>;
+};
+
diff --git a/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt b/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
new file mode 100644
index 0000000..cf89894
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
@@ -0,0 +1,16 @@
+Amlogic Meson6 SoCs Timer Controller
+
+Required properties:
+
+- compatible : should be "amlogic,meson6-timer.txt"
+- reg : Specifies base physical address and size of the registers.
+- interrupts : The interrupt of the first timer
+
+Example:
+
+timer@c1109940 {
+	compatible = "amlogic,meson6-timer";
+	reg = <0xc1109940 0x14>;
+	interrupts = <0 10 1>;
+};
+
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ac7269f..5cf0618 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -14,6 +14,7 @@ allwinner	Allwinner Technology Co., Ltd.
 altr	Altera Corp.
 amcc	Applied Micro Circuits Corporation (APM, formally AMCC)
 amd	Advanced Micro Devices (AMD), Inc.
+amlogic	Amlogic, Inc.
 ams	AMS AG
 amstaos	AMS-Taos Inc.
 apm	Applied Micro Circuits Corporation (APM)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
