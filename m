From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 0/5] Add new features for the Spreadtrum serial controller
Date: Tue, 19 Feb 2019 15:31:10 +0800
Message-ID: <cover.1550560916.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch set fixes the baud rate calculation formula issue, as well as
adding power management support and DMA mode support for the Spreadtrum
serial controller.

Lanqing Liu (5):
  serial: sprd: Modify the baud rate calculation formula
  dt-bindings: serial: sprd: Add clocks and clocks-names properties
  serial: sprd: Add power management for the Spreadtrum serial
    controller
  dt-bindings: serial: sprd: Add dma properties to support DMA mode
  serial: sprd: Add DMA mode support

 .../devicetree/bindings/serial/sprd-uart.txt       |   17 +-
 drivers/tty/serial/sprd_serial.c                   |  503 +++++++++++++++++++-
 2 files changed, 499 insertions(+), 21 deletions(-)

-- 
1.7.9.5
