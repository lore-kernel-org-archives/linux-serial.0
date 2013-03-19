From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCHv4 0/7] ARM: sunxi: Extend UART support for Allwinner SoCs
Date: Tue, 19 Mar 2013 11:35:09 +0100
Message-ID: <1363689316-7847-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:42762 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781Ab3CSKfU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Mar 2013 06:35:20 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kevin@allwinnertech.com, sunny@allwinnertech.com, shuge@allwinnertech.com, linux-serial@vger.kernel.org

Hi,

This patchset reworks a bit the UART support that is found in the DT
for Allwinner SoCs, which was quite limited until now.

It first switches to using the clocks property, then rework a bit the
DTSI to have only the UART available in the A10 and the A13 (the A10
has 8 UARTs, while A13 has only the uart1 and uart3).

Thanks,
Maxime

Changes from v3:
  - Renamed uart nodes to serial
  - Reworked the patch for 8250_dw to use the IS_ERR macro for clocks e=
rror
    checking

Changes from v2:
  - Reworked Emilio's patch according to Heikki Krogerus' review to ena=
ble the
    use of the clock framework even when not using the dt

Emilio L=C3=B3pez (1):
  serial: 8250_dw: add support for clk api

Maxime Ripard (6):
  ARM: sunxi: dt: Use clocks property instead of clock-frequency for
    the UARTs
  ARM: sunxi: Rename uart nodes to serial
  ARM: sunxi: dt: Move uart0 to sun4i-a10.dtsi
  ARM: sunxi: dt: Add uart3 dt node
  ARM: sunxi: dt: Add A10 UARTs to the dtsi.
  ARM: sunxi: hackberry: Add UART muxing

 arch/arm/boot/dts/sun4i-a10-cubieboard.dts |    4 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts  |    4 +-
 arch/arm/boot/dts/sun4i-a10.dtsi           |   60 ++++++++++++++++++++=
++++++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts  |    2 +-
 arch/arm/boot/dts/sunxi.dtsi               |   16 ++++----
 drivers/tty/serial/8250/8250_dw.c          |   33 ++++++++++-----
 6 files changed, 98 insertions(+), 21 deletions(-)

--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
