From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V3 3/7] of: Document {little,big,native}-endian bindings
Date: Mon, 24 Nov 2014 15:36:18 -0800
Message-ID: <1416872182-6440-4-git-send-email-cernekee@gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:62266 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbaKXXgd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Nov 2014 18:36:33 -0500
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
Cc: arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org

These apply to newly converted drivers, like serial8250/libahci/...
The examples were adapted from the regmap bindings document.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../devicetree/bindings/common-properties.txt      | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/common-properties.txt

diff --git a/Documentation/devicetree/bindings/common-properties.txt b/Documentation/devicetree/bindings/common-properties.txt
new file mode 100644
index 0000000..21044a4
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
+   peripheral always needs to be accessed in LE mode.  This is the
+   default.
+ - native-endian: Boolean; always use register accesses matched to the
+   endianness of the kernel binary (e.g. LE vmlinux -> readl/writel,
+   BE vmlinux -> ioread32be/iowrite32be).  In this case no byteswaps
+   will ever be performed.  Use this if the hardware "self-adjusts"
+   register endianness based on the CPU's configured endianness.
+
+Note that regmap, in contrast, defaults to native-endian.  But this
+document is targeted for existing drivers, most of which currently use
+readl/writel because they expect to be accessing PCI/PCIe devices rather
+than memory-mapped SoC peripherals.  Since the readl/writel accessors
+perform a byteswap on BE systems, this means that the drivers in question
+are implicitly "little-endian".
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
2.1.0

