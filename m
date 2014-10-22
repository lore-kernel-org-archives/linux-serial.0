From: Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH 0/3] tty: serial: Add mediatek MT8127 and MT8135 UART support
Date: Wed, 22 Oct 2014 21:12:06 +0800
Message-ID: <1413983529-21887-1-git-send-email-eddie.huang@mediatek.com>
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
To: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, srv_heupstream@mediatek.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, hc.yen@mediatek.com, yh.chen@mediatek.com, linux-kernel@vger.kernel.org, nathan.chung@mediatek.com, linux-serial@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Eddie Huang <eddie.huang@mediatek.com>, Jiri Slaby <jslaby@suse.cz>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

This patch base on 3.18-rc1, which include mediatek MT65XX SOC
UART driver developed by Matthias Brugger, and
Joe.C's Mediatek MT8127 & MT8135 basic SOC support patch[1].

This patch fix one 8250_mtk.c bug that divisor maybe zero, and add device tree support.
Test ok on MT8127 and MT8135 tablet platform.

Eddie Huang (3):
  tty: serial: Fix mediatek UART driver setting baudrate issue
  ARM: mediatek: add UART dts for mt8127 and mt8135
  DTS: serial: Add bindings document for the Mediatek UARTs

 .../devicetree/bindings/serial/mtk-uart.txt        |  2 ++
 arch/arm/boot/dts/mt8127.dtsi                      | 34 ++++++++++++++++++++
 arch/arm/boot/dts/mt8135.dtsi                      | 36 ++++++++++++++++++++++
 drivers/tty/serial/8250/8250_mtk.c                 |  4 +--
 4 files changed, 74 insertions(+), 2 deletions(-)
