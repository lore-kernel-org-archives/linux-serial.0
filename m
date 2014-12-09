From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: [PATCH 0/5] tty/serial: at91: fix atmel_serial_probe(), dma_sync_* and the Hardware Handshaking support
Date: Tue, 9 Dec 2014 14:31:31 +0100
Message-ID: <cover.1418131298.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, wenyou.yang@atmel.com, ludovic.desroches@atmel.com, leilei.zhao@atmel.com, voice.shen@atmel.com, josh.wu@atmel.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>
List-Id: linux-serial@vger.kernel.org

This series of patches fix many bugs:
- a wrong enum type was used when calling dma_sync_*_for_cpu() and
  dma_sync_*_for_device()
- IO accesses to registers were done in atmel_serial_probe() after the
  peripheral clock had been disabled.
- the -EDEFER error was not handled properly in atmel_serial_probe()
- the Hardware Handshaking mode could never be enabled to control the RTS line

The patches were made from the next-20141205 tag of the linux-next repository.
They were tested on a SAMA5Dx FPGA platform.

Cyrille Pitchen (5):
  tty/serial: at91: use correct type for dma_sync_*_for_cpu() and
    dma_sync_*_for_device()
  tty/serial: at91: enable peripheral clock before accessing I/O
    registers
  tty/serial: at91: fix error handling in atmel_serial_probe()
  tty/serial: at91: fix RTS line management when hardware handshake is
    enabled
  tty/serial: at91: fix typo and indentation

 drivers/tty/serial/atmel_serial.c | 153 +++++++++++++++++++++++++-------------
 1 file changed, 101 insertions(+), 52 deletions(-)

-- 
1.8.2.2
