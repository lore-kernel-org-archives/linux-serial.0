From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCHv2 0/3] Fix handware handshake on SAM9x5 platforms
Date: Mon, 12 Sep 2016 11:47:30 +0200
Message-ID: <20160912094733.21501-1-richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>
List-Id: linux-serial@vger.kernel.org

Since commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
hardware handshake is enabled"), hardware handshake is not working
anymore on SAM9x5 platforms.

The first two patches fix the hardware handshake when CTS/RTS pins are
handle by GPIOs.

The last patch fixes hardware handshake when CTS/RTS pins are not GPIOs.

Changes since v1:
 - Correct patch 1 with the error found by kbuild.
 - Add Alexandre's Acked-by on patch 2
 - Rewrite patch 3 logic in the light of the on-going discussion
   with Cyrille and Alexandre.

NB: patch 2 NEEDS patch 1 to compile.


Richard Genoud (3):
  serial: mctrl_gpio: implement mctrl_gpio_use_rtscts
  tty/serial: at91: fix hardware handshake with GPIOs
  tty/serial: at91: fix hardware handshake when DMA is not used

 drivers/tty/serial/atmel_serial.c      | 25 +++++++++++++++++--------
 drivers/tty/serial/serial_mctrl_gpio.c |  8 ++++++++
 drivers/tty/serial/serial_mctrl_gpio.h | 10 ++++++++++
 3 files changed, 35 insertions(+), 8 deletions(-)
