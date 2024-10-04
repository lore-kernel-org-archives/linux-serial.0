Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD682499
	for <linux-serial@vger.kernel.org>; Fri,  4 Oct 2024 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728024854; cv=none; b=Nm0Q9P+RAbC54YncR5tWGHSk4VKEe1cfIK4QYzojbavGlabDxPmUib9l8ulQl1MiLCRzL5cj65mDVg9iIQaJixT15TfbnZ4urbWwLDrDR+n/joNs7dlYITYP0/sDguly7oFNPZqF3sgucAsoh+rq61h5lhGaP1b6ys5h7QRjsO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728024854; c=relaxed/simple;
	bh=dHbeqTOFijkf+HG0GxeHaA5ZnKKP1WS0EPmt37KZWYM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XfHIE2SaqdLJe/srGh3ts71wXFpxfutxGWfAYSUkd8NksZ+ZpObq8r6X1dYw9txlGT+4Me/69zVF17E6M2kRdWLvzp15LsKAAH7pxmATDRSUPwb6l8bKrrLRyjwhMVfFdVPpZdmeWNHZ952PpSS57Fz/4PuIXmT2F8rB1+d4BN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH3q6Kaa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH3q6Kaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10AEC4CECC;
	Fri,  4 Oct 2024 06:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728024854;
	bh=dHbeqTOFijkf+HG0GxeHaA5ZnKKP1WS0EPmt37KZWYM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GH3q6Kaa5r5RSbncazDzIPRYW1dDSe/EHsUU81j78iA9l1SSDX4NgC0GGrddXCpMQ
	 azRJvdZFhoZsNCEmUbMgiCMWKTFDS5PnE8aAl1ocLdc9JPpL3EAAIG/v7jAhwKRM8a
	 Ul5b43c9YVIoASViyJ1Tr0h69EitJLgKxB1KKFHjKf80xgTzldbSoeGl7KXnagW5TE
	 tdBfKzGjjFWVYyKSiuPSJagfiHFuxPmYMcvs7bWM/yrTuHUlqQGMvA6VrFRkzVkUZk
	 21QBUPnXYg40VkPMnWT5z+5hrKcFqaOQMZT0E4z5B2lx4swXDUeICws2Pg+jU+4kG9
	 BSmWhKEtBuF6Q==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id F3DEC1200069;
	Fri,  4 Oct 2024 02:54:12 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 04 Oct 2024 02:54:13 -0400
X-ME-Sender: <xms:FJH_ZjX-mTJ5qSZB52-76AC1bEOrsGJ2LzotzJ6LyrcPXzg3SSjetQ>
    <xme:FJH_Zrn2xnyE9p1sON2MpfX9AIRoFVWNulLkJCaU2Af3tfQxxaVD-cXrTy6Ra71o1
    VuLdrNxqh4sT4q_m0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvg
    hlrdhorhhgqeenucggtffrrghtthgvrhhnpeejjeffteetfeetkeeijedugeeuvdfgfeef
    iedtudeikeeggeefkefhudfhlefhveenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlh
    drohhrghesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehhtggrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepshgthhhnvghl
    lhgvsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepihhlphhordhjrghrvhhinh
    gvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhi
    nhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehmrggtrhhosehorhgtrg
    hmrdhmvgdruhhkpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FJH_ZvaaTbq7YwQP5PTXD8qijyf0GwxK1lwDYe3ZeMg-rtHaUXTPUw>
    <xmx:FJH_ZuVq739NZbNaUqYvIOpOTa-pTJagZeYIkFWoI9gjNdOMGKZEow>
    <xmx:FJH_ZtkFWvBsiPVEIm2_wQJTzBcKrRVM3C2Unrc6FvR3TwwibsxcSg>
    <xmx:FJH_ZrcPiEougHjDp2aRgjiB43kXD2juTSb3l7yUNGNyGdctbHTHmQ>
    <xmx:FJH_ZnGsXpuGcmOzHAbcobxQeY-beaijC00gDHCVORFNfN0VqK0Gii2m>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C11CB2220071; Fri,  4 Oct 2024 02:54:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 04 Oct 2024 06:53:51 +0000
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Message-Id: <b59d81ee-04af-4557-9d35-ec2c03fbcbe7@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2410022305040.45128@angie.orcam.me.uk>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <alpine.DEB.2.21.2405230244140.1257@angie.orcam.me.uk>
 <ef2912910d006c573324bcf063cb76e843dc8267.camel@linux.ibm.com>
 <alpine.DEB.2.21.2410011707550.45128@angie.orcam.me.uk>
 <7bcec0eb88c3891d23f5c9f224e708e4a9bb8b89.camel@linux.ibm.com>
 <alpine.DEB.2.21.2410021632150.45128@angie.orcam.me.uk>
 <84bbda13-ded1-4ada-a765-9d012d3f4abd@app.fastmail.com>
 <alpine.DEB.2.21.2410022305040.45128@angie.orcam.me.uk>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2024, at 22:59, Maciej W. Rozycki wrote:
> On Wed, 2 Oct 2024, Arnd Bergmann wrote:
>> Part of the problem that Niklas is trying to solve with the
>> CONFIG_HAS_IOPORT annotations is to prevent an invalid inb()/outb()
>> from turning into a NULL pointer dereference as it currently does
>> on architectures that have no way to support PIO but get the
>> default implementation from asm-generic/io.h.
>
>  It can be worse than that.  Part of my confusion with the defxx driver 
> trying to do port I/O with my POWER9 system came from the mapping actually 
> resulting in non-NULL invalid pointers, dereferencing which caused a flood 
> of obscure messages produced to the system console by the system firmware:
>
> LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
> IPMI: dropping non severe PEL event
> LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
> IPMI: dropping non severe PEL event
> LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
> IPMI: dropping non severe PEL event
> LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
> IPMI: dropping non severe PEL event
> [...]
>
> from which it was all but obvious that they were caused by an attempt to 
> use PCI port I/O with a system lacking support for it.

Ah, that's too bad. I think this is a result of the patch that
Michael did to shut up the NULL pointer warning we get, see
be140f1732b5 ("powerpc/64: Set _IO_BASE to POISON_POINTER_DELTA
not 0 for CONFIG_PCI=n"). I really wish we could have finished
Niklas' series earlier to avoid this.

>> I think that anyone using hardware that relies on port I/O on
>> non-x86 is at this point going to have a reasonable understanding
>> of the system, so I'm not too worried here. ;-)
>
>  Well, virtually all non-x86 systems continue supporting PCI/e port I/O 
> via a suitably decoded CPU-side MMIO window, so I think coming across one 
> that doesn't can still be a nasty surprise even in 2024.  For instance 
> I've been happily using a PC parallel port PCIe option card, one of the 
> very few interfaces if not the only one remaining that have not ever seen 
> an MMIO variant, with my RISC-V hardware, newer than said POWER9 system.
>
>  So far it's been the s390 and a couple of POWER system implementations 
> that have support for PCI/e port I/O removed.  Have I missed anything?

I meant PCIe cards with I/O space here, not host bridges. I know you
have a lot of them, but what I've heard from Arm platform maintainers
is that they tend to struggle finding any PCIe cards to test their
hsot bridge drivers on, and I expect that a lot of them are actually
broken because they have never been tested and just copied the
implementation badly from some other driver.

I think the only new PCIe devices you can find today that still use
I/O space are ones with compatibility registers for IBM PC style
hardware (vga, uart, parport), but most users would never have used
one of those and instead use the native register interface of their
GPU (on non-x86), USB-serial and no parport. Other devices that
needed I/O space never worked on PCIe anyway because of the lack
of ISA style DMA.

There are also a lot of Arm systems that have no I/O space support at
all, such as the Apple M2 I'm using at the moment.

      Arnd
