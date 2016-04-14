From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 3/5] serial: mxs-auart: Use generic uart-has-rtscts DT property
Date: Thu, 14 Apr 2016 14:13:21 +0200
Message-ID: <1460636003-3011-4-git-send-email-geert+renesas@glider.be>
References: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460636003-3011-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Convert the Freescale MXS AUART driver from using the vendor-specific
"fsl,uart-has-rtscts" to the generic "uart-has-rtscts" DT property, as
documented by the Generic Serial DT Bindings.

The old vendor-specific property is still recognized by the driver for
backwards compatibility, but it is deprecated.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt | 2 +-
 drivers/tty/serial/mxs-auart.c                             | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
index 7c408c87e6138979..9ba60c14047a0be8 100644
--- a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
@@ -11,7 +11,7 @@ Required properties:
 - dma-names: "rx" for RX channel, "tx" for TX channel.
 
 Optional properties:
-- fsl,uart-has-rtscts : Indicate the UART has RTS and CTS lines
+- uart-has-rtscts : Indicate the UART has RTS and CTS lines
   for hardware flow control,
 	it also means you enable the DMA support for this UART.
 - {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index cd0414bbe094898e..c988544f38bbb885 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1185,7 +1185,8 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 	}
 	s->port.line = ret;
 
-	if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
+	if (of_get_property(np, "uart-has-rtscts", NULL) ||
+	    of_get_property(np, "fsl,uart-has-rtscts", NULL) /* deprecated */)
 		set_bit(MXS_AUART_RTSCTS, &s->flags);
 
 	return 0;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
