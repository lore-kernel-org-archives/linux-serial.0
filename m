From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/6] serial: sa1100: add support for mctrl gpios
Date: Fri, 31 May 2019 15:56:58 +0200
Message-ID: <20190531135658.jo4kas3ozj7gpmmc@pengutronix.de>
References: <20190531111257.27hor6xgb3nsdghg@shell.armlinux.org.uk>
 <E1hWfTn-0003fP-Rl@rmk-PC.armlinux.org.uk>
 <20190531125013.3gkexhmbqjpdvrtf@pengutronix.de>
 <20190531132340.bco6xpyl3aatbryl@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190531132340.bco6xpyl3aatbryl@shell.armlinux.org.uk>
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

On Fri, May 31, 2019 at 02:23:40PM +0100, Russell King - ARM Linux admin wr=
ote:
> On Fri, May 31, 2019 at 02:50:13PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, May 31, 2019 at 12:13:47PM +0100, Russell King wrote:
> > > +static int sa1100_serial_add_one_port(struct sa1100_port *sport, str=
uct platform_device *dev)
> > > +{
> > > +	sport->port.dev =3D &dev->dev;
> > > +	sport->gpios =3D mctrl_gpio_init_noauto(sport->port.dev, 0);
> > =

> > the _noauto function was only introduced to ease a transition. I think
> > the driver would benefit to use mctrl_gpio_init() instead.
> =

> In what way would the driver benefit?  mctrl_gpio_init() requires that
> there are IRQs for each input GPIO.  This is not the case with most
> SA11x0 platforms, where the GPIO controls are implemented using simple
> latches, hence that interface is entirely unsuitable.

Ah, but then you can only use the outputs reliably here as an edge on
(say) CTS stays unnoticed with both mctrl_gpio_init() and
mctrl_gpio_init_noauto().

Unless I miss something (which is quite possible given that it's quite
some time ago I looked into mctrl_gpio) with mctrl_gpio_init_noauto()
having a CTS-gpio is just ignored unless the modem ctrl lines are
explicitely requestet while with mctrl_gpio_init() it results in an
error. Isn't the error the better alternative?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
