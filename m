From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH v2 3/3] serial: 8250_dw: add fractional divisor support
Date: Thu, 5 Jul 2018 14:39:21 +0800
Message-ID: <20180705143921.6a8aeb50@xhacker.debian>
References: <20180704165908.4bb8b090@xhacker.debian>
        <20180704170310.56772d77@xhacker.debian>
        <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Andy,

On Wed, 04 Jul 2018 19:08:22 +0300 Andy Shevchenko wrote:

> On Wed, 2018-07-04 at 17:03 +0800, Jisheng Zhang wrote:
>=20
> Thanks for an update, my comments below.
>=20
> > For Synopsys DesignWare 8250 uart which version >=3D 4.00a, there's a
> > valid divisor latch fraction register. The fractional divisor width is
> > 4bits ~ 6bits. =20
>=20
> I have read 4.00a spec a bit and didn't find this limitation.
> The fractional divider can fit up to 32 bits.

the limitation isn't put in the register description, but in the description
about fractional divisor width configure parameters. Searching DLF_SIZE will
find it.

=46rom another side, 32bits fractional div is a waste, for example, let's
assume the fract divisor =3D 0.9,=20
if fractional width is 4 bits, DLF reg will be set to UP(0.9*2^4) =3D 15, t=
he
real frac divisor =3D  15/2^4 =3D 0.93;
if fractional width is 32 bits, DLF reg will be set to UP(0.9*2^32) =3D 386=
5470567
the real frac divisor =3D 3865470567/2^32 =3D 0.90;

>=20
> > Now the preparation is done, it's easy to add the feature support.
> > This patch firstly checks the component version during probe, if
> > version >=3D 4.00a, then calculates the fractional divisor width, then
> > setups dw specific get_divisor() and set_divisor() hook. =20
> =20
> > +#define DW_FRAC_MIN_VERS		0x3430302A =20
>=20
> Do we really need this?=20
>=20
> My intuition (I, unfortunately, didn't find any evidence in Synopsys
> specs for UART) tells me that when it's unimplemented we would read back
> 0's, which is fine.

yeah, I agree with you. I will remove this version check in the new version

>=20
> I would test this a bit later.
>=20
> >  =20
>=20
> > +	unsigned int		dlf_size:3; =20
>=20
> These bit fields (besides the fact you need 5) more or less for software
> quirk flags. In your case I would rather keep a u32 value of DFL mask as
> done for msr slightly above in this structure.

OK. When setting the frac div, we use DLF size rather than mask, so could
I only calculate the DLF size once then use an u8 value to hold the
calculated DLF size rather than calculating every time?

>=20
> >  };
> > =20
> > +/*
> > + * For version >=3D 4.00a, the dw uarts have a valid divisor latch
> > fraction
> > + * register. Calculate divisor with extra 4bits ~ 6bits fractional
> > portion.
> > + */ =20
>=20
> This comment kinda noise. Better to put actual formula from datasheet
> how this fractional divider is involved into calculus.

yeah. Will do.

>=20
> > +static unsigned int dw8250_get_divisor(struct uart_port *p,
> > +				       unsigned int baud,
> > +				       unsigned int *frac)
> > +{
> > +	unsigned int quot;
> > +	struct dw8250_data *d =3D p->private_data;
> > + =20
>=20
> > +	quot =3D DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4),
> > baud); =20
>=20
> If we have clock rate like 100MHz and 10 bits of fractional divider it
> would give an integer overflow.

This depends on the fraction divider width. If it's only 4~6 bits,
then we are fine.

>=20
> 4 here is a magic. Needs to be commented / described better.

Yes. divisor =3D clk/(16*baud) =3D BRD(I) + BRD(F)
"I" means integer, "F" means fractional

2^dlf_size*clk/(16*baud) =3D 2^dlf_size*(BRD(I) + BRD(F))

clk*2^(dlf_size - 4)/baud =3D 2^dlf_size*((BRD(I) + BRD(F))

the left part is "DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud)",
let's assume it equals quot.

then, BRD(I) =3D quot / 2^dlf_size =3D quot >> dlf_size, this is where
"quot >> d->dlf_size" below from.

BRD(F) =3D quot & dlf_mask =3D quot & (~0U >> (32 - dlf_size))

>=20
> > +	*frac =3D quot & (~0U >> (32 - d->dlf_size));
> > + =20
>=20
> Operating on dfl_mask is simple as
>=20
> u64 quot =3D p->uartclk * (p->dfl_mask + 1);

Since the dlf_mask is always 2^n - 1,=20
clk * (p->dlf_mask + 1) =3D clk << p->dlf_size, but the later
is simpler

>=20
> *frac =3D div64_u64(quot, baud * 16 * (p->dfl_mask + 1);
> return quot;

quot =3D DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud)
*frac =3D quot & (~0U >> (32 - d->dlf_size))
return quot >> d->dlf_size;

vs.

quot =3D p->uartclk * (p->dfl_mask + 1);
*frac =3D div64_u64(quot, baud * 16 * (p->dfl_mask + 1);
return quot;

shift vs mul.

If the dlf width is only 4~6 bits, the first calculation can avoid
64bit div. I prefer the first calculation.

>=20
> (Perhaps some magic with types is needed, but you get the idea)
>=20
> > +	return quot >> d->dlf_size;
> > +}
> > +
> > +static void dw8250_set_divisor(struct uart_port *p, unsigned int
> > baud,
> > +			       unsigned int quot, unsigned int
> > quot_frac)
> > +{
> > +	struct uart_8250_port *up =3D up_to_u8250p(p);
> > +
> > +	serial_port_out(p, DW_UART_DLF >> p->regshift, quot_frac); =20
>=20
> It should use the helper, not playing tricks with serial_port_out().

I assume the helper here means the one you mentioned below, i.e in

if (p->iotype =3D=3D UPIO_MEM32BE) {
	...
} else {
	...
}

>=20
> > +	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> > +	serial_dl_write(up, quot); =20
>=20
> At some point it would be a helper, I think. We can call
> serial8250_do_set_divisor() here. So, perhaps we might export it.

serial8250_do_set_divisor will drop the frac, that's not we want ;)

>=20
> > +}
> > +
> >  static void dw8250_quirks(struct uart_port *p, struct dw8250_data
> > *data)
> >  {
> >  	if (p->dev->of_node) {
> > @@ -414,6 +445,28 @@ static void dw8250_setup_port(struct uart_port
> > *p)
> >  	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
> >  		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) &
> > 0xff);
> > =20
> > +	/*
> > +	 * For version >=3D 4.00a, the dw uarts have a valid divisor
> > latch
> > +	 * fraction register. Calculate the fractional divisor width.
> > +	 */
> > +	if (reg >=3D DW_FRAC_MIN_VERS) {
> > +		struct dw8250_data *d =3D p->private_data;
> > + =20
>=20
> > +		if (p->iotype =3D=3D UPIO_MEM32BE) {
> > +			iowrite32be(~0U, p->membase + DW_UART_DLF);
> > +			reg =3D ioread32be(p->membase + DW_UART_DLF);
> > +		} else {
> > +			writel(~0U, p->membase + DW_UART_DLF);
> > +			reg =3D readl(p->membase + DW_UART_DLF);
> > +		} =20
>=20
> This should use some helpers. I'll prepare a patch soon and send it
> here, you may include it in your series.

Nice. Thanks.

>=20
> I think you need to clean up back them. So the flow like
>=20
> 1. Write all 1:s
> 2. Read back the value
> 3. Write all 0:s

oh, yeah! will do

>=20
> > +		d->dlf_size =3D fls(reg); =20
>=20
> Just save value itself as dfl_mask.

we use the dlf size during calculation, so it's better to hold the dlf_size
instead.

Thanks for the kind review,
Jisheng
