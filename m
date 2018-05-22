From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 7/8] arm64: tegra: Add nodes for tcu on Tegra194
Date: Tue, 22 May 2018 17:28:26 +0100
Message-ID: <295c8125-6cdc-92b6-d0d7-01bf6ba0f8bd@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-8-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180508114403.14499-8-mperttunen@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>, robh+dt@kernel.org, mark.rutland@arm.com, jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, thierry.reding@gmail.com
Cc: araza@nvidia.com, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


On 08/05/18 12:44, Mikko Perttunen wrote:
> Add nodes required for communication through the Tegra Combined UART.
> This includes the AON HSP instance, addition of shared interrupts
> for the TOP0 HSP instance, and finally the TCU node itself. Also
> mark the HSP instances as compatible to tegra194-hsp, as the hardware
> is not identical but is compatible to tegra186-hsp.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 34 +++++++++++++++++++++++++++++---
>   1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index 6d699815a84f..d7f780b06fe2 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -217,10 +217,31 @@
>   		};
>   
>   		hsp_top0: hsp@3c00000 {
> -			compatible = "nvidia,tegra186-hsp";
> +			compatible = "nvidia,tegra194-hsp", "nvidia,tegra186-hsp";

I might be wrong, but I think we may need to update the binding doc 
compatibility property for hsp. For example see 
'Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt'.

Cheers
Jon

-- 
nvpublic
