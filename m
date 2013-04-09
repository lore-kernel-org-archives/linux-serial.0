From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH 3/4] ARM: davinci: da850: do not specify clock_frequency for UART DT node
Date: Tue, 9 Apr 2013 18:01:03 +0530
Message-ID: <1365510664-1394-4-git-send-email-prakash.pm@ti.com>
References: <1365510481-32129-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57453 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936714Ab3DIMah (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Apr 2013 08:30:37 -0400
In-Reply-To: <1365510481-32129-1-git-send-email-prakash.pm@ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-serial@vger.kernel.org
Cc: nsekhar@ti.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, "Manjunathappa, Prakash" <prakash.pm@ti.com>

DT kernel on da850-evm comes up with garbled UART logs. This is because
of mismatch in actual module clock rate and rate specified(clock-frequency)
in DT blob. kernel should not assume or depend on bootloaders clock
configuration, instead let it find the clock rate at runtime.

Issue discussed here before arriving on this implementation:
"ARM: davinci: da850 evm: update clock rate for UART 1/2 DT nodes"
https://patchwork.kernel.org/patch/2162271/

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 arch/arm/boot/dts/da850.dtsi |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 3ec1bda..4498375 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -66,7 +66,6 @@
 		serial0: serial@1c42000 {
 			compatible = "ns16550a";
 			reg = <0x42000 0x100>;
-			clock-frequency = <150000000>;
 			reg-shift = <2>;
 			interrupts = <25>;
 			status = "disabled";
@@ -74,7 +73,6 @@
 		serial1: serial@1d0c000 {
 			compatible = "ns16550a";
 			reg = <0x10c000 0x100>;
-			clock-frequency = <150000000>;
 			reg-shift = <2>;
 			interrupts = <53>;
 			status = "disabled";
@@ -82,7 +80,6 @@
 		serial2: serial@1d0d000 {
 			compatible = "ns16550a";
 			reg = <0x10d000 0x100>;
-			clock-frequency = <150000000>;
 			reg-shift = <2>;
 			interrupts = <61>;
 			status = "disabled";
-- 
1.7.4.1

