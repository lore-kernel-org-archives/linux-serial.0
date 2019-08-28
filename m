From: Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 0/5] Serial: imx: various fixes
Date: Wed, 28 Aug 2019 21:37:50 +0300
Message-ID: <1567017475-11919-1-git-send-email-sorganov@gmail.com>
References: <20190530152950.25377-1-sorganov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190530152950.25377-1-sorganov@gmail.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sergey Organov <sorganov@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The original problem that caused these changes was broken bytes being
sent/received at random on RTS/CTS handshake switch (i.e., on
setting/clearing termios CRTSCTS bit).

As it went, a few other problems were found and fixed, and then the
fix for original issue has been split into multiple patches that seem
to make sense by themselves. Thus, the "serial: imx: fix data breakage
on termios change", that finally fixes the issue, depends on 2
preceding patches.

The last patch in the series, "serial: imx: use Tx ready rather than
Tx empty irq" is independent of the rest and doesn't fix any serious
issue, but it should get rid of holes in continuous output,
specifically in PIO mode.

Changes in v2:
  - Removed wrong [PATCH 1/8] serial: imx: fix DTR inversion
  - Rebased on top of "tty-next"

Sergey Organov (5):
  serial: imx: get rid of unbounded busy-waiting loop
  serial: imx: do not stop Rx/Tx on termios change
  serial: imx: do not disable individual irqs during termios change
  serial: imx: fix data breakage on termios change
  serial: imx: use Tx ready rather than Tx empty irq

 drivers/tty/serial/imx.c | 56 ++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

-- 
2.10.0.1.g57b01a3
