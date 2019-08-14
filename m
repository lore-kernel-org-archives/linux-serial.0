From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/3] serial: atmel: Don't check for mctrl_gpio_to_gpiod()
 returning error
Date: Wed, 14 Aug 2019 13:08:04 +0200
Message-ID: <20190814110804.2ceo2upc3su7muup@pengutronix.de>
References: <20190814092757.13726-1-geert+renesas@glider.be>
 <20190814092924.13857-1-geert+renesas@glider.be>
 <20190814092924.13857-2-geert+renesas@glider.be>
 <20190814093558.xlx5ck54dw2dgb6k@pengutronix.de>
 <CAMuHMdWNj-H9B8E9=NeCgLracBuJODfPyBYJERh=vt4oNFUkGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWNj-H9B8E9=NeCgLracBuJODfPyBYJERh=vt4oNFUkGw@mail.gmail.com>
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Frieder Schrempf <frieder.schrempf@kontron.de>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, NXP Linux Team <linux-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>, Jiri Slaby <jslaby@suse.com>, Shawn Guo <shawnguo@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 14, 2019 at 12:20:33PM +0200, Geert Uytterhoeven wrote:
> Hi Uwe,
> =

> On Wed, Aug 14, 2019 at 11:36 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, Aug 14, 2019 at 11:29:22AM +0200, Geert Uytterhoeven wrote:
> > > Since commit 1d267ea6539f2663 ("serial: mctrl-gpio: simplify init
> > > routine"), mctrl_gpio_init() returns failure if the assignment to any
> > > member of the gpio array results in an error pointer.
> > > Since commit c359522194593815 ("serial: mctrl_gpio: Avoid probe failu=
res
> > > in case of missing gpiolib"), mctrl_gpio_to_gpiod() returns NULL in t=
he
> > > !CONFIG_GPIOLIB case.
> > > Hence there is no longer a need to check for mctrl_gpio_to_gpiod()
> > > returning an error value.  A simple NULL check is sufficient.
> > >
> > > This follows the spirit of commit 445df7ff3fd1a0a9 ("serial: mctrl-gp=
io:
> > > drop usages of IS_ERR_OR_NULL") in the mctrl-gpio core.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  drivers/tty/serial/atmel_serial.c | 12 ++++--------
> > >  1 file changed, 4 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/a=
tmel_serial.c
> > > index 19a85d6fe3d20541..e9620a81166b7dc1 100644
> > > --- a/drivers/tty/serial/atmel_serial.c
> > > +++ b/drivers/tty/serial/atmel_serial.c
> > > @@ -303,32 +303,28 @@ static unsigned int atmel_get_lines_status(stru=
ct uart_port *port)
> > >
> > >       mctrl_gpio_get(atmel_port->gpios, &ret);
> > >
> > > -     if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
> > > -                                             UART_GPIO_CTS))) {
> > > +     if (mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS)) {
> > >               if (ret & TIOCM_CTS)
> > >                       status &=3D ~ATMEL_US_CTS;
> > >               else
> > >                       status |=3D ATMEL_US_CTS;
> > >       }
> >
> > The change is fine, but it seems the atmel driver doesn't use mctrl_gpio
> > as expected (at least as expected by me). IMHO driving the hardware
> > function of the CTS pin shouldn't be conditional on the presence of a
> > cts-gpio. Is there a reason not to just drop the if completely?
> =

> The above code returns the hardware status if CTS is not a GPIO, and
> returns (overrides with) the GPIO status if CTS is a GPIO.
> Isn't that correct, or am I missing something?

I took a deeper look into this driver now. The task for
atmel_get_lines_status() isn't to implement the get_mctrl() callback.

Instead this is called in the irqhandler to set ATMEL_US_RI in a
"pending" value that then later in atmel_handle_status() is translated
to a "ring" event that is handled there.

So the right cleanup would be to let atmel_get_lines_status() just be

	return atmel_uart_readl(port, ATMEL_US_CSR);

. If something happend on the lines implemented as gpio the driver's irq
function isn't called anyhow.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
