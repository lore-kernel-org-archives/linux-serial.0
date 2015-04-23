From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: tty: serial: 8250_mtk: Add support for second clock
Date: Thu, 23 Apr 2015 10:51:02 +0200
Message-ID: <1429779066-21406-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


The following changes since commit 39a8804455fb23f09157341d3ba7db6d7ae6ee76:

  Linux 4.0 (2015-04-12 15:12:50 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/sha/linux-2.6.git tags/v4.0-mtk-uart-clk

for you to fetch changes up to 91bb93e93bf0916f9ebf571e8ab7cb671322ebc8:

  tty: serial: 8250_mtk: Add support for bus clock (2015-04-23 10:36:04 +0200)

----------------------------------------------------------------
This series adds support for the second clock on the Mediatek UART.
This is necessary for SoCs needing a bus clock to be enabled before
the UART can be accessed.

----------------------------------------------------------------
Sascha Hauer (4):
      tty: serial: 8250_mtk: Use devm_clk_get
      tty: serial: 8250_mtk: remove unnecessary test
      tty: serial: 8250_mtk: use pm_runtime callbacks for enabling
      tty: serial: 8250_mtk: Add support for bus clock

 .../devicetree/bindings/serial/mtk-uart.txt        |  9 ++-
 drivers/tty/serial/8250/8250_mtk.c                 | 92 ++++++++++++----------
 2 files changed, 57 insertions(+), 44 deletions(-)
