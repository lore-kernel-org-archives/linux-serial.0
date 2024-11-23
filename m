Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78115FA7B
	for <linux-serial@vger.kernel.org>; Sat, 23 Nov 2024 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732353745; cv=none; b=VXungluf52WkMS/1HAGx27BE4I78YeOx55ncAT3oRSTNMbHk0eBbvO92vWqqmc23fVl50AP7eZYin8IS61ayHi0O0pmCFWE3dFIGjir74qoWLJZniU+6XEvp3Z6USbKBZmxpH0GN634ma5pnLdVgOQO3PGs27NGK3Jky8sBtfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732353745; c=relaxed/simple;
	bh=FrlEPiy9gU6yMxHh98nl205KP5/kI+RKPt5NCxX8nG4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sVOfQ8GspgwLk/PRYr9G0LrDonbqCoq37I8pLtTlYlA6NUe3eJT22vhzkiy5eG+PViUE6p0PmMPWpko7Bu5ybJRv0OKV11QxNzEW5wRsjJrQjUC7vheqsfI2h7i3+kFN7KB7SQmQnzhttpxUpDf+CjwplBkz2oNws2Vl8AnQNUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3JtvMGh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3JtvMGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625A0C4AF0B;
	Sat, 23 Nov 2024 09:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732353744;
	bh=FrlEPiy9gU6yMxHh98nl205KP5/kI+RKPt5NCxX8nG4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=P3JtvMGhu5BqfRY6Oc2BsbxeM8pMEjA2L3hEVUOWXLFjqMTt4Q/agVaJdQVIidIZ5
	 lBrZrGEFn5MJUNmLuci0be8xe9cKtlGL+anUNpgxydCL+lwcKPLclVOI/shgNUki8c
	 LbaYDIQgDdTTyARopa/Q8P96wY/GCBB2gkHY5ruooMN1gv/Z2iPPNbxzon1TKV4FZl
	 1qESIOgAhaJT7SPHkN20NNdXVYoPpPItmhU5vgwt3F8GjLWSk8Xj80xQWPK/L+SLuf
	 5+kIYt8AEeSqRxf+PmZ3HWvo0Zu3ut4Zl7LnDBLDWfgQwScG0rg2n0nGm3SpUckbTd
	 3yZ5flyVJk5iw==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4DAFB1200066;
	Sat, 23 Nov 2024 04:22:23 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Sat, 23 Nov 2024 04:22:23 -0500
X-ME-Sender: <xms:z55BZ584rMme2vllu-BUmvzo20_gfHOqP6gKg1YdmeaXvu87KVvNVw>
    <xme:z55BZ9sRvfWRXLCZK9Bb6cm45GsROE6ttpXGHXczNKZ30E5OgJscqY02wMrHsYgJn
    df2oEAZTC17l_F8Ku8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgedugddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrd
    horhhgqeenucggtffrrghtthgvrhhnpeejjeffteetfeetkeeijedugeeuvdfgfeefiedt
    udeikeeggeefkefhudfhlefhveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdroh
    hrghesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepnhhikhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtggrsehlihhnuhig
    rdhisghmrdgtohhmpdhrtghpthhtohepshgthhhnvghllhgvsehlihhnuhigrdhisghmrd
    gtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidr
    ihhnthgvlhdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuh
    igrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhn
    uggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvg
    htpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:z55BZ3C0z9ZqFVcixIbEnxMzllggytJERsZ2ZUG67RQCfwNTrTUPRg>
    <xmx:z55BZ9ffr85VwP2AROrNdP4TKGqqDGwSy1YSIhleTzoA4H-LEBlNug>
    <xmx:z55BZ-M8dQw2peAZyhMUgVo7fj07p9p34aAc6AlzSgXg4-uQvoeC7g>
    <xmx:z55BZ_l6yR5wjj6ez_f5-4pCIR_W5_fDwXipwt6iVI-Z_ommN81SKg>
    <xmx:z55BZ4ujbt6aJA4rlgoMHkHSQdxDJeax7LFsjVXN11jhZgj3WlJTeOcV>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0FD872220071; Sat, 23 Nov 2024 04:22:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 23 Nov 2024 10:21:27 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Niklas Schnelle" <niks@kernel.org>, "Guenter Roeck" <linux@roeck-us.net>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Message-Id: <f1d973ed-c830-47a0-aaa4-4d331b5e03b0@app.fastmail.com>
In-Reply-To: <ddcbade39fb8a4dcac57c66c59fcc0b4d56dcaa6.camel@kernel.org>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <92c2c05a-be0d-4017-a766-62832668512d@roeck-us.net>
 <ddcbade39fb8a4dcac57c66c59fcc0b4d56dcaa6.camel@kernel.org>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Nov 23, 2024, at 00:34, Niklas Schnelle wrote:
>
> Am I seeing it right that despite the warning and the code setting
> no_serial_in / no_serial_out the console=ttyS0 in the above qemu boots
> still worked? Also for example in the nios2 case I see the warning 4
> times. So this makes me wonder since the warning is new is it possible
> that set_io_from_upio() has been called with an invalid / all
> zero port before but it was invisible.

Yes, that is certainly the case, sorry if I wasn't clear about this.

The warning shows that there is something wrong with the code,
but that problem has likely existed for a long time. We can
obviously just hide that warning again and ignore the underlying
problem without causing any regressions to the previous state,
but I hope we can improve it in some way that makes it less
broken on non-x86 architectures.

> The way I'm reading __serial8250_isa_init_ports() and in particular the
> first loop if nr_uarts is e.g. 5 in the nios case but only the first
> entry in serial8250_ports[] has the IOMEM 8250 it will still call
> serial8250_setup_port() on the 4 other unintalized/zero elements which
> would explain the iotype being 0. And as far as I can see nr_uarts is
> just set to the value of CONFIG_SERIAL_8250_RUNTIME_UARTS in
> 8250_platform.c.

The way I was reading the code, all five would be uninitialized
at the time we call __serial8250_isa_init_ports(), and the first
port only gets set later on.

Another thing I see is that the 8250 driver ("serial") is the
only one that ends up registering a lot of ports at boot time,
while the other ones only register the ones they actually detect.

E.g. on my Apple workstation, I get

# head /proc/tty/driver/*
==> /proc/tty/driver/IMX-uart <==
serinfo:1.0 driver revision:

==> /proc/tty/driver/fsl-linflexuart <==
serinfo:1.0 driver revision:

==> /proc/tty/driver/fsl-lpuart <==
serinfo:1.0 driver revision:

==> /proc/tty/driver/msm_serial <==
serinfo:1.0 driver revision:

==> /proc/tty/driver/mvebu_serial <==
serinfo:1.0 driver revision:

==> /proc/tty/driver/qcom_geni_console <==
serinfo:1.0 driver revision:

==> /proc/tty/driver/qcom_geni_uart <==
serinfo:1.0 driver revision:

==> /proc/tty/driver/s3c2410_serial <==
serinfo:1.0 driver revision:
0: uart:APPLE S5L mmio:0x39B200000 irq:42 tx:0 rx:0 CTS|DSR|CD

==> /proc/tty/driver/serial <==
serinfo:1.0 driver revision:
0: uart:unknown port:00000000 irq:0
1: uart:unknown port:00000000 irq:0
2: uart:unknown port:00000000 irq:0
3: uart:unknown port:00000000 irq:0
4: uart:unknown port:00000000 irq:0
5: uart:unknown port:00000000 irq:0
6: uart:unknown port:00000000 irq:0
7: uart:unknown port:00000000 irq:0
8: uart:unknown port:00000000 irq:0

==> /proc/tty/driver/tegra_hsuart <==
serinfo:1.0 driver revision:

==> /proc/tty/driver/usbserial <==
usbserinfo:1.0 driver:2.0

The way that this driver was meant to handle that originally
is that /sbin/setserial can be used at runtime to configure
any UART that is attached to an ISA bus even if it did not
get detected at boot time, by setting the correct port and
IRQ numbers from userspace. This may be required on i486
systems with ISA cards providing additional non-PNP 8250
on a nonstandard port number, but is likely not useful on
anything other than x86-32.

      Arnd
