From: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] 8250 UART driver for NXP LPC18xx family
Date: Fri, 15 May 2015 20:29:13 +0200
Message-ID: <1431714555-7063-1-git-send-email-manabian@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This patch set adds a serial port driver for the 8250-
based UART found on LPC18xx/43xx devices. The UART is
16550A compatible with additional features like RS485
support, synchronous mode, IrDA, and DMA.

For now only basic UART and RS485 operation is supported.

The plan is add additional features like DMA support once
the PL080 DMA controller gets device tree bindings.

Joachim Eastwood (2):
  serial: 8250: add LPC18xx/43xx UART driver
  doc: dt: add documentation for nxp,lpc1850-uart

 .../bindings/serial/nxp,lpc1850-uart.txt           |  21 +++
 drivers/tty/serial/8250/8250_lpc18xx.c             | 204 +++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig                    |   8 +
 drivers/tty/serial/8250/Makefile                   |   1 +
 4 files changed, 234 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt
 create mode 100644 drivers/tty/serial/8250/8250_lpc18xx.c

-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
