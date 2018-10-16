From: Songjun Wu <songjun.wu@linux.intel.com>
Subject: [RESEND PATCH 00/14] serial: lantiq: Add CCF suppport
Date: Tue, 16 Oct 2018 17:19:01 +0800
Message-ID: <20181016091915.19909-1-songjun.wu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com, hauke.mehrtens@intel.com
Cc: gregkh@linuxfoundation.org, paul.burton@mips.com, jslaby@suse.com, Songjun Wu <songjun.wu@linux.intel.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Rob Herring <robh+dt@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-serial@vger.kernel.org


This patch series is for adding common clock framework support
for lantiq serial driver, mainly includes:
1) Add common clock framework support.
2) Modify the dts file according to the DT conventions.
3) Replace the platform dependent functions with kernel functions



Songjun Wu (14):
  MIPS: dts: Change upper case to lower case
  MIPS: dts: Add aliases node for lantiq danube serial
  serial: lantiq: Get serial id from dts
  serial: lantiq: Change ltq_w32_mask to asc_update_bits
  MIPS: lantiq: Unselect SWAP_IO_SPACE when LANTIQ is selected
  serial: lantiq: Use readl/writel instead of ltq_r32/ltq_w32
  serial: lantiq: Rename fpiclk to freqclk
  serial: lantiq: Replace clk_enable/clk_disable with clk generic API
  serial: lantiq: Add CCF support
  serial: lantiq: Reorder the head files
  include: Add lantiq.h in include/linux/
  serial: lantiq: Replace lantiq_soc.h with lantiq.h
  serial: lantiq: Change init_lqasc to static declaration
  dt-bindings: serial: lantiq: Add optional properties for CCF

 .../devicetree/bindings/serial/lantiq_asc.txt      |  15 +++
 arch/mips/Kconfig                                  |   1 -
 arch/mips/boot/dts/lantiq/danube.dtsi              |  42 +++---
 arch/mips/boot/dts/lantiq/easy50712.dts            |  18 ++-
 drivers/tty/serial/lantiq.c                        | 145 ++++++++++++---------
 include/linux/lantiq.h                             |  23 ++++
 6 files changed, 155 insertions(+), 89 deletions(-)
 create mode 100644 include/linux/lantiq.h

-- 
2.11.0
