From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
Date: Mon, 6 Mar 2017 10:30:43 +0100
Message-ID: <20170306093043.ay4dz3ehp3aakwxh@pengutronix.de>
References: <20170303142201.16452-1-richard.genoud@gmail.com>
 <CAMuHMdX-K9B20Tu5NtHJRHmGGuT60OFu8TokZxsF8aSaS7HuHQ@mail.gmail.com>
 <20170303191248.wlwjri55ip2x5pgg@pengutronix.de>
 <CAMuHMdXFrwa2jCVDb+8ecqgARLG0oGrPp9pLs0b6vEiWeKJ+uA@mail.gmail.com>
 <20170303194414.n76tr3oa2mlrzjre@pengutronix.de>
 <CAMuHMdXiz5hqW=fm-2H1aNKq_gXD2o0508jD2XjxYUvKoEvHdw@mail.gmail.com>
 <20170304174819.esxhwwbsxzuq3vyc@pengutronix.de>
 <CAMuHMdX8BEnaTtNFAbcvfHwJH=oPUmQ2NB+jfouGyhQpJ_m_4A@mail.gmail.com>
 <20170306085842.yijkfpqi3adcedmm@pengutronix.de>
 <CAMuHMdV2_vbocY4wCzvYtPAaF+QEX_Y4g6qVu5EqEBf5AnFdaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdV2_vbocY4wCzvYtPAaF+QEX_Y4g6qVu5EqEBf5AnFdaw@mail.gmail.com>
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
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hello Geert,

On Mon, Mar 06, 2017 at 10:09:50AM +0100, Geert Uytterhoeven wrote:
> On Mon, Mar 6, 2017 at 9:58 AM, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Mon, Mar 06, 2017 at 09:49:39AM +0100, Geert Uytterhoeven wrote:
> >> > Given that mctrl-gpio can be useful on legacy platforms, a device co=
uld
> >> > silently run without cts-gpio even there.
> >>
> >> On platforms were CONFIG_GPIOLIB=3Dn, this is not true, so the issue i=
s moot.
> >>
> >> All serial drivers using (optional) mctrl-gpio have this in Kconfig:
> >>
> >>     select SERIAL_MCTRL_GPIO if GPIOLIB
> >>
> >> So they will use mctrl-gpio when GPIOLIB is enabled.
> >> If GPIOPLIB is disabled, no flow control GPIOs are expected, and the
> >> driver should not break that case.
> >
> > So it all boils down to the question: Is GPIOLIB=3Dn enough to assume no
> > gpio is needed?
> >
> > I'd say it is not.
> =

> How does the platform register these GPIOs when GPIOPLIB is not enabled by
> the platform, and gpiod_add_lookup_table() is thus not available?

Obviously the platformcode cannot. In this case you could argue that
platformcode shouldn't register the device if a gpio is necessary. But
this reasoning doesn't work for (DT=3Dy || ACPI=3Dy) && GPIOLIB=3Dn.

I wouldn't want to code this in each driver (something like:

	if (IS_ENABLED(GPIOLIB) || device_is_instantiated_by_dt(dev) || device_is_=
instantiated_by_acpi(dev))
		gpios =3D mctrl_gpio_init(...);
	else
		gpios =3D NULL;

). Putting this into GPIOLIB is the right approach, and so this is
another argument for HALFGPIOLIB. This would fix mctrl_gpio_init en
passant.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
