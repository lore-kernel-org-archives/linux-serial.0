From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH RESEND v3 0/2] Add device tree probe support for
 tty/serial/imx
Date: Fri, 22 Jul 2011 09:53:36 +0800
Message-ID: <20110722015335.GD26837@S2100-06.ap.freescale.net>
References: <1309972820-18547-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:43878
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751587Ab1GVBqd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Jul 2011 21:46:33 -0400
Content-Disposition: inline
In-Reply-To: <1309972820-18547-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Thu, Jul 07, 2011 at 01:20:18AM +0800, Shawn Guo wrote:
> The first patch removes the use of cpu_is_mx1().  The second patch
> adds device tree probe with a dependency on the following patch.
> 
>   http://article.gmane.org/gmane.linux.drivers.devicetree/6128
> 
> Changes with resend:
>  * Fix typo
>  * Change a few macros to inline functions
> 
> Changes since v2:
>  * Not use generic naming imx-uart, instead use specific soc name
>    to show uart type compatibility (Sascha's suggestion)
> 
> Changes since v1:
>  * Address review comments given by Grant and Uwe
> 
> Shawn Guo (2):
>       serial/imx: get rid of the uses of cpu_is_mx1()
>       serial/imx: add device tree probe support
> 
>  .../bindings/tty/serial/fsl-imx-uart.txt           |   19 +++
>  arch/arm/mach-imx/clock-imx1.c                     |    6 +-
>  arch/arm/mach-imx/clock-imx21.c                    |    8 +-
>  arch/arm/mach-imx/clock-imx25.c                    |   11 +-
>  arch/arm/mach-imx/clock-imx27.c                    |   13 +-
>  arch/arm/mach-imx/clock-imx31.c                    |   11 +-
>  arch/arm/mach-imx/clock-imx35.c                    |    7 +-
>  arch/arm/mach-mx5/clock-mx51-mx53.c                |   18 ++-
>  arch/arm/plat-mxc/devices/platform-imx-uart.c      |    7 +-
>  drivers/tty/serial/imx.c                           |  167 +++++++++++++++++---
>  10 files changed, 205 insertions(+), 62 deletions(-)
> 
To avoid conflict, will repost the series when Grant's devicetree/next
and i.mx tree get merged on mainline in the coming merge window.

Alan, hopefully, you can give your ack then, so that Sascha can pick
it up.

-- 
Regards,
Shawn

