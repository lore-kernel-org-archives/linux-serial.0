From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH v2 0/9] Improve Rx/Tx DMA implementation
Date: Tue, 28 Jun 2016 11:02:26 +0530
Message-ID: <20160628053235.5114-1-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: stefan@agner.ch, shawnguo@kernel.org, kernel@pengutronix.de, mturquette@baylibre.com, sboyd@codeaurora.org, jslaby@suse.com, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
List-Id: linux-serial@vger.kernel.org

Changes since v1:
Split suspend/resume patch.

Bhuvanchandra DV (5):
  tty: serial: fsl_lpuart: Fix broken 8m/s1 support
  tty: serial: fsl-lpuart: Use cyclic DMA for Rx
  tty: serial: fsl-lpuart: Use scatter/gather DMA for Tx
  tty: serial: fsl-lpuart: Update suspend/resume for DMA mode
  tty: serial: fsl_lpuart: Add support for RS-485

Stefan Agner (4):
  tty: serial: fsl_lpuart: consider TX FIFO too in tx_empty
  clk: imx: vf610: Disable automatic clock gating for lpuart in LPSTOP mode
  tty: serial: fsl_lpuart: support suspend/resume
  tty: serial: fsl_lpuart: fix clearing of receive flag

 drivers/clk/imx/clk-vf610.c     |  12 +-
 drivers/tty/serial/fsl_lpuart.c | 810 +++++++++++++++++++++++-----------------
 2 files changed, 482 insertions(+), 340 deletions(-)

-- 
2.9.0

