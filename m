Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19A2DF14B;
	Thu, 18 Dec 2025 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049137; cv=none; b=EmjHS/azGoPtOhwSjbG059ohQaOs+DUrJOTM3n1XriJy88H5/EWXVff3MVIVI2YdGtpBfs2txexgW32tC2/VOdjDqbfChlXt/K262+b3KYhw5jCGCEu/hbfHuI9jUvcSUbHZXyDadeYB6nJjWbcgj3mOX3+0UEWPktZT+WBTnpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049137; c=relaxed/simple;
	bh=SlgGoPmHV38jZMg8HJCg7FO867j4EFHAadeRFt104vk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ff2xT93mQjs2pcxtjoVlUDwWDzA0jFBRRi7bp5yOJzsRbiGiVagGfKrItvdpSdN2UGbm/TFFO0VyfAghTnPayrYra6bi082bJotsCwAw4vBgYnXWwcYb6KRbm+LZQta+PYqsnu9X6BS2NLWvaZY7Am8vY0GHlhb4418+Q57jrNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RCLpK0+P; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RCLpK0+P"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dX4S22tTKz9sss;
	Thu, 18 Dec 2025 10:02:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766048546; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEjxFC1NV1+CrGsH+3SICivYUfRp0u5Pb+P/hzIEiug=;
	b=RCLpK0+PVhX6dx5ZE2K/+9xKImyVrcmqJmPzSEE3wKK26DK1Nfqs/Lxda0mOHCA7hSYNji
	+B6155+6pqE7RU9351fHNOg3Mv4mdGCZSZm4cfK0LEB52qnggv70n5zh40gz6/0PrzUVoe
	hTMOONUsdrXRRq+lMLw8z7Ag5tdoQfqwTzJNFXcqe5g30YBYN1Tejh1l4QfnSiPOD7Z7Lb
	W51nyArZ8dY/IdfYOxF3jvfszP0uAP45dXzBpAinNyeh2bkGgOwU2I9ymMeyRaOvqNTula
	nUe++oY2sqOmj3yR+tAkogfBvIm07Iqjhq2cdMEk6YRJUS8zdV5pQk8A9A2KJQ==
Message-ID: <6a910f10581848991b485e48e2df4568fa4f1dbb.camel@mailbox.org>
Subject: Re: [PATCH] tty: serial: Replace deprecated PCI API
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, phasta@kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,  linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Date: Thu, 18 Dec 2025 10:02:19 +0100
In-Reply-To: <9bf73b42-9669-4457-9b58-1420a29b61bf@roeck-us.net>
References: <20251126091032.130787-2-phasta@kernel.org>
	 <3f5370b7-c67c-409d-8422-83b5096d1233@roeck-us.net>
	 <de540d7789d0e9f77efde05fab4705b8d97245d8.camel@mailbox.org>
	 <2025121710-audacious-slot-fa2f@gregkh>
	 <9bf73b42-9669-4457-9b58-1420a29b61bf@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 7373b838ed935154262
X-MBO-RS-META: r5wtwnq3kc6xd7qzdgpqj49bq8hfpix9

+Cc Florian

On Wed, 2025-12-17 at 08:11 -0800, Guenter Roeck wrote:
> On 12/17/25 06:06, Greg Kroah-Hartman wrote:
> > On Thu, Dec 11, 2025 at 02:57:46PM +0100, Philipp Stanner wrote:
> > > On Wed, 2025-11-26 at 09:02 -0800, Guenter Roeck wrote:
> > > > On 11/26/25 01:10, Philipp Stanner wrote:
> > > > > pcim_iomap_table() is deprecated. Moreover, its special usage in =
8250,
> > > > > causes a WARN_ON to fire (in pcim_add_mapping_to_legacy_table()).
> > > > >=20
> > > > > 8250's function serial8250_pci_setup_port() effectively maps the =
same
> > > > > BAR multiple times and adds an offset to the start address. While
> > > > > mapping and adding offsets is not a bug, it can be achieved in a =
far
> > > > > more straightforward way by using the specialized function
> > > > > pcim_iomap_range().
> > > > >=20
> > > > > pcim_iomap_range() does not add the mapping addresses to the depr=
ecated
> > > > > iomap table - that's not a problem, however, because non of the u=
sers of
> > > > > serial8250_pci_setup_port() uses pcim_iomap_table().
> > > > >=20
> > > > > Replace the deprecated PCI functions with pcim_iomap_range().
> > > > >=20
> > > > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > > > Link: https://lore.kernel.org/dri-devel/16cd212f-6ea0-471d-bf32-3=
4f55d7292fe@roeck-us.net/
> > > > > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > > > > ---
> > > > > @Guenther: Can you please test this? I hope it fixes your issue.
> > > >=20
> > > > Yes, it does. Thanks a lot for fixing this!
> > > >=20
> > > > Tested-by: Guenter Roeck <linux@roeck-us.net>
> > >=20
> > > @Greg:
> > > Can you apply this?
> >=20
> > Does not apply at all to 6.19-rc1 :(
> >=20
>=20
> It conflicts with commit b7cefdb663382 ("serial: 8250_pcilib: Replace dep=
recated
> PCI functions"). Unfortunately that commit does not fix the problem; I st=
ill
> see it with v6.19-rc1.

Without me being too familiar with the code, it seems that that commit
didn't do what it promised, which is getting rid of the multiple
mappings of the same BAR. Presumably it is mapped multiple times
through setup_port():

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8=
250_pci.c
index 152f914c599d..f0f13fdda2df 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -165,7 +165,15 @@ static int
 setup_port(struct serial_private *priv, struct uart_8250_port *port,
           u8 bar, unsigned int offset, int regshift)
 {
-       return serial8250_pci_setup_port(priv->dev, port, bar, offset, regs=
hift);
+       void __iomem *iomem =3D NULL;
+
+       if (pci_resource_flags(priv->dev, bar) & IORESOURCE_MEM) {
+               iomem =3D pcim_iomap(priv->dev, bar, 0);
+               if (!iomem)
+                       return -ENOMEM;
+       }
+
+       return serial8250_pci_setup_port(priv->dev, port, bar, offset, regs=
hift, iomem);
 }


Note that pcim_iomap() is the party that is *adding* the mappings to
the legacy table, whereas pcim_iomap_table() was just used to access
those.

In any case, I'm quite confident that this description of intended
behavior from the commit message

"the remapping should only be called once via 'pcim_iomap()'. Therefore
the remapping moved to the caller of 'serial8250_pci_setup_port()'."

has not been implemented in the actual code. Otherwise the WARN_ON
couldn't fire.


My personal opinion is that mapping the same BAR multiple times is not
a bug and there is no real practical reason why it shouldn't be done
when it can make sense. pci_iomap_range() exists for that reason since
quite some time.

So my suggested fix for this would be to revert b7cefdb663382 and apply
my patch here instead.


P.


>=20
> Guenter
>=20

