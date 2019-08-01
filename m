From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: imx: Avoid probe failure in case of missing
 gpiolib
Date: Thu, 1 Aug 2019 13:50:46 +0200
Message-ID: <20190801115046.lf66umgfj2xk6eqv@pengutronix.de>
References: <20190801081524.22577-1-frieder.schrempf@kontron.de>
 <20190801084827.m42ci3amo37hmesi@pengutronix.de>
 <0674d68b-99fa-3408-1dd1-22dc84144b43@kontron.de>
 <20190801095529.dm3pvgts6cy6mbiq@pengutronix.de>
 <0174be55-5e40-8cc7-82c7-54f9de46f711@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0174be55-5e40-8cc7-82c7-54f9de46f711@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Hello,

On Thu, Aug 01, 2019 at 10:59:54AM +0000, Schrempf Frieder wrote:
> So I would rather go with a variation of your second proposal and keep 
> the dummy implementation, but let it return NULL instead of an error 
> pointer, as all the mctrl_gpio_*() functions already seem to have a 
> check for gpios == NULL.
> 
> What do you think?

I'll gladly review a patch.

Best regads
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
