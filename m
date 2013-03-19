From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 7/7] ARM: sunxi: hackberry: Add UART muxing
Date: Tue, 19 Mar 2013 11:35:16 +0100
Message-ID: <1363689316-7847-8-git-send-email-maxime.ripard@free-electrons.com>
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

We previously relied on the bootloader to do the muxing of the UART for
the Hackberry. Don't rely on it anymore and use pinctrl.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Emilio L=C3=B3pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun4i-a10-hackberry.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/=
dts/sun4i-a10-hackberry.dts
index 9ab6875..2046000 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -24,6 +24,8 @@
=20
 	soc {
 		uart0: serial@01c28000 {
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&uart0_pins_a>;
 			status =3D "okay";
 		};
 	};
--=20
1.7.10.4
