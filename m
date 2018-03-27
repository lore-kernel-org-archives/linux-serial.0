From: Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 00/12] Add r8a77470/iW-RainboW-G23S single board computer
 support
Date: Tue, 27 Mar 2018 15:37:11 +0100
Message-ID: <1522161443-54428-1-git-send-email-biju.das@bp.renesas.com>
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

This patch series tested against linux-next tag next-20180327 and
renesas-dev branch tag "renesas-dev-20180326v2-v4.16-rc7

Biju Das (12):
  soc: renesas: rcar-sysc: Add r8a77470 support
  soc: renesas: Identify RZ/G1C
  soc: renesas: rcar-rst: Add support for RZ/G1C
  serial: sh-sci: Document r8a77470 bindings
  clk: renesas: Add r8a77470 CPG Core Clock Definitions
  clk: renesas: cpg-mssr: Add r8a77470 support
  ARM: shmobile: r8a77470: basic SoC support
  ARM: dts: r8a77470: Initial SoC device tree
  ARM: shmobile: Document iW-RainboW-G23S single board computer
  ARM: dts: iwg23s-sbc: Add support for iWave G23S-SBC based on RZ/G1C
  ARM: shmobile: defconfig: Enable r8a77470 SoC
  ARM: multi_v7_defconfig: Enable r8a77470 SoC

 Documentation/devicetree/bindings/arm/shmobile.txt |   4 +
 .../devicetree/bindings/clock/renesas,cpg-mssr.txt |   9 +-
 .../bindings/power/renesas,rcar-sysc.txt           |   1 +
 .../devicetree/bindings/reset/renesas,rst.txt      |   1 +
 .../bindings/serial/renesas,sci-serial.txt         |   2 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts          |  30 +++
 arch/arm/boot/dts/r8a77470.dtsi                    | 156 ++++++++++++++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/configs/shmobile_defconfig                |   1 +
 arch/arm/mach-shmobile/Kconfig                     |   4 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |   2 +
 drivers/clk/renesas/Kconfig                        |   5 +
 drivers/clk/renesas/Makefile                       |   1 +
 drivers/clk/renesas/r8a7747x-cpg-mssr.c            | 229 +++++++++++++++++++++
 drivers/clk/renesas/rcar-gen2-cpg.c                |  34 ++-
 drivers/clk/renesas/renesas-cpg-mssr.c             |   6 +
 drivers/clk/renesas/renesas-cpg-mssr.h             |   1 +
 drivers/soc/renesas/Kconfig                        |   5 +
 drivers/soc/renesas/Makefile                       |   1 +
 drivers/soc/renesas/r8a7747x-sysc.c                |  29 +++
 drivers/soc/renesas/rcar-rst.c                     |   1 +
 drivers/soc/renesas/rcar-sysc.c                    |   3 +
 drivers/soc/renesas/rcar-sysc.h                    |   1 +
 drivers/soc/renesas/renesas-soc.c                  |   8 +
 include/dt-bindings/clock/r8a7747x-cpg-mssr.h      |  36 ++++
 include/dt-bindings/power/r8a7747x-sysc.h          |  22 ++
 27 files changed, 587 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
 create mode 100644 arch/arm/boot/dts/r8a77470.dtsi
 create mode 100644 drivers/clk/renesas/r8a7747x-cpg-mssr.c
 create mode 100644 drivers/soc/renesas/r8a7747x-sysc.c
 create mode 100644 include/dt-bindings/clock/r8a7747x-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/r8a7747x-sysc.h

-- 
2.7.4
