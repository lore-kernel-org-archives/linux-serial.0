From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: imx: add rx and tx led trigger
Date: Wed, 06 Jul 2016 22:09:39 +0200
Message-ID: <3835401.kFNahHioV5@wuerfel>
References: <1467646452-21243-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5565521.Lr5FKj2vNK@wuerfel> <20160706173057.GS16643@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160706173057.GS16643@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Wednesday, July 6, 2016 7:30:57 PM CEST Uwe Kleine-K=F6nig wrote:
> On Wed, Jul 06, 2016 at 05:22:40PM +0200, Arnd Bergmann wrote:
> > On Monday, July 4, 2016 5:50:09 PM CEST Uwe Kleine-K=F6nig wrote:
> > > On Mon, Jul 04, 2016 at 05:43:03PM +0200, Arnd Bergmann wrote:
> > > > On Monday, July 4, 2016 5:34:12 PM CEST Uwe Kleine-K=F6nig wrote:
> > > > > Add support for two led triggers per UART instance that blink on
> > > > > transmission and reception of data respectively.
> > > > > =

> > > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > > ---
> > > > >  drivers/tty/serial/imx.c | 57 ++++++++++++++++++++++++++++++++++=
++++++++++++++
> > > > >  1 file changed, 57 insertions(+)
> > > > =

> > > > What is specific to this driver here? Could this be done in the
> > > > core tty code instead?
> > > =

> > > The core doesn't notice when the driver starts to push out characters.
> > > =

> > > I also have a patch in my queue that adds support for rts delaying in
> > > rs485 mode. While the delay between start_tx being called and the fir=
st
> > > char leaving the hardware might not be big enough to care in rs232 mo=
de,
> > > with a big delay_rts_before_send it might matter.
> > =

> > Right, that makes sense. It still seems odd to have this just in one
> > driver, and your changelog above doesn't really explain what the
> > blinkenlights are actually good for.
> > =

> > I'm sure you had something useful in mind, can you elaborate?
> =

> I don't know the exact motivation. $customer wants to see when there is
> traffic on the serial line. Is there a better motivation needed?

I don't know, it depends a bit on how smart you think $customer is ;-)

Some customers know exactly what they need and why they ask for it,
some others are a bit confused about their own requirements.

I can certainly think of cases where this makes sense, e.g. a modem
appliance or a terminal server.

> If so, what was the motivation for the mmc led trigger (which btw also
> used the host's device name as trigger name).

I didn't see that patch.

> > If this is something we may want to do on other platforms as well,
> > we should perhaps not hardwire the name of the imx tty device in
> > the led trigger name.
> =

> I cannot follow. If we have several serial lines and a trigger for each
> of them, they must get different names. Using the device's name to
> distinguish them seems like a good and obvious idea.

The main problem I see is if someone puts the name of the trigger into
a dtb file, as this hardcodes the connection between the Linux driver
name and numbering system with the device tree binding, which are normally
separate.

If we could derive the trigger name from the "/aliases/serial%d" property
in DT instead, it would get a little more portable.

	Arnd
