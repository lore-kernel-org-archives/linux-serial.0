From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 5/5] serial: sirf: Use generic uart-has-rtscts DT property
Date: Fri, 22 Apr 2016 17:22:24 +0200
Message-ID: <1461338544-29568-6-git-send-email-geert+renesas@glider.be>
References: <1461338544-29568-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461338544-29568-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Convert the SiRF UART driver from using the vendor-specific
"sirf,uart-has-rtscts" to the generic "uart-has-rtscts" DT property, as
documented by the Generic Serial DT Bindings.

The old vendor-specific property is still recognized by the driver for
backwards compatibility, but deprecated.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v2:
  - No changes.

 Documentation/devicetree/bindings/serial/sirf-uart.txt | 8 ++++----
 drivers/tty/serial/sirfsoc_uart.c                      | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/sirf-uart.txt b/Documentation/devicetree/bindings/serial/sirf-uart.txt
index 67e2a0aeb0429572..1e48bbbeecc6dd27 100644
--- a/Documentation/devicetree/bindings/serial/sirf-uart.txt
+++ b/Documentation/devicetree/bindings/serial/sirf-uart.txt
@@ -9,9 +9,9 @@ Required properties:
 - clocks : Should contain uart clock number
 
 Optional properties:
-- sirf,uart-has-rtscts: we have hardware flow controller pins in hardware
-- rts-gpios: RTS pin for USP-based UART if sirf,uart-has-rtscts is true
-- cts-gpios: CTS pin for USP-based UART if sirf,uart-has-rtscts is true
+- uart-has-rtscts: we have hardware flow controller pins in hardware
+- rts-gpios: RTS pin for USP-based UART if uart-has-rtscts is true
+- cts-gpios: CTS pin for USP-based UART if uart-has-rtscts is true
 
 Example:
 
@@ -28,7 +28,7 @@ On the board-specific dts, we can put rts-gpios and cts-gpios like
 
 usp@b0090000 {
 	compatible = "sirf,prima2-usp-uart";
-	sirf,uart-has-rtscts;
+	uart-has-rtscts;
 	rts-gpios = <&gpio 15 0>;
 	cts-gpios = <&gpio 46 0>;
 };
diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 1d1c0b9857ff6900..b186c9c4f850cc16 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1293,7 +1293,8 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 	sirfport->uart_reg = (struct sirfsoc_uart_register *)match->data;
 
 	sirfport->hw_flow_ctrl =
-		of_property_read_bool(np, "sirf,uart-has-rtscts");
+		of_property_read_bool(np, "uart-has-rtscts") ||
+		of_property_read_bool(np, "sirf,uart-has-rtscts") /* deprecated */;
 	if (of_device_is_compatible(np, "sirf,prima2-uart") ||
 		of_device_is_compatible(np, "sirf,atlas7-uart"))
 		sirfport->uart_reg->uart_type = SIRF_REAL_UART;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
