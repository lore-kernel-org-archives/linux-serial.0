From: Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH v2 0/4] tty: serial: Add earlycon support to MT8173 SoC
Date: Mon, 12 Jan 2015 21:08:20 +0800
Message-ID: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
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
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>, srv_heupstream@mediatek.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, yh.chen@mediatek.com, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-serial@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

8250 earlycon will always init serial hardware. The hardware setting is
from kernel earlycon parameters or by probe current baudrate. I add noinit
options in 8250 earlycon to bypass init, such that earlycon can use the
same hardware setting as loader.

This series also add MT8173 earlycon support, and stdout in device
tree.

Change v2:
1. Add noinit options.
2. Remove duplicate code in 8250_mtk.c, reuse the 8250_early.c existed function.

This patchset is based on 3.19-rc1, and my basic support for Mediatek
MT8173 SoC [1].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315165.html

Eddie Huang (4):
  tty: serial: Add 8250 earlycon to support noinit option
  tty: serial: 8250_mtk: Add earlycon
  arm64: dts: Add mediatek MT8173 earlycon support
  Document: Modify 8250 earlycon kernel parameters

 Documentation/kernel-parameters.txt         |  5 ++++-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |  4 +++-
 drivers/tty/serial/8250/8250_early.c        |  7 ++++---
 drivers/tty/serial/8250/8250_mtk.c          | 15 +++++++++++++++
 drivers/tty/serial/earlycon.c               | 17 ++++++++++++-----
 include/linux/serial_8250.h                 |  2 ++
 include/linux/serial_core.h                 |  1 +
 7 files changed, 41 insertions(+), 10 deletions(-)

--
1.8.1.1.dirty
