From: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Subject: [PATCH v2 1/7] qcom-geni-se: Add QCOM GENI SE Driver summary
Date: Fri, 12 Jan 2018 18:05:41 -0700
Message-ID: <1515805547-22816-2-git-send-email-kramasub@codeaurora.org>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
To: corbet@lwn.net, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org
Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

Generic Interface (GENI) firmware based Qualcomm Universal Peripheral (QUP)
Wrapper is a programmable module that is composed of multiple Serial
Engines (SE) and can support various Serial Interfaces like UART, SPI,
I2C, I3C, etc. This document provides a high level overview of the GENI
based QUP Wrapper.

Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
---
 Documentation/qcom-geni-se.txt | 56 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/qcom-geni-se.txt

diff --git a/Documentation/qcom-geni-se.txt b/Documentation/qcom-geni-se.txt
new file mode 100644
index 0000000..dc517ef
--- /dev/null
+++ b/Documentation/qcom-geni-se.txt
@@ -0,0 +1,56 @@
+Introduction
+============
+
+Generic Interface (GENI) Serial Engine (SE) Wrapper driver is introduced
+to manage GENI firmware based Qualcomm Universal Peripheral (QUP) Wrapper
+controller. QUP Wrapper is designed to support various serial bus protocols
+like UART, SPI, I2C, I3C, etc.
+
+Hardware description
+====================
+
+GENI based QUP is a highly-flexible and programmable module for supporting
+a wide range of serial interfaces like UART, SPI, I2C, I3C, etc. A single
+QUP module can provide upto 8 Serial Interfaces, using its internal
+Serial Engines. The actual configuration is determined by the target
+platform configuration. The protocol supported by each interface is
+determined by the firmware loaded to the Serial Engine. Each SE consists
+of a DMA Engine and GENI sub modules which enable Serial Engines to
+support FIFO and DMA modes of operation.
+
+::
+
+                      +-----------------------------------------+
+                      |QUP Wrapper                              |
+                      |         +----------------------------+  |
+   --QUP & SE Clocks-->         | Serial Engine N            |  +-IO------>
+                      |         | ...                        |  | Interface
+   <---Clock Perf.----+    +----+-----------------------+    |  |
+     State Interface  |    | Serial Engine 1            |    |  |
+                      |    |                            |    |  |
+                      |    |                            |    |  |
+   <--------AHB------->    |                            |    |  |
+                      |    |                            +----+  |
+                      |    |                            |       |
+                      |    |                            |       |
+   <------SE IRQ------+    +----------------------------+       |
+                      |                                         |
+                      +-----------------------------------------+
+
+                         Figure 1: GENI based QUP Wrapper
+
+Software description
+====================
+
+GENI SE Wrapper driver is structured into 2 parts:
+
+geni_se_device represents QUP Wrapper controller. This part of the driver
+manages QUP Wrapper information such as hardware version, clock
+performance table that is common to all the internal Serial Engines.
+
+geni_se_rsc represents Serial Engine. This part of the driver manages
+Serial Engine information such as clocks, pinctrl states, containing QUP
+Wrapper. This part of driver also supports operations(eg. initialize the
+concerned Serial Engine, select between FIFO and DMA mode of operation etc.)
+that are common to all the Serial Engines and are independent of Serial
+Interfaces.
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
