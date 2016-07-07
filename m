From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: imx: add rx and tx led trigger
Date: Thu, 07 Jul 2016 10:27:51 +0200
Message-ID: <6724841.mKIqTiexKe@wuerfel>
References: <1467646452-21243-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <3835401.kFNahHioV5@wuerfel> <20160707062800.GT16643@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160707062800.GT16643@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On Thursday, July 7, 2016 8:28:00 AM CEST Uwe Kleine-K=F6nig wrote:
> Hello Arnd,
> =

> [adding Rob Herring to Cc]
> =

> On Wed, Jul 06, 2016 at 10:09:39PM +0200, Arnd Bergmann wrote:
> > On Wednesday, July 6, 2016 7:30:57 PM CEST Uwe Kleine-K=F6nig wrote:
> > > On Wed, Jul 06, 2016 at 05:22:40PM +0200, Arnd Bergmann wrote:
> > > > On Monday, July 4, 2016 5:50:09 PM CEST Uwe Kleine-K=F6nig wrote:
> > > > > On Mon, Jul 04, 2016 at 05:43:03PM +0200, Arnd Bergmann wrote:
> > > > > > On Monday, July 4, 2016 5:34:12 PM CEST Uwe Kleine-K=F6nig wrot=
e:
> > > > > > > Add support for two led triggers per UART instance that blink=
 on
> > > > > > > transmission and reception of data respectively.
> > > > > > > =

> > > > If this is something we may want to do on other platforms as well,
> > > > we should perhaps not hardwire the name of the imx tty device in
> > > > the led trigger name.
> > > =

> > > I cannot follow. If we have several serial lines and a trigger for ea=
ch
> > > of them, they must get different names. Using the device's name to
> > > distinguish them seems like a good and obvious idea.
> > =

> > The main problem I see is if someone puts the name of the trigger into
> > a dtb file, as this hardcodes the connection between the Linux driver
> > name and numbering system with the device tree binding, which are norma=
lly
> > separate.
> > =

> > If we could derive the trigger name from the "/aliases/serial%d" proper=
ty
> > in DT instead, it would get a little more portable.
> =

> Alternatively we could invent a more dtish way as aliases seem to be
> frowned upon [1], something like:
> =

> 	led#0 {
> 		label =3D "userled";
> 		linux,default-trigger =3D &uart1, "tx";
> 	};
> =

> 	uart1: serial@43f90000 {
> 		...
> 		#trigger-cells =3D <1>;
> 	};

That looks nice, but I don't see how we could implement this in a
backwards compatible way, as we don't know whether the first cell
of the property is a phandle or a string.

> Having said that, I don't think it's a big problem if the value of
> "linux,default-trigger" is Linux-specific. Moreover, is a default
> trigger considered a hardware description?

What's more important here I think is that even in Linux, the name
of the uart is not always stable across versions or configurations,
e.g. in on OMAP we can have either ttyO%d or ttyS%d.

	Arnd
