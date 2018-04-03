From: Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH v3 0/3] Add r8a77470/iW-RainboW-G23S single board computer
 support
Date: Tue,  3 Apr 2018 12:19:36 +0100
Message-ID: <1522754379-64116-1-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Kishon Vijay Abraham I <kishon@ti.com>, Chris Paterson <Chris.Paterson2@renesas.com>, Borislav Petkov <bp@suse.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Magnus Damm <magnus.damm@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Simon Horman <horms@verge.net.au>, Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>, linux-clk@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-serial@vger.kernel.org

Hello, 

This series adds support for Rensas RZ/G1C (r8a77470) SoC and
RZ/G1C based iW-RainboW-G23S single board computer.

The series introduces a cpg-mssr clock/power gating module, a power/reset
controller for the SoC.

power areas for RZ/G1C are similar to RZ/G1E.

Few functionalities have currently been enabled in DTS and tested: serial
boot console.

This patch series tested against renesas-dev branch 
tag "renesas-dev-20180328-v4.16-rc7

V1-->V2
	Incorporated geert's review comments.
V2-->V3
        Incorporated simon and geert's review comments.

Biju Das (3):
  serial: sh-sci: Document r8a77470 bindings
  ARM: dts: r8a77470: Initial SoC device tree
  ARM: dts: iwg23s-sbc: Add support for iWave G23S-SBC based on RZ/G1C

 .../bindings/serial/renesas,sci-serial.txt         |   2 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts          |  35 +++++
 arch/arm/boot/dts/r8a77470.dtsi                    | 154 +++++++++++++++++++++
 4 files changed, 192 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
 create mode 100644 arch/arm/boot/dts/r8a77470.dtsi

-- 
2.7.4
