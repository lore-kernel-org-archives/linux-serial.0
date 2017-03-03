From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
Date: Fri, 3 Mar 2017 20:12:48 +0100
Message-ID: <20170303191248.wlwjri55ip2x5pgg@pengutronix.de>
References: <20170303142201.16452-1-richard.genoud@gmail.com>
 <CAMuHMdX-K9B20Tu5NtHJRHmGGuT60OFu8TokZxsF8aSaS7HuHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdX-K9B20Tu5NtHJRHmGGuT60OFu8TokZxsF8aSaS7HuHQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 03, 2017 at 07:58:36PM +0100, Geert Uytterhoeven wrote:
> Hi Richard,
> =

> On Fri, Mar 3, 2017 at 3:22 PM, Richard Genoud <richard.genoud@gmail.com>=
 wrote:
> > Since commit 1d267ea6539f ("serial: mctrl-gpio: simplify init routine"),
> > the mctrl_gpio_to_gpiod() function can't return an error anymore.
> > So, just testing for a NULL pointer is ok.
> =

> If CONFIG_GPIOLIB=3Dn, mctrl_gpio_to_gpiod() always returns ERR_PTR(-ENOS=
YS).
> That case should be handled correctly, too.

The correct change to handle this is:

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 91e7dddbf72c..2f4cdd4e7b4f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3022,7 +3022,7 @@ static int sci_probe_single(struct platform_device *d=
ev,
 		return ret;
 =

 	sciport->gpios =3D mctrl_gpio_init(&sciport->port, 0);
-	if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) !=3D -ENOSYS)
+	if (IS_ERR(sciport->gpios))
 		return PTR_ERR(sciport->gpios);
 =

 	if (p->capabilities & SCIx_HAVE_RTSCTS) {

Then mctrl_gpio_to_gpiod isn't called. I don't have a machine to test
this, but I think currently this makes the machine barf to continue
here because with sciport->gpios =3D ERR_PTR(-ENOSYS) calling

	mctrl_gpio_to_gpiod(sciport->gpios, ...)

is a bad idea.
 =

> Perhaps mctrl_gpio_to_gpiod() should always return NULL if !CONFIG_GPIOLI=
B?

No, mctrl_gpio_to_gpiod is right. You are only supposed to call it if
mctrl_gpio_init succeeded.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
