From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH V2 1/4] mfd: f81504-core: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO core support
Date: Fri, 29 Jan 2016 15:41:27 +0200
Message-ID: <1454074887.2521.335.camel@linux.intel.com>
References: <1453972838-30268-1-git-send-email-hpeter+linux_kernel@gmail.com>
	 <1453972838-30268-2-git-send-email-hpeter+linux_kernel@gmail.com>
	 <1453982106.2521.279.camel@linux.intel.com> <56AAFD88.2060505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56AAFD88.2060505@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>, linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Fri, 2016-01-29 at 13:50 +0800, Peter Hung wrote:

> Andy Shevchenko =E6=96=BC 2016/1/28 =E4=B8=8B=E5=8D=88 07:55 =E5=AF=AB=
=E9=81=93:
> > > +obj-$(CONFIG_MFD_FINTEK_F81504_CORE)	+=3D f81504-core.o

> +static int f81504_port_init(struct pci_dev *dev)
> > > +{
> > > +	size_t i, j;
> > > +	u32 max_port, iobase, gpio_addr;
> > > +	u32 bar_data[3];
> > > +	u16 tmp;
> > > +	u8 config_base, gpio_en, f0h_data, f3h_data;
> > > +	bool is_gpio;
> > > +	struct f81504_pci_private *priv =3D pci_get_drvdata(dev);
> >=20
> > I would suggest to rearrange definition block here (and in the rest
> > of
> > the functions in entire series) to somehow follow the following
> > pattern
> >=20
> > 1) assignments go first, especially container_of() based ones;
> > 2) group variables by meaning and put longer lines upper;
> > 3) return value variable, if exists, goes last.
> >=20
> > Besides that choose types carefully. If there is known limit for
> > counters, no need to define wider type than needed. Use proper
> > types
> > for corresponding values.
>=20
> I'll try to rearrange the definition blocks.


> For the counter issue, some senior recommend me to change count from
> int
> to size_t for performance.

Wow, how come? On which arch?

Also mark this as (1) to refer below.

>  In this case, should I use u8 to replace
> i & j ? It should be less than 12 & 6.

At least you tell compiler that it may use any suitable type. In any
case the last decision is by compiler if you don't do any tricks.

So, I suggest to use non-fixed width type like (unsigned) int and leave
everything else on compiler.


> > > +
> > > +	/* Init GPIO IO Address */
> > > +	pci_read_config_dword(dev, 0x18, &gpio_addr);
> > > +	gpio_addr &=3D 0xffffffe0;
> >=20
> >=20
> > > +	pci_write_config_byte(dev, F81504_GPIO_IO_LSB_REG,
> > > gpio_addr
> > > & 0xff);
> > > +	pci_write_config_byte(dev, F81504_GPIO_IO_MSB_REG,
> > > (gpio_addr >> 8) &
> > > +			0xff);
> >=20
> > Could it be written at once as a word?
>=20
> I tested with writing a word to "F81504_GPIO_IO_LSB_REG", but
> it'll failed, so I'll remain it.

Please, add a comment line above.

>=20
> > > +	if (priv) {
> > > +		/* Reinit from resume(), read the previous value
> > > from priv */
> > >=20
> >=20
> > > +		gpio_en =3D priv->gpio_en;
> >=20
> > I would suggest to move this line down to follow same pattern in
> > else
> > branch.

I'm talking here to make simple rearrangement like

if () {
=C2=A0=E2=80=A6
=C2=A0gpio_en =3D =E2=80=A6
} else {
=E2=80=A6
=C2=A0gpio_en =3D =E2=80=A6
}

Thus the gpio_en assignment goes last in both branches.

> > > +
> > > +		pci_write_config_byte(dev, config_base + 0x06,
> > > dev-
> > > > irq);
> > > +
> > > +		/*
> > > +		=C2=A0* Force init to RS232 / Share Mode, recovery
> > > previous mode
> > > +		=C2=A0* will done in F81504 8250 platform driver
> > > resume()
> >=20
> > Period at the end of sentences in multi-line comments.
>=20
> Sorry, what this mean for ?
> I cant use multi-line comments in the end ??

Sentences are started with capital letters and end with period '.'
character, like this one.


> > > +	for (i =3D 0; i < max_port; ++i) {
> > > +		/* Check UART is enabled */
> > >=20
> >=20
> > > +		pci_read_config_byte(dev, F81504_UART_START_ADDR
> > > + i
> > > *
> > > +				F81504_UART_OFFSET, &tmp);
> > > +		if (!tmp)
> > > +			continue;
> >=20
> > So, this is the same as below, right?
> >=20
> > > +
> > > +		/* Get UART IO Address */
> > > +		pci_read_config_word(dev, F81504_UART_START_ADDR
> > > + i
> > > *
> > > +				F81504_UART_OFFSET + 4,
> > > &iobase);
> >=20
> > =E2=80=A6why not to check here?
>=20
> It's a bit difference, this section will check if UART enabled (tmp).
> It'll generate platform device and get IO address when tmp !=3D 0. If
> tmp =3D 0, skip this idx, dont need to get current IO address and try
> with next.

Yeah, I missed that the offset is different.

> +		if (status) {
> > > +			dev_warn(&dev->dev, "%s: add device
> > > failed:
> > > %d\n",
> > > +					__func__, status);
> >=20
> > Indent _ under &.
>=20
> Some senior recommend me to do at least 2-tabs to do indent when
> code cross multi-line. So I'll use to 2-tabs from "dev" to do indent.

> How should I do with indent ?? It seems no consensus, but Lindent
> will do indent like your comments.

I would suggest to use what is used in most recent drivers and modules.
I don't remember that 2 tabs fact is somehow reflected in CodingStyle.

Maybe your seniour was talkin about multi-line function definition?

> +		f81504_gpio_cell.pdata_size =3D sizeof(i);
> >=20
> > Static. The problem here is badly chosen type of i. Like I
> > mentioned at
> > the top of review=E2=80=A6
>=20
> I'll try to rewrite it with pass a structure. It seems more make
> sense.

That's correct on one side, on the other I'm not sure you got my
comment. size_t is arch-dependent type, sizeof() is not the same
everywhere.

> +	pci_read_config_byte(dev, F81504_GPIO_IO_MSB_REG, &tmp);
> > > +	priv->gpio_ioaddr =3D tmp << 8;
> > > +	pci_read_config_byte(dev, F81504_GPIO_IO_LSB_REG, &tmp);
> > > +	priv->gpio_ioaddr |=3D tmp;
> >=20
> > One read as word?
>=20
> It can't read as word. The "F81504_GPIO_IO_LSB_REG" is 0xf1, It
> seems can't be read word/dword from a odd address.
>=20
> I'll remain it.

Put comment about that.

>=C2=A0
> > > +static const struct pci_device_id f81504_dev_table[] =3D {
> > > +	/* Fintek PCI serial cards */
> > > +	{PCI_DEVICE(FINTEK_VID, FINTEK_F81504), .driver_data =3D
> > > 4},
> > > +	{PCI_DEVICE(FINTEK_VID, FINTEK_F81508), .driver_data =3D
> > > 8},
> > > +	{PCI_DEVICE(FINTEK_VID, FINTEK_F81512), .driver_data =3D
> > > 12},
> > > +	{}
> >=20
> > So, if you have default y for this and 8250_pci, which one will be
> > loaded?
>=20
> I had tested on x86, It'll handle by 8250_pci.c when this &
> 8250_pci.c
> all built-in mode.

Yeah. here is the problem. When you introduce that you have to be sure
that no-one will try to build kernel with both included right now.

To avoid potential problem you may split the driver to main part and
Kconfig enabling part. Lee, what is your advice here?

>=20
> BTW, due to the series patches across 3 subsystems MFD/GPIO/8250.
> I make the series patches under MFD subsystem, but the buildbot
> report git repository conflict with GPIO & 8250 (patch 2 & 3).
>=20
> Should I split the series patches into 3 independent patch and
> based on their maintainer git repository?

It should go via one subsystem, otherwise user may end up with non-
working interim kernel version, i.e. when bisecting.

In case if it based on some stuff which is not in upstream yet, you
have to describe this carefully to maintainers that they may create
immutable branches and cross-apply the stuff. But I suppose it's not
your case and your series is quite straightforward.


--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
