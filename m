From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 6/7] ARM: sunxi: dt: Add A10 UARTs to the dtsi.
Date: Tue, 19 Mar 2013 11:35:15 +0100
Message-ID: <1363689316-7847-7-git-send-email-maxime.ripard@free-electrons.com>
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

The Allwinner A10 SoC has 8 available UARTs, which is 6 more than on th=
e
A13, so add the missing UARTs to the sun4i-a10 dtsi.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Emilio L=C3=B3pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |   50 ++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i=
-a10.dtsi
index b605672..68a27fc 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -57,5 +57,55 @@
 			clocks =3D <&osc>;
 			status =3D "disabled";
 		};
+
+		uart2: serial@01c28800 {
+			compatible =3D "snps,dw-apb-uart";
+			reg =3D <0x01c28800 0x400>;
+			interrupts =3D <3>;
+			reg-shift =3D <2>;
+			reg-io-width =3D <4>;
+			clocks =3D <&osc>;
+			status =3D "disabled";
+		};
+
+		uart4: serial@01c29000 {
+			compatible =3D "snps,dw-apb-uart";
+			reg =3D <0x01c29000 0x400>;
+			interrupts =3D <17>;
+			reg-shift =3D <2>;
+			reg-io-width =3D <4>;
+			clocks =3D <&osc>;
+			status =3D "disabled";
+		};
+
+		uart5: serial@01c29400 {
+			compatible =3D "snps,dw-apb-uart";
+			reg =3D <0x01c29400 0x400>;
+			interrupts =3D <18>;
+			reg-shift =3D <2>;
+			reg-io-width =3D <4>;
+			clocks =3D <&osc>;
+			status =3D "disabled";
+		};
+
+		uart6: serial@01c29800 {
+			compatible =3D "snps,dw-apb-uart";
+			reg =3D <0x01c29800 0x400>;
+			interrupts =3D <19>;
+			reg-shift =3D <2>;
+			reg-io-width =3D <4>;
+			clocks =3D <&osc>;
+			status =3D "disabled";
+		};
+
+		uart7: serial@01c29c00 {
+			compatible =3D "snps,dw-apb-uart";
+			reg =3D <0x01c29c00 0x400>;
+			interrupts =3D <20>;
+			reg-shift =3D <2>;
+			reg-io-width =3D <4>;
+			clocks =3D <&osc>;
+			status =3D "disabled";
+		};
 	};
 };
--=20
1.7.10.4
