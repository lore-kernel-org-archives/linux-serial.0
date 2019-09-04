From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH V2 00/12] serial: tegra: Tegra186 support and fixes
Date: Wed, 4 Sep 2019 10:12:55 +0530
Message-ID: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Krishna Yarlagadda <kyarlagadda@nvidia.com>
List-Id: linux-serial@vger.kernel.org

Series of patches adding enhancements to exising UART driver and adding
support for new chip Tegra186 and Tegra194.
Tegra186 uses GPCDMA for dma transfers which is still not available in
mainstream. However, it can work in PIO/FIFO mode and support added for it.
Also Tegra186 has a hardware issue where it does not meet tolernace +/-4% and
to work around it, device tree entries provided to adjust baud rate for a
particular range.

Changes from V1:
Consistent spellings and few other cosmetic changes.
Do not ignore sysrq request when ignoring reads.
Remove WARN_ON for errors that are user triggered.
Fix max ports for Tegra186 and Tegra194
Register uart driver in init by reading max ports from dt.
Rename burst size and wait api for FIFO enable.


Ahung Cheng (1):
  serial: tegra: avoid reg access when clk disabled

Krishna Yarlagadda (9):
  serial: tegra: report error to upper tty layer
  dt-binding: serial: tegra: add new chips
  serial: tegra: check for FIFO mode enabled status
  serial: tegra: set maximum num of uart ports to 8
  serial: tegra: add support to use 8 bytes trigger
  serial: tegra: DT for Adjusted baud rates
  serial: tegra: add support to adjust baud rate
  serial: tegra: report clk rate errors
  serial: tegra: Add PIO mode support

Shardar Shariff Md (2):
  serial: tegra: add support to ignore read
  serial: tegra: flush the RX fifo on frame error

 .../bindings/serial/nvidia,tegra20-hsuart.txt      |  39 ++-
 drivers/tty/serial/serial-tegra.c                  | 374 ++++++++++++++++++---
 2 files changed, 368 insertions(+), 45 deletions(-)

-- 
2.7.4
