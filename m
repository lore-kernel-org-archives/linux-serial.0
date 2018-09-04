From: Radu Pirea <radu_nicolae.pirea@upb.ro>
Subject: [PATCH v12 0/6] Driver for at91 usart in spi mode
Date: Tue,  4 Sep 2018 14:13:04 +0300
Message-ID: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org, broonie@kernel.org, jslaby@suse.com, richard.genoud@gmail.com, davem@davemloft.net, mchehab+samsung@kernel.org, akpm@linux-foundation.org, arnd@arndb.de
Cc: devicetree@vger.kernel.org, Radu Pirea <radu_nicolae.pirea@upb.ro>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi,

Well, this is the 12th version of this patch series.
In this version I fixed a warning from kbuild-robot and I have no idea
how I forgot to add static in declaration of that functions. Also I
fixed the example for the SPI driver in bindings.

Currently I am not working for Microchip, but I will continue to
maintain and improve this driver. So yes, this is the reason that
I changed my email address from MAINTAINERS file.

Changes in v12:
- fixed interrupts property in example from bindings of SPI driver
- changed email address in MAINTAINERS
- added static to declaration of few functions in SPI
  driver(kbuild-robot warning)

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
