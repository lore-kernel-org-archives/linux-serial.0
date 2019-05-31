From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH] serial: sa1100: add note about modem control signals
Date: Fri, 31 May 2019 16:57:00 +0100
Message-ID: <20190531155700.crrawgf3iot2sm2t@shell.armlinux.org.uk>
References: <20190531151032.tfrl7yqph6wsg5pl@pengutronix.de>
 <E1hWjO0-00087g-7y@rmk-PC.armlinux.org.uk>
 <20190531153135.sboekptwx4jxlpeg@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190531153135.sboekptwx4jxlpeg@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Fri, May 31, 2019 at 05:31:35PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Russell,
> =

> On Fri, May 31, 2019 at 04:24:04PM +0100, Russell King wrote:
> > As suggested by Uwe, add a note indicating that the modem control
> > signals do not support interrupts, which precludes the driver from
> > using mctrl_gpio_init().
> > =

> > Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> > =

> > Uwe, something like this?
> > =

> >  drivers/tty/serial/sa1100.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > =

> > diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
> > index a6b4309b62fc..d7dbf0576be8 100644
> > --- a/drivers/tty/serial/sa1100.c
> > +++ b/drivers/tty/serial/sa1100.c
> > @@ -949,6 +949,9 @@ static int sa1100_serial_resume(struct platform_dev=
ice *dev)
> >  static int sa1100_serial_add_one_port(struct sa1100_port *sport, struc=
t platform_device *dev)
> >  {
> >  	sport->port.dev =3D &dev->dev;
> > +
> > +	// GPIO driver does not support interrupts for these modem
> > +	// control signals, so the serial driver polls them.
> >  	sport->gpios =3D mctrl_gpio_init_noauto(sport->port.dev, 0);
> >  	if (IS_ERR(sport->gpios)) {
> >  		int err =3D PTR_ERR(sport->gpios);
> =

> I would mention that because of this mctrl_gpio_init cannot be used.

Ok.

> (And I would have expected C-like comments).

It seems that Linus has changed his opinion on C99 commenting style,
from "it's not real C" to "I prefer it":

https://lore.kernel.org/patchwork/patch/852060/

Yes, this is mostly about the SPDX commenting style, but Linus seems to
be expressing a general preference towards "//" style comments over
"/* */" comments, especially for new comments.

Specifically see replies #14 and #18, especially #18 where the
discussion moves towards trailing-line comments for structure members.

-- =

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps =
up
According to speedtest.net: 11.9Mbps down 500kbps up
