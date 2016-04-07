From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 00/12] serial: 8250: split LPSS to 8250_lpss, enable DMA on Quark
Date: Thu,  7 Apr 2016 23:37:01 +0300
Message-ID: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

This is combined series of two things:
 - split out the Intel LPSS specific driver from 8250_pci into 8250_lpss
 - enable DMA support on Intel Quark UART

The patch has been tested on few Intel SoCs / platforms.

This is targeting serial subsystem, thus it would be nice to get and Ack from Vinod first.
Moreover, the series depends on series [1] that is now under review.

That's why I ask Vinod to create immutable tag / branch for the [1] and the
dependants (at least one more, which is sata_dwc_460ex).

[1] http://www.spinics.net/lists/dmaengine/msg08709.html

Andy Shevchenko (12):
  dmaengine: dw: keep copy of custom slave config in dwc
  dmaengine: dw: provide probe(), remove() stubs for users
  dmaengine: dw: set polarity of handshake interface
  dmaengine: dw: override LLP support if asked in platform data
  serial: 8250_dma: switch to new dmaengine_terminate_* API
  serial: 8250_dma: stop ongoing RX DMA on exception
  serial: 8250_dma: adjust DMA address of the UART
  serial: 8250: enable AFE on ports where FIFO is 16 bytes
  serial: 8250_lpss: split LPSS driver to separate module
  serial: 8250_lpss: move Quark code from PCI driver
  serial: 8250_lpss: enable MSI for Intel Quark
  serial: 8250_lpss: enable DMA on Intel Quark UART

 drivers/dma/dw/core.c                |  41 ++--
 drivers/dma/dw/regs.h                |   5 +-
 drivers/tty/serial/8250/8250.h       |   2 +
 drivers/tty/serial/8250/8250_dma.c   |  26 ++-
 drivers/tty/serial/8250/8250_lpss.c  | 356 +++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c   | 242 +-----------------------
 drivers/tty/serial/8250/8250_port.c  |   4 +-
 drivers/tty/serial/8250/Kconfig      |  14 +-
 drivers/tty/serial/8250/Makefile     |   1 +
 include/linux/dma/dw.h               |   5 +
 include/linux/platform_data/dma-dw.h |   4 +
 11 files changed, 429 insertions(+), 271 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_lpss.c

-- 
2.8.0.rc3
