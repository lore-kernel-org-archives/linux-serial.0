From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 0/4] serial: omap: robustify for high speed transfers
Date: Fri, 22 Jan 2016 11:27:27 +0100
Message-ID: <87lh7hrjsg.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, peter@hurleysoftware.com, bigeasy@linutronix.de, tony@atomide.com, nsekhar@ti.com, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The DMA-enabled OMAP UART driver in its current form queues 48 bytes for a
DMA-RX transfer. After the transfer is complete, a new transfer of 48 bytes
is queued. The DMA completion callback runs in tasklet context, so a
reschedule with context switch is required for the completion to be
processed and the next 48 bytes to be queued.

When running at a high speed such as 3Mbit, the CPU has 128us between when
the DMA hardware transfer completes and when the DMA hardware must be fully
prepared for the next transfer. For an embedded board running applications,
this does not give the CPU much time. If the UART is using hardware flow
control, this situation results in a dramatic decrease in real transfer
speeds. If flow control is not used, the CPU will almost certainly be
forced to drop data.

This patch series modifies the UART driver to use cyclic DMA transfers
with a growable ring buffer to accommodate baud rates. The ring buffer is
large enough to hold at least 1s of RX-data. (At 3Mbit that is 367KiB.) In
order to ensure that data in the ring buffer is not overwritten before
being processed by the tty layer, a hrtimer is used as a watchdog.

With this patch series, the UART driver is resilent against latencies up
to 500ms. This means that if no flow control is used, data will not be
dropped until such latencies occur. If hardware flow control is used,
real transfer speeds will not be affected until such latencies occur.

Patch series against next-20160122.

John Ogness (4):
  ARM: edma: special case slot limit workaround
  tty: serial: 8250: add optional spinlock arg to serial8250_rx_chars
  tty: serial: 8250: omap: convert to using cyclic transfers
  tty: serial: 8250: omap: consume spurious interrupts

 drivers/dma/edma.c                  |   25 +-
 drivers/tty/serial/8250/8250.h      |    2 +
 drivers/tty/serial/8250/8250_fsl.c  |    2 +-
 drivers/tty/serial/8250/8250_omap.c |  430 ++++++++++++++++++++++++-----------
 drivers/tty/serial/8250/8250_port.c |    9 +-
 include/linux/serial_8250.h         |    3 +-
 6 files changed, 333 insertions(+), 138 deletions(-)

-- 
1.7.10.4
