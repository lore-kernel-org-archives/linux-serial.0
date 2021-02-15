Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F3CC433E6
	for <linux-serial@archiver.kernel.org>; Mon, 15 Feb 2021 12:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A2C64E37
	for <linux-serial@archiver.kernel.org>; Mon, 15 Feb 2021 12:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBOMKP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Feb 2021 07:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhBOMKN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Feb 2021 07:10:13 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20D6C061574;
        Mon, 15 Feb 2021 04:09:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l12so8601376wry.2;
        Mon, 15 Feb 2021 04:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kpEy6lOwP0QHLFzXWaV+idBpODtSq1roPIWRmlASS8o=;
        b=DeJT68C+xUcRQx4Nz4qUdOGLkRAdzrHZsnOGyrtK8Yn9gCRR4HMpGI+TM6qupM+HvT
         AWnJdHCuaROBlsG0oaFcbJvX1d7TlnFqdyanvf1/osIC7XXOjN2QORRHJuU00nboendM
         40zqr+Q4X9mlEPniOu+blGOaHllv7qE2KVF9vqeNRg1rIIE1e8WhGffI1CaVUYY9dCjm
         Vzs1KVe6/2/wjT2zUQcQERmfOWphNSfAvMrJ35amRA4HbATrhDVLQLSzVtzHxLJNlpw7
         ehsBSDTjo09o+EdyFtXALYIqitqzToo8YFh/1kpW4AV3X/piVs6xGDEeN30ugBaIhlVU
         1DxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kpEy6lOwP0QHLFzXWaV+idBpODtSq1roPIWRmlASS8o=;
        b=qfopYv5gCG7FIqdq33CWnPnFGGs04ts3+O0tdN+Hd9yAEjek4LKJ7b3zH0HxNyIs/W
         REoZJn7ZHvFOSEX1SPVdWmgOcwLMac7+B8rDZ56yP2akTizSXvtHBu0MYRlw67Q3NC0D
         TnwilwfDf/cmk2Amv4ePycj+d5Yp/1Wz5ERUZ+YmNStNw2FRD9O9gjBXdM82nkOR1SG0
         EdeHeZRpTHWmK+3OaouzlnWuh41bUpl3nXKrDwk/D1lUFHzMAxkJRHB1DR+h0qVA3Hem
         Fm2eNToyxfzaOzyjigdxSWO3dCsmbzrVIuRRnNb4Z9RR+VaAOWmrwVc3O3x8+d0izg3y
         rhzw==
X-Gm-Message-State: AOAM532UbY7NThDFw3F6/unuHDqWbSjWJesVPHpOwsBH85GP1hb6K57N
        arS7zdvvE7JJyqlV35GrDx4=
X-Google-Smtp-Source: ABdhPJw59lbY+urTEa6bFKku7XtTJOTbzTpklDmeiB6f4cQujXDmx0MR4nchH4xAHaCUxhIq2DI0CA==
X-Received: by 2002:a5d:6d06:: with SMTP id e6mr18476698wrq.425.1613390971629;
        Mon, 15 Feb 2021 04:09:31 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id c6sm19700482wrt.26.2021.02.15.04.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 04:09:30 -0800 (PST)
Date:   Mon, 15 Feb 2021 13:09:28 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] tty: serial: Add earlycon driver for Tegra Combined UART
Message-ID: <YCpkeJKs/ZnTwgXJ@ulmo.localdomain>
References: <20210213115824.3306965-1-mperttunen@nvidia.com>
 <YCpMF7MyJYB8x7Zi@ulmo.localdomain>
 <2cdba410-7cc8-6ad3-53ab-d9c24e58a028@kapsi.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6eptjk77NuY8zBiU"
Content-Disposition: inline
In-Reply-To: <2cdba410-7cc8-6ad3-53ab-d9c24e58a028@kapsi.fi>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--6eptjk77NuY8zBiU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2021 at 12:35:31PM +0200, Mikko Perttunen wrote:
> On 2/15/21 12:25 PM, Thierry Reding wrote:
> > On Sat, Feb 13, 2021 at 01:58:24PM +0200, Mikko Perttunen wrote:
> > > Add an earlycon driver for platforms with TCU, namely Tegra194.
> > > The driver is compatible with boot parameters passed by NVIDIA
> > > boot chains.
> >=20
> > I'm not sure I understand the latter part of this description. What boot
> > parameters is this compatible with? Looking at the setup function there
> > doesn't seem to be anything out of the ordinary here, so I'm wondering
> > if that's just confusing. If there's anything special, it might be worth
> > specifically pointing out what that is. Perhaps both in the commit
> > message and in a code comment, so it's properly documented.
>=20
> It's that the name of the driver 'tegra_comb_uart' matches what the boot
> chain passes; and that OF_EARLYCON_DECLARE is not used. (OF_EARLYCON_DECL=
ARE
> cannot anyway be used due to the mailbox indirection in device tree).

This is all not immediately obvious. Perhaps you can add more of this
into the commit message and perhaps provide an example of how this would
be used on the kernel command-line.

You say "mailbox indirection" and looking at the implementation this
does seem to use the mailbox's base address as a sort of TX FIFO, which
I think is all good. However, I'm wondering if we couldn't somehow
detect this all dynamically at runtime. Don't we have access to the
device tree node at this point? If so, couldn't we parse all the
necessary information from the DT instead of relying on the user
providing the mailbox address on the command-line?

I realize that this would all make things a bit more complicated in this
driver, but at the same time it'd make life so much easier for users, so
I think it's worth at least considering.

To elaborate on this a bit, I think it'd be much more useful if users
could specify something like this:

	earlycon=3Dtegra-tcu

rather than:

	earlycon=3Dtegra_comb_uart,0xc150000

Note that I'm not even sure if that's a correct address. It'd be even
better if all of this can just be derived from the device tree. My
recollection is that earlycon always needs to be explicitly enabled, but
I thought it was also possible to derive which console to use from the
/chose/stdout-path property in device tree.

> > > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > ---
> > >   drivers/tty/serial/Kconfig              | 12 +++++
> > >   drivers/tty/serial/Makefile             |  1 +
> > >   drivers/tty/serial/tegra-tcu-earlycon.c | 72 ++++++++++++++++++++++=
+++
> > >   3 files changed, 85 insertions(+)
> > >   create mode 100644 drivers/tty/serial/tegra-tcu-earlycon.c
> > >=20
> > > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > > index 34a2899e69c0..d941785e3f46 100644
> > > --- a/drivers/tty/serial/Kconfig
> > > +++ b/drivers/tty/serial/Kconfig
> > > @@ -331,6 +331,18 @@ config SERIAL_TEGRA_TCU_CONSOLE
> > >   	  If unsure, say Y.
> > > +config SERIAL_TEGRA_TCU_EARLYCON
> > > +	bool "Earlycon on NVIDIA Tegra Combined UART"
> > > +	depends on ARCH_TEGRA || COMPILE_TEST
> > > +	select SERIAL_EARLYCON
> > > +	select SERIAL_CORE_CONSOLE
> > > +	default y if SERIAL_TEGRA_TCU_CONSOLE
> > > +	help
> > > +	  If you say Y here, TCU output will be supported during the earlyc=
on
> > > +	  phase of the boot.
> > > +
> > > +	  If unsure, say Y.
> > > +
> > >   config SERIAL_MAX3100
> > >   	tristate "MAX3100 support"
> > >   	depends on SPI
> > > diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> > > index b85d53f9e9ff..408144326fed 100644
> > > --- a/drivers/tty/serial/Makefile
> > > +++ b/drivers/tty/serial/Makefile
> > > @@ -72,6 +72,7 @@ obj-$(CONFIG_SERIAL_XILINX_PS_UART) +=3D xilinx_uar=
tps.o
> > >   obj-$(CONFIG_SERIAL_SIRFSOC) +=3D sirfsoc_uart.o
> > >   obj-$(CONFIG_SERIAL_TEGRA) +=3D serial-tegra.o
> > >   obj-$(CONFIG_SERIAL_TEGRA_TCU) +=3D tegra-tcu.o
> > > +obj-$(CONFIG_SERIAL_TEGRA_TCU_EARLYCON) +=3D tegra-tcu-earlycon.o
> > >   obj-$(CONFIG_SERIAL_AR933X)   +=3D ar933x_uart.o
> > >   obj-$(CONFIG_SERIAL_EFM32_UART) +=3D efm32-uart.o
> > >   obj-$(CONFIG_SERIAL_ARC)	+=3D arc_uart.o
> > > diff --git a/drivers/tty/serial/tegra-tcu-earlycon.c b/drivers/tty/se=
rial/tegra-tcu-earlycon.c
> > > new file mode 100644
> > > index 000000000000..9decfbced0a7
> > > --- /dev/null
> > > +++ b/drivers/tty/serial/tegra-tcu-earlycon.c
> > > @@ -0,0 +1,72 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2017-2021, NVIDIA CORPORATION.  All rights reserved.
> > > + */
> > > +
> > > +#include <linux/console.h>
> > > +#include <linux/io.h>
> > > +#include <linux/serial_core.h>
> > > +
> > > +#define NUM_BYTES_FIELD_BIT	24
> > > +#define FLUSH_BIT		26
> >=20
> > This one seems to be unused.
>=20
> True, I'll remove it.
>=20
> >=20
> > > +#define INTR_TRIGGER_BIT	31
> >=20
> > I wonder if this could somehow be integrated with the existing TCU
> > driver since we have these bits defined there already. And really this
> > is basically a skeleton version of the same driver.
> >=20
> > > +/*
> > > + * This function splits the string to be printed (const char *s) int=
o multiple
> > > + * packets. Each packet contains a max of 3 characters. Packets are =
sent to the
> > > + * SPE-based combined UART server for printing. Communication with S=
PE is done
> > > + * through mailbox registers which can generate interrupts for SPE.
> > > + */
> > > +static void early_tcu_write(struct console *console, const char *s, =
unsigned int count)
> > > +{
> > > +	struct earlycon_device *device =3D console->data;
> > > +	u8 __iomem *addr =3D device->port.membase;
> > > +	u32 mbox_val =3D BIT(INTR_TRIGGER_BIT);
> > > +	unsigned int i;
> > > +
> > > +	/* Loop for processing each 3 char packet */
> > > +	for (i =3D 0; i < count; i++) {
> > > +		if (s[i] =3D=3D '\n')
> > > +			mbox_val =3D update_and_send_mbox(addr, mbox_val, '\r');
> > > +		mbox_val =3D update_and_send_mbox(addr, mbox_val, s[i]);
> > > +	}
> > > +
> > > +	if ((mbox_val >> NUM_BYTES_FIELD_BIT) & 0x3) {
> > > +		while (readl(addr) & BIT(INTR_TRIGGER_BIT))
> > > +			cpu_relax();
> > > +		writel(mbox_val, addr);
> > > +	}
> > > +}
> >=20
> > For example this function already exists in the Tegra TCU driver and
> > perhaps some of that could be refactored to work for both cases.
>=20
> This is very similar to the main tegra_tcu driver, but considering how
> simple this driver is, and the main driver using the mailbox framework
> making the actual implementation incompatible, I was thinking that it's
> easier to just have this be independent.

I don't have a strong objection to keeping these functions separate,
especially since they are fairly small and not likely to ever change, so
the maintenance burden is going to be small in any case.

But even so it might be nice to stash this all into the same file. After
all, people aren't going to enable this configuration option if they
have the Tegra TCU driver disabled. Once these are integrated, it's also
likely not worth even having a separate Kconfig option because the added
code is so little.

Thierry

--6eptjk77NuY8zBiU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmAqZHUACgkQ3SOs138+
s6H52A//R/nUqjFNAtDEACMsOalOHV0DE/oDBuQK98TzswVWyXBy2KqgPtJFLVFs
rvc59lfZueCDbSLQns3CtnvxQsG/c7FDZLyutXLZdo7LLJPtYgDW44WVKsVST5di
F3USltTbb/dv0hM/ASzE3kJuBHGOHd/qwGc740HDqwNTKi3C+Zszi4am4FmrOKFI
SpUW3WEn1pyxxBo54KTko0lOVl8EWiavMa9SQFun+BlLE2VuGpapq8M5AOZaKrER
n7BcmEmDssUM3MJNPdLNqgqLZgp3mB1I/WsCHKCvjHlQd+RTBTneH6dKOgD0SQlR
f+Nuhpga/zo/p6fZNT8hW7sbRYSf2gldFvNOQgVcsswigpWAkfUTB4zmOxKeODWx
m1F5Q5qUkEEv4EFmaO5aZadRg/guwiU8JdonCf4YjeEaJ6mBKC3k9UHxBmJPhk8R
Pd+nubaqd7vEoMOyOHoV8DQMstQgdRgWxb26IVpVFDw68f6xhIptZ8R9JQ8rb2Oc
SlvOeJMybn80+j9Y+D4pLvH3xVCyC7XOn8XRC+Q5kqKUY29v+/IdzpXSCYd7e9G3
m/uyNsAi/UF0ycqoDWeCEAVJ4MUI1o4lTV+DFEHy1o+vCI23lSM5GVDv6TND094E
809s+tzkmb0PWFEgWjWCjukQSXqNr1a/Y8nfXh9jXA6/Wq/es9c=
=KIp4
-----END PGP SIGNATURE-----

--6eptjk77NuY8zBiU--
