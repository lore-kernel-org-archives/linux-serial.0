Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D14433031A;
	Thu, 18 Dec 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050236; cv=none; b=WVCDU2mk/EUj+iISct3bJHEpzfkn7UbIEQ650UmQLSwyFpfgtk93oR/InOAKTDVf956ClaajMwowmf4jOI2/Ond/xGrg7zX+BqYqraSrmh1UrdPITNgWlxfXp8C5qqsEtes276syDog9o9Fq4WzCNnGohOAKw3PSFTkfWywF7OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050236; c=relaxed/simple;
	bh=KM94aRRRu8H12IVd933tnxGJyWSun4oXOKMKXS8vMhk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ssm4JVjqwyxkwNz8fAesZoiPbrzHZtVIxNk2w/2hsSMPZE3ckDwO3IXjPrcLvZEb2CY/lu8F9ILmOwcIunRftf+hFWU2g+hwB7ALNyWBom4y+P6/41x2aUJIAPZzPR6cc586Wg9jc7hfqBiJWIr8SYVKRoFflDTnJdihIQHGqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xzSWdDOV; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xzSWdDOV"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dX54J27kDz9tty;
	Thu, 18 Dec 2025 10:30:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766050224; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KM94aRRRu8H12IVd933tnxGJyWSun4oXOKMKXS8vMhk=;
	b=xzSWdDOVdj9xkiCp/I2pri460dxriTSyQzun+vue3/qarJuuOQ2csGbIrvVjcr+3BlOgZS
	3Kq8loAUt9pqOwbK+QXTHNdZR7vgynwJ47dW0CMoIzk2lxT0PZcDMdS485L3Dt59EQiRAq
	9Yb74g6RC7ZP8cngCipboDnKE9NVDs9o2MlZ3gtrPSGzkVXjV4NftbiQn5gTBBzHtAG4F2
	ukqkJ0QOBLjjkNUXHgOb4t6FqaLr7EUc2qBaJQZxcfbwwmCUSQsDKHuMvWijjemX7rUAc2
	OyAP7QKs584twuo8ybAdiDW79AR6Yg4l6MAERbz8JyDlYj6kciwmJ8Bb+OU+tA==
Message-ID: <9f2960385d8ce318d3446fb6106f64b47781c730.camel@mailbox.org>
Subject: Re: [PATCH] tty: serial: Replace deprecated PCI API
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: phasta@kernel.org, Guenter Roeck <linux@roeck-us.net>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,  linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Date: Thu, 18 Dec 2025 10:30:18 +0100
In-Reply-To: <6a910f10581848991b485e48e2df4568fa4f1dbb.camel@mailbox.org>
References: <20251126091032.130787-2-phasta@kernel.org>
	 <3f5370b7-c67c-409d-8422-83b5096d1233@roeck-us.net>
	 <de540d7789d0e9f77efde05fab4705b8d97245d8.camel@mailbox.org>
	 <2025121710-audacious-slot-fa2f@gregkh>
	 <9bf73b42-9669-4457-9b58-1420a29b61bf@roeck-us.net>
	 <6a910f10581848991b485e48e2df4568fa4f1dbb.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 88d4240b9c489b9e2e6
X-MBO-RS-META: eencdif7gaz4o9irpdn8j9s7c94juhbj

On Thu, 2025-12-18 at 10:02 +0100, Philipp Stanner wrote:
> +Cc Florian
>=20
> On Wed, 2025-12-17 at 08:11 -0800, Guenter Roeck wrote:
> > On 12/17/25 06:06, Greg Kroah-Hartman wrote:
> > > On Thu, Dec 11, 2025 at 02:57:46PM +0100, Philipp Stanner wrote:
> > > > On Wed, 2025-11-26 at 09:02 -0800, Guenter Roeck wrote:
> > > > > On 11/26/25 01:10, Philipp Stanner wrote:
> > > > > > pcim_iomap_table() is deprecated. Moreover, its special usage i=
n 8250,
> > > > > > causes a WARN_ON to fire (in pcim_add_mapping_to_legacy_table()=
).
> > > > > >=20
> > > > > > 8250's function serial8250_pci_setup_port() effectively maps th=
e same
> > > > > > BAR multiple times and adds an offset to the start address. Whi=
le
> > > > > > mapping and adding offsets is not a bug, it can be achieved in =
a far
> > > > > > more straightforward way by using the specialized function
> > > > > > pcim_iomap_range().
> > > > > >=20
> > > > > > pcim_iomap_range() does not add the mapping addresses to the de=
precated
> > > > > > iomap table - that's not a problem, however, because non of the=
 users of
> > > > > > serial8250_pci_setup_port() uses pcim_iomap_table().
> > > > > >=20
> > > > > > Replace the deprecated PCI functions with pcim_iomap_range().
> > > > > >=20
> > > > > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > > > > Link: https://lore.kernel.org/dri-devel/16cd212f-6ea0-471d-bf32=
-34f55d7292fe@roeck-us.net/
> > > > > > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > > > > > ---
> > > > > > @Guenther: Can you please test this? I hope it fixes your issue=
.
> > > > >=20
> > > > > Yes, it does. Thanks a lot for fixing this!
> > > > >=20
> > > > > Tested-by: Guenter Roeck <linux@roeck-us.net>
> > > >=20
> > > > @Greg:
> > > > Can you apply this?
> > >=20
> > > Does not apply at all to 6.19-rc1 :(
> > >=20
> >=20
> > It conflicts with commit b7cefdb663382 ("serial: 8250_pcilib: Replace d=
eprecated
> > PCI functions"). Unfortunately that commit does not fix the problem; I =
still
> > see it with v6.19-rc1.
>=20
> Without me being too familiar with the code, it seems that that commit
> didn't do what it promised, which is getting rid of the multiple
> mappings of the same BAR. Presumably it is mapped multiple times
> through setup_port():
>=20
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250=
/8250_pci.c
> index 152f914c599d..f0f13fdda2df 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -165,7 +165,15 @@ static int
> =C2=A0setup_port(struct serial_private *priv, struct uart_8250_port *port=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 bar, unsi=
gned int offset, int regshift)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return serial8250_pci_setup_port(pr=
iv->dev, port, bar, offset, regshift);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void __iomem *iomem =3D NULL;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pci_resource_flags(priv->dev, b=
ar) & IORESOURCE_MEM) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 iomem =3D pcim_iomap(priv->dev, bar, 0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (!iomem)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return serial8250_pci_setup_port(pr=
iv->dev, port, bar, offset, regshift, iomem);
> =C2=A0}
>=20
>=20
> Note that pcim_iomap() is the party that is *adding* the mappings to
> the legacy table, whereas pcim_iomap_table() was just used to access
> those.
>=20
> In any case, I'm quite confident that this description of intended
> behavior from the commit message
>=20
> "the remapping should only be called once via 'pcim_iomap()'. Therefore
> the remapping moved to the caller of 'serial8250_pci_setup_port()'."
>=20
> has not been implemented in the actual code. Otherwise the WARN_ON
> couldn't fire.
>=20
>=20
> My personal opinion is that mapping the same BAR multiple times is not
> a bug and there is no real practical reason why it shouldn't be done
> when it can make sense. pci_iomap_range() exists for that reason since
> quite some time.
>=20
> So my suggested fix for this would be to revert b7cefdb663382 and apply
> my patch here instead.


Ah, nevermind. I thought about it and it's probably safe to say that
that WARN_ON is useless anyways. So since Florian has already done the
work of getting rid of the deprecated function, I think the clean thing
to do is to remove the WARN_ON from PCI.

I proposed this to Bjorn today:
https://lore.kernel.org/all/20251218092819.149665-2-phasta@kernel.org/

Sorry for the noise

P.
