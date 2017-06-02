From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v5 00/11] serial/gpio: exar: Fixes and support for IOT2000
Date: Fri,  2 Jun 2017 09:28:43 +0200
Message-ID: <cover.1496388533.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

This makes the gpio-exar driver usable, which was prevented by a number
of fatal bugs, and adds support for the SIMATIC IOT2040 to the 8250-exar
driver and, indirectly, to gpio-exar as well. It's a cross-subsystem
series, so I'm also cross-posting to the serial and gpio lists.

Changes in v5:
 - factor out exar8250_platform hook setup as separate patch
 - pass properties to __xr17v35x_register_gpio
 - constant property support for platform_device_add_properties

Jan

Jan Kiszka (11):
  serial: exar: Leave MPIOs as output for Commtech adapters
  gpio-exar/8250-exar: Do not even instantiate a GPIO device for
    Commtech cards
  gpio-exar/8250-exar: Fix passing in of parent PCI device
  gpio: exar: Allocate resources on behalf of the platform device
  gpio: exar: Fix iomap request
  gpio: exar: Fix reading of directions and values
  gpio-exar/8250-exar: Rearrange gpiochip parenthood
  serial: exar: Factor out platform hooks
  platform: Accept const properties
  gpio-exar/8250-exar: Make set of exported GPIOs configurable
  serial: exar: Add support for IOT2040 device

 drivers/base/platform.c             |   2 +-
 drivers/gpio/gpio-exar.c            |  75 +++++++-------
 drivers/tty/serial/8250/8250_exar.c | 188 ++++++++++++++++++++++++++++++++++--
 include/linux/platform_device.h     |   2 +-
 4 files changed, 218 insertions(+), 49 deletions(-)

-- 
2.12.3
