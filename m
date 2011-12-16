From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 4/4] ARM: omap: pass minimal SoC/board data for UART
 from dt
Date: Fri, 16 Dec 2011 16:21:43 +0100
Message-ID: <4EEB6207.9090200@ti.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com> <1323863746-18145-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41345 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756324Ab1LPPV5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Dec 2011 10:21:57 -0500
In-Reply-To: <1323863746-18145-5-git-send-email-rnayak@ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, khilman@ti.com, tony@atomide.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com

Hi Rajendra,

Just one minor comment if you plan to repost.

On 12/14/2011 12:55 PM, Rajendra Nayak wrote:
> Pass minimal data needed for console boot, from dt, for
> OMAP4 panda/sdp and OMAP3 beagle boards, and get rid of the
> static initialization from generic board file.
>
> Acked-by: Rob Herring<rob.herring@calxeda.com>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>

Tested-by: Benoit Cousson <b-cousson@ti.com>

>   arch/arm/boot/dts/omap3.dtsi        |   31 +++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/omap4.dtsi        |   28 ++++++++++++++++++++++++++++
>   arch/arm/mach-omap2/board-generic.c |    1 -
>   3 files changed, 59 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index d202bb5..216c331 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -13,6 +13,13 @@
>   / {
>   	compatible = "ti,omap3430", "ti,omap3";
>
> +	aliases {
> +		serial0 =&uart1;
> +		serial1 =&uart2;
> +		serial2 =&uart3;
> +		serial3 =&uart4;
> +	};
> +
>   	cpus {
>   		cpu@0 {
>   			compatible = "arm,cortex-a8";
> @@ -59,5 +66,29 @@
>   			interrupt-controller;
>   			#interrupt-cells =<1>;
>   		};
> +
> +		uart1: serial@0x4806a000 {

Could you get rid of the 0x prefix for consistency?
This is applicable for the omap4.dtsi as well.

Thanks,
Benoit
