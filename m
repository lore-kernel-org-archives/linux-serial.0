From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 3/3] serial: sirf: add DT-binding document to describle detailed properties
Date: Tue, 13 Aug 2013 19:18:17 +0800
Message-ID: <1376392697-20664-3-git-send-email-Baohua.Song@csr.com>
References: <1376392697-20664-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:38860 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287Ab3HMLSg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Aug 2013 07:18:36 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so4743326pdj.18
        for <linux-serial@vger.kernel.org>; Tue, 13 Aug 2013 04:18:36 -0700 (PDT)
In-Reply-To: <1376392697-20664-1-git-send-email-Baohua.Song@csr.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Qipan Li <Qipan.Li@csr.com>

we defined some special properties for hardware flow control, document them
for DT-binding.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 .../devicetree/bindings/tty/serial/sirf-uart.txt   | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/sirf-uart.txt

diff --git a/Documentation/devicetree/bindings/tty/serial/sirf-uart.txt b/Documentation/devicetree/bindings/tty/serial/sirf-uart.txt
new file mode 100644
index 0000000..97dfd59
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/sirf-uart.txt
@@ -0,0 +1,34 @@
+* CSR SiRFprimaII/atlasVI Universal Synchronous Asynchronous Receiver/Transmitter *
+
+Required properties:
+- compatible : Should be "sirf,prima2-uart" or "sirf, prima2-usp-uart"
+- reg : Offset and length of the register set for the device
+- interrupts : Should contain uart interrupt
+- fifosize : Should define hardware rx/tx fifo size
+- clocks : Should contain uart clock number
+
+Optional properties:
+- sirf,uart-has-rtscts: we have hardware flow controller pins in hardware
+- rts-gpios: RTS pin for USP-based UART if sirf,uart-has-rtscts is true
+- cts-gpios: CTS pin for USP-based UART if sirf,uart-has-rtscts is true
+
+Example:
+
+uart0: uart@b0050000 {
+	cell-index = <0>;
+	compatible = "sirf,prima2-uart";
+	reg = <0xb0050000 0x1000>;
+	interrupts = <17>;
+	fifosize = <128>;
+	clocks = <&clks 13>;
+};
+
+On the board-specific dts, we can put rts-gpios and cts-gpios like
+
+usp@b0090000 {
+	compatible = "sirf,prima2-usp-uart";
+	sirf,uart-has-rtscts;
+	rts-gpios = <&gpio 15 0>;
+	cts-gpios = <&gpio 46 0>;
+};
+
-- 
1.8.2.3

