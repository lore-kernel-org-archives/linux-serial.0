From: Sergei Zviagintsev <sergei@s15v.net>
Subject: Re: [PATCH RFC v2 1/3] tty: serial core: provide method to search
 uart by phandle
Date: Tue, 30 Jun 2015 11:09:10 +0300
Message-ID: <20150630080910.GC17917@localhost.localdomain>
References: <1435520786-31867-1-git-send-email-marek@goldelico.com>
 <1435520786-31867-2-git-send-email-marek@goldelico.com>
 <20150628213434.GB21426@localhost.localdomain>
 <72C0781B-5DEC-474C-83B5-3CD6B8D68890@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <72C0781B-5DEC-474C-83B5-3CD6B8D68890@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Marek Belisko <marek@goldelico.com>, Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, Mark Rutland <mark.rutland@arm.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sebastian Reichel <sre@kernel.org>, NeilBrown <neil@brown.name>, Grant Likely <grant.likely@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>
List-Id: linux-serial@vger.kernel.org

Hi,

On Mon, Jun 29, 2015 at 06:44:23PM +0200, Dr. H. Nikolaus Schaller wrot=
e:
[...]
> >> +	list_for_each_entry(uart, &uart_list, head) {
> >> +		if (node !=3D uart->dev->of_node)
> >> +			continue;
> >> +
> >> +		return uart;
> >=20
> > We can easily save three lines here :)
>=20
> Hm. We have copied from here:
>=20
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/=
drivers/usb/phy/phy.c?id=3Drefs/tags/v4.1#n65
>=20
> So please let us know how you want to save 3 lines.

Sorry for not being specific, I just meant that it could be written as

if (node =3D=3D uart->dev->of_node)
	return uart;

> >> +/**
> >> + * devm_serial_get_uart_by_phandle - find the uart by phandle
> >> + * @dev - device that requests this uart
> >> + * @phandle - name of the property holding the uart phandle value
> >> + * @index - the index of the uart
> >> + *
> >> + * Returns the uart_port associated with the given phandle value,
> >> + * after getting a refcount to it, -ENODEV if there is no such ua=
rt or
> >> + * -EPROBE_DEFER if there is a phandle to the uart, but the devic=
e is
> >> + * not yet loaded. While at that, it also associates the device w=
ith
> >> + * the uart using devres. On driver detach, release function is i=
nvoked
> >> + * on the devres data, then, devres data is freed.
> >=20
> > Add -ENOMEM and -EINVAL, remove -EPROBE_DEFER?
>=20
> Well, if the device is not loaded it means the caller must return -EP=
ROBE_DEFER
> anyways since it can=E2=80=99t complete it=E2=80=99s probe function.

That was my mistake, from the first sight I hadn't found where
-EPROBE_DEFER is actually returned from the code and thus decided that
kernel-doc has an error. But now I see it, thanks.

> >> +
> >> +	*ptr =3D uart;
> >> +	devres_add(dev, ptr);
> >=20
> > What is the point of assigning value to *ptr?
>=20
> Good question. I think it is necessary to store a copy of the found u=
art/phy instead of a reference.
> Therefore the assignment to *ptr copies into the new memory area allo=
cated above by=20
>=20
> ptr =3D devres_alloc(devm_serial_uart_release, sizeof(*ptr), GFP_KERN=
EL);
>=20
> This makes the dev the owner of the data - instead of unknown ownersh=
ip before.
>=20
> It is the same as here (but it might be wrong/unnecessary there as we=
ll):
>=20
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/=
drivers/usb/phy/phy.c?id=3Drefs/tags/v4.1#n209
>=20
> Maybe it has something to do with the unfinished devm_serial_uart_rel=
ease().

Indeed. I haven't noticed this through the first quick look into the
code. Thank you for explanation.
