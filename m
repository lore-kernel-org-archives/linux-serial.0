From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v4 0/2] Document msm_serial bindings and support newer uartdms
Date: Wed, 28 Aug 2013 13:32:39 -0700
Message-ID: <1377721961-3508-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, David Brown <davidb@codeaurora.org>, devicetree@vger.kernel.org, Kumar Gala <galak@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

This patchset aligns the msm_serial driver more with downstream usage and
updates the driver's DT bindings.

Changes since v3:
 * Moved bindings to serial instead of tty/serial

Changes since v2:
 * Fixed up DT review comments
 * Dropped patches that were picked up in tty tree

Changes since v1:
 * Dropped _clk postfix from {core,iface}_clk
 * Split DT binding into two files
 * Renamed DT binding files to match compatible strings
 * Fixed up DT review comments
 * Added new patch 5/5 (more than 1 char for UARTDM)

Stephen Boyd (2):
  devicetree: serial: Document msm_serial bindings
  ARM: dts: msm: Update uartdm compatible strings

 .../devicetree/bindings/serial/qcom,msm-uart.txt   | 25 ++++++++++
 .../devicetree/bindings/serial/qcom,msm-uartdm.txt | 53 ++++++++++++++++++++++
 .../devicetree/bindings/tty/serial/msm_serial.txt  | 27 -----------
 arch/arm/boot/dts/msm8660-surf.dts                 |  2 +-
 arch/arm/boot/dts/msm8960-cdp.dts                  |  2 +-
 5 files changed, 80 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
 delete mode 100644 Documentation/devicetree/bindings/tty/serial/msm_serial.txt

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
