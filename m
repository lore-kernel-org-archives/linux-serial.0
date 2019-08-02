From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 4/4] serial: 8250: Don't check for mctrl_gpio_init()
 returning -ENOSYS
Date: Fri, 2 Aug 2019 14:26:23 +0200
Message-ID: <20190802122623.GA25281@kroah.com>
References: <20190802100349.8659-1-frieder.schrempf@kontron.de>
 <20190802100349.8659-4-frieder.schrempf@kontron.de>
 <20190802121555.dl6rpjphgaxdvcke@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190802121555.dl6rpjphgaxdvcke@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Schrempf Frieder <frieder.schrempf@kontron.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 02, 2019 at 02:15:55PM +0200, Uwe Kleine-König wrote:
> On Fri, Aug 02, 2019 at 10:04:11AM +0000, Schrempf Frieder wrote:
> > From: Frieder Schrempf <frieder.schrempf@kontron.de>
> > 
> > Now that the mctrl_gpio code returns NULL instead of ERR_PTR(-ENOSYS)
> > if CONFIG_GPIOLIB is disabled, we can safely remove this check.
> > 
> > Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> @greg: This patch doesn't depend on patch 2; ditto for patch 3. So only
> taking patches 1, 3 and 4 should be fine. This way Frieder's v4 only
> have to care for patch 2. (Assuming noone objects to 1, 3 and 4 of
> course.)

Sounds good, I'll do that, thanks.

greg k-h
