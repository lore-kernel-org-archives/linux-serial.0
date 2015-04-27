From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2] tty: serial: 8250_mtk: Add support for second clock
Date: Mon, 27 Apr 2015 08:49:53 +0200
Message-ID: <1430117397-13517-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/sha/linux-2.6.git tags/v4.1-mtk-uart-clk-v2

for you to fetch changes up to 02e3f747bea47f6c02dc3f52e40869ea8ce5342a:

  tty: serial: 8250_mtk: Add support for bus clock (2015-04-27 08:39:06 +0200)

----------------------------------------------------------------
This series adds support for the second clock on the Mediatek UART.
This is necessary for SoCs needing a bus clock to be enabled before
the UART can be accessed.

Changes since v1:
- keep support old binding with unnamed clk
- hopefully clarify commit message
- do not leak in if() with unnecessary braces.

----------------------------------------------------------------
Sascha Hauer (4):
      tty: serial: 8250_mtk: remove unnecessary test
      tty: serial: 8250_mtk: Use devm_clk_get
      tty: serial: 8250_mtk: use pm_runtime callbacks for enabling
      tty: serial: 8250_mtk: Add support for bus clock

 .../devicetree/bindings/serial/mtk-uart.txt        |  12 ++-
 drivers/tty/serial/8250/8250_mtk.c                 | 104 ++++++++++++---------
 2 files changed, 70 insertions(+), 46 deletions(-)
