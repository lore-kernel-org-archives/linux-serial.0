From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCHv2 1/2] dt: document the of_serial bindings
Date: Thu, 23 Jun 2011 15:08:34 +0100
Message-ID: <1308838115-23034-1-git-send-email-jamie@jamieiles.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50124 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257Ab1FWOIx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 23 Jun 2011 10:08:53 -0400
Received: by wyb38 with SMTP id 38so1309666wyb.19
        for <linux-serial@vger.kernel.org>; Thu, 23 Jun 2011 07:08:52 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jamie Iles <jamie@jamieiles.com>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>

The of_serial bindings can be used to register a number of serial
devices.  Document this binding with all of the others.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 .../devicetree/bindings/tty/serial/of-serial.txt   |   34 ++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/of-serial.txt

diff --git a/Documentation/devicetree/bindings/tty/serial/of-serial.txt b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
new file mode 100644
index 0000000..b0c52c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
@@ -0,0 +1,34 @@
+* UART (Universal Asynchronous Receiver/Transmitter)
+
+Required properties:
+- compatible : one of:
+	- "ns8250"
+	- "ns16450"
+	- "ns16550a"
+	- "ns16550"
+	- "ns16750"
+	- "ns16850"
+	- "nvidia,tegra250-uart"
+	- "ibm,qpace-nwp-serial"
+	- "serial" if the port type is unknown.
+- reg : offset and length of the register set for the device.
+- interrupts : should contain uart interrupt.
+- clock-frequency : the input clock frequency for the UART.
+
+Optional properties:
+- current-speed : the current active speed of the UART.
+- reg-offset : offset to apply to the mapbase from the start of the registers.
+- reg-shift : quantity to shift the register offsets by.
+- used-by-rtas : set to indicate that the port is in use by the firmware and
+  should not be registered.
+
+Example:
+
+	uart@80230000 {
+		compatible = "ns8250";
+		device-type = "serial";
+		reg = <0x80230000 0x100>;
+		clock-frequency = <3686400>;
+		interrupts = <10>;
+		reg-shift = <2>;
+	};
-- 
1.7.4.1

