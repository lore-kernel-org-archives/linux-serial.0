From: Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v6 0/6] Driver for at91 usart in spi mode
Date: Thu, 7 Jun 2018 14:00:14 +0300
Message-ID: <20180607110020.20565-1-radu.pirea@microchip.com>
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
To: broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, lee.jones@linaro.org, richard.genoud@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, Radu Pirea <radu.pirea@microchip.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello,

This is the second version of driver. I added a mfd driver which by
default probes atmel_serial driver and if in dt is specified to probe
the spi driver, then the spi-at91-usart driver will be probed. The
compatible for atmel_serial is now the compatible for at91-usart mfd
driver and compatilbe for atmel_serial driver was changed in order to
keep the bindings for serial as they are.

Changes in v1:
- added spi-at91-usart driver

Changes in v2:
- added at91-usart mfd driver
- modified spi-at91-usart driver to work as mfd driver child
- modified atmel_serial driver to work as mfd driver child

Changes in v3:
- fixed spi slaves probing

Changes in v4:
- modified the spi driver to use cs gpio support form spi subsystem
- fixed dma transfers for serial driver
- squashed binding for spi and serial and moved them to mfd/atmel-usart.txt

Changes in v5:
- fixed usage of stdout-path property with atmel_serial driver

Changes in v6:
- removed unused compatible strings from serial and spi drivers

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
 drivers/mfd/at91-usart.c                      |  68 +++
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-at91-usart.c                  | 434 ++++++++++++++++++
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/atmel_serial.c             |  42 +-
 include/dt-bindings/mfd/at91-usart.h          |  17 +
 11 files changed, 606 insertions(+), 17 deletions(-)
 rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
 create mode 100644 drivers/mfd/at91-usart.c
 create mode 100644 drivers/spi/spi-at91-usart.c
 create mode 100644 include/dt-bindings/mfd/at91-usart.h

-- 
2.17.1
