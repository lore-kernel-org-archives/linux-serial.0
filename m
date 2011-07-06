From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v3 1/2] serial/imx: get rid of the uses of cpu_is_mx1()
Date: Thu, 7 Jul 2011 00:50:08 +0800
Message-ID: <20110706165007.GD4034@S2100-06.ap.freescale.net>
References: <1309969814-13195-1-git-send-email-shawn.guo@linaro.org>
 <1309969814-13195-2-git-send-email-shawn.guo@linaro.org>
 <20110706163740.GW6069@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:32155
	"EHLO CH1EHSOBE018.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754530Ab1GFQnp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Jul 2011 12:43:45 -0400
Content-Disposition: inline
In-Reply-To: <20110706163740.GW6069@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, devicetree-discuss@lists.ozlabs.org, Alan Cox <alan@linux.intel.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, patches@linaro.org

On Wed, Jul 06, 2011 at 06:37:40PM +0200, Sascha Hauer wrote:
> On Thu, Jul 07, 2011 at 12:30:13AM +0800, Shawn Guo wrote:
> > The patch removes all the uses of cpu_is_mx1().  Instead, it uses
> > the .id_table of platform_driver to distinguish the uart device type,
> > IMX1_UART and IMX21_UART.  The IMX21_UART type runs on all i.mx
> > except i.mx1.
> > 
> > A couple of !cpu_is_mx1() logic gets turned into IS_IMX21_UART,
> > as the codes wrapped there are really IMX21 type uart specific.
> > 
> > It also removes macro MX1_UCR3_REF25 and MX1_UCR3_REF30 which are
> > not used anywhere.
> 
> Two typos and one minor nitpick, otherwise I'm fine with it. Should go
> via the i.MX tree rather than the serial tree. Alan?
> 
> 
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Alan Cox <alan@linux.intel.com>
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >  arch/arm/mach-imx/clock-imx1.c                |    6 +-
> >  arch/arm/mach-imx/clock-imx21.c               |    8 ++--
> >  arch/arm/mach-imx/clock-imx25.c               |   11 ++--
> >  arch/arm/mach-imx/clock-imx27.c               |   13 +++--
> >  arch/arm/mach-imx/clock-imx31.c               |   11 ++--
> >  arch/arm/mach-imx/clock-imx35.c               |    7 ++-
> >  arch/arm/mach-mx5/clock-mx51-mx53.c           |   18 ++++---
> >  arch/arm/plat-mxc/devices/platform-imx-uart.c |    7 ++-
> >  drivers/tty/serial/imx.c                      |   66 ++++++++++++++++++++-----
> >  9 files changed, 97 insertions(+), 50 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
> > index a65838f..42ef76a 100644
> > --- a/arch/arm/mach-imx/clock-imx25.c
> > +++ b/arch/arm/mach-imx/clock-imx25.c
> > @@ -272,11 +272,12 @@ DEFINE_CLOCK(can2_clk,	 1, CCM_CGCR1,  3, get_rate_ipg, NULL, NULL);
> >  	},
> >  
> > diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/arch/arm/plat-mxc/devices/platform-imx-uart.c
> > index cfce8c9..a425a5a 100644
> > --- a/arch/arm/plat-mxc/devices/platform-imx-uart.c
> > +++ b/arch/arm/plat-mxc/devices/platform-imx-uart.c
> > @@ -152,7 +152,7 @@ struct platform_device *__init imx_add_imx_uart_3irq(
> >  		},
> >  	};
> >  
> > -	return imx_add_platform_device("imx-uart", data->id, res,
> > +	return imx_add_platform_device("imx1-uart", data->id, res,
> >  			ARRAY_SIZE(res), pdata, sizeof(*pdata));
> >  }
> >  
> > @@ -172,6 +172,7 @@ struct platform_device *__init imx_add_imx_uart_1irq(
> >  		},
> >  	};
> >  
> > -	return imx_add_platform_device("imx-uart", data->id, res, ARRAY_SIZE(res),
> > -			pdata, sizeof(*pdata));
> > +	/* i.mx21 type uart runs on all i.mx expcept i.mx1 */
> 
> s/expcept/except/
> >  #define  UCR3_AIRINTEN   (1<<5)  /* Async IR wake interrupt enable */
> >  #define  UCR3_AWAKEN	 (1<<4)  /* Async wake interrupt enable */
> > -#define  MX1_UCR3_REF25 	 (1<<3)  /* Ref freq 25 MHz, only on mx1 */
> > -#define  MX1_UCR3_REF30 	 (1<<2)  /* Ref Freq 30 MHz, only on mx1 */
> > -#define  MX2_UCR3_RXDMUXSEL	 (1<<2)  /* RXD Muxed Input Select, on mx2/mx3 */
> > +#define  IMX21_UCR3_RXDMUXSEL	 (1<<2)  /* RXD Muxed Input Select */
> >  #define  UCR3_INVT  	 (1<<1)  /* Inverted Infrared transmission */
> >  #define  UCR3_BPEN  	 (1<<0)  /* Preset registers enable */
> >  #define  UCR4_CTSTL_SHF  10      /* CTS trigger level shift */
> > @@ -181,6 +179,18 @@
> >  
> >  #define UART_NR 8
> >  
> > +/* i.mx21 type uart runs on all i.mx expcept i.mx1 */
> 
> ditto
> 
> >  
> > +#define UTS (sport->devdata->uts_reg)
> > +#define IS_IMX1_UART()	(sport->devdata->devtype == IMX1_UART)
> > +#define IS_IMX21_UART()	(sport->devdata->devtype == IMX21_UART)
> 
> Can we make this a static inline function?
> 
Ok, will resend it right now to get these fixed.

-- 
Regards,
Shawn

