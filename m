From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 0/6] serial/gpio: exar: Fixes and support for IOT2000
Date: Thu, 18 May 2017 16:59:03 +0200
Message-ID: <cover.1495119548.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

This makes the gpio-exar driver usable, which was prevented by a number
of fatal bugs, and adds support for the SIMATIC IOT2040 to the 8250-exar
driver and, indirectly, to gpio-exar as well. It's a cross-subsystem
series, so I'm also cross-posting to the serial and gpio lists.

Changes in v2:
 - dropped already merged patches
 - switched to platform_data structure for exar <-> gpio driver
   communication
 - use dmi_check_system() to express platform match
 - adjusted bit logic style in exar_get_direction/value

Jan

Jan Kiszka (6):
  gpio: exar: Fix passing in of parent PCI device
  gpio: exar: Allocate resources on behalf of the platform device
  gpio: exar: Fix iomap request
  gpio: exar: Fix reading of directions and values
  gpio-exar/8250-exar: Make set of exported GPIOs configurable
  serial: exar: Add support for IOT2040 device

 drivers/gpio/gpio-exar.c                |  54 +++++++-----
 drivers/tty/serial/8250/8250_exar.c     | 151 ++++++++++++++++++++++++++++++--
 include/linux/platform_data/gpio-exar.h |  25 ++++++
 3 files changed, 198 insertions(+), 32 deletions(-)
 create mode 100644 include/linux/platform_data/gpio-exar.h

-- 
2.12.0
