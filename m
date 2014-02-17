From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH v3 0/7] tty/serial: Add helpers to use GPIOs to control modem lines and implement atmel_serial.c
Date: Mon, 17 Feb 2014 17:57:20 +0100
Message-ID: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:50511 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbaBQQ56 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Feb 2014 11:57:58 -0500
Received: by mail-we0-f169.google.com with SMTP id t61so10977209wes.0
        for <linux-serial@vger.kernel.org>; Mon, 17 Feb 2014 08:57:57 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

The USART controller on sam9x5 chips (and also all AT91/SAMA5 chips
but at91rm9200) are not capable of handling DTR/DSR/DCD/RI signal.
Moreover, even if the controller can handle CTS/RTS, the dedicated
CTS/RTS pins are already muxed for other peripherals (LCDC/EMAC/MMC).

So this patchset adds the possibility to control those lines via GPIO,
as it is done for RTS in the patch "switch atmel serial to use gpiolib"

As it was suggested by Alexander Shiyan, I made that available for
every board.

Patch 1 implements the generic helpers to control modem lines via GPIO
Patches 2 and 3 are just a little tidy up of atmel_serial.c.
Patch 4 implements modem control lines in atmel_serial atmel_serial.
Patches 5 and 6 implement the get_direction() gpio call for at91, as
it is needed by gpiod_get_direction().
Patch 7 implement the interrupts of CTS/DSR/DCD/RI.

This is based on 3.14-rc3 + Linus Walleij/Nicolas Ferre's patch:
 354e57f3a0a2 ARM/serial: at91: switch atmel serial to use gpiolib
(in Uwe's tree git://git.pengutronix.de/git/ukl/linux.git dropmachtimexh )
and Philipp Zabel's patch:
 8f984bc11e1cc gpiolib: make gpiod_direction_output take a logical value
(in gpio tree git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git )
(there won't be a merge conflict if this last patch is not present, the
gpios will "just" be on the wrong direction.)
 
Tested on at91sam9g35, with a null modem cable between 2 serial ports,
one with CTS/RTS controlled by the USART controller, the other via GPIO,
full duplex transfers.
Did some tests also with null modem cables on a PC.

Updates from v2:
	- remove UART_GPIO_MIN/UART_GPIO_MAX_INPUT and use a direction
	boolean instead.
	- implement get_direction in at91 pinctrl and mach-at91/gpio.c.
	- remove the get_mctrl_gpio_name() function that was used for
	logs only.
	- split atmel_serial.c patch in 2.
	- use a gpio lookup table to declare modem gpios in platform
	devices boards. So there's no more special case for platform
	data gpios in atmel_serial.c.

Updates from v1:
	- Instead of controlling modem signal only on atmel board, the
	code is now available for every board.
	- The active low flag from device tree is now used.

Richard Genoud (7):
  tty/serial: Add GPIOLIB helpers for controlling modem lines
  tty/serial: at91: use dev_err instead of printk
  tty/serial: at91: remove unused open/close hooks
  tty/serial: at91: use mctrl_gpio helpers
  ARM: at91: gpio: implement get_direction
  pinctrl: at91: implement get_direction
  tty/serial: at91: add interrupts for modem control lines

 Documentation/serial/driver              |  21 +++
 arch/arm/mach-at91/at91rm9200_devices.c  |  16 +-
 arch/arm/mach-at91/at91sam9260_devices.c |   7 -
 arch/arm/mach-at91/at91sam9261_devices.c |   4 -
 arch/arm/mach-at91/at91sam9263_devices.c |   4 -
 arch/arm/mach-at91/at91sam9g45_devices.c |   5 -
 arch/arm/mach-at91/at91sam9rl_devices.c  |   5 -
 arch/arm/mach-at91/gpio.c                |  13 ++
 drivers/pinctrl/pinctrl-at91.c           |  12 ++
 drivers/tty/serial/Kconfig               |   4 +
 drivers/tty/serial/Makefile              |   3 +
 drivers/tty/serial/atmel_serial.c        | 249 +++++++++++++++++++++++--------
 drivers/tty/serial/serial_mctrl_gpio.c   | 112 ++++++++++++++
 drivers/tty/serial/serial_mctrl_gpio.h   |  92 ++++++++++++
 include/linux/platform_data/atmel.h      |   1 -
 15 files changed, 456 insertions(+), 92 deletions(-)
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.c
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.h

-- 
1.8.5

