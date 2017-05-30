From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v4 0/9] serial/gpio: exar: Fixes and support for IOT2000
Date: Tue, 30 May 2017 09:01:15 +0200
Message-ID: <cover.1496127684.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

This makes the gpio-exar driver usable, which was prevented by a number
of fatal bugs, and adds support for the SIMATIC IOT2040 to the 8250-exar
driver and, indirectly, to gpio-exar as well. It's a cross-subsystem
series, so I'm also cross-posting to the serial and gpio lists.

Changes in v4:
 - fold v3 patches 8 and 9 together
 - use DT-like property names

I would suggest to send this series as a whole through one branch,
either gpio after receiving acks from Greg or serial (most acks from
Linus are there).

Jan

Jan Kiszka (9):
  serial: exar: Leave MPIOs as output for Commtech adapters
  gpio-exar/8250-exar: Do not even instantiate a GPIO device for
    Commtech cards
  gpio-exar/8250-exar: Fix passing in of parent PCI device
  gpio: exar: Allocate resources on behalf of the platform device
  gpio: exar: Fix iomap request
  gpio: exar: Fix reading of directions and values
  gpio-exar/8250-exar: Rearrange gpiochip parenthood
  gpio-exar/8250-exar: Make set of exported GPIOs configurable
  serial: exar: Add support for IOT2040 device

 drivers/gpio/gpio-exar.c            |  75 ++++++++-------
 drivers/tty/serial/8250/8250_exar.c | 180 ++++++++++++++++++++++++++++++++++--
 2 files changed, 208 insertions(+), 47 deletions(-)

-- 
2.12.3
