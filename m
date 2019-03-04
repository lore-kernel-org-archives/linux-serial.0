From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 0/4] Add new features for the Spreadtrum serial controller
Date: Mon,  4 Mar 2019 16:58:20 +0800
Message-ID: <cover.1551689518.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch set fixes the baud rate calculation formula issue, as well as
adding power management support and DMA mode support for the Spreadtrum
serial controller.

Changes from v1:
 - The patch 1 of V1 was applied, so remove the baud rate fix from this patch set.
 - Add reviewed tag from Rob for patch 1.
 - Fix the incorrect names' order in patch 3.

Lanqing Liu (4):
  dt-bindings: serial: sprd: Add clocks and clocks-names properties
  serial: sprd: Add power management for the Spreadtrum serial
    controller
  dt-bindings: serial: sprd: Add dma properties to support DMA mode
  serial: sprd: Add DMA mode support

 .../devicetree/bindings/serial/sprd-uart.txt       |   17 +-
 drivers/tty/serial/sprd_serial.c                   |  501 +++++++++++++++++++-
 2 files changed, 498 insertions(+), 20 deletions(-)

-- 
1.7.9.5
