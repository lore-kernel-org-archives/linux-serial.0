From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 00/24] LPUART fixes and improvements
Date: Mon, 29 Jul 2019 12:52:02 -0700
Message-ID: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Everyone:

This series contains fixes/improvements to LPUART dirver I came up
with recently as well as fixes picked up from Toradex and NXP Vybrid
repos.

Feedback is welcome!

Thanks,
Andrey Smirnov

Andrey Smirnov (22):
  tty: serial: fsl_lpuart: Flush HW FIFOs in .flush_buffer
  tty: serial: fsl_lpuart: Simplify RX/TX IRQ handlers
  tty: serial: fsl_lpuart: Fix bogus indentation
  tty: serial: fsl_lpuart: Drop unnecessary sg_set_buf() call
  tty: serial: fsl_lpuart: Drop unnecessary uart_write_wakeup()
  tty: serial: fsl_lpuart: Fix issue in software flow control
  tty: serial: fls_lpuart: Split shared TX IRQ handler into two
  tty: serial: fsl_lpuart: Drop no-op bit opearation
  tty: serial: fsl_lpuart: Drop unnecessary extra parenthesis
  tty: serial: fsl_lpuart: Clear CSTOPB unconditionally
  tty: serial: fsl_lpuart: Use appropriate lpuart32_* I/O funcs
  tty: serial: fsl_lpuart: Introduce lpuart_wait_bit_set()
  tty: serial: fsl_lpuart: Use cpu_relax() instead of barrier()
  tty: serial: fsl_lpuart: Introduce lpuart_stopped_or_empty()
  tty: serial: fsl_lpuart: Drop unnecessary lpuart*_stop_tx()
  tty: serial: fsl_lpuart: Introduce lpuart_dma_shutdown()
  tty: serial: fsl_lpuart: Introduce lpuart_tx_dma_startup()
  tty: serial: fsl_lpuart: Introduce lpuart_rx_dma_startup()
  tty: serial: fsl_lpuart: Introduce lpuart32_configure()
  tty: serial: fsl_lpuart: Introduce lpuart*_setup_watermark_enable()
  tty: serial: fsl_lpuart: Don't enable TIE in .startup() or .resume()
  tty: serial: fsl_lpuart: Ignore TX/RX interrupts if DMA is enabled

Stefan Agner (2):
  tty: serial: fsl_lpuart: fix framing error handling when using DMA
  tty: serial: fsl_lpuart: flush receive FIFO after overruns

 drivers/tty/serial/fsl_lpuart.c | 495 +++++++++++++++++---------------
 1 file changed, 261 insertions(+), 234 deletions(-)

-- 
2.21.0
