From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/6] serial: sa1100: add support for mctrl gpios
Date: Fri, 31 May 2019 17:10:32 +0200
Message-ID: <20190531151032.tfrl7yqph6wsg5pl@pengutronix.de>
References: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
 <E1hWfTn-0003fP-Rl@rmk-PC.armlinux.org.uk>
 <20190531125013.3gkexhmbqjpdvrtf@pengutronix.de>
 <20190531132340.bco6xpyl3aatbryl@shell.armlinux.org.uk>
 <20190531135658.jo4kas3ozj7gpmmc@pengutronix.de>
 <20190531140127.yp2o7effrsxencyb@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190531140127.yp2o7effrsxencyb@shell.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Fri, May 31, 2019 at 03:01:28PM +0100, Russell King - ARM Linux admin wr=
ote:
> On Fri, May 31, 2019 at 03:56:58PM +0200, Uwe Kleine-K=F6nig wrote:
> > Unless I miss something (which is quite possible given that it's quite
> > some time ago I looked into mctrl_gpio) with mctrl_gpio_init_noauto()
> > having a CTS-gpio is just ignored unless the modem ctrl lines are
> > explicitely requestet while with mctrl_gpio_init() it results in an
> > error. Isn't the error the better alternative?
> =

> Unless the serial driver polls the modem control line status, which
> the SA1100 driver continues to do in exactly the same way after this
> conversion.
> =

> Do you suggest that we just regress the driver by ripping out this
> support that no one has had any problems with, and that is known to
> work sufficiently in its day, just because we now don't like it?

No, of course not. A nice improvement would be to teach gpio_mctrl (or
serial core?) about polling. But this is of course out of scope for this
patch, so I suggest to stay with mctrl_gpio_init_noauto and document the
lack of irq-capability somewhere prominently such that someone who picks
up converting mctrl_gpio_init_noauto to mctrl_gpio_init notices this
problem before actually hitting it.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
