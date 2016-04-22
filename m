From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 0/5] serial: Add Generic Serial Device Tree Bindings
Date: Fri, 22 Apr 2016 17:22:19 +0200
Message-ID: <1461338544-29568-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

	Hi Greg, Jiri,

This patch series, against next-20160422, introduces Generic Serial
Device Tree Bindings, and converts drivers using vendor-specific DT
properties to the generic properies where appropriate.

The Generic Serial Device Tree Bindings document a set of generic
properties for describing UARTs in a device tree:
  1. The GPIO modem control properties are currently duplicated across
     hardware-specific binding documentation,
  2. The property for dedicated RTS/CTS hardware flow control lines is
     already supported by several drivers, albeit with a vendor-specific
     prefix, hence make it generic.
Whether these generic properties apply to a particular device still
depends on the DT bindings of the actual device.

The old (deprecated) vendor-specific properties are still supported by
the drivers for backwards compatibility.

Changes compared to v1:
  - Add Acked-by,
  - Drop out[12]-gpios from the bindings (a patch to drop it from the
    code has been submitted separately).

I will sent out patches to update the actual DTS files later, after this
series has been integrated into mainline.  DTS updates typically go
through a different path (e.g. arm-soc), and RTS/CTS support would be
broken if the DTSes would be updated before the drivers.

Thanks for applying!

Geert Uytterhoeven (5):
  doc: DT: Add Generic Serial Device Tree Bindings
  serial: imx: Use generic uart-has-rtscts DT property
  serial: mxs-auart: Use generic uart-has-rtscts DT property
  serial: sirf: Introduce helper variable struct device_node *np
  serial: sirf: Use generic uart-has-rtscts DT property

 .../devicetree/bindings/serial/fsl-imx-uart.txt    |  4 +-
 .../devicetree/bindings/serial/fsl-mxs-auart.txt   |  2 +-
 .../devicetree/bindings/serial/serial.txt          | 57 ++++++++++++++++++++++
 .../devicetree/bindings/serial/sirf-uart.txt       |  8 +--
 drivers/tty/serial/imx.c                           |  3 +-
 drivers/tty/serial/mxs-auart.c                     |  3 +-
 drivers/tty/serial/sirfsoc_uart.c                  | 39 ++++++++-------
 7 files changed, 87 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/serial.txt

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
