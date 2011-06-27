From: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
Subject: [PATCHv3 1/2] dt: document the of_serial bindings
Date: Mon, 27 Jun 2011 13:32:33 +0100
Message-ID: <1309177954-8786-1-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

The of_serial bindings can be used to register a number of serial
devices.  Document this binding with all of the others.

v3: remove device-type and clarify used-by-rtas

Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
---
 .../devicetree/bindings/tty/serial/of-serial.txt   |   33 ++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/of-serial.txt

diff --git a/Documentation/devicetree/bindings/tty/serial/of-serial.txt b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
new file mode 100644
index 0000000..35e53ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
@@ -0,0 +1,33 @@
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
+- used-by-rtas : set to indicate that the port is in use by the OpenFirmware
+  RTAS and should not be registered.
+
+Example:
+
+	uart@80230000 {
+		compatible = "ns8250";
+		reg = <0x80230000 0x100>;
+		clock-frequency = <3686400>;
+		interrupts = <10>;
+		reg-shift = <2>;
+	};
-- 
1.7.4.1
