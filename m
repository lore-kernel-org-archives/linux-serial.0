From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH v3 3/3] serial: 8250_dw: add fractional divisor support
Date: Tue, 10 Jul 2018 10:07:04 +0800
Message-ID: <20180710100704.236d256c@xhacker.debian>
References: <20180709160942.11a74f7a@xhacker.debian>
        <20180709162315.7f53eb9a@xhacker.debian>
        <20180709163241.4d4ee343@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709163241.4d4ee343@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Andy,

On Mon, 9 Jul 2018 16:32:41 +0800 Jisheng Zhang wrote:

> Hi Andy,
>=20
> On Mon, 9 Jul 2018 16:23:15 +0800 Jisheng Zhang wrote:
>=20
> > For Synopsys DesignWare 8250 uart which version >=3D 4.00a, there's a
> > valid divisor latch fraction register. The fractional divisor width is
> > 4bits ~ 6bits.
> >=20
> > Now the preparation is done, it's easy to add the feature support.
> > This patch firstly tries to get the fractional divisor width during
> > probe, then setups dw specific get_divisor() and set_divisor() hook.
> >=20
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 45 +++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/825=
0/8250_dw.c
> > index fa8a00e8c9c6..e90c3d229f00 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -31,6 +31,7 @@
> > =20
> >  /* Offsets for the DesignWare specific registers */
> >  #define DW_UART_USR	0x1f /* UART Status Register */
> > +#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
> >  #define DW_UART_CPR	0xf4 /* Component Parameter Register */
> >  #define DW_UART_UCV	0xf8 /* UART Component Version */
> > =20
> > @@ -55,6 +56,7 @@
> > =20
> >  struct dw8250_data {
> >  	u8			usr_reg;
> > +	u8			dlf_size;
> >  	int			line;
> >  	int			msr_mask_on;
> >  	int			msr_mask_off;
> > @@ -366,6 +368,37 @@ static bool dw8250_idma_filter(struct dma_chan *ch=
an, void *param)
> >  	return param =3D=3D chan->device->dev->parent;
> >  }
> > =20
> > +/*
> > + * divisor =3D clk / (16 * baud) =3D div(I) + div(F)
> > + * "I" means integer, "F" means fractional
> > + *
> > + * 2^dlf_size * clk / (16 * baud) =3D 2^dlf_size * (div(I) + div(F))
> > + * so, (clk << (dlf_siz - 4)) / baud =3D (div(I) + div(F)) << dlf_size
> > + *
> > + * let quot =3D DIV_ROUND_CLOSEST(clk << (dlf_size - 4), baud), we get
> > + * div(I) =3D quot >> dlf_size
> > + * div(F) =3D quot & dlf_mask, where dlf_mask =3D GENMASK(dlf_size - 1=
, 0)
> > + */
> > +static unsigned int dw8250_get_divisor(struct uart_port *p,
> > +				       unsigned int baud,
> > +				       unsigned int *frac)
> > +{
> > +	unsigned int quot;
> > +	struct dw8250_data *d =3D p->private_data;
> > +
> > +	quot =3D DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud);
> > +	*frac =3D quot & GENMASK(d->dlf_size - 1, 0);
> > +
> > +	return quot >> d->dlf_size; =20
>=20
> After more consideration, I sent out this version for the following two
> points:
>=20
> 1. the max frac divisor width is 6bits now, but we dunno whether future IP
> extends it or not. This patch version can still support > 6bits width exc=
ept
> the overflow concern. But fixing overflow(if there is) is as simple as us=
ing\
> the DIV_ROUND_CLOSEST_ULL macro.
>=20
> 2. this version makes use of well implemented GENMASK to get the dlf_mask,
> the micro is well understood, I think. so the code is simplified as well.
>=20
> 3. the magic "4" is explained in the comments, I hope it could help the
> code.

I agree with your "making the code simple" concern. So I have a considerati=
on
again. I think I made the code complex unnecessarily, the simplest get_divi=
sor code
could be:

get_divisor()
{
	unsigned int quot, rem;

	quot =3D clk / (16 * baud);
	rem =3D clk % (16 *baud);
	*frac =3D DIV_ROUND_CLOSEST(rem << dlf_size, 16*baud);

	return quot;
}

Compared with previous version, this one adds one more div instruction,
but remove several "shift, and" instructions, the performance isn't that ba=
d.
=46rom another side, even this version gets a trivial performance regression,
the get_divisor() doesn't sit on the hot code path. Making the code simpler=
 is
more important.

I will send a new version.

Thanks
