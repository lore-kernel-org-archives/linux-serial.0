From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 2/4] serial: mctrl_gpio: Add a NULL check to
 mctrl_gpio_to_gpiod()
Date: Fri, 2 Aug 2019 14:12:31 +0200
Message-ID: <20190802121231.wk6yg5mkyivs3rni@pengutronix.de>
References: <20190802100349.8659-1-frieder.schrempf@kontron.de>
 <20190802100349.8659-2-frieder.schrempf@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190802100349.8659-2-frieder.schrempf@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 02, 2019 at 10:04:10AM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> As it is allowed to use the mctrl_gpio_* functions before
> initialization (as the 8250 driver does according to 434be0ae7aa7),

Actually I was surprised some time ago that 8250 used serial_mctrl
without first initializing it and expecting it to work. I didn't look in
detail, but I wouldn't go so far to call this "allowed". The commit
itself calls it "workaround" which seems a better match.

> it seems appropriate to have a NULL check in all of the functions.
> Otherwise the mctrl_gpio_to_gpiod() function is prone to be used
> in a context that can lead to a NULL pointer dereference.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
