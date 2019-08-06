From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 4/4] serial: 8250: Don't check for mctrl_gpio_init()
 returning -ENOSYS
Date: Tue, 6 Aug 2019 09:44:11 +0200
Message-ID: <20190806074411.coizcyqs54ylgq3e@pengutronix.de>
References: <20190802100349.8659-1-frieder.schrempf@kontron.de>
 <20190802100349.8659-4-frieder.schrempf@kontron.de>
 <20190802121555.dl6rpjphgaxdvcke@pengutronix.de>
 <20190802122623.GA25281@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190802122623.GA25281@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Schrempf Frieder <frieder.schrempf@kontron.de>, "linux-imx@nxp.com" <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hey Greg

On Fri, Aug 02, 2019 at 02:26:23PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 02, 2019 at 02:15:55PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, Aug 02, 2019 at 10:04:11AM +0000, Schrempf Frieder wrote:
> > > From: Frieder Schrempf <frieder.schrempf@kontron.de>
> > > =

> > > Now that the mctrl_gpio code returns NULL instead of ERR_PTR(-ENOSYS)
> > > if CONFIG_GPIOLIB is disabled, we can safely remove this check.
> > > =

> > > Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > =

> > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > =

> > @greg: This patch doesn't depend on patch 2; ditto for patch 3. So only
> > taking patches 1, 3 and 4 should be fine. This way Frieder's v4 only
> > have to care for patch 2. (Assuming noone objects to 1, 3 and 4 of
> > course.)
> =

> Sounds good, I'll do that, thanks.

again you somehow managed to mangle my name :-|

$ git log -3 8f0df898b27926e443d13770adfd828cc0f50148 | grep Uwe
    Acked-by: Uwe Kleine-Knig <u.kleine-koenig@pengutronix.de>
    Acked-by: Uwe Kleine-Knig <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Uwe Kleine-Knig <u.kleine-koenig@pengutronix.de>

in all three instances the =F6 is missing.

Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
