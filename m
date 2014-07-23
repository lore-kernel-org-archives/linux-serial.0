From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v5 0/2] serial: 8250_dw: optional reset control and deferred probe support
Date: Wed, 23 Jul 2014 23:33:05 +0800
Message-ID: <1406129587-24668-1-git-send-email-wens@csie.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Greg,

This series adds optional reset control and deferred probing support
to 8250_dw. These are required to support the UARTs on sun6i/sun8i.
They were originally part of my sun8i PRCM series. The other parts
of that series have been merged already. It would be really nice
if we could get these 2 in as well.

Patch 1 adds optional reset control support to the 8250_dw, which
is used by sun6i and sun8i platforms. Till now, this wasn't needed
from a working standpoint, as the bootloader de-asserts the reset
control on the console UART for us. However, during the development
of the sun8i patches, I noticed other UARTs wouldn't work. Also the
new sun6i A31 Hummingbird has multiple UARTs available, which would
require this patch.

Patch 2 adds deferred probing to 8250_dw. In my case, even though
the clocks and reset controller "devices" were registered before
the UART, the 8250_dw driver binded with the UART devices before
the clocks and resets were available. This resulted in the 8250_dw
driver failing. I only tested the R_UART device.

Patch 2 also does proper cleanup in the event that probing failed.

Maxime, I dropped your Acked-by because I added the cleanup code
path.

Changes since v4:
  - Rebased onto tty-next (4847914)
  - Do proper cleanup in the probe function if errors are encountered.

No changes before v4.


Cheers
ChenYu


Chen-Yu Tsai (2):
  serial: 8250_dw: Add optional reset control support
  serial: 8250_dw: Add support for deferred probing

 .../bindings/serial/snps-dw-apb-uart.txt           |  1 +
 drivers/tty/serial/8250/8250_dw.c                  | 50 +++++++++++++++++++---
 2 files changed, 44 insertions(+), 7 deletions(-)

-- 
2.0.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
