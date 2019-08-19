From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 2/6] arm64: Introduce config for S32
Date: Mon, 19 Aug 2019 10:14:58 +0200
Message-ID: <20190819081457.GH5999@X250>
References: <20190809112853.15846-1-stefan-gabriel.mirea@nxp.com>
 <20190809112853.15846-3-stefan-gabriel.mirea@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190809112853.15846-3-stefan-gabriel.mirea@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, Leo Li <leoyang.li@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Cosmin Stefan Stoica <cosmin.stoica@nxp.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 09, 2019 at 11:29:10AM +0000, Stefan-gabriel Mirea wrote:
> From: Mihaela Martinas <Mihaela.Martinas@freescale.com>
> 
> Add configuration option for the Freescale S32 platform family in
> Kconfig.platforms. For starters, the only SoC supported will be Treerunner
> (S32V234), with a single execution target: the S32V234-EVB (rev 29288)
> board.
> 
> Signed-off-by: Mihaela Martinas <Mihaela.Martinas@freescale.com>
> Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> ---
>  arch/arm64/Kconfig.platforms | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 4778c775de1b..a9a6152d37eb 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -210,6 +210,11 @@ config ARCH_ROCKCHIP
>  	  This enables support for the ARMv8 based Rockchip chipsets,
>  	  like the RK3368.
>  
> +config ARCH_S32
> +	bool "Freescale S32 SoC Family"

So you still want to use 'Freescale' than 'NXP' here?

> +	help
> +	  This enables support for the Freescale S32 family of processors.

Shawn

> +
>  config ARCH_SEATTLE
>  	bool "AMD Seattle SoC Family"
>  	help
> -- 
> 2.22.0
> 
