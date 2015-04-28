From: Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH v3 0/3] tty: serial: Add earlycon support to MT8173 SoC
Date: Tue, 28 Apr 2015 21:40:31 +0800
Message-ID: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: srv_heupstream@mediatek.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jiri Slaby <jslaby@suse.cz>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Wang Long <long.wanglong@huawei.com>, Kevin Cernekee <cernekee@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Cox <alan@linux.intel.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.orgSascha Hauer <kern>
List-Id: linux-serial@vger.kernel.org

This patch add earlycon support to MT8173 SoC platform.
To use earlycon, need
1. Add earlycon in boot parameters
2. Add "linux,sdtout-path" property in device tree file

This patch based on 4.1-rc1.

Change in v3:
Remove noinit options, not necessary, because 8250_early.c will not init hardware
if not provide baudrate.

Change v2:
1. Add noinit options.
2. Remove duplicate code in 8250_mtk.c, reuse the 8250_early.c existed function.

Eddie Huang (3):
  tty: serial: 8250: export early_serial8250_setup function
  tty: serial: 8250_mtk: Add earlycon
  arm64: dts: Add mediatek MT8173 earlycon support

 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |  4 +++-
 drivers/tty/serial/8250/8250_early.c        |  2 +-
 drivers/tty/serial/8250/8250_mtk.c          | 13 +++++++++++++
 include/linux/serial_8250.h                 |  2 ++
 4 files changed, 19 insertions(+), 2 deletions(-)

-- 
1.8.1.1.dirty
