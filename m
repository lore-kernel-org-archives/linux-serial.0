From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PULL] serial/gpio: exar: Fixes and support for IOT2000
Date: Mon, 3 Jul 2017 09:21:30 +0200
Message-ID: <5de2f417-02e2-b983-67bd-7d82232956b0@siemens.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com>
 <CACRpkdZYSFTa63BF5u-J=pu2XwUbVZiQGAtZybhjQno6vVbe=g@mail.gmail.com>
 <9520074b-3731-7bbe-d59d-cbed90ac16bb@siemens.com>
 <CACRpkdbNPnNbk_r0NWEs4e7PuKmMf9KTjeRPRnxTOHuK-+ki2Q@mail.gmail.com>
 <c0a29540-7946-4e95-1b59-3a2f478757da@siemens.com>
 <d52a1a65-842c-9c73-17f7-5574fcefab2a@siemens.com>
 <CACRpkdZ1atVQLuDio6PVk4Xg+DUBDt2F2OH+2UjVkue8rKNbcA@mail.gmail.com>
 <20170629144940.GD23512@kroah.com>
 <CACRpkdYEvc2De88sy-FWOOkU8-O4KwX00rLZ7dBk6H2H0Q0+LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYEvc2De88sy-FWOOkU8-O4KwX00rLZ7dBk6H2H0Q0+LQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

The following changes since commit 85bb4646f8908eb786dfa19a6bb2ff1423dc8aa4:

  gpio: rcar: Add R8A7743 (RZ/G1M) support (2017-06-29 14:22:38 +0200)

are available in the git repository at:

  git://git.kiszka.org/linux.git queues/gpio-iot2000

for you to fetch changes up to 413058df4331ce29f9934a5870d582c7e71fe15f:

  serial: exar: Add support for IOT2040 device (2017-07-03 08:33:20 +0200)

This corresponds to v6 of the series with additional review and ack
tags.

----------------------------------------------------------------
Jan Kiszka (8):
      serial: uapi: Add support for bus termination
      gpio-exar/8250-exar: Do not even instantiate a GPIO device for Commtech cards
      gpio: exar: Fix iomap request
      gpio-exar/8250-exar: Rearrange gpiochip parenthood
      serial: exar: Factor out platform hooks
      platform: Accept const properties
      gpio-exar/8250-exar: Make set of exported GPIOs configurable
      serial: exar: Add support for IOT2040 device

 drivers/base/platform.c             |   2 +-
 drivers/gpio/gpio-exar.c            |  71 +++++++--------
 drivers/tty/serial/8250/8250_exar.c | 170 +++++++++++++++++++++++++++++++++++-
 include/linux/platform_device.h     |   2 +-
 include/uapi/linux/serial.h         |   3 +
 5 files changed, 208 insertions(+), 40 deletions(-)

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
