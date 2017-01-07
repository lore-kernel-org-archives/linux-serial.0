From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v7 0/3] add gpio support to exar
Date: Sat,  7 Jan 2017 23:57:46 +0000
Message-ID: <1483833469-11422-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, gnomes@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-serial@vger.kernel.org

Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
can be controlled using gpio interface.

v5 was sent in January, 2016 and after reviews it was suggested to
split the exar code out of 8250_pci and make its own driver.

For reference it is at https://patchwork.kernel.org/patch/8058311/

First split attempt was patch series v6.

regards
sudip

Sudip Mukherjee (3):
  gpio: exar: add gpio for exar cards
  serial: exar: split out the exar code from 8250_pci
  serial: 8250_pci: remove exar code

 drivers/gpio/Kconfig                |   7 +
 drivers/gpio/Makefile               |   1 +
 drivers/gpio/gpio-exar.c            | 238 +++++++++++++++++
 drivers/tty/serial/8250/8250_exar.c | 515 ++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c  | 336 +----------------------
 drivers/tty/serial/8250/Kconfig     |   5 +
 drivers/tty/serial/8250/Makefile    |   1 +
 7 files changed, 770 insertions(+), 333 deletions(-)
 create mode 100644 drivers/gpio/gpio-exar.c
 create mode 100644 drivers/tty/serial/8250/8250_exar.c

-- 
1.9.1

