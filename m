From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: [PATCH linux-next 0/4] tty/serial: at91: add support to FIFOs
Date: Tue, 2 Jun 2015 16:18:20 +0200
Message-ID: <cover.1433253787.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, wenyou.yang@atmel.com, ludovic.desroches@atmel.com, leilei.zhao@atmel.com, josh.wu@atmel.com, alexandre.belloni@free-electrons.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>
List-Id: linux-serial@vger.kernel.org

ChangeLog

v1:
This series of patches add support to FIFOs which will be introduced with Atmel
sama5d2x SoC.

FIFOs allow to reduce the number of I/O access. Indeed depending on the data
size and the USART mode, FIFOs work in either single or multiple data. For
multiple data, up to 4 data can be written into the Transmit Holding Register
or read from the Receive Holding Register in a single word access.

Also the RX FIFO allows to reduce the risk of receive overrun and data loss,
especially when the DMA controller is not used.

Finally, when the hardware handshake mode is selected, the RTS line can now be
controlled by two thresholds on the RX FIFO. When FIFO level (the number of
data available to be read) crosses the high threshold, the RTS line is set to
high level telling the peer that it should stop sending new data. Data are read
from the RX FIFO and when the FIFO level crosses the low threshold, the RTS
is set back to low level telling the remote peer that it can send data again.

This new feature resolves a long time hardware limitation where the RTS line
was directly controlled by a PDC signal. There is no equivalent of that signal
for the DMA controller so for all SoCs without PDC for USART there was no mean
to control the RTS line properly: once the hardware handshake mode selected,
the RTS line remains high level. Next SoCs with FIFOs will be able to use the
hardware handshake mode thanks to the RX FIFO.

Cyrille Pitchen (4):
  ARM: at91/dt: add new DT properties for Atmel usart
  tty/serial: at91: fix some macro definitions to fit coding style
  tty/serial: at91: add support to FIFOs
  tty/serial: at91: use 32bit writes into TX FIFO when DMA is enabled

 .../devicetree/bindings/serial/atmel-usart.txt     |  15 ++
 drivers/tty/serial/atmel_serial.c                  | 195 +++++++++++++----
 include/linux/atmel_serial.h                       | 240 ++++++++++++---------
 3 files changed, 307 insertions(+), 143 deletions(-)

-- 
1.8.2.2
