From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v2 6/9] ARM: meson: documentation: add bindings documentation
Date: Thu, 11 Sep 2014 22:11:37 +0200
Message-ID: <1410466300-19168-7-git-send-email-carlo@caione.org>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:53117 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606AbaIKUMR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Sep 2014 16:12:17 -0400
In-Reply-To: <1410466300-19168-1-git-send-email-carlo@caione.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com, maxime.ripard@free-electrons.com, afaerber@suse.de, matthias.bgg@gmail.com
Cc: Carlo Caione <carlo@caione.org>

Add vendor prefixes and basic documentation for MesonX SoCs bindings

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 Documentation/devicetree/bindings/arm/amlogic.txt     | 8 ++++++++
 Documentation/devicetree/bindings/arm/geniatech.txt   | 5 +++++
 Documentation/devicetree/bindings/vendor-prefixes.txt | 2 ++
 3 files changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic.txt
 create mode 100644 Documentation/devicetree/bindings/arm/geniatech.txt

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
new file mode 100644
index 0000000..7eece72
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -0,0 +1,8 @@
+Amlogic MesonX device tree bindings
+-------------------------------------------
+
+Boards with the Amlogic Meson6 SoC shall have the following properties:
+
+Required root node property:
+
+compatible = "amlogic,meson6";
diff --git a/Documentation/devicetree/bindings/arm/geniatech.txt b/Documentation/devicetree/bindings/arm/geniatech.txt
new file mode 100644
index 0000000..74ccba4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/geniatech.txt
@@ -0,0 +1,5 @@
+Geniatech platforms device tree bindings
+-------------------------------------------
+
+Geniatech ATV1200
+    - compatible = "geniatech,atv1200"
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 46a311e..fb32fe0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -13,6 +13,7 @@ allwinner	Allwinner Technology Co., Ltd.
 altr	Altera Corp.
 amcc	Applied Micro Circuits Corporation (APM, formally AMCC)
 amd	Advanced Micro Devices (AMD), Inc.
+amlogic	Amlogic, Inc.
 ams	AMS AG
 amstaos	AMS-Taos Inc.
 apm	Applied Micro Circuits Corporation (APM)
@@ -50,6 +51,7 @@ excito	Excito
 fsl	Freescale Semiconductor
 GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+geniatech	Geniatech, Inc.
 globalscale	Globalscale Technologies, Inc.
 gmt	Global Mixed-mode Technology, Inc.
 google	Google, Inc.
-- 
1.9.1

