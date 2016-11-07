From: Simon Horman <horms@verge.net.au>
Subject: [PATCH/RFC] arm64: dts: r8a7796-salvator-x: Disable sdr104 of SDHI
Date: Mon,  7 Nov 2016 16:33:34 +0100
Message-ID: <1478532814-8652-1-git-send-email-horms@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

The problem which the card inserted in the slot of SDHI{0,3} does not
recognize in the combination of some boards and UHS-I sdcard occurred.

Therefore, this patch repealed SDR104 of SDHI0 and SDHI3.

Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index 03334e943efa..c3061a6df410 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -567,7 +567,6 @@
 	wp-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
 	bus-width = <4>;
 	sd-uhs-sdr50;
-	sd-uhs-sdr104;
 	status = "okay";
 };
 
@@ -597,7 +596,6 @@
 	wp-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
 	bus-width = <4>;
 	sd-uhs-sdr50;
-	sd-uhs-sdr104;
 	status = "okay";
 };
 
-- 
2.7.0.rc3.207.g0ac5344
