From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH 0/8] Improve Rx/Tx DMA implementation
Date: Thu, 9 Jun 2016 20:40:31 +0530
Message-ID: <20160609151039.20817-1-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, stefan@agner.ch, kernel@pengutronix.de, jslaby@suse.com, shawnguo@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
List-Id: linux-serial@vger.kernel.org

Bhuvanchandra DV (5):
  tty: serial: fsl_lpuart: Fix broken 8m/s1 support
  tty: serial: fsl-lpuart: Use cyclic DMA for Rx
  tty: serial: fsl-lpuart: Use scatter/gather DMA for Tx Drop PIO to DMA
    switching and use scatter/gather DMA for Tx path to improve
    performance.
  tty: serial: fsl-lpuart: Update suspend/resume for DMA mode
  tty: serial: fsl_lpuart: Add support for RS-485

Stefan Agner (3):
  tty: serial: fsl_lpuart: consider TX FIFO too in tx_empty
  tty: serial: fsl_lpuart: support suspend/resume
  tty: serial: fsl_lpuart: fix clearing of receive flag

 drivers/clk/imx/clk-vf610.c     |  12 +-
 drivers/tty/serial/fsl_lpuart.c | 810 +++++++++++++++++++++++-----------------
 2 files changed, 482 insertions(+), 340 deletions(-)

-- 
2.8.3
