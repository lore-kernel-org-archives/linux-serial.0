From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH RESEND 0/5] tty/serial: Add helpers to use GPIOs to control modem lines and implement atmel_serial.c
Date: Tue, 13 May 2014 20:20:40 +0200
Message-ID: <1400005245-11943-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:60273 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbaEMSU5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 May 2014 14:20:57 -0400
Received: by mail-we0-f182.google.com with SMTP id t60so806697wes.27
        for <linux-serial@vger.kernel.org>; Tue, 13 May 2014 11:20:56 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yegor Yefremov <yegor_sub1@visionsystems.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

This patch series is a leftover of http://www.spinics.net/lists/arm-kernel/msg314242.html
that missed 3.15 because it caused merge conflicts.

The USART controllers on sam9x5 chips (and also all AT91/SAMA5 chips
but at91rm9200) are not capable of handling DTR/DSR/DCD/RI signal.
Moreover, even if the controller can handle CTS/RTS, the dedicated
CTS/RTS pins may be already muxed for other peripherals (LCDC/EMAC/MMC).

So this patchset adds the possibility to control those lines via GPIO,
as it is done for RTS in the patch "switch atmel serial to use gpiolib"

NB: The 1st patch should make it for 3.15-final since it corrects a
device tree binding documentation example that has been introduced in 3.15-rc1.

Patch 1: For 3.15-final: fix GPIO_ACTIVE_LOW usage in device-tree documentation.
Patch 2: For 3.16: implements at91_gpiolib_get_direction used in patch 4
Patch 3: For 3.16: implements the generic helpers to control modem lines via GPIO.
Patch 4: For 3.16: implements modem control lines in atmel_serial atmel_serial.
Patch 5: For 3.16: implements the interrupts of CTS/DSR/DCD/RI.

This is based on v3.15-rc5.

Tested on at91sam9g35, with a null modem cable between 2 serial ports,
one with CTS/RTS controlled by the USART controller, the other via GPIO,
full duplex transfers.
Did some tests also with null modem cables on a PC, and with real modems.

Richard Genoud (5):
  tty/serial: atmel_serial: Fix device tree documentation
  ARM: at91: gpio: implement get_direction
  tty/serial: Add GPIOLIB helpers for controlling modem lines
  tty/serial: at91: use mctrl_gpio helpers
  tty/serial: at91: add interrupts for modem control lines

 .../devicetree/bindings/serial/atmel-usart.txt     |   12 +-
 Documentation/serial/driver                        |   25 +++
 arch/arm/mach-at91/at91rm9200_devices.c            |   16 +-
 arch/arm/mach-at91/at91sam9260_devices.c           |    7 -
 arch/arm/mach-at91/at91sam9261_devices.c           |    4 -
 arch/arm/mach-at91/at91sam9263_devices.c           |    4 -
 arch/arm/mach-at91/at91sam9g45_devices.c           |    5 -
 arch/arm/mach-at91/at91sam9rl_devices.c            |    5 -
 arch/arm/mach-at91/gpio.c                          |   13 ++
 drivers/tty/serial/Kconfig                         |    4 +
 drivers/tty/serial/Makefile                        |    3 +
 drivers/tty/serial/atmel_serial.c                  |  230 ++++++++++++++++----
 drivers/tty/serial/serial_mctrl_gpio.c             |  143 ++++++++++++
 drivers/tty/serial/serial_mctrl_gpio.h             |  110 ++++++++++
 include/linux/platform_data/atmel.h                |    1 -
 15 files changed, 509 insertions(+), 73 deletions(-)
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.c
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.h

-- 
1.7.10.4

