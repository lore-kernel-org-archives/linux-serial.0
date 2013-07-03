From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH v2 5/5] ARM: dts: enable the uart2 for imx6q-arm2
Date: Wed, 3 Jul 2013 17:42:37 +0800
Message-ID: <1372844557-3078-6-git-send-email-b32955@freescale.com>
References: <1372844557-3078-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [213.199.154.187] ([213.199.154.187]:30239 "EHLO
	db8outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755352Ab3GCKKl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Jul 2013 06:10:41 -0400
In-Reply-To: <1372844557-3078-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, Huang Shijie <b32955@freescale.com>

enable the uart2 for imx6q-arm2 board.
The uart2 works in the DTE mode, with the RTS/CTS and DMA enabled.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6q-arm2.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index 4e54fde..8beaa68 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -97,6 +97,16 @@
 	status = "okay";
 };
 
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2_dte>;
+	fsl,dte-mode;
+	fsl,uart-has-rtscts;
+	dma-names = "rx", "tx";
+	dmas = <&sdma 27 4 0>, <&sdma 28 4 0>;
+	status = "okay";
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4_1>;
-- 
1.7.1


