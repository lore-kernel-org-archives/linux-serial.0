From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/8] serial/gpio: exar: Fixes and support for IOT2000
Date: Sat, 13 May 2017 09:28:58 +0200
Message-ID: <cover.1494660546.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

This makes the gpio-exar driver usable, which was prevented by a number
of fatal bugs, and adds support for the SIMATIC IOT2040 to the 8250-exar
driver and, indirectly, to gpio-exar as well. It's a cross-subsystem
series, so I'm also cross-posting to the serial and gpio lists.

Jan

Jan Kiszka (8):
  serial: exar: Preconfigure xr17v35x MPIOs as output
  gpio: exar: Fix passing in of parent PCI device
  gpio: exar: Allocate resources on behalf of the platform device
  gpio: exar: Fix iomap request
  gpio: exar: Fix reading of directions and values
  serial: uapi: Add support for bus termination
  gpio-exar/8250-exar: Make set of exported GPIOs configurable
  serial: exar: Add support for IOT2040 device

 drivers/gpio/gpio-exar.c            |  55 ++++++++------
 drivers/tty/serial/8250/8250_exar.c | 145 +++++++++++++++++++++++++++++++++---
 include/uapi/linux/serial.h         |   3 +
 3 files changed, 169 insertions(+), 34 deletions(-)

-- 
2.12.0
