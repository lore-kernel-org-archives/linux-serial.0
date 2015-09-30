From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH v2 0/6] tty: serial: msm: Add DMA support and fix bit definitions
Date: Wed, 30 Sep 2015 15:08:20 +0300
Message-ID: <1443614906-2196-1-git-send-email-ivan.ivanov@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Andy Gross <agross@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Frank Rowand <frank.rowand@sonymobile.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

This is second version of patches which DMA support for UARTDM type
of hardware found in Qualcomm chip sets.

Changes since v0 (https://lkml.org/lkml/2015/9/12/108):

* Fixed SysRq issue reported by Srini.
* Dropped [PATCH 3/7], which did not make any functional change.

Ivan T. Ivanov (4):
  tty: serial: msm: Add msm prefix to all driver functions
  tty: serial: msm: Add TX DMA support
  tty: serial: msm: Add RX DMA support
  tty: serial: msm: Remove 115.2 Kbps maximum baud rate limitation

Pramod Gurav (2):
  tty: serial: msm: Add mask value for UART_DM registers
  tty: serial: msm: replaces (1 << x) with BIT(x) macro

 .../devicetree/bindings/serial/qcom,msm-uartdm.txt |   6 +
 drivers/tty/serial/msm_serial.c                    | 620 +++++++++++++++++++--
 drivers/tty/serial/msm_serial.h                    |  53 +-
 3 files changed, 606 insertions(+), 73 deletions(-)

--
1.9.1
