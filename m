From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v3 00/10] ARM: Exynos: Add Exynos5420 SoC support
Date: Mon, 17 Jun 2013 13:45:58 +0200
Message-ID: <2185503.D4KZKFJ8y6@amdc1227>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:38235 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932741Ab3FQLqH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Jun 2013 07:46:07 -0400
In-reply-to: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, s.nawrocki@samsung.com, mark.rutland@arm.com, thomas.ab@samsung.com

Hi Chander,

On Monday 17 of June 2013 16:30:25 Chander Kashyap wrote:
> Exynos5420 is new SoC in Samsung's Exynos5 SoC series. This series adds
> initial support for this SoC.
> Changes since v2:
> 
> 1. Renamed oscclk to fin_pll, in order to keep it consistant with
> Exynos4/Exynos5 2. Pass memory as single bank rather than splitting in
> 256MB size banks.
> 
> Changes since v1:
> 
> 1. As not-dt platforms will not be supported from 3.11 onwards, following
>    patches from previous patch series are dropped:
>    "irqchip: exynos-combiner: set irq base as 256 for Exynos5420"
>    "ARM: Exynos: initialize l2x0 cache controller only for cortex-a9 based
> SoCs" 2. Added device type property in cpu node in the following patch:
>    "ARM: dts: list the CPU nodes for Exynos5250
> 3. Sorted out the nodes listed in based upon the physical addresses as
> suggested by Tomasz Figa.
> 4. As Tomasz is going to consolidate the secondary cpu power register
> address calculation in all possible scnarios, hence dropped the following
> patch: "ARM: Exynos: fix secondary cpu power control register address
> calculation" 5. Replaced the setup/remove)_irq calls with
> (request/free)_irq calls as suggested by Mark Rutland in patch:
>    "clocksource: exynos_mct: use (request/free)_irq calls for local timer
>     registration"
> 6. Changed the registration of epll and rpll from pll35xx to pl36xx.
> 7. Changed driver data selection for serial port, based on ARCH_EXYNOS.
> 8. Changed the interrupt cells from 2 to 1 as suggested by Tomasz Figa.
> 
> Chander Kashyap (10):
>   ARM: dts: fork out common Exynos5 nodes
>   ARM: dts: list the CPU nodes for Exynos5250
>   ARM: Exynos: Add support for Exynos5420 SoC
>   serial: samsung: select Exynos specific driver data if ARCH_EXYNOS is
>     defined
>   ARM: Exynos: use four additional chipid bits to identify Exynos
>     family
>   clk: exynos5420: register clocks using common clock framework
>   ARM: dts: Add initial device tree support for Exynos5420
>   clocksource: exynos_mct: use (request/free)_irq calls for local timer
>     registration
>   ARM: Exynos: add secondary CPU boot base location for Exynos5420
>   ARM: Exynos: extend soft-reset support for Exynos5420
> 
>  .../devicetree/bindings/clock/exynos5420-clock.txt |  201 ++++++
>  arch/arm/boot/dts/Makefile                         |    1 +
>  arch/arm/boot/dts/exynos5.dtsi                     |  111 +++
>  arch/arm/boot/dts/exynos5250.dtsi                  |   80 +-
>  arch/arm/boot/dts/exynos5420-smdk5420.dts          |   33 +
>  arch/arm/boot/dts/exynos5420.dtsi                  |  103 +++
>  arch/arm/mach-exynos/Kconfig                       |   10 +
>  arch/arm/mach-exynos/common.c                      |   18 +-
>  arch/arm/mach-exynos/include/mach/uncompress.h     |    7 +-
>  arch/arm/mach-exynos/mach-exynos5-dt.c             |    1 +
>  arch/arm/mach-exynos/platsmp.c                     |   12 +-
>  arch/arm/plat-samsung/include/plat/cpu.h           |    8 +
>  drivers/clk/samsung/Makefile                       |    1 +
>  drivers/clk/samsung/clk-exynos5420.c               |  762
> ++++++++++++++++++++ drivers/clocksource/exynos_mct.c                   |  
> 35 +-
>  drivers/tty/serial/samsung.c                       |    4 +-
>  16 files changed, 1280 insertions(+), 107 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/clock/exynos5420-clock.txt create mode
> 100644 arch/arm/boot/dts/exynos5.dtsi
>  create mode 100644 arch/arm/boot/dts/exynos5420-smdk5420.dts
>  create mode 100644 arch/arm/boot/dts/exynos5420.dtsi
>  create mode 100644 drivers/clk/samsung/clk-exynos5420.c

Except one comment for patch 07/10, the whole series looks good to me. Have my

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz

