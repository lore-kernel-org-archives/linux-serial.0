From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/2] serial: imx: use UPF_AUTO_CTS
Date: Wed, 26 Jun 2019 12:15:55 +0200
Message-ID: <20190626101557.26299-1-s.hauer@pengutronix.de>
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
To: linux-serial@vger.kernel.org
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Sergey Organov <sorganov@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This series eliminates a duplicate call to uart_handle_cts_change() and
sets the UPF_AUTO_CTS flag for the i.MX UART driver.

Normally setting the UPF_AUTO_CTS flag should only be a little
optimization as the transmitter is no longer enabled/disabled with every
CTS change, here it fixes an issue which initially brought me to
implement this patch. I am working on uploading a firmware to a Marvell
bluetooth chip. During download it often happened that a CTS interrupt
was lost and the upload stalled forever. This patch fixes the issue
(without knowing why we lost CTS interrupts in the first place)

This series is based on Sergei Shtylyovs series "serial: imx: fix RTS
and RTS/CTS handling" and should be applied ontop of it.

Sascha Hauer (2):
  serial: imx: remove duplicate handling of CTS change
  serial: imx: use UPF_AUTO_CTS

 drivers/tty/serial/imx.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

-- 
2.20.1
