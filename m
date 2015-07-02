From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 0/5] tty/serial: at91: add support to FIFOs
Date: Thu, 2 Jul 2015 15:18:08 +0200
Message-ID: <cover.1435842688.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, leilei.zhao-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

ChangeLog

v4:
- insert a new patch in the series to remove UART_PUT_* and UART_GET_*
  macros. replace them by atmel_uart_writel() and atmel_uart_readl().

v3:
- add "Acked-by" tags on patches 1, 2 and 4.
- define macros check the FIFO size and to configure the high and low RTS
  thresholds in patch 3.
- fix a spelling mistake in patch 3: s/raisonable/reasonably/

v2:
- remove "atmel,rts-high-threshold" and "atmel,rts-low-threshold" from new
  DT properties. For now these two thresholds are set once for all during the
  probe but a later patch might allow to configure them at run time.
- reword the commit message of the DT property patch to better explain why we
  have chosen to introduce the new property "atmel,fifo-size".
- add a missing chunk in the FIFO patch: as the commit message explains, we
  need to use 8bit accesses when dealing with the Transmit/Receive Holding
  Registers.

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

Cyrille Pitchen (5):
  ARM: at91/dt: add a new DT property to support FIFOs on Atmel USARTs
  tty/serial: at91: fix some macro definitions to fit coding style
  tty/serial: at91: remove bunch of macros to access UART registers
  tty/serial: at91: add support to FIFOs
  tty/serial: at91: use 32bit writes into TX FIFO when DMA is enabled

 .../devicetree/bindings/serial/atmel-usart.txt     |   3 +
 drivers/tty/serial/atmel_serial.c                  | 467 +++++++++++++--------
 include/linux/atmel_serial.h                       | 240 ++++++-----
 3 files changed, 439 insertions(+), 271 deletions(-)

-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
