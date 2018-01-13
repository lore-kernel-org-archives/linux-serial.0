From: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Subject: [PATCH v2 0/7] Introduce GENI SE Controller Driver
Date: Fri, 12 Jan 2018 18:05:40 -0700
Message-ID: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: corbet@lwn.net, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org
Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

Generic Interface (GENI) firmware based Qualcomm Universal Peripheral (QUP)
Wrapper is a next generation programmable module for supporting a wide
range of serial interfaces like UART, SPI, I2C, I3C, etc. A single QUP
module can provide upto 8 Serial Interfaces using its internal Serial
Engines (SE). The protocol supported by each interface is determined by
the firmware loaded to the Serial Engine.

This patch series introduces GENI SE Driver to manage the GENI based QUP
Wrapper and the common aspects of all SEs inside the QUP Wrapper. This
patch series also introduces the UART and I2C Controller drivers to
drive the SEs that are programmed with the respective protocols.

[v2]
 * Updated device tree bindings to describe the hardware
 * Updated SE DT node as child node of QUP Wrapper DT node
 * Moved common AHB clocks to QUP Wrapper DT node
 * Use the standard "clock-frequency" I2C property
 * Update compatible field in UART Controller to reflect hardware manual
 * Addressed other device tree binding specific comments from Rob Herring

Karthikeyan Ramasubramanian (7):
  qcom-geni-se: Add QCOM GENI SE Driver summary
  dt-bindings: soc: qcom: Add device tree binding for GENI SE
  soc: qcom: Add GENI based QUP Wrapper driver
  dt-bindings: i2c: Add device tree bindings for GENI I2C Controller
  i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C
    controller
  dt-bindings: serial: Add bindings for GENI based UART Controller
  tty: serial: msm_geni_serial: Add serial driver support for GENI based
    QUP

 .../devicetree/bindings/i2c/i2c-qcom-geni.txt      |   35 +
 .../devicetree/bindings/serial/qcom,geni-uart.txt  |   29 +
 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |   66 +
 Documentation/qcom-geni-se.txt                     |   56 +
 drivers/i2c/busses/Kconfig                         |   10 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-qcom-geni.c                 |  656 +++++++++
 drivers/soc/qcom/Kconfig                           |    8 +
 drivers/soc/qcom/Makefile                          |    1 +
 drivers/soc/qcom/qcom-geni-se.c                    | 1016 ++++++++++++++
 drivers/tty/serial/Kconfig                         |   10 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/qcom_geni_serial.c              | 1414 ++++++++++++++++++++
 include/linux/qcom-geni-se.h                       |  807 +++++++++++
 14 files changed, 4110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,geni-uart.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
 create mode 100644 Documentation/qcom-geni-se.txt
 create mode 100644 drivers/i2c/busses/i2c-qcom-geni.c
 create mode 100644 drivers/soc/qcom/qcom-geni-se.c
 create mode 100644 drivers/tty/serial/qcom_geni_serial.c
 create mode 100644 include/linux/qcom-geni-se.h

-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

