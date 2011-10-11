From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [RFC PATCH] tty/serial: RS485 bindings for device tree
Date: Tue, 11 Oct 2011 19:13:28 +0200
Message-ID: <1318353208-24422-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, claudio@evidence.eu.com, jesper.nilsson@axis.com, alan@lxorguk.ukuu.org.uk
Cc: grant.likely@secretlab.ca, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Generic bindings for RS485 feature included in some UARTs.
Those bindings have to be used withing an UART device tree node.
Documentation updated to link to the bindings definition.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Hi all,

1/ I have used the "linux" vendor definition: tell me if it makes sense...
2/ I have the feeling that the SER_RS485_RTS_ON_SEND flag can easily deduced
   from a zero value on both "before" and "after" data delays.

Tell me what you think about this...

Bye,

 Documentation/devicetree/bindings/serial/rs485.txt |   28 ++++++++++++++++++++
 Documentation/serial/serial-rs485.txt              |    5 +++
 2 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/rs485.txt

diff --git a/Documentation/devicetree/bindings/serial/rs485.txt b/Documentation/devicetree/bindings/serial/rs485.txt
new file mode 100644
index 0000000..6514be8
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/rs485.txt
@@ -0,0 +1,28 @@
+* RS485 serial communications
+
+The RTS signal is capable of automatically controlling line direction for
+the built-in half-duplex mode.
+The properties described hereafter shall be given to a half-duplex capable
+UART node.
+
+Optional properties:
+- linux,rs485-enabled-at-boot-time: empty property telling to enable the rs485
+  feature at boot time. It can be disabled later with proper ioctl.
+- linux,rs485-rts-delay: prop-encoded-array <a b> where:
+  * a is the delay beteween rts signal and beginning of data sent in milliseconds.
+      it corresponds to the delay before sending data.
+  * b is the delay between end of data sent and rts signal in milliseconds
+      it corresponds to the delay after sending data and actual release of the
+      line.
+
+RS485 example for Atmel USART:
+	usart0: serial@fff8c000 {
+		compatible = "atmel,at91sam9260-usart";
+		reg = <0xfff8c000 0x4000>;
+		interrupts = <7>;
+		atmel,use-dma-rx;
+		atmel,use-dma-tx;
+		linux,rs485-enabled-at-boot-time;
+		linux,rs485-rts-delay = <0 200>;	// in milliseconds
+	};
+
diff --git a/Documentation/serial/serial-rs485.txt b/Documentation/serial/serial-rs485.txt
index a493238..d11e5eb 100644
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
 
@@ -118,3 +122,4 @@
 5. REFERENCES
 
  [1]	include/linux/serial.h
+ [2]	Documentation/devicetree/bindings/serial/rs485.txt
-- 
1.7.5.4
