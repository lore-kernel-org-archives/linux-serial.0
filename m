From: Chuah Kim Tatt <kim.tatt.chuah@intel.com>
Subject: [PATCH v2 0/3] Fix DNV HSUART RX DMA timeout interrupt issue
Date: Wed, 15 Jun 2016 13:44:10 +0800
Message-ID: <1465969453-16198-1-git-send-email-kim.tatt.chuah@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, vinod.koul@intel.com
Cc: heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, kim.tatt.chuah@intel.com, linux-kernel@vger.kernel.org, jui.nee.tan@intel.com, peter@hurleysoftware.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: "Chuah, Kim Tatt" <kim.tatt.chuah@intel.com>

These patches fix a DNV HSUART DMA issue with timeout interrupts, where
RX data is stuck in buffer when RX DMA is used and the number of received
bytes is less than 4096.
These patches have been tested on Intel Denverton platform.

Changes from v1:
  - Added patch "serial: 8250_dma: Export serial8250_rx_dma_flush()" to solve
    build error when CONFIG_SERIAL_8250_MID is set to "m".

Chuah, Kim Tatt (3):
  dmaengine: hsu: Export hsu_dma_get_status()
  serial: 8250_dma: Export serial8250_rx_dma_flush()
  serial: 8250_mid: Read RX buffer on RX DMA timeout for DNV

 drivers/dma/hsu/hsu.c              | 90 +++++++++++++++++++++++++++++---------
 drivers/dma/hsu/pci.c              | 11 ++++-
 drivers/tty/serial/8250/8250_dma.c |  1 +
 drivers/tty/serial/8250/8250_mid.c | 24 +++++++---
 include/linux/dma/hsu.h            | 14 ++++--
 5 files changed, 109 insertions(+), 31 deletions(-)

-- 
1.9.1
