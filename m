Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EFB7261D;
	Wed, 13 Aug 2025 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092291; cv=none; b=Cc7UagXDh5vUeO/jgOYQ2eRfWhBFm40jS0M8xDB55kPn+DayufonEGkv5IfDbOCpEc1MsVE8Q2Ycbak/M+Th9CmUh7a+a3E7qiCe2Ga5klxRmDuBQbFyAX65clp/zdSNN1PKkFfmQyLAla7hHtlNV19OSM05OlWGKqEU2WWQbU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092291; c=relaxed/simple;
	bh=kzvIFJTThlLQDTF0SfsbvezRVY7pC4RrTK8Eyx2TggI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0S+FyD4ydm0Yzv/5CKZmPG5fOzF/o1EFKtTn93EUNwq5egjlyuzDqLgBLpEUmPtO04fuHfbCeNzXzwSnh7Ircs1ZW8EaZ1P4fv/WkXBtzg8CLvfpxHNQym24rSkY/v7jcEcwEQcps3FmiyhSjPut0dBnbGP6JtajLaVYSXliHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=eUMrfpWH; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="eUMrfpWH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1755092288; x=1755697088; i=parker@finest.io;
	bh=9VhQHr4+unstqwJkUnIUsDv4zG6qvG2KxphQg+F/KGM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eUMrfpWHkyJZ6xBd0O6x7tFO5S8M4gsJin/97/TF6xmxi+YMTyjay+6CzuOI3uk0
	 j6ZLzge5YUyWTf17ao4ebQ5Hqa5rQIjY1Gw1Z0dmamboLpH9HA8MZ20zwSemH5Q3U
	 wJdDxOgdZzrzpDOj69ckpj8NXGndLHrINoYS9pCpVSwr1Q0FGyGHULjydU2uVbj5B
	 To4cOU8ci9UfTCUVrxR+FNCpAc/VNLFMp4TOaWG6/fhqd+S6om4gJn3ZzFVmZza9d
	 A2Juhhs1Kx2IFz1AJe/YKD+pUphIQFs2ZP9v5cWebjZjU1hzAYYA1lTUmjlwGyLZ7
	 QNQO1JwvxZE0UmDAdQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MZTNi-1v7iq535Mc-00QAvJ; Wed, 13 Aug 2025 15:32:35 +0200
Date: Wed, 13 Aug 2025 09:30:47 -0400
From: Parker Newman <parker@finest.io>
To: Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>, Parker
 Newman <pnewman@connecttech.com>
Subject: Re: [PATCH] tty: serial: 8250: exar: fix kernel warning in
 default_setup function
Message-ID: <20250813091900.7d4e4e89.parker@finest.io>
In-Reply-To: <20250813130629.03832804@posteo.net>
References: <aIiDf31HzRBGuMN2@monster.localdomain>
 <2025072929-distant-hardener-0e75@gregkh>
 <20250730130348.082ad53d@posteo.net>
 <aJJ49CSBqGZM_b1Y@smile.fi.intel.com>
 <20250813130629.03832804@posteo.net>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SznZxPD8Wg0H9mAKXReSepM9oqGY/h7EqhlXevfBi6qe4J72OPJ
 UL4uQ7JuBYPzF1x0VoNcDQiFxWvA5Q7tquqdx49JDWq0P6JKbe82VKYTbUAsfzAbj0Sso0q
 PUlShXNC/iJzYvQFOxaKY9/ToJHJvhyvlyH+X2uDga3Lop6xeKBh1hoTQ1FQl4QcnQcsXxg
 0tHXfarAG3SKHsMW+nvEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fkiYmi6M+bs=;dpCzEdJn+Km4HmeNQhuJYrJ/O4w
 tbdy+a9YIF5ZIjdNWE9nQNFzSKpWPy3mvozX5HomM+2k/qtOD2qD/GPETDlcWG1wKZ27+7WU3
 RYXgOwBLVuPuOXLq4p6OV7m1xEc/50RKrCgHQqViLFl0vwGeUhPUsoBF29dYSqbv8MKNEQtg6
 mqFIPm1f8Q9OVYFEFxMYflyq85pjMICsTEEFhFxV8jkMO4E0XxxT38ogjgOluKfqTUf4k4ibu
 wg2eKSwcEIhfa7Vnz+quZzZ7bIgyalWmhrlsYk1F+Ln2ewWIwaTz2uRShl4sRGy6pmkvJpsga
 lFSjaQC/1auZDKPJ6/x8XrLztKnhWqs2DHCfV9jSOTkC9YCN6MhFylFLKRXJBhbheawXzr/dZ
 9MSGEbf3ZiXpPZwUTfjMiG5EudjKWKM6SILJFtrjljUbtwBrcy+j+wHlNkwylCqzaRwPgUzFS
 O/XeFaXvYXP2kM8zSo/JD77P2ryVD2iHZ5XolxVNdqm/nzAq2ECkHuWODyOFYqyvV2YQDZR5t
 8zTeRCSbHDRX4I6ucsxvVMMjpE3/LlYL9qTb3M146DQ6Rqy9ELZ1prhJsAy+trktJlwuUZfJd
 lu6vudTsYx0Yy9cGHcpsB2AVIYzN1YHF81Y1heCtWSjinqLS/l3s/7ZIc5gmBnuhFIMYg0ppZ
 yVz6S6nTXtOwXNqRKMwdvsUTyYC4shz1q4p+cyjnaV/Why97cM29ysXioAqqywGzg1/XdJWlQ
 mEw/BOB8ErtG/0qFmLzEihIiVGKE0r5jhuZqbDqtZdijAwkuIapGcKIQt6MmxTBiWR2G+B9s9
 30cBgz6dvbhx0E/bkqdLzDJGDIncLXRJ8RjG0a7EFqy8EVqtrH4pYnQp1ZujToA5qFLh4N1bQ
 Bq4gkZguvRpBlGJnmrwraZmNk7AytExcH4CALX3K6mn2K082SJy7DXQwi2/FgSMwmHAOkdfSo
 NwRCWZ4HP3Fvxnsa5VNcD4t2qnAuyy5Zu4712MDEJdIQW0bYm5VdNuUsGmCPeNWhPhVRe6PQ/
 uJcqhq+3efNG2mctuGLwrhB5pf6hM8kOT6Gw3TbQ5YF/EWhpNIZfawmxwpaaCA/NQqCohuzTG
 jGZj6K7zMmhZE6ZwJ0U+kt5++LD+UZ35ORkQn2UDelQJZJEQmc3mLkpH93El4pxkrw/laO2pG
 go02G3SzMkqJDvje1ooDboX/G0qrlgMTaxZ+P6TQw9wyoU/dQ2uVn9Dk4gnkkOvldU5QyhRIL
 ju3cI8clBDP26o80VawipZnkqreEosFYWbNm6+ag6Dr2zCJONbJ3wzRvcfU0YhGGuz2GKvvnu
 ea4+MIObzF7gcLxhwTCGZmkyfzI7tsKcMreMRa/e6anQ8cWzrzXTapMuKS1Ha0zUmF5qR+EN1
 5jD1WRI9xlzW12CoRaa9LWWNErt0zJA0111xAL9Ah7b90vFAiknyPe8sn+TnClRTvM2WwVkVo
 NPJxszDi5uvR95stHD1EBhqWYXCTL1+dCU37h+HSEo/SdgJgiigK/rotLgQbRRofvfoBeogzM
 sW4mXos2eaLYeXraxV/TN1AJV+GFlLrltlSj5ozxmiMPTmAZu/TP8Y5hYpPXQ8DK5ewHyvZe9
 r757BE0fLpenNVjyWHyGSlBwkeuu7WkwkfrcMZinw3Ppor7oHr5a/dOrKxVnTvICDYCcYxfmr
 WyMRQY9hciJkzfBHTeIhvg

On Wed, 13 Aug 2025 11:06:31 +0000
Wilken Gottwalt <wilken.gottwalt@posteo.net> wrote:

> On Wed, 6 Aug 2025 00:34:44 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>=20
> > On Wed, Jul 30, 2025 at 11:03:50AM +0000, Wilken Gottwalt wrote: =20
> > > On Tue, 29 Jul 2025 10:48:17 +0200
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > >  =20
> > > > > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/s=
erial/8250/8250_exar.c
> > > > > index 04a0cbab02c2..5660bb897803 100644
> > > > > --- a/drivers/tty/serial/8250/8250_exar.c
> > > > > +++ b/drivers/tty/serial/8250/8250_exar.c
> > > > > @@ -500,12 +500,13 @@ static int default_setup(struct exar8250 *=
priv, struct pci_dev
> > > > > *pcidev, struct uart_8250_port *port)
> > > > >  {
> > > > >  	const struct exar8250_board *board =3D priv->board;
> > > > > +	unsigned int bar =3D 0;
> > > > >  	unsigned char status;
> > > > > -	int err;
> > > > > =20
> > > > > -	err =3D serial8250_pci_setup_port(pcidev, port, 0, offset, boa=
rd->reg_shift);
> > > > > -	if (err)
> > > > > -		return err;
> > > > > +	port->port.iotype =3D UPIO_MEM;
> > > > > +	port->port.mapbase =3D pci_resource_start(pcidev, bar) + offse=
t;
> > > > > +	port->port.membase =3D priv->virt + offset;
> > > > > +	port->port.regshift =3D board->reg_shift; =20
> > > >=20
> > > > And so now serial8250_pci_setup_port() is never called?  Are you s=
ure
> > > > that's ok? =20
> > >=20
> > > Hi Greg,
> > >=20
> > > I will not provide a second version of this patch, because this is a=
 bigger
> > > problem involving 8250_exar, 8250_pci and 8250_pci1xxxx. With the ch=
anges from
> > > kernel 6.10 to 6.11 the underlying pcim_* functions where changed. T=
he
> > > serial8250_pci_setup_port() does checks on pci_dev + BAR where resou=
rces were
> > > already mapped via pcim_iomap(), pci_iomap() or even pci_ioremap_bar=
(). Not
> > > sure if mixing this is a good idea after the kernel 6.11 changes.
> > >=20
> > > serial8250_pci_setup_port() uses pcim_iomap() and pcim_iomap_table()=
 for checking
> > > these already mapped resources. But the pcim_iomap_table() is deprec=
ated and
> > > suggests to use pcim_iomap() function to aquire the pointer to the r=
esources
> > > while at the same time pcim_iomap() description states, don't use th=
is function=20
> > > twice on the same BAR. I think the most sane approach would be to dr=
op the
> > > pcim_iomap() and pcim_iomap_table() checks from the serial8250_pci_s=
etup_port()
> > > function. But I can not fully test this, I only have access to some =
hardware
> > > used by the 8250_exar driver. I also CC Andy and Parker, both worked=
 on the
> > > affected code. =20
> >=20
> > I'm on vacations right now and I lost context of this a long ago, plea=
se Cc me
> > to any new version of this change to have a fresh look. =20
>=20
> Hi Andy,
>=20
> there is not much to add here. It is basically a recursivly added issue =
and
> affects the three mentioned drivers. In my opinion it is safe to remove =
the
> pcim_iomap() and pcim_iomap_table() functions checks from the generic
> serial8250_pci_setup_port() function. To me it looks like the "newly"
> implemented pcim_iomap(), which should not be used twice on the same pci=
 bar,
> is the only issue here. But I can only speak for the 8250_exar driver. W=
e
> use the fix in productions systems and it solves the issue. But beyond t=
hat?
> To me the change of the pcim_iomap() looks like a design flaw in general=
,
> allowing io-mapping only one resource per pci bar looks odd to me, but I=
 am
> not knowleged enough about these subsystems.
>=20
Hi All,
It looks like there are 2 issues in serial8250_pci_setup_port() after the
previously mentioned changes to the PCI core.=20

1. pcim_iomap() should only be called once per BAR=20
2. pcim_iomap_table() is deprecated

It seems like fixing serial8250_pci_setup_port() makes the most sense as t=
he=20
deprecated code is in that function. This function is used in 8250_exar,
8250_pci, and 8250_pci1xxxx.=20

The fix would be to have pcim_iomap() called in probe prior to setting up =
the=20
ports. This is already done in 8250_exar and 8250_pci1xxxx but not in 8250=
_pci.=20

Then 8250_pci_setup_port() would need a new argument to pass the serial ca=
rd's=20
BAR address. Or maybe add a "struct serial8250_pci_port" that wrappers
all the arguments?

Making these changes for 8250_pci1xxxx and 8250_exar would be trivial but=
=20
8250_pci will take some more effort.=20

I can try to get this done in the next few weeks if this makes sense to=20
everyone. I can test the 8250_exar driver and potentially can find a 8250_=
pci
based card but I don't think I have access to anything that uses 8250_pci1=
xxxx.

-Parker
