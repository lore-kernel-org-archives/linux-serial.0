From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 5/7] ARM: sunxi: dt: Add uart3 dt node
Date: Tue, 19 Mar 2013 11:35:14 +0100
Message-ID: <1363689316-7847-6-git-send-email-maxime.ripard@free-electrons.com>
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

Both A10 and A13 Allwinner SoCs have a Synopsys APB uart3 device
available, so add it to the sunxi.dtsi file

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Emilio L=C3=B3pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sunxi.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dts=
i
index cf53c43..a85030b 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -68,5 +68,15 @@
 			clocks =3D <&osc>;
 			status =3D "disabled";
 		};
+
+		uart3: serial@01c28c00 {
+			compatible =3D "snps,dw-apb-uart";
+			reg =3D <0x01c28c00 0x400>;
+			interrupts =3D <4>;
+			reg-shift =3D <2>;
+			reg-io-width =3D <4>;
+			clocks =3D <&osc>;
+			status =3D "disabled";
+		};
 	};
 };
--=20
1.7.10.4
