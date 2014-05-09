From: dean_jenkins@mentor.com
Subject: [PATCH 0/5] serial: imx: fixes
Date: Fri,  9 May 2014 16:19:43 +0100
Message-ID: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
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
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: dirk.behme@de.bosch.com, s.hauer@pengutronix.de, dean_jenkins@mentor.com, b32955@freescale.com, linux-arm-kernel@lists.infradead.org, shawn.guo@freescale.com
List-Id: linux-serial@vger.kernel.org

From: Dean Jenkins <Dean_Jenkins@mentor.com>

The following set of patches were tested on an i.MX6 multi-core platform.

Patches 1 to 4 were tested using a Bluetooth BCSP UART connection at 115.2kbps
and 4Mbps. The fixes were needed because the i.MX6 UART driver caused spinlock
deadlocks with the HCI TTY layer.

Patch 5 improves the i.MX6 UART driver for use with kdb.

Patch 1: serial: imx: remove unneeded imx_transmit_buffer() from imx_start_tx()
Patch 2: serial: imx: remove uart_write_wakeup() from imx_transmit_buffer()
Patch 3: serial: imx: avoid spinlock recursion deadlock
Patch 4: serial: imx: move imx_transmit_buffer() into imx_txint()
Patch 5: serial: imx: clean up imx_poll_get_char()

The patches are based off 3.15-rc4.

----------------------------------------------------------------
Andy Lowe (1):
      serial: imx: avoid spinlock recursion deadlock

Dirk Behme (4):
      serial: imx: remove unneeded imx_transmit_buffer() from imx_start_tx()
      serial: imx: remove uart_write_wakeup() from imx_transmit_buffer()
      serial: imx: move imx_transmit_buffer() into imx_txint()
      serial: imx: clean up imx_poll_get_char()

 drivers/tty/serial/imx.c |   73 ++++++++++++++--------------------------------
 1 file changed, 22 insertions(+), 51 deletions(-)
