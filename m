From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v7 00/11] serial: 8250: split LPSS to 8250_lpss, enable DMA on Quark
Date: Fri, 17 Jun 2016 15:41:00 +0300
Message-ID: <1466167271-11902-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

This is combined series of two things:
- split out the Intel LPSS specific driver from 8250_pci into 8250_lpss
- enable DMA support on Intel Quark UART

The patch has been tested on few Intel SoCs / platforms. In any case I would
like to ask Bryan to do independent test.

This is targeting serial subsystem, and it has necessary Ack from Vinod.

The series can be reached in the branch located at [2].

[1] http://www.spinics.net/lists/kernel/msg2244475.html
[2] https://bitbucket.org/andy-shev/linux/branch/topic%2Fdw%2Fqrk

Bryan, since this series doesn't include any DMA management quirks I didn't
address it. It is a matter of the following series which I would send later.

Since v6:
- protect the code against SERIAL_8250_DMA=n && DW_DMAC_CORE=m

Since v5:
- add Vinod's Ack tag
- rebase on top of latest linux-next

Since v4:
- fix an issue what kernel test bot reported (lkp)
- add a list of supported SoC to Kconfig (Bryan)
- rename polarity -> hs_polarity (Bryan)

Since v3:
- rebase on top of recent tty-next branch
- add Reviewed-by tag from Bryan

Since v2:
- add tags
- rebase on top of new version of [1]

Since v1:
- address most of Peter's comments (mostly changelog to patch 8)
- add tag to patch 5
- drop patch 6 from the series to be separately dealt with

Andy Shevchenko (11):
  dmaengine: dw: keep copy of custom slave config in dwc
  dmaengine: dw: provide probe(), remove() stubs for users
  dmaengine: dw: set polarity of handshake interface
  dmaengine: dw: override LLP support if asked in platform data
  serial: 8250_dma: switch to new dmaengine_terminate_* API
  serial: 8250_dma: adjust DMA address of the UART
  serial: 8250: enable AFE on ports where FIFO is 16 bytes
  serial: 8250_lpss: split LPSS driver to separate module
  serial: 8250_lpss: move Quark code from PCI driver
  serial: 8250_lpss: enable MSI for Intel Quark
  serial: 8250_lpss: enable DMA on Intel Quark UART

 drivers/dma/dw/core.c                |  43 ++--
 drivers/dma/dw/regs.h                |   5 +-
 drivers/tty/serial/8250/8250.h       |   5 +
 drivers/tty/serial/8250/8250_dma.c   |  14 +-
 drivers/tty/serial/8250/8250_lpss.c  | 379 +++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c   | 257 +-----------------------
 drivers/tty/serial/8250/8250_port.c  |   9 +-
 drivers/tty/serial/8250/Kconfig      |  16 +-
 drivers/tty/serial/8250/Makefile     |   1 +
 include/linux/dma/dw.h               |   5 +
 include/linux/platform_data/dma-dw.h |   4 +
 11 files changed, 452 insertions(+), 286 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_lpss.c

-- 
2.8.1
