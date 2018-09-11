From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL v2] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
Date: Tue, 11 Sep 2018 12:18:50 +0100
Message-ID: <20180911111850.GJ4185@dell>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu_nicolae.pirea@upb.ro>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org, broonie@kernel.org, jslaby@suse.com, richard.genoud@gmail.com, davem@davemloft.net, mchehab+samsung@kernel.org, akpm@linux-foundation.org, arnd@arndb.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

[In case you missed it]

This new pull-request contains the following changes since v1:

 - Uplift the submission version from v11 to v12
 - Include fix for build breakage due to missing Device Tree include file

Since it is based on the original pull-request, it can be pulled
in either directly on top of it or as a pull in its own right.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20-1

for you to fetch changes up to 65b80dfffeabd4eb253b93d07eadde4d89c18511:

  mfd: at91-usart: Include Device Tree header (2018-09-11 11:44:56 +0100)

----------------------------------------------------------------
Immutable branch between MFD, SPI and TTY due for the v4.20 merge window (v2)

----------------------------------------------------------------
Lee Jones (4):
      dt-bindings: mfd: atmel-usart: Correct interrupts property to include IRQ number
      MAINTAINERS: Change Radu's email address
      spi: at91-usart: Make local functions static
      mfd: at91-usart: Include Device Tree header

Radu Pirea (6):
      MAINTAINERS: Add AT91 USART MFD entry
      dt-bindings: Add binding for atmel-usart in SPI mode
      mfd: at91-usart: Add MFD driver for USART
      MAINTAINERS: Add AT91 USART SPI entry
      spi: at91-usart: Add driver for at91-usart as SPI
      tty/serial: atmel: Change the driver to work under at91-usart MFD

 .../bindings/{serial => mfd}/atmel-usart.txt       |  25 +-
 MAINTAINERS                                        |  16 +
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/at91-usart.c                           |  72 ++++
 drivers/spi/Kconfig                                |   8 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-at91-usart.c                       | 432 +++++++++++++++++++++
 drivers/tty/serial/Kconfig                         |   1 +
 drivers/tty/serial/atmel_serial.c                  |  42 +-
 include/dt-bindings/mfd/at91-usart.h               |  17 +
 11 files changed, 607 insertions(+), 17 deletions(-)
 rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
 create mode 100644 drivers/mfd/at91-usart.c
 create mode 100644 drivers/spi/spi-at91-usart.c
 create mode 100644 include/dt-bindings/mfd/at91-usart.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
