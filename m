Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDD72C0F97;
	Thu, 11 Dec 2025 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765461481; cv=none; b=q6YHBwcwHyQYZEU7RWEOYNaaHynEVUBsdTPp3sRQq/nftcZC+9IKlLWdp63mFWxBFSXQfGgzt4x2Ags+8Cd9eM4Sfwwad6fqt84MvxZt2APf8R6zPmq3ljsdciIBiHZggqZSxVn7FZIJM8vbv2vfHOYOZ8yVrSQpj+vCfFpddKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765461481; c=relaxed/simple;
	bh=vZM32RnAWiEMeE9rSc7p4ytmGTsTE9ubn5xNv56iu7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q1G60/WbzKyvGKT2gifwt1O9Nvh8WgDYTqMYMn0ylE838T1lDkOF+XO5x3gJCBHstt+OCvlq6XtLEOEe+q4atNFOoapZnkzuDRjNiObjpyzuY9A3KFjK62y3mSFom7lM5/klUWIawn6I41ArRNOAMZbahFaROegMKBC/nMDjUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gr6ljyuO; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gr6ljyuO"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dRvL542SZz9tRr;
	Thu, 11 Dec 2025 14:57:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1765461469; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aiPBzNWfpt3cqpowU4DKu3351BhGbSF41lWXDiOhaQ=;
	b=gr6ljyuO5EwhRw2XQ/XLMuDXN7llqXE0DthhLMZWiZddNSgz9+Lu+FYiBVgc4s2HmGot06
	tkNQ2I+COM4Mzo6Rrj/D/cRy9uWmIQXP+iMtW4VXyL8RuiIIy5gABut3CA0pGMWcPP3etF
	rqpfIA7t/sASosVH+hqBAHK+PQuJLT6ZIU9jzpcwhqjPGelqu5Gnj5SmwTE54SC4IYzwyy
	sVz1fNaF2LYGEr5UyfJeaYHV7TkUEeX1p8yyJDPuMZFwbFdtzo7bhBVG2q0wOB6pD7stnS
	OfjJj9HmJzKzV0mqm+bgWNqJS6eXpl/jbpbTRjslYpvLUl+4SfZAu+Ux3hj9fA==
Message-ID: <de540d7789d0e9f77efde05fab4705b8d97245d8.camel@mailbox.org>
Subject: Re: [PATCH] tty: serial: Replace deprecated PCI API
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Philipp Stanner <phasta@kernel.org>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Date: Thu, 11 Dec 2025 14:57:46 +0100
In-Reply-To: <3f5370b7-c67c-409d-8422-83b5096d1233@roeck-us.net>
References: <20251126091032.130787-2-phasta@kernel.org>
	 <3f5370b7-c67c-409d-8422-83b5096d1233@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: ac2e4983f9aeb5b9cb5
X-MBO-RS-META: kmakwgpb48m9qy8fqz7zazp19cu7ztyu

On Wed, 2025-11-26 at 09:02 -0800, Guenter Roeck wrote:
> On 11/26/25 01:10, Philipp Stanner wrote:
> > pcim_iomap_table() is deprecated. Moreover, its special usage in 8250,
> > causes a WARN_ON to fire (in pcim_add_mapping_to_legacy_table()).
> >=20
> > 8250's function serial8250_pci_setup_port() effectively maps the same
> > BAR multiple times and adds an offset to the start address. While
> > mapping and adding offsets is not a bug, it can be achieved in a far
> > more straightforward way by using the specialized function
> > pcim_iomap_range().
> >=20
> > pcim_iomap_range() does not add the mapping addresses to the deprecated
> > iomap table - that's not a problem, however, because non of the users o=
f
> > serial8250_pci_setup_port() uses pcim_iomap_table().
> >=20
> > Replace the deprecated PCI functions with pcim_iomap_range().
> >=20
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Link: https://lore.kernel.org/dri-devel/16cd212f-6ea0-471d-bf32-34f55d7=
292fe@roeck-us.net/
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > @Guenther: Can you please test this? I hope it fixes your issue.
>=20
> Yes, it does. Thanks a lot for fixing this!
>=20
> Tested-by: Guenter Roeck <linux@roeck-us.net>

@Greg:
Can you apply this?

P.


>=20
> > ---
> > =C2=A0 drivers/tty/serial/8250/8250_pcilib.c | 9 +++++----
> > =C2=A0 1 file changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial=
/8250/8250_pcilib.c
> > index d8d0ae0d7238..f98eb2ab1005 100644
> > --- a/drivers/tty/serial/8250/8250_pcilib.c
> > +++ b/drivers/tty/serial/8250/8250_pcilib.c
> > @@ -28,13 +28,14 @@ int serial8250_pci_setup_port(struct pci_dev *dev, =
struct uart_8250_port *port,
> > =C2=A0=C2=A0		return -EINVAL;
> > =C2=A0=20
> > =C2=A0=C2=A0	if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
> > -		if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
> > -			return -ENOMEM;
> > -
> > =C2=A0=C2=A0		port->port.iotype =3D UPIO_MEM;
> > =C2=A0=C2=A0		port->port.iobase =3D 0;
> > =C2=A0=C2=A0		port->port.mapbase =3D pci_resource_start(dev, bar) + off=
set;
> > -		port->port.membase =3D pcim_iomap_table(dev)[bar] + offset;
> > +
> > +		port->port.membase =3D pcim_iomap_range(dev, bar, offset, 0);
> > +		if (IS_ERR(port->port.membase))
> > +			return PTR_ERR(port->port.membase);
> > +
> > =C2=A0=C2=A0		port->port.regshift =3D regshift;
> > =C2=A0=C2=A0	} else if (IS_ENABLED(CONFIG_HAS_IOPORT)) {
> > =C2=A0=C2=A0		port->port.iotype =3D UPIO_PORT;
>=20

