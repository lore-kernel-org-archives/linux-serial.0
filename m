From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 72/79] tty/serial: RS485 bindings for device tree
Date: Wed, 26 Oct 2011 14:13:17 +0200
Message-ID: <1319631204-23262-72-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32873 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932930Ab1JZMOD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:14:03 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Nicolas Ferre <nicolas.ferre@atmel.com>

Generic bindings for RS485 feature included in some UARTs.
Those bindings have to be used withing an UART device tree node.
Documentation updated to link to the bindings definition.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 Documentation/devicetree/bindings/serial/rs485.txt |   31 ++++++++++++++++++++
 .../devicetree/bindings/tty/serial/atmel-usart.txt |   27 +++++++++++++++++
 Documentation/serial/serial-rs485.txt              |    5 +++
 3 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/rs485.txt
 create mode 100644 Documentation/devicetree/bindings/tty/serial/atmel-usart.txt

diff --git a/Documentation/devicetree/bindings/serial/rs485.txt b/Documentation/devicetree/bindings/serial/rs485.txt
new file mode 100644
index 0000000..1e753c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/rs485.txt
@@ -0,0 +1,31 @@
+* RS485 serial communications
+
+The RTS signal is capable of automatically controlling line direction for
+the built-in half-duplex mode.
+The properties described hereafter shall be given to a half-duplex capable
+UART node.
+
+Required properties:
+- rs485-rts-delay: prop-encoded-array <a b> where:
+  * a is the delay beteween rts signal and beginning of data sent in milliseconds.
+      it corresponds to the delay before sending data.
+  * b is the delay between end of data sent and rts signal in milliseconds
+      it corresponds to the delay after sending data and actual release of the line.
+
+Optional properties:
+- linux,rs485-enabled-at-boot-time: empty property telling to enable the rs485
+  feature at boot time. It can be disabled later with proper ioctl.
+- rs485-rx-during-tx: empty property that enables the receiving of data even
+  whilst sending data.
+
+RS485 example for Atmel USART:
+	usart0: serial@fff8c000 {
+		compatible = "atmel,at91sam9260-usart";
+		reg = <0xfff8c000 0x4000>;
+		interrupts = <7>;
+		atmel,use-dma-rx;
+		atmel,use-dma-tx;
+		linux,rs485-enabled-at-boot-time;
+		rs485-rts-delay = <0 200>;		// in milliseconds
+	};
+
diff --git a/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt b/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
new file mode 100644
index 0000000..a49d9a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
@@ -0,0 +1,27 @@
+* Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
+
+Required properties:
+- compatible: Should be "atmel,<chip>-usart"
+  The compatible <chip> indicated will be the first SoC to support an
+  additional mode or an USART new feature.
+- reg: Should contain registers location and length
+- interrupts: Should contain interrupt
+
+Optional properties:
+- atmel,use-dma-rx: use of PDC or DMA for receiving data
+- atmel,use-dma-tx: use of PDC or DMA for transmitting data
+
+<chip> compatible description:
+- at91rm9200:  legacy USART support
+- at91sam9260: generic USART implementation for SAM9 SoCs
+
+Example:
+
+	usart0: serial@fff8c000 {
+		compatible = "atmel,at91sam9260-usart";
+		reg = <0xfff8c000 0x4000>;
+		interrupts = <7>;
+		atmel,use-dma-rx;
+		atmel,use-dma-tx;
+	};
+
diff --git a/Documentation/serial/serial-rs485.txt b/Documentation/serial/serial-rs485.txt
index c8878f8..079cb3d 100644
--- a/Documentation/serial/serial-rs485.txt
+++ b/Documentation/serial/serial-rs485.txt
@@ -28,6 +28,10 @@
    RS485 communications. This data structure is used to set and configure RS485
    parameters in the platform data and in ioctls.
 
+   The device tree can also provide RS485 boot time parameters (see [2]
+   for bindings). The driver is in charge of filling this data structure from
+   the values given by the device tree.
+
    Any driver for devices capable of working both as RS232 and RS485 should
    provide at least the following ioctls:
 
@@ -121,3 +125,4 @@
 5. REFERENCES
 
  [1]	include/linux/serial.h
+ [2]	Documentation/devicetree/bindings/serial/rs485.txt
-- 
1.7.7

