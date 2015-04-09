From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V4 3/5] of: Document {little,big,native}-endian bindings
Date: Thu,  9 Apr 2015 13:05:16 -0700
Message-ID: <1428609918-10290-4-git-send-email-cernekee@gmail.com>
References: <1428609918-10290-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428609918-10290-1-git-send-email-cernekee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
Cc: arnd@arndb.de, peter@hurleysoftware.com, f.fainelli@gmail.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

These apply to newly converted drivers, like serial8250/libahci/...
The examples were adapted from the regmap bindings document.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../devicetree/bindings/common-properties.txt      | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/common-properties.txt

diff --git a/Documentation/devicetree/bindings/common-properties.txt b/Documentation/devicetree/bindings/common-properties.txt
new file mode 100644
index 000000000000..3193979b1d05
--- /dev/null
+++ b/Documentation/devicetree/bindings/common-properties.txt
@@ -0,0 +1,60 @@
+Common properties
+
+The ePAPR specification does not define any properties related to hardware
+byteswapping, but endianness issues show up frequently in porting Linux to
+different machine types.  This document attempts to provide a consistent
+way of handling byteswapping across drivers.
+
+Optional properties:
+ - big-endian: Boolean; force big endian register accesses
+   unconditionally (e.g. ioread32be/iowrite32be).  Use this if you
+   know the peripheral always needs to be accessed in BE mode.
+ - little-endian: Boolean; force little endian register accesses
+   unconditionally (e.g. readl/writel).  Use this if you know the
+   peripheral always needs to be accessed in LE mode.
+ - native-endian: Boolean; always use register accesses matched to the
+   endianness of the kernel binary (e.g. LE vmlinux -> readl/writel,
+   BE vmlinux -> ioread32be/iowrite32be).  In this case no byteswaps
+   will ever be performed.  Use this if the hardware "self-adjusts"
+   register endianness based on the CPU's configured endianness.
+
+If a binding supports these properties, then the binding should also
+specify the default behavior if none of these properties are present.
+In such cases, little-endian is the preferred default, but it is not
+a requirement.  The of_device_is_big_endian() and of_fdt_is_big_endian()
+helper functions do assume that little-endian is the default, because
+most existing (PCI-based) drivers implicitly default to LE by using
+readl/writel for MMIO accesses.
+
+Examples:
+Scenario 1 : CPU in LE mode & device in LE mode.
+dev: dev@40031000 {
+	      compatible = "name";
+	      reg = <0x40031000 0x1000>;
+	      ...
+	      native-endian;
+};
+
+Scenario 2 : CPU in LE mode & device in BE mode.
+dev: dev@40031000 {
+	      compatible = "name";
+	      reg = <0x40031000 0x1000>;
+	      ...
+	      big-endian;
+};
+
+Scenario 3 : CPU in BE mode & device in BE mode.
+dev: dev@40031000 {
+	      compatible = "name";
+	      reg = <0x40031000 0x1000>;
+	      ...
+	      native-endian;
+};
+
+Scenario 4 : CPU in BE mode & device in LE mode.
+dev: dev@40031000 {
+	      compatible = "name";
+	      reg = <0x40031000 0x1000>;
+	      ...
+	      little-endian;
+};
-- 
2.2.2
