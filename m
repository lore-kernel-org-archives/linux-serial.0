From: Radu Pirea <radu.pirea@microchip.com>
Subject: [RESEND PATCH v11 0/6] Driver for at91 usart in spi mode
Date: Fri, 31 Aug 2018 16:41:35 +0300
Message-ID: <20180831134141.9335-1-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: richard.genoud@gmail.com, pirea.radu@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org, jslaby@suse.com, broonie@kernel.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Radu Pirea <radu.pirea@microchip.com>
List-Id: linux-serial@vger.kernel.org

Hello,

This is the 11th version of driver. I added a mfd driver which by
default probes atmel_serial driver and if in dt is specified to probe
the spi driver, then the spi-at91-usart driver will be probed. The
compatible for atmel_serial is now the compatible for at91-usart mfd
driver and compatilbe for atmel_serial driver was changed in order to
keep the bindings for serial as they are.

@Lee, could you take this patch series into your tree? I addressed all Mark
remarks.

In this resend I changed my email address from MAINTAINERS file.

Changes in v11:
- removed "depends on HAS_DMA" from drivers/spi/Kconfig because the driver has
no dma support
- changed "selects MFD_AT91_USART" to "depends on MFD_AT91_USART" in
drivers/spi/Kconfig
- changed comment style in spi-at91-usart.c

Changes in v10:
-fixed kbuild test robot warning

Changes in v9:
- minor changes
- rebased on top of broonie/for-4.19

Changes in v8:
- fixed passing an empty mfd cell if "atmel,usart-mode" value is invalid

Changes in v7:
- synced up  SPDIX license with module license
- numbering of usart modes starts from 0 insteand of 1

Changes in v6:
- removed unused compatible strings from serial and spi drivers

Changes in v5:
- fixed usage of stdout-path property with atmel_serial driver

Changes in v4:
- modified the spi driver to use cs gpio support form spi subsystem
- fixed dma transfers for serial driver
- squashed binding for spi and serial and moved them to mfd/atmel-usart.txt

Changes in v3:
- fixed spi slaves probing

Changes in v2:
- added at91-usart mfd driver
- modified spi-at91-usart driver to work as mfd driver child
- modified atmel_serial driver to work as mfd driver child

Changes in v1:
- added spi-at91-usart driver

Radu Pirea (6):
  MAINTAINERS: add at91 usart mfd driver
  dt-bindings: add binding for atmel-usart in SPI mode
  mfd: at91-usart: added mfd driver for usart
  MAINTAINERS: add at91 usart spi driver
  spi: at91-usart: add driver for at91-usart as spi
  tty/serial: atmel: change the driver to work under at91-usart mfd

 .../bindings/{serial => mfd}/atmel-usart.txt  |  25 +-
 MAINTAINERS                                   |  16 +
 drivers/mfd/Kconfig                           |   9 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/at91-usart.c                      |  71 +++
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-at91-usart.c                  | 432 ++++++++++++++++++
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/atmel_serial.c             |  42 +-
 include/dt-bindings/mfd/at91-usart.h          |  17 +
 11 files changed, 606 insertions(+), 17 deletions(-)
 rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
 create mode 100644 drivers/mfd/at91-usart.c
 create mode 100644 drivers/spi/spi-at91-usart.c
 create mode 100644 include/dt-bindings/mfd/at91-usart.h

-- 
2.18.0
