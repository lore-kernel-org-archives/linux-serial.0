From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 4/5] ARM: dts: imx6q: add dte pinctrl for uart2
Date: Thu, 4 Jul 2013 15:23:45 +0800
Message-ID: <20130704072344.GB11046@S2101-09.ap.freescale.net>
References: <1372844557-3078-1-git-send-email-b32955@freescale.com>
 <1372844557-3078-5-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db8lp0185.outbound.messaging.microsoft.com ([213.199.154.185]:40982
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933586Ab3GDHX0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Jul 2013 03:23:26 -0400
Content-Disposition: inline
In-Reply-To: <1372844557-3078-5-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jul 03, 2013 at 05:42:36PM +0800, Huang Shijie wrote:
> In imx6q-arm2 board, the UART2 works in the dte mode.
> So add a pinctrl for it.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q.dtsi |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

Since imx6q and imx6dl are pin-to-pin compatible, from now on I would
require the same pin group be added for these two SoC together, so that
we can enforce the same label name.

> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 9a69891..8a518c6 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -266,6 +266,15 @@
>  							MX6Q_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
>  						>;
>  					};
> +
> +					pinctrl_uart2_dte: uart2grp-2 {
> +						fsl,pins = <
> +							MX6Q_PAD_EIM_D26__UART2_RX_DATA 0x1b0b1
> +							MX6Q_PAD_EIM_D27__UART2_TX_DATA 0x1b0b1
> +							MX6Q_PAD_EIM_D28__UART2_CTS_B	0x1b0b1
> +							MX6Q_PAD_EIM_D29__UART2_CTS_B	0x1b0b1

Why do you have two pads mux-ed on one function?

Shawn

> +						>;
> +					};
>  				};
>  
>  				uart4 {
> -- 
> 1.7.1
> 
> 

