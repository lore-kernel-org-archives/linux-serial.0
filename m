Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13D37F00A
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358215; cv=pass; b=T8wBpCS73vjiWMkjtVEAYlYvZOD3eSIRlYajAuPaqeDa8PHa1FIXX28GK6+157sv0tkoV6UC2XxE2FkegkOz47gVH4TpvxQslsEXBAxGuQErq9Enk2jo4KgAZpN6s57v8qvNqR7ee2sT1PingmPHomBEPC6WQ1gotYA0pSd6dIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358215; c=relaxed/simple;
	bh=EoJjq+T7VyGPNATN8SO5bqxvJfuZRwCFmI4lyyJXJ0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BF4L9YSL/STIFM6dve6STR/X+7tuXrQwg7BBo/mO+D95UGLYzBk19A7JnNYeZQYLFGeVn5xF51TFyF5r90Vp40tex+sJjseEVjU86kvmjkOT2I5ejtBNRi006TY5WY02Ly4aRaqFkFhUPfyghnKfsCOpT9KtYj7jYrgxgVBjcaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=WBYhzMr4; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="WBYhzMr4"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-480033bdcf4so921536f8f.2
        for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 03:36:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786358212; cv=none;
        d=google.com; s=arc-20260327;
        b=NQrWwnoS1+p5HSjfvKrDG8kHVuHRKQ7onYLltWOHfcTGrd3VHTj1b4/XzY4OuQomif
         cjMoQ46ZAxdiB0c5nLPur2MzDaXDC3B21udkGYLDYnay6YWCOyiOoeGB2PzFy9imJ+VV
         vKiZusDjgtEevC2v4c5H/0kvwc9SkZWU7zoq3DCPja4C9WI9R0tdCNgvV78zP3yl3LyI
         dF7qd8alnVXlNy6FSWADbZkUL/9QI0Q9bUlvPXcd/hP3iHYS594sjVY41+xWn30klcIr
         Kluqa7AWGifXeGMxOW/B5nd4BM8v1yqpv1CG1o59rWnd96z0QC4Pr83eMiYA2mhCCuaN
         RgiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JZiFErJumO4f6l/jB3Vv8dc/wBPU8PfaQ8eqWXYPx/g=;
        fh=N4UyGkHWfZMPx+ZjY5S5msJd13aeVu3AIYQFNyVcHPg=;
        b=a9Vw/sVbl/fdeVWorM5eRWXsWlutpIoi01zIu/habCKH52qmRRlKdpekKbrIo0dIAf
         +J8RFzUbSIn7fzjsL+NHXEVrqhr/qiuyk2u12Fft8NwsQAxtQVLrNTnQYKwhCONpahxr
         FLxQII52wnUxoIVt4dZ0pUdZ9I31DFr/2zSXiZeAOveJPdKoxhVOpoG17iQLX5hkVeFJ
         vvSzI1hBj0rPJ/mzpz+9AUJWKzljmRMvVsyYRDzIOBvsaOL8JsTqPTlfrRM3QigboAC7
         YCbDl3h4C7m0AOJhQki5BVOEgeCbkQlSU8gRUOwwzarkqbmat/KB5b43ei2qAMScYf32
         siSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1786358212; x=1786963012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JZiFErJumO4f6l/jB3Vv8dc/wBPU8PfaQ8eqWXYPx/g=;
        b=WBYhzMr4Cf+6KEWTSh3811AVodQnmLtOhN/fXj7ACc5pC4j3KNdC9Q9nfSyO89paK+
         EVsFDZpuwLSzi/JjV4jcVkadqxYf3WrIFbAjE64nqj6Y9nWMt4OQGtPTXnXRn02e4BLg
         3JuXEXqorbjU6OrFdhbzOdSqfA2ncm4cSap0ij3kBHiE0ypSzPm4YX4LSS3OYj5AXTWe
         eE4bH54u7VqtNddKi8nmHBWHTvw6GRppBYdMI6sk97sb/Toqd4swPPvhMGvlNDbuWf2X
         x/dhcYQiPcm9g9pRlGFqnU2bqhx+b1a9qlj32VOZ/HDYfCXWwPkja55oQIMEqe3uDsgA
         0Jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786358212; x=1786963012;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JZiFErJumO4f6l/jB3Vv8dc/wBPU8PfaQ8eqWXYPx/g=;
        b=CNNwp7qPbwkwm4vufM4BNelZar0ceZIFSaaqzYvL2cw9b/RMBJvDhEmM8tiAqLNEO4
         iCrqIs9dNRY3C7lc9PRIVQc2jcbcaWqjCwUt6+PvZFc44tqBPTZ1TnSUuqZ3n+DxmvPs
         vW5fgwYWrC3sox88/p85C2mXEWZScwJM3afSv92iYC6tX5AROtxwrVETOsYZvHjVIlTe
         lJ69lpiXmMhIZJQfjE9CEP6Bp/rRcSzw5cIgxk/kQprXDh/bcsG8WdBFOBYhRzjvo+LA
         +i1r4pJM/o7iDg9HSCZeXl5IDgeXuoOYRLRjprjpNRUFPnglP5PmSVW+sD1zKL8xbuPx
         OnmA==
X-Forwarded-Encrypted: i=1; AHgh+RpBitY//aRv5//OQ8htS1g7IYeds1Qwdb20l1LCc7jfiepkJ/piGw2GZ5Q0xg7yhIlwAljQPfw6end0F20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQseuzFk6f36P8x8G/vtvYY3aEuCSOZS8UNRERTu1qOu9sSqYX
	crlDxFdjnawv7tfpEyzKesW2jrTypNSfG8r6RtW+BsYdNh3utdxiGIUpiIvKTO+0+62NLC3XyTl
	ws6e2grFJ1BFlSwgGRLZO6Tfh9p+8N4tTcLltGWR/IA==
X-Gm-Gg: AR+sD10hI3T0b4ip9aYAsy1D+ulTo2R6d9oUNsQiKhtAoinmjk/o/e8SVaYsO/oGRKX
	VXRmzsip7KTjO5wcxJ8cpaAgzERVsI4asOcsDmlpXCl8qQBcX2HOde/IRRQVOr0FamY/NjURZQX
	zfbvVFHnD1w7Y5NE+CO/NyERcXDXVP5zYWwv5NUDA1rwBrJpxonORUT3/NMeofQEAjjtiQRlb6W
	jua/dE9f+1M/MdQsMVbZFNKXgT8ArbkdT/iyDhgwz1oKJQNYF/EVkXmnS/CUKCy6wor58GkU7x7
	QeTuqSjvrxyzjyZVwOQYbwRzlkV+zc6FStIuLndwZPM3bHcHOaBu7EG9/hcc5JeVp9NYXpXY922
	C7U1MwdoD4lYz0C6bPg0k8ZP3sX8tkA==
X-Received: by 2002:adf:e012:0:20b0:47f:959f:f69c with SMTP id
 ffacd0b85a97d-481455ce280mr1198921f8f.7.1786358211845; Mon, 10 Aug 2026
 03:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785932211.git.gregoire.layet@9elements.com>
 <51db5e5bb5bf44dd5ab893b8d547291f04e1d3c7.1785932211.git.gregoire.layet@9elements.com>
 <178609182923.193353.7287772568467157519.b4-review@b4>
In-Reply-To: <178609182923.193353.7287772568467157519.b4-review@b4>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Mon, 10 Aug 2026 12:36:39 +0200
X-Gm-Features: AUfX_mzXwFrJ-NjND3MQzEP6QwRNrCstHPVctQ1cLuVCmYnxx742CiD2MW3y8Ss
Message-ID: <CAFi2wKZdJ3LxJVDqC2K79T0JhoOOWSj=ZmL9pB+Lka_aXDXatQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] soc: mfd: add ASPEED AST2600 PCIe BMC device driver
To: Tan Siewert <tan.siewert@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org, 
	=?UTF-8?Q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, mfd@lists.linux.dev, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > +
> > +static int aspeed_pci_bmc_device_setup_vuart(struct pci_dev *pdev,
> > +                                          struct aspeed_pci_bmc_dev *p=
ci_bmc_dev)
> > +{
> > +     resource_size_t bar =3D pci_resource_start(pdev, 1);
> > +     struct plat_serial8250_port *port;
> > +     u16 vuart_ioport;
> > +     unsigned int i;
> > +
> > +     for (i =3D 0; i < ASPEED_BMC_VUART; i++) {
> > +             port =3D &pci_bmc_dev->uart[i];
> > +
> > +             /* ASPEED BMC device shift addresses by 2 to the left */
> > +             vuart_ioport =3D vuart_port_addr[i] << 2;
> > +
> > +             port->mapbase =3D bar + vuart_ioport;
> > +             port->uartclk =3D 115200 * 16;
> > +             port->irq =3D pci_irq_vector(pdev, vuart_msi_index[i]);
> > +             port->iotype =3D UPIO_MEM32;
> > +             port->type =3D PORT_16550A;
> > +             port->flags |=3D (UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXE=
D_TYPE);
> > +             port->regshift =3D 2;
> > +     }
> > +
> > +     pci_bmc_dev->cell =3D (struct mfd_cell) {
> > +             .name           =3D "serial8250",
> > +             .platform_data  =3D pci_bmc_dev->uart,
> > +             .pdata_size     =3D sizeof(pci_bmc_dev->uart),
> > +     };
>
> In the commit message you're describing that the MFD driver will be used =
for
> setting up MSI interrupts:
> > It doesn't bind the whole PCIe resource to allow each sub-driver to bin=
d the
> > needed addresses.
>
> But you're adding the UART devices here which now means that the core dri=
ver is
> doing more than MSI interrupt init.

I might have misunderstood but this is creating the UART device by
using the 'serial8250' driver.

> the core driver is doing more than MSI interrupt init.

Yes, as the core driver should add the devices with the right drivers.
I will add this in the commit message.

> Suggestion from my side would be to have an array of `mfd_cell` where you=
 define
> which devices are part of the MFD,

There is already such an array, it is a one element array as only the
VUART is done.
'struct mfd_cell cell; ' will become an real array when KCS will be
added afterwards.

This is not an 2 cell array for the 2 VUART as the 'serial8250'
manages the two VUART on its own.
From what I have researched, this was the way to add UART devices from
an MFD driver.

> and your VUART lives in another driver.
> See `ls2k-bmc-core` for example.

The UART already lives in another driver: the 'serial8250' driver.

Regards,
Gr=C3=A9goire
