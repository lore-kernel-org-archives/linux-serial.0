From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 8/8] arm64: tegra: Mark tcu as primary serial port on
 Tegra194 P2888
Date: Tue, 22 May 2018 17:29:13 +0100
Message-ID: <d7b65d6d-c415-ac49-d729-9c6b44feb8c6@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-9-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180508114403.14499-9-mperttunen@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>, robh+dt@kernel.org, mark.rutland@arm.com, jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, thierry.reding@gmail.com
Cc: araza@nvidia.com, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


On 08/05/18 12:44, Mikko Perttunen wrote:
> The Tegra Combined UART is the proper primary serial port on P2888,
> so use it.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> index 859ab5af17c1..95e2433984f7 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> @@ -10,7 +10,7 @@
>   	aliases {
>   		sdhci0 = "/cbb/sdhci@3460000";
>   		sdhci1 = "/cbb/sdhci@3400000";
> -		serial0 = &uartb;
> +		serial0 = &tcu;
>   		i2c0 = "/bpmp/i2c";
>   		i2c1 = "/cbb/i2c@3160000";
>   		i2c2 = "/cbb/i2c@c240000";
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
