From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 4/7] ARM: sunxi: dt: Move uart0 to sun4i-a10.dtsi
Date: Tue, 19 Mar 2013 11:35:13 +0100
Message-ID: <1363689316-7847-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1363689316-7847-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363689316-7847-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kevin@allwinnertech.com, sunny@allwinnertech.com, shuge@allwinnertech.com, linux-serial@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The UART0 is only available on the Allwinner A10 SoCs, and not on the
A13, so move the uart0 node to sun4i-a10.dtsi.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Emilio L=C3=B3pez <emilio@elopez.com.ar>
Tested-by: Emilio L=C3=B3pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |   10 ++++++++++
 arch/arm/boot/dts/sunxi.dtsi     |   10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i=
-a10.dtsi
index 03d2b53..b605672 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -47,5 +47,15 @@
 				allwinner,pull =3D <0>;
 			};
 		};
+
+		uart0: serial@01c28000 {
+			compatible =3D "snps,dw-apb-uart";
+			reg =3D <0x01c28000 0x400>;
+			interrupts =3D <1>;
+			reg-shift =3D <2>;
+			reg-io-width =3D <4>;
+			clocks =3D <&osc>;
+			status =3D "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dts=
i
index 1e0f4b5..cf53c43 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -59,16 +59,6 @@
 			#interrupt-cells =3D <1>;
 		};
=20
-		uart0: serial@01c28000 {
-			compatible =3D "snps,dw-apb-uart";
-			reg =3D <0x01c28000 0x400>;
-			interrupts =3D <1>;
-			reg-shift =3D <2>;
-			reg-io-width =3D <4>;
-			clocks =3D <&osc>;
-			status =3D "disabled";
-		};
-
 		uart1: serial@01c28400 {
 			compatible =3D "snps,dw-apb-uart";
 			reg =3D <0x01c28400 0x400>;
--=20
1.7.10.4
