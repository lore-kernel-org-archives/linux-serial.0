From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 0/4] serial: fsl_lpuart: fix various DMA related issues
Date: Fri, 28 Nov 2014 01:23:21 +0100
Message-ID: <1417134205-4400-1-git-send-email-stefan@agner.ch>
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
Cc: linux-kernel@vger.kernel.org, stefan@agner.ch, linux-serial@vger.kernel.org, jingchang.lu@freescale.com, shawn.guo@linaro.org, jslaby@suse.cz, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Patch 1 and 3 are actual fixes, whereas 2 and 4 don't lead to issues
in standard cases but are still worthwhile fixes.

Stefan Agner (4):
  serial: fsl_lpuart: delete timer on shutdown
  serial: fsl_lpuart: move DMA channel request to probe
  serial: fsl_lpuart: avoid new transfer while DMA is running
  serial: fsl_lpuart: update RX timer on successful DMA transfer

 drivers/tty/serial/fsl_lpuart.c | 110 +++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 58 deletions(-)

-- 
2.1.3
