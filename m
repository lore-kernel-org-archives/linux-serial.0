From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 0/6] serial: samsung: add DMA support
Date: Wed, 10 Dec 2014 12:49:21 +0100
Message-ID: <1418212167-28992-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, akpm@linux-foundation.org, kgene.kim@samsung.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, l.czerwinski@samsung.com, s.nawrocki@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

Hi,

This patch introduces DMA mode in samsung serial driver. It reduces
number of interrupts and CPU usage while sending large data blocks.

For TX transfers DMA mode is used when number of bytes to send it larger
than TX FIFO size, for smaller transfers PIO mode is used.

For RX transfers DMA mode is used when number of bytes in RX FIFO is
larger than threshold level. If it's not, we obtain RX timeout interrupt
and we receive data in PIO mode.

DMA mode is enabled when "dmas" property is defined in device-tree node
of serial port. Otherwise PIO mode is used.

To have this working, proper residue handling and DMA_PAUSE support in
DMAC driver are necessary. At many samsung platforms DMAC is pl330, which
does not have those features in mainline driver yet, so if you would
like to test series, my patches for pl330 driver are needed. You can
find them here:
https://lkml.org/lkml/2014/12/10/156

Entire series is based on previous work of Sylwester Nawrocki and
Lukasz Czerwinski.

Best regards,
Robert Baldyga

Robert Baldyga (6):
  serial: samsung: add struct s3c24xx_uart_dma
  serial: samsung: alloc dma stucture in ourport
  serial: s3c: add missing register definitions
  serial: samsung: add dma reqest/release functions
  serial: samsung: add DMA support for TX
  serial: samsung: add DMA support for RX

 drivers/tty/serial/samsung.c | 582 +++++++++++++++++++++++++++++++++++++++++--
 drivers/tty/serial/samsung.h |  42 ++++
 include/linux/serial_s3c.h   |  28 +++
 3 files changed, 634 insertions(+), 18 deletions(-)

-- 
1.9.1
