From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 9/9] of: document rs485 bindings for Atmel USART,
 Freescale UARTs and OMAP UART
Date: Thu, 29 Jun 2017 20:53:34 +0200
Message-ID: <20170629185334.7pjlsnpggfvx4clo@pengutronix.de>
References: <20170626090803.10981-1-u.kleine-koenig@pengutronix.de>
 <20170626090803.10981-10-u.kleine-koenig@pengutronix.de>
 <20170628180400.h7yxrprhr44wncgs@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170628180400.h7yxrprhr44wncgs@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 28, 2017 at 01:04:00PM -0500, Rob Herring wrote:
> On Mon, Jun 26, 2017 at 11:08:03AM +0200, Uwe Kleine-König wrote:
> > The drivers support the rs485 binding described in rs485.txt, this commit
> > just makes that explicit.
> 
> "dt-bindings: serial: ..." for the subject if you respin the series. 

Done, I shortend the first line a bit, it now looks as follows:

	dt-bindings: serial: document rs485 bindings for various devices

	Atmel USART, Freescale UARTs and OMAP UART all support the rs485 binding 
	described in rs485.txt, this commit just makes that explicit.

	Acked-by: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
	Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
	Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
