From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v3 0/9] Add and make use of a common rs485 device tree parsing function
Date: Mon, 26 Jun 2017 11:07:54 +0200
Message-ID: <20170626090803.10981-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hello,

this is v3 of the series that targets to consolidate parsing the rs485 specific
dt properties in a single place.

The only changes since v2 (Message-Id:
<20170623094945.31908-1-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>) are:

 - simplify atmel driver to not have a single line function that is only
   called once
 - build warning fix in omap driver (already sent a v2.5 for that)

Best regards
Uwe

Sascha Hauer (6):
  serial: Add common rs485 device tree parsing function
  serial: atmel: Use common rs485 device tree parsing function
  serial: fsl_lpuart: Use common rs485 device tree parsing function
  serial: omap-serial: Use common rs485 device tree parsing function
  serial: imx: default to half duplex rs485
  serial: imx: Use common rs485 device tree parsing function

Uwe Kleine-König (3):
  serial: fsl_lpuart: clear unsupported options in .rs485_config()
  dt-bindings: serial/rs485: make rs485-rts-delay optional
  of: document rs485 bindings for Atmel USART, Freescale UARTs and OMAP
    UART

 .../devicetree/bindings/serial/atmel-usart.txt     |  1 +
 .../devicetree/bindings/serial/fsl-imx-uart.txt    |  1 +
 .../devicetree/bindings/serial/fsl-lpuart.txt      |  1 +
 .../devicetree/bindings/serial/omap_serial.txt     |  1 +
 Documentation/devicetree/bindings/serial/rs485.txt |  5 +--
 drivers/tty/serial/Kconfig                         |  4 ++
 drivers/tty/serial/Makefile                        |  2 +
 drivers/tty/serial/atmel_serial.c                  | 25 +-----------
 drivers/tty/serial/fsl_lpuart.c                    | 29 ++++++++++---
 drivers/tty/serial/imx.c                           |  5 ++-
 drivers/tty/serial/of.c                            | 47 ++++++++++++++++++++++
 drivers/tty/serial/omap-serial.c                   | 13 +-----
 include/linux/serial_core.h                        | 13 ++++++
 13 files changed, 100 insertions(+), 47 deletions(-)
 create mode 100644 drivers/tty/serial/of.c

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
