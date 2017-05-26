From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v3 00/10] serial/gpio: exar: Fixes and support for IOT2000
Date: Fri, 26 May 2017 18:02:27 +0200
Message-ID: <cover.1495814557.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

This makes the gpio-exar driver usable, which was prevented by a number
of fatal bugs, and adds support for the SIMATIC IOT2040 to the 8250-exar
driver and, indirectly, to gpio-exar as well. It's a cross-subsystem
series, so I'm also cross-posting to the serial and gpio lists.

Changes in v3:
 - fix MPIO state for Commtech adapters (regression of merged patch from
   previous round)
 - do not create gpio device for Commtech adapters
 - switch back to device properties
 - pass parent reference via device.parent instead of platform data
 - use dmi_system_id table instead of open-coded matching
 - address some smaller review remarks
 - fix reading back of rs485 state
 - adjust parenthood of exar gpiochip

Jan

Jan Kiszka (10):
  serial: exar: Leave MPIOs as output for Commtech adapters
  gpio-exar/8250-exar: Do not even instantiate a GPIO device for
    Commtech cards
  gpio-exar/8250-exar: Fix passing in of parent PCI device
  gpio: exar: Allocate resources on behalf of the platform device
  gpio: exar: Fix iomap request
  gpio: exar: Fix reading of directions and values
  gpio-exar/8250-exar: Rearrange gpiochip parenthood
  gpio: exar: Refactor address and bit calculations
  gpio-exar/8250-exar: Make set of exported GPIOs configurable
  serial: exar: Add support for IOT2040 device

 drivers/gpio/gpio-exar.c            |  74 ++++++++-------
 drivers/tty/serial/8250/8250_exar.c | 180 ++++++++++++++++++++++++++++++++++--
 2 files changed, 207 insertions(+), 47 deletions(-)

-- 
2.12.0
