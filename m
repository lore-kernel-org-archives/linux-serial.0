From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 0/9] Add and make use of a common rs485 device tree parsing function
Date: Wed, 21 Jun 2017 12:21:21 +0200
Message-ID: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hello,

this series unifies parsing of

	rs485-rts-delay
	linux,rs485-enabled-at-boot-time
	rs485-rx-during-tx

in the drivers that already support some of these. As the function
implmented here is more strict that the open coded stuff already in the
drivers three device trees needed adaption to ensure the machines
continue to work as expected.

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
  ARM: dts/at91: ensure UARTs used for rs485 specify rs485-rts-delay
  ARM: dts/imx: ensure UARTs used for rs485 specify rs485-rts-delay
  of: document rs485 bindings for Atmel USART, Freescale UARTs and OMAP
    UART

 .../devicetree/bindings/serial/atmel-usart.txt     |  1 +
 .../devicetree/bindings/serial/fsl-imx-uart.txt    |  1 +
 .../devicetree/bindings/serial/fsl-lpuart.txt      |  1 +
 .../devicetree/bindings/serial/omap_serial.txt     |  1 +
 arch/arm/boot/dts/animeo_ip.dts                    |  2 +
 arch/arm/boot/dts/at91-vinco.dts                   |  1 +
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            |  1 +
 drivers/tty/serial/Kconfig                         |  4 ++
 drivers/tty/serial/Makefile                        |  2 +
 drivers/tty/serial/atmel_serial.c                  | 17 +-------
 drivers/tty/serial/fsl_lpuart.c                    |  5 ++-
 drivers/tty/serial/imx.c                           |  5 ++-
 drivers/tty/serial/of.c                            | 45 ++++++++++++++++++++++
 drivers/tty/serial/omap-serial.c                   | 12 +-----
 include/linux/serial_core.h                        | 12 ++++++
 15 files changed, 79 insertions(+), 31 deletions(-)
 create mode 100644 drivers/tty/serial/of.c

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
