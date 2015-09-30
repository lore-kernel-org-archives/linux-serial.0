From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH v3 0/6] tty: serial: msm: Add DMA support and fix bit definitions
Date: Wed, 30 Sep 2015 15:26:57 +0300
Message-ID: <1443616023-28625-1-git-send-email-ivan.ivanov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <agross@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Frank Rowand <frank.rowand@sonymobile.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

This is the third version of patches which add DMA support for UARTDM type
of hardware found in Qualcomm chip sets.

Changes since v0 (https://lkml.org/lkml/2015/9/12/108):

* Fixed SysRq issue reported by Srini.
* Dropped [PATCH 3/7], because it did not make functional change.

Ivan T. Ivanov (4):
  tty: serial: msm: Add msm prefix to all driver functions
  tty: serial: msm: Add TX DMA support
  tty: serial: msm: Add RX DMA support
  tty: serial: msm: Remove 115.2 Kbps maximum baud rate limitation

Pramod Gurav (2):
  tty: serial: msm: Add mask value for UART_DM registers
  tty: serial: msm: replaces (1 << x) with BIT(x) macro

 .../devicetree/bindings/serial/qcom,msm-uartdm.txt |   6 +
 drivers/tty/serial/msm_serial.c                    | 622 +++++++++++++++++++--
 drivers/tty/serial/msm_serial.h                    |  53 +-
 3 files changed, 607 insertions(+), 74 deletions(-)

--
1.9.1
