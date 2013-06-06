From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 04/13] ARM: dts: list the CPU nodes for Exynos5250
Date: Thu, 6 Jun 2013 17:54:39 +0100
Message-ID: <20130606165439.GC23311@e106331-lin.cambridge.arm.com>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
 <1370516488-25860-4-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1370516488-25860-4-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "t.figa@samsung.com" <t.figa@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 06, 2013 at 12:01:18PM +0100, Chander Kashyap wrote:
> Instead of having to specify the number for CPUs in Exynos5250 in platsmp.c
> file, let the number of CPUs be determined by having this information listed
> in Exynos5250 device tree file.
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |   14 ++++++++++++++
>  arch/arm/mach-exynos/platsmp.c    |   10 +++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index e571d3b..7f6b1c7 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -50,6 +50,20 @@
>  		pinctrl3 = &pinctrl_3;
>  	};
>  
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			compatible = "arm,cortex-a15";
> +			reg = <0>;
> +		};
> +		cpu@1 {
> +			compatible = "arm,cortex-a15";
> +			reg = <1>;
> +		};
> +	};
> +

It would be nice to have device_type = "cpu" on each of the cpu nodes.

Thanks,
Mark.
