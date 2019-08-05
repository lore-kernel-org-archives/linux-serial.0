From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v3 0/6] LPUART fixes and improvements
Date: Mon,  5 Aug 2019 11:56:55 -0700
Message-ID: <20190805185701.22863-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Everyone:

This series contains fixes/improvements to LPUART dirver I came up
with recently as well as fixes picked up from Toradex and NXP Vybrid
repos.

Feedback is welcome!

Changes since [v2]:

 - Series rebased on Greg's tty-testing branch

Changes since [v1]:

 - Dropped "tty: serial: fsl_lpuart: Drop unnecessary sg_set_buf()
   call" due to being a duplicate of "tty: serial: fsl_lpuart: remove
   sg_set_buf() for sport->rx_sgl"
   
 - Fixed build break in "tty: serial: fsl_lpuart: Introduce
   lpuart_tx_dma_startup()"

Thanks,
Andrey Smirnov

[v2] lore.kernel.org/r/20190731173045.11718-1-andrew.smirnov@gmail.com
[v1] lore.kernel.org/r/20190729195226.8862-1-andrew.smirnov@gmail.com

Andrey Smirnov (6):
  tty: serial: fsl_lpuart: Introduce lpuart_tx_dma_startup()
  tty: serial: fsl_lpuart: Introduce lpuart_rx_dma_startup()
  tty: serial: fsl_lpuart: Introduce lpuart32_configure()
  tty: serial: fsl_lpuart: Introduce lpuart*_setup_watermark_enable()
  tty: serial: fsl_lpuart: Don't enable TIE in .startup() or .resume()
  tty: serial: fsl_lpuart: Ignore TX/RX interrupts if DMA is enabled

 drivers/tty/serial/fsl_lpuart.c | 195 +++++++++++++++-----------------
 1 file changed, 91 insertions(+), 104 deletions(-)

-- 
2.21.0
