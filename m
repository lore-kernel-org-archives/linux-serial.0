From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v2 4/9] ARM: meson: documentation: add timer documentation
Date: Thu, 11 Sep 2014 22:11:35 +0200
Message-ID: <1410466300-19168-5-git-send-email-carlo@caione.org>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:54878 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579AbaIKUMM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Sep 2014 16:12:12 -0400
In-Reply-To: <1410466300-19168-1-git-send-email-carlo@caione.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com, maxime.ripard@free-electrons.com, afaerber@suse.de, matthias.bgg@gmail.com
Cc: Carlo Caione <carlo@caione.org>

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 .../devicetree/bindings/timer/amlogic,meson6-timer.txt   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt b/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
new file mode 100644
index 0000000..cf89894
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
@@ -0,0 +1,16 @@
+Amlogic Meson6 SoCs Timer Controller
+
+Required properties:
+
+- compatible : should be "amlogic,meson6-timer.txt"
+- reg : Specifies base physical address and size of the registers.
+- interrupts : The interrupt of the first timer
+
+Example:
+
+timer@c1109940 {
+	compatible = "amlogic,meson6-timer";
+	reg = <0xc1109940 0x14>;
+	interrupts = <0 10 1>;
+};
+
-- 
1.9.1

