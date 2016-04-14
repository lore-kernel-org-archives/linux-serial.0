From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 2/5] serial: imx: Use generic uart-has-rtscts DT property
Date: Thu, 14 Apr 2016 14:13:20 +0200
Message-ID: <1460636003-3011-3-git-send-email-geert+renesas@glider.be>
References: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460636003-3011-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Convert the Freescale IMX UART driver from using the vendor-specific
"fsl,uart-has-rtscts" to the generic "uart-has-rtscts" DT property, as
documented by the Generic Serial DT Bindings.

The old vendor-specific property is still recognized by the driver for
backwards compatibility, but deprecated.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 Documentation/devicetree/bindings/serial/fsl-imx-uart.txt | 4 ++--
 drivers/tty/serial/imx.c                                  | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
index ed94c217c98d18a6..1e82802d8e322db5 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
@@ -6,7 +6,7 @@ Required properties:
 - interrupts : Should contain uart interrupt
 
 Optional properties:
-- fsl,uart-has-rtscts : Indicate the uart has rts and cts
+- uart-has-rtscts : Indicate the uart has rts and cts
 - fsl,irda-mode : Indicate the uart supports irda mode
 - fsl,dte-mode : Indicate the uart works in DTE mode. The uart works
                   in DCE mode by default.
@@ -24,6 +24,6 @@ uart1: serial@73fbc000 {
 	compatible = "fsl,imx51-uart", "fsl,imx21-uart";
 	reg = <0x73fbc000 0x4000>;
 	interrupts = <31>;
-	fsl,uart-has-rtscts;
+	uart-has-rtscts;
 	fsl,dte-mode;
 };
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 231e7d5caf6c1845..9fc09d3de1e2428b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1927,7 +1927,8 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 	}
 	sport->port.line = ret;
 
-	if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
+	if (of_get_property(np, "uart-has-rtscts", NULL) ||
+	    of_get_property(np, "fsl,uart-has-rtscts", NULL) /* deprecated */)
 		sport->have_rtscts = 1;
 
 	if (of_get_property(np, "fsl,dte-mode", NULL))
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
