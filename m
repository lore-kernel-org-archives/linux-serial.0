From: Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH 1/4] dmaengine: imx-sdma: fix buffer ownership
Date: Wed, 11 Sep 2019 16:49:40 +0200
Message-ID: <20190911144943.21554-2-philipp.puschmann@emlix.com>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190911144943.21554-1-philipp.puschmann@emlix.com>
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

BD_DONE flag marks ownership of the buffer. When 1 SDMA owns the buffer,
when 0 ARM owns it. When processing the buffers in
sdma_update_channel_loop the ownership of the currently processed buffer
was set to SDMA again before running the callback function of the the
buffer and while the sdma script may be running in parallel. So there was
the possibility to get the buffer overwritten by SDMA before it has been
processed by kernel leading to kind of random errors in the upper layers,
e.g. bluetooth.

It may be further a good idea to make the status struct member volatile or
access it using writel or similar to rule out that the compiler sets the
BD_DONE flag before the callback routine has finished.

Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
---
 drivers/dma/imx-sdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index a01f4b5d793c..1abb14ff394d 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -802,7 +802,6 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		*/
 
 		desc->chn_real_count = bd->mode.count;
-		bd->mode.status |= BD_DONE;
 		bd->mode.count = desc->period_len;
 		desc->buf_ptail = desc->buf_tail;
 		desc->buf_tail = (desc->buf_tail + 1) % desc->num_bd;
@@ -817,6 +816,8 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
 		spin_lock(&sdmac->vc.lock);
 
+		bd->mode.status |= BD_DONE;
+
 		if (error)
 			sdmac->status = old_status;
 	}
-- 
2.23.0
