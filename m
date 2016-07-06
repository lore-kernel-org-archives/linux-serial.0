From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: imx: add rx and tx led trigger
Date: Wed, 06 Jul 2016 17:22:40 +0200
Message-ID: <5565521.Lr5FKj2vNK@wuerfel>
References: <1467646452-21243-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <13559901.NSWqUx1Nl6@wuerfel> <20160704155009.GJ16643@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160704155009.GJ16643@pengutronix.de>
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
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Monday, July 4, 2016 5:50:09 PM CEST Uwe Kleine-K=F6nig wrote:
> On Mon, Jul 04, 2016 at 05:43:03PM +0200, Arnd Bergmann wrote:
> > On Monday, July 4, 2016 5:34:12 PM CEST Uwe Kleine-K=F6nig wrote:
> > > Add support for two led triggers per UART instance that blink on
> > > transmission and reception of data respectively.
> > > =

> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/tty/serial/imx.c | 57 ++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  1 file changed, 57 insertions(+)
> > =

> > What is specific to this driver here? Could this be done in the
> > core tty code instead?
> =

> The core doesn't notice when the driver starts to push out characters.
> =

> I also have a patch in my queue that adds support for rts delaying in
> rs485 mode. While the delay between start_tx being called and the first
> char leaving the hardware might not be big enough to care in rs232 mode,
> with a big delay_rts_before_send it might matter.

Right, that makes sense. It still seems odd to have this just in one
driver, and your changelog above doesn't really explain what the
blinkenlights are actually good for.

I'm sure you had something useful in mind, can you elaborate?

If this is something we may want to do on other platforms as well,
we should perhaps not hardwire the name of the imx tty device in
the led trigger name.

	Arnd
