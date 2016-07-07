From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: imx: add rx and tx led trigger
Date: Thu, 7 Jul 2016 08:28:00 +0200
Message-ID: <20160707062800.GT16643@pengutronix.de>
References: <1467646452-21243-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5565521.Lr5FKj2vNK@wuerfel>
 <20160706173057.GS16643@pengutronix.de>
 <3835401.kFNahHioV5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <3835401.kFNahHioV5@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Hello Arnd,

[adding Rob Herring to Cc]

On Wed, Jul 06, 2016 at 10:09:39PM +0200, Arnd Bergmann wrote:
> On Wednesday, July 6, 2016 7:30:57 PM CEST Uwe Kleine-K=F6nig wrote:
> > On Wed, Jul 06, 2016 at 05:22:40PM +0200, Arnd Bergmann wrote:
> > > On Monday, July 4, 2016 5:50:09 PM CEST Uwe Kleine-K=F6nig wrote:
> > > > On Mon, Jul 04, 2016 at 05:43:03PM +0200, Arnd Bergmann wrote:
> > > > > On Monday, July 4, 2016 5:34:12 PM CEST Uwe Kleine-K=F6nig wrote:
> > > > > > Add support for two led triggers per UART instance that blink on
> > > > > > transmission and reception of data respectively.
> > > > > > =

> > > If this is something we may want to do on other platforms as well,
> > > we should perhaps not hardwire the name of the imx tty device in
> > > the led trigger name.
> > =

> > I cannot follow. If we have several serial lines and a trigger for each
> > of them, they must get different names. Using the device's name to
> > distinguish them seems like a good and obvious idea.
> =

> The main problem I see is if someone puts the name of the trigger into
> a dtb file, as this hardcodes the connection between the Linux driver
> name and numbering system with the device tree binding, which are normally
> separate.
> =

> If we could derive the trigger name from the "/aliases/serial%d" property
> in DT instead, it would get a little more portable.

Alternatively we could invent a more dtish way as aliases seem to be
frowned upon [1], something like:

	led#0 {
		label =3D "userled";
		linux,default-trigger =3D &uart1, "tx";
	};

	uart1: serial@43f90000 {
		...
		#trigger-cells =3D <1>;
	};

Having said that, I don't think it's a big problem if the value of
"linux,default-trigger" is Linux-specific. Moreover, is a default
trigger considered a hardware description?

Best regards
Uwe

[1] http://mid.gmane.org/20160705140546.GA10601@rob-hp-laptop
    Not sure this is a general objection to aliases, though.

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
