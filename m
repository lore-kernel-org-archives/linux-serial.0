From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 00/15] serial: imx: misc fix and features
Date: Tue, 9 Dec 2014 18:11:21 +0900
Message-ID: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jiada_wang@mentor.com, anton_bondarenko@mentor.com, dirk.behme@de.bosch.com
List-Id: linux-serial@vger.kernel.org

Hi Guys,

This patch attempts to add several features and fix issues existing
in imx UART driver.

Tested-ON: i.MX6Q SabreAuto board.

Anton Bondarenko (1):
  serial: imx: initialized DMA w/o HW flow enabled

Dirk Behme (6):
  serial: imx: remove unneeded imx_transmit_buffer() from imx_start_tx()
  serial: imx: TX DMA: clean up sg initialization
  serial: imx: unmap sg in case of dmaengine_prep_slave_sg() failure
  serial: imx: unmap scatter gather list in imx_flush_buffer
  serial: imx: use dma_is_txing to synchronize dma_tx_callback and
    imx_dma_tx
  serial: imx: disable TDMAEN in imx_flush_buffer()

Jiada Wang (7):
  serial: imx: add CREAD flag support
  serial: imx: use locking to stop concurrent access of UCR1
  Revert "serial: imx: always wake up the processes in the TX callback"
  serial: imx: call imx_dma_tx() again in dma_tx_callback
  serial: imx: Enable UCR4_OREN in startup interface
  serial: imx: Fix issue in software flow control
  serial: imx: Support sw flow control in DMA mode

Robin Gong (1):
  serial: imx: start rx_dma once RXFIFO is not empty

 drivers/tty/serial/imx.c | 160 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 126 insertions(+), 34 deletions(-)

-- 
1.9.3
