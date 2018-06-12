From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/7] clk: intel: Add clock driver for GRX500 SoC
Date: Tue, 12 Jun 2018 16:37:25 -0600
Message-ID: <20180612223725.GC2197@rob-hp-laptop>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-3-songjun.wu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180612054034.4969-3-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Songjun Wu <songjun.wu@linux.intel.com>
Cc: hua.ma@linux.intel.com, yixin.zhu@linux.intel.com, chuanhua.lei@intel.com, linux-mips@linux-mips.org, qi-ming.wu@intel.com, linux-clk@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 12, 2018 at 01:40:29PM +0800, Songjun Wu wrote:
> From: Yixin Zhu <yixin.zhu@linux.intel.com>
> 
> PLL of GRX500 provide clock to DDR, CPU, and peripherals as show below
> 
>                  +---------+
> 	    |--->| LCPLL3 0|--PCIe clk-->
>    XO       |    +---------+
> +-----------|
>             |    +---------+
>             |    |        3|--PAE clk-->
>             |--->| PLL0B  2|--GSWIP clk-->
>             |    |        1|--DDR clk-->DDR PHY clk-->
>             |    |        0|--CPU1 clk--+   +-----+
>             |    +---------+            |--->0    |
>             |                               | MUX |--CPU clk-->
>             |    +---------+            |--->1    |
>             |    |        0|--CPU0 clk--+   +-----+
>             |--->| PLLOA  1|--SSX4 clk-->
>                  |        2|--NGI clk-->
>                  |        3|--CBM clk-->
>                  +---------+
> 
> VCO of all PLLs of GRX500 is not supposed to be reprogrammed.
> DDR PHY clock is created to show correct clock rate in software
> point of view.
> CPU clock of 1Ghz from PLL0B otherwise from PLL0A.
> Signed-off-by: Yixin Zhu <yixin.zhu@linux.intel.com>
> 
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>

Need a blank line before the SoB's and not one in the middle.

> ---
> 
>  .../devicetree/bindings/clock/intel,grx500-clk.txt |  46 ++

Please split bindings to separate patch.

>  drivers/clk/Kconfig                                |   1 +
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/intel/Kconfig                          |  21 +
>  drivers/clk/intel/Makefile                         |   7 +
>  drivers/clk/intel/clk-cgu-api.c                    | 676 +++++++++++++++++++++
>  drivers/clk/intel/clk-cgu-api.h                    | 120 ++++
>  drivers/clk/intel/clk-grx500.c                     | 236 +++++++
>  include/dt-bindings/clock/intel,grx500-clk.h       |  61 ++
>  9 files changed, 1169 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
>  create mode 100644 drivers/clk/intel/Kconfig
>  create mode 100644 drivers/clk/intel/Makefile
>  create mode 100644 drivers/clk/intel/clk-cgu-api.c
>  create mode 100644 drivers/clk/intel/clk-cgu-api.h
>  create mode 100644 drivers/clk/intel/clk-grx500.c
>  create mode 100644 include/dt-bindings/clock/intel,grx500-clk.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
> new file mode 100644
> index 000000000000..dd761d900dc9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
> @@ -0,0 +1,46 @@
> +Device Tree Clock bindings for GRX500 PLL controller.
> +
> +This binding uses the common clock binding:
> +	Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +This GRX500 PLL controller provides the 5 main clock domain of the SoC: CPU/DDR, XBAR,
> +Voice, WLAN, PCIe and gate clocks for HW modules.
> +
> +Required properties for osc clock node
> +- compatible: Should be intel,grx500-xxx-clk

These would need to be enumerated with all possible values. However, see 
below.

> +- reg: offset address of the controller memory area.
> +- clocks: phandle of the external reference clock
> +- #clock-cells: can be one or zero.
> +- clock-output-names: Names of the output clocks.
> +
> +Example:
> +	pll0aclk: pll0aclk {
> +		#clock-cells = <1>;
> +		compatible = "intel,grx500-pll0a-clk";
> +		clocks = <&pll0a>;
> +		reg = <0x8>;
> +		clock-output-names = "cbmclk", "ngiclk", "ssx4clk", "cpu0clk";
> +	};
> +
> +	cpuclk: cpuclk {
> +		#clock-cells = <0>;
> +		compatible = "intel,grx500-cpu-clk";
> +		clocks = <&pll0aclk CPU0_CLK>, <&pll0bclk CPU1_CLK>;
> +		reg = <0x8>;
> +		clock-output-names = "cpu";
> +	};
> +
> +Required properties for gate node:
> +- compatible: Should be intel,grx500-gatex-clk
> +- reg: offset address of the controller memory area.
> +- #clock-cells: Should be <1>
> +- clock-output-names: Names of the output clocks.
> +
> +Example:
> +	clkgate0: clkgate0 {
> +		#clock-cells = <1>;
> +		compatible = "intel,grx500-gate0-clk";
> +		reg = <0x114>;
> +		clock-output-names = "gate_xbar0", "gate_xbar1", "gate_xbar2",
> +		"gate_xbar3", "gate_xbar6", "gate_xbar7";
> +	};

We generally don't do a clock node per clock or few clocks but rather 1 
clock node per clock controller block. See any recent clock bindings.

Rob
