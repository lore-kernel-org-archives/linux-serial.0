From: Mateusz Holenko <mholenko@antmicro.com>
Subject: [PATCH 2/3] dt-bindings: serial: document LiteUART bindings
Date: Mon, 30 Sep 2019 15:04:30 +0200
Message-ID: <20190930130430.GA9080@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc: Karol Gugala <kgugala@antmicro.com>, Mateusz Holenko <mholenko@antmicro.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Sam Ravnborg <sam@ravnborg.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Icenowy Zheng <icenowy@aosc.io>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-serial@vger.kernel.org

From: Filip Kokosinski <fkokosinski@internships.antmicro.com>

Add documentation for LiteUART devicetree bindings.

Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
---
 .../devicetree/bindings/serial/litex,liteuart.txt    | 12 ++++++++++++
 MAINTAINERS                                          |  6 ++++++
 2 files changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.txt

diff --git a/Documentation/devicetree/bindings/serial/litex,liteuart.txt b/Documentation/devicetree/bindings/serial/litex,liteuart.txt
new file mode 100644
index 000000000..13c71a0c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/litex,liteuart.txt
@@ -0,0 +1,12 @@
+LiteUART serial controller
+
+Required properties:
+- compatible: should be "litex,liteuart"
+- reg: base address and length of the register set for this device
+
+Example:
+
+uart0: serial@f0001000 {
+	compatible = "litex,liteuart";
+	reg = <0xe0001800 0x100>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index b2326dece..65a6cf296 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9462,6 +9462,12 @@ F:	Documentation/misc-devices/lis3lv02d.rst
 F:	drivers/misc/lis3lv02d/
 F:	drivers/platform/x86/hp_accel.c
 
+LITEX PLATFORM
+M:	Karol Gugala <kgugala@antmicro.com>
+M:	Mateusz Holenko <mholenko@antmicro.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/litex,liteuart.txt
+
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Jiri Kosina <jikos@kernel.org>
-- 
2.23.0
