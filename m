From: David Brown <davidb@codeaurora.org>
Subject: [PATCH v2 0/4] Initial DT support for MSM8660
Date: Tue, 16 Aug 2011 10:52:12 -0700
Message-ID: <1313517136-27414-1-git-send-email-davidb@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, Russell King <linux@arm.linux.org.uk>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

This series adds initial support for booting the MSM8660 via
devicetree.  The target boots with a serial console, and no platform
data.

In order to test this with a devicetree boot, it is necessary to
include patches allowing the devicetree to be appended to the kernel,
and merge ATAG values into the DT.

Once these patches reach mainline, I intend to remove the non-DT boot
for this target.

History:
  v2 - Consistent name for msm-uart devices.

David Brown (4):
  msm_serial: Use relative resources for iomem
  msm_serial: Add devicetree support
  ARM: msm: Add devicetree support for msm8660-surf
  ARM: msm: Describe MSM 8660 SURF FPGA registers in DT

 .../devicetree/bindings/tty/serial/msm_serial.txt  |   22 +++++
 arch/arm/boot/dts/msm8660-surf.dts                 |   29 ++++++
 arch/arm/mach-msm/board-msm8x60.c                  |   98 ++++++++++++++++++--
 drivers/tty/serial/msm_serial.c                    |   30 ++++--
 4 files changed, 162 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/msm_serial.txt
 create mode 100644 arch/arm/boot/dts/msm8660-surf.dts

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
