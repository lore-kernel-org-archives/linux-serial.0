From: Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH 0/4] Fix UART DMA freezes for iMX6
Date: Wed, 11 Sep 2019 16:49:39 +0200
Message-ID: <20190911144943.21554-1-philipp.puschmann@emlix.com>
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
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, jslaby@suse.com, vkoul@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, gregkh@linuxfoundation.org, dmaengine@vger.kernel.org, dan.j.williams@intel.com, festevam@gmail.com, Philipp Puschmann <philipp.puschmann@emlix.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

For some years and since many kernel versions there are reports that
RX UART DMA channel stops working at one point. So far the usual workaround was
to disable RX DMA. This patches try to fix the underlying problem.

When a running sdma script does not find any usable destination buffer to put
its data into it just leads to stopping the channel being scheduled again. As
solution we we manually retrigger the sdma script for this channel and by this
dissolve the freeze.

While this seems to work fine so far a further patch in this series increases
the number of RX DMA periods for UART to reduce use cases running into such
a situation.

This patch series was tested with the current kernel and backported to
kernel 4.15 with a special use case using a WL1837MOD via UART and provoking
the hanging of UART RX DMA within seconds after starting a test application.
It resulted in well known
  "Bluetooth: hci0: command 0x0408 tx timeout"
errors and complete stop of UART data reception. Our Bluetooth traffic consists
of many independent small packets, mostly only a few bytes, causing high usage
of periods.


Philipp Puschmann (4):
  dmaengine: imx-sdma: fix buffer ownership
  dmaengine: imx-sdma: fix dma freezes
  serial: imx: adapt rx buffer and dma periods
  dmaengine: imx-sdma: drop redundant variable

 drivers/dma/imx-sdma.c   | 32 ++++++++++++++++++++++----------
 drivers/tty/serial/imx.c |  5 ++---
 2 files changed, 24 insertions(+), 13 deletions(-)

-- 
2.23.0
