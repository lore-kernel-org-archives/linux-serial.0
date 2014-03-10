From: Richard Genoud <noreply.rgenoud@gmail.com>
Subject: [PATCH v6 0/3] tty/serial: Add helpers to use GPIOs to control modem lines and implement atmel_serial.c
Date: Mon, 10 Mar 2014 17:45:48 +0100
Message-ID: <1394469951-21192-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:34718 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbaCJQqI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Mar 2014 12:46:08 -0400
Received: by mail-we0-f180.google.com with SMTP id p61so8794898wes.25
        for <linux-serial@vger.kernel.org>; Mon, 10 Mar 2014 09:46:06 -0700 (PDT)
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
Patch 2 implements modem control lines in atmel_serial atmel_serial.
Patch 3 implements the interrupts of CTS/DSR/DCD/RI in atmel_serial.

I've taken into account lasts remarks that Alexander made me off-list.

This is based on next-20140307 + [PATCH v3 5/7] ARM: at91: gpio: implement get_direction
(It has been acked by Linus, but I don't think it has been applied in a tree yet)

Tested on at91sam9g35, with a null modem cable between 2 serial ports,
one with CTS/RTS controlled by the USART controller, the other via GPIO,
full duplex transfers.
Did some tests also with null modem cables on a PC, and with real modems.
And a lot of rings tested with ioctl TIOCMIWAIT, TIOCGICOUNT, TIOCMGET (and TIOCMSET, for RTS/DTR)

Updates from v5:
	- Add UART_GPIO_RNG.
	- Add atmel-serial documentation that was lost in v3 !
	- switched a dev_warn to dev_dbg.
	- remove checks (irq >= 0) in interrupt handler.
	- simplified a !IS_ERR_OR_NULL(gpiod) test to just gpiod
	- fixed a bug in rollback code in atmel_serial.c

Updates from v4:
	- patches "tty/serial: at91: remove unused open/close hooks" and
	"tty/serial: at91: use dev_err instead of printk" have been picked
	by Greg on tty tree.
	- As Alexander pointed out, IS_ERR_OR_NULL() was replaced by a simple
	check againts NULL in patch 1/3
	- in path 1/3, a warning is produced instead of an error when we can't set
	the direction of a GPIO.

Updates from v3:
	- add static keyword on struct uart0_gpios_table.
	- add use an index at the mctrl_gpio_init() function to make it
	usable by driver that allocates several ports at once.
	- hide struct gpio_desc from users.
	- patch "pinctrl: at91: implement get_direction" has been picked by Linus.
	- patch "ARM: at91: gpio: implement get_direction" has been acked by Linus.

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

Richard Genoud (3):
  tty/serial: Add GPIOLIB helpers for controlling modem lines
  tty/serial: at91: use mctrl_gpio helpers
  tty/serial: at91: add interrupts for modem control lines

 .../devicetree/bindings/serial/atmel-usart.txt     |  12 +-
 Documentation/serial/driver                        |  25 +++
 arch/arm/mach-at91/at91rm9200_devices.c            |  16 +-
 arch/arm/mach-at91/at91sam9260_devices.c           |   7 -
 arch/arm/mach-at91/at91sam9261_devices.c           |   4 -
 arch/arm/mach-at91/at91sam9263_devices.c           |   4 -
 arch/arm/mach-at91/at91sam9g45_devices.c           |   5 -
 arch/arm/mach-at91/at91sam9rl_devices.c            |   5 -
 drivers/tty/serial/Kconfig                         |   4 +
 drivers/tty/serial/Makefile                        |   3 +
 drivers/tty/serial/atmel_serial.c                  | 230 +++++++++++++++++----
 drivers/tty/serial/serial_mctrl_gpio.c             | 143 +++++++++++++
 drivers/tty/serial/serial_mctrl_gpio.h             | 110 ++++++++++
 include/linux/platform_data/atmel.h                |   1 -
 14 files changed, 496 insertions(+), 73 deletions(-)
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.c
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.h

-- 
1.8.5.5

