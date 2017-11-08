From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 0/5] rs485 properties: platform agnosticism + RTS polarity
Date: Wed, 8 Nov 2017 11:32:34 +0100
Message-ID: <cover.1510134353.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Jackson <mpfj-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>, Michal Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Rework the common helper function for retrieving rs485 properties
to be platform agnostic (patch [1/5]) and to allow specifying the
RTS polarity (patch [2/5] and [3/5]).

Amend the fsl_lpuart and imx drivers to take advantage of this
and fix a bunch of bugs while at it (patch [4/5] and [5/5]).

Note that Michal Oleszczyk posted a patch yesterday which documents
the "rs485-rts-active-high" property supported by omap-serial in a
way which suggests that *all* drivers default to active low, which
is not the case (all other drivers default to active high).
I think the present series is a better approach, but let's have a
technical discussion about that.

I posted an earlier version of patch [1/5] a while back but withdrew
it because I wanted to change uart_get_rs485_mode() to take a
struct dev and a struct serial_rs485, instead of a struct uart_port
(which seemed too fragile on second thought).  That change has been
made now.

Thanks,

Lukas


Lukas Wunner (5):
  serial: Make retrieval of rs485 properties platform-agnostic
  dt-bindings: serial: Add common rs485 binding for RTS polarity
  serial: core: Support common rs485 binding for RTS polarity
  serial: fsl_lpuart: Support common rs485 binding for RTS polarity
  serial: imx: Support common rs485 binding for RTS polarity

 .../devicetree/bindings/serial/fsl-imx-uart.txt    |  3 ++-
 .../devicetree/bindings/serial/fsl-lpuart.txt      |  3 ++-
 .../devicetree/bindings/serial/omap_serial.txt     |  1 +
 Documentation/devicetree/bindings/serial/rs485.txt |  1 +
 drivers/tty/serial/atmel_serial.c                  |  2 +-
 drivers/tty/serial/fsl_lpuart.c                    | 15 ++++----------
 drivers/tty/serial/imx.c                           | 11 ++++++++---
 drivers/tty/serial/omap-serial.c                   | 11 +++++++----
 drivers/tty/serial/serial_core.c                   | 23 +++++++++++++++-------
 include/linux/serial_core.h                        |  3 +--
 10 files changed, 43 insertions(+), 30 deletions(-)

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
