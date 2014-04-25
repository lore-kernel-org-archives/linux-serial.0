From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 0/5] tty/serial: Add helpers to use GPIOs to control modem lines and implement atmel_serial.c
Date: Fri, 25 Apr 2014 16:52:36 +0200
Message-ID: <1398437561-4289-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:42960 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbaDYOxE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Apr 2014 10:53:04 -0400
Received: by mail-we0-f171.google.com with SMTP id t61so3675623wes.2
        for <linux-serial@vger.kernel.org>; Fri, 25 Apr 2014 07:53:02 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

This patch series is a leftover of http://www.spinics.net/lists/arm-kernel/msg314242.html
that missed 3.15 because it caused merge conflicts.

The 1st patch may be applied as a fix for 3.15-rc, since it correct a
device tree binding documentation example.

Greg, for you to decide if it's worth it or not !

It's based on v3.15-rc2.

Richard Genoud (5):
  tty/serial: atmel_serial: Fix device tree documetation
  ARM: at91: gpio: implement get_direction
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
 arch/arm/mach-at91/gpio.c                          |  13 ++
 drivers/tty/serial/Kconfig                         |   4 +
 drivers/tty/serial/Makefile                        |   3 +
 drivers/tty/serial/atmel_serial.c                  | 230 +++++++++++++++++----
 drivers/tty/serial/serial_mctrl_gpio.c             | 143 +++++++++++++
 drivers/tty/serial/serial_mctrl_gpio.h             | 110 ++++++++++
 include/linux/platform_data/atmel.h                |   1 -
 15 files changed, 509 insertions(+), 73 deletions(-)
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.c
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.h

-- 
1.8.5.5

