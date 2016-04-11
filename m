From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 09/12] serial: 8250_lpss: split LPSS driver to
 separate module
Date: Mon, 11 Apr 2016 16:09:02 +0300
Message-ID: <1460380142.6620.75.camel@linux.intel.com>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1460061433-63750-10-git-send-email-andriy.shevchenko@linux.intel.com>
	 <57070C93.2090000@hurleysoftware.com>
	 <CAHp75VffKnKpiGBp2q_3A19BLC0oic53g9F+9oUrnPM3Snfupw@mail.gmail.com>
	 <57083445.9090009@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57083445.9090009@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, 2016-04-08 at 15:44 -0700, Peter Hurley wrote:
> On 04/08/2016 01:17 AM, Andy Shevchenko wrote:
> >=20
> > On Fri, Apr 8, 2016 at 4:42 AM, Peter Hurley <peter@hurleysoftware.=
c
> > om> wrote:
> > >=20
> > > On 04/07/2016 01:37 PM, Andy Shevchenko wrote:
> > > >=20
> > > > Intes SoCs, such as Braswell, have DesignWare UART. Split out t=
o
> > > > separate
> > > > module which also will be used for Intel Quark later.
> > > What's the rationale?
> > 1. Not poison 8250_pci with too many quirks.
> > 2. They all use same DMA engine, otherwise we might end up in all
> > possible DMA engines included in one file.
> > 3. All of them are actually DesignWare, so, in the future we might
> > share code between 8250_dw and 8250_lpss.
> Just my opinion, but I like to see the rationale in the changelog.

Agreed. Already did locally.

>=C2=A0
> > > And this really isn't a split; this patch introduces a number of
> > > significant
> > > changes from the pci version.
> > Some style changes, yes, but "significant"?
> > For example?
> I'm just pointing out the changelog doesn't really match the
> commit. I'm not suggesting necessarily to redo the series, but just
> more
> adequately reflect the change. See below.


> +struct lpss8250_board {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long freq;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int base_baud;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*setup)(struct lpss8250 *, =
struct uart_port *p);
> > > > +};
> > > New concept.

> > > +struct lpss8250 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int line;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct lpss8250_board *board;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* DMA parameters */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct uart_8250_dma dma;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct dw_dma_slave dma_param;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 dma_maxburst;
> > > > +};

> > > > +static int byt_serial_setup(struct lpss8250 *lpss, struct
> > > > uart_port *port)
> > > This would have been much easier to review if you had simply move=
d
> > > it here
> > > and done the rework in a follow-on patch.
> > I didn't quite get this one.
> Well, just comparing byt_serial_setup() from the two versions:
> 1) dma setup is in a completely separate function
> 2) the tx & rx dma parameters are folded together
> 3) the port setup is split out
> 4) introduction of struct lpss8250
> ...


>=20
> >=20
> > How series should look like?
> I would have just moved byt_serial_setup() without any of the other
> changes
> except perhaps replacing pciserial_board with lpss8250_board, and
> then made the other changes on top before the Quark patches.
>=20
> There is no changelog describing the purpose of struct lpss8250_board=
,
> or
> struct lpss8250. Or of the dma changes. Or why dma_maxburst was
> parameterized.
> ...
>=20
> Naturally, I can figure all of that out on my own, but it would have
> been
> better to read your reasoning.
>=20
> It looks alot of work to split out now, so I guess what's done is
> done, and I'll
> just review this *really* carefully. But imagine if you hadn't wrote
> it, and
> were reviewing this: it's very difficult to mentally separate out the
> changes
> and keep track of them while reviewing. Side-by-side diff is nearly
> useless...
>=20

I sent new version, please, review.

> > > >=C2=A0
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0ret =3D lpss->board->setup(lpss, &uart.port);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0if (ret)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return r=
et;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D lpss8250_dma_setup(lpss,=
 &uart);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0return ret;
> > > I would fold this call into board setup which avoids the
> > > ugliness when this error pathway is reworked in the
> > > follow-on patches.
> > Each of them?
> I'm assuming there's just the two: byt_serial_setup()
> and qrk_serial_setup()?

=46or now yes.

>=20
> Did I overlook something? Perhaps I missed some design goal?

Nope.=C2=A0
But I still prefer to have separate _dma_setup() helper. I didn't see
too much ugliness in the next patches.

> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D lpss8250_probe,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.remove=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D lpss8250_remove,
> > > No power management?
> > PCI does the trick, no *special* power management treatment
> > required, yes.
> I realized that later this am; sorry about that.
> [Maybe just put a small note in the changelog about that though?]

OK.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
