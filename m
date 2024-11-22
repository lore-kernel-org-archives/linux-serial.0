Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C313635E
	for <linux-serial@vger.kernel.org>; Fri, 22 Nov 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293152; cv=none; b=YZE0OfsFeqRp3ajitpirW2a2FnXGvxfi7K/TfhL18ESGR4rsLBeGs4Qj5o/CvUg15BbRnHSbjy9vcwj1RY7PlD1urDPNHx8diz/Q0B0XXD03B+S/2/CV5T0Pb7h7ZZvg8LCG8Vx+5rE+hj0iUCSpbzkK5D3A2bVC6vAWnUUIbvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293152; c=relaxed/simple;
	bh=Qx3DsxLqf23svbHaUxQJ7Vt+bEoe0OkHD+bRPH22oDk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jmuOr/PfVpS89jMeu3aW562z98QQ3cMO1WQpAVvZlrR2FrD6/xCU0FcqtRenhTUowSHjqNE93kPay+XEsfZUfmMwNiHc9dFEKBGCTvt44w8w6lNx++UbFbgbshLLmkheTt9LsEAfbu7WWInkn75WI9KzkRwmirs4XG6qI4hvBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dE/D9Eh8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE/D9Eh8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB649C4CED2;
	Fri, 22 Nov 2024 16:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732293152;
	bh=Qx3DsxLqf23svbHaUxQJ7Vt+bEoe0OkHD+bRPH22oDk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dE/D9Eh8wtyvflZsANnaZn3TEUGqMfB9IUkVeo7gGB6W0mMl34S+g8TcVvrwx2JxB
	 4HVmEhSo0ZoNZBKeuEaogK9RrpJZRMoi59XMukwSi/97aV72WGXhpPqo4e00BXq2QD
	 0b7GrCdFQOGAHN0uBqWEh4gTLeRXxKYAADZxyjA2AyMLdBkDmDoVn86MS5FMlDp7Xh
	 /P4w33lCc3MkK+zYsMgbE04X+2vA/L2snzlhqYdGn8+LQ2dIBlX5uSFfwnj+gPlb35
	 hzNZQ+kVzyzcdPz+SmnqBtW33NlRuQup8SIbTfSJo7xoMgisKCuPHbg4HFJLE9HBAR
	 H/Pmu23k3qOYw==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 943DA1200086;
	Fri, 22 Nov 2024 11:32:30 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 22 Nov 2024 11:32:30 -0500
X-ME-Sender: <xms:HrJAZ-2V3lGPaK4EyK_8qjk4ZBtSuFidjfNjKjkVer1EgHrxMUVcjQ>
    <xme:HrJAZxHg6toYOLjKFk_JI1VgZvgNXRppnqs6s2DGA1hNjjHT3rHxW7lQzqDlFBeTI
    EJzTbcNUJpKW6YdNN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeelgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrd
    horhhgqeenucggtffrrghtthgvrhhnpeejjeffteetfeetkeeijedugeeuvdfgfeefiedt
    udeikeeggeefkefhudfhlefhveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdroh
    hrghesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehhtggrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepshgthhhnvghllhgv
    sehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnh
    eslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhu
    gihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigsehrohgvtghkqd
    hushdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HrJAZ24FXYBRKm6l1nt9-80DaG07N0bB8GTPyCol7WyCTPA6SS77RQ>
    <xmx:HrJAZ_2Px-S45t-dempXeCJSevKvHcmKYxWqfSmL_hYFB_yr8Cs9Ww>
    <xmx:HrJAZxFh1ROyvnkMFyF455a3ddyfr5bv6SqNFtXOM54How6HIc3WyQ>
    <xmx:HrJAZ482ouGy_QFZd8wCEmY4UA9v_pav4S4iM78-wNcq4F41gu5K0g>
    <xmx:HrJAZ2lGh4_ljuRmnGF2rNyzasagBE2Vsca-wggEYSsuVWVlF2Vy4_U2>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5970A2220071; Fri, 22 Nov 2024 11:32:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 Nov 2024 17:31:39 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Guenter Roeck" <linux@roeck-us.net>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Message-Id: <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
In-Reply-To: <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 22, 2024, at 16:35, Niklas Schnelle wrote:
> On Fri, 2024-11-22 at 07:18 -0800, Guenter Roeck wrote:
>> On Fri, Apr 05, 2024 at 05:29:24PM +0200, Niklas Schnelle wrote:
>> > In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
>> > compile time. We thus need to add HAS_IOPORT as dependency for those
>> > drivers using them unconditionally. For 8250 based drivers some support
>> > MMIO only use so fence only the parts requiring I/O ports.
>> > 
>> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
>> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> ...
>> > @@ -422,10 +443,12 @@ static void set_io_from_upio(struct uart_port *p)
>> >  	up->dl_write = default_serial_dl_write;
>> >  
>> > +	default:
>> > +		WARN(1, "Unsupported UART type %x\n", p->iotype);
>> 
>> So, according to this patch, the serial uart on microblaze, nios2,
>> openrisc, xtensa, and possibly others is not or no longer supported.
>> 
>> WARNING: CPU: 0 PID: 0 at drivers/tty/serial/8250/8250_port.c:470 serial8250_set_defaults+0x1a8/0x22c
>> Unsupported UART type 0
>> 
>> Any special reason ?
>
> So according to the warning the p->iotype is 0 which is UPIO_PORT.
> For UPIO_PORT the switch above the WARN would pick io_serial_in() and
> io_serial_out() as handlers. These use inb() respectively outb() to
> access the serial so I don't see how they would work with !HAS_IOPORT
> and it most definitely won't work for s390.
>
> Now for Microblaze Kconfig says to select HAS_IOPORT if PCI so I'd
> assume that it can use inb()/outb() and maybe the PCI requirement is
> not correct if this isn't a PCI device and it used to work with
> inb()/outb()? For nios2, openrisc, and xtensa they don't select
> HAS_IOPORT so either it really won't work anyway or they should select
> it. Can you tell us more about the devices involved where you saw this?

I've tried to have a quick look at the four architectures, here
is what I see in the sources:

- on microblaze, the default uart is xlnx,xps-uartlite-1.00.a,
  and there is no 8250. The PCI code that theoretically supports
  I/O port access through an ISA bridge (copied from powerpc),
  but there is currently no code to set up the I/O space window,
  so in practice the port I/O is just a NULL pointer dereference.

- nios2 has a 16550 compatible UART listed in the devicetree
  file, but this uses normal UPIO_MEM registers, not ISA-style
  I/O ports. There is no support for ISA or PCI.

- openrisc has no support for port I/O, like on nios2 the
  16550 style uart is on UPIO_MEM according to the devicetree

- xtensa manually sets up a UPIO_MEM uart in its board files
  and in its dts files. The PCI support does have code to
  hand port I/O, but it looks incorrect to me and either broke
  at some point or never worked. Most likely this was copied
  incorrectly from old powerpc or sparc code where it worked.

So in all four cases, the normal uart should keep working,
and if something tried to start up an ISA style 8250, I
would expect to see the new version produce the WARN()
in place of what was a NULL pointer dereference (reading
from (u8 *)0x2f8) before.

Since there are so many ways to set up a broken 8250,
it is still possible that something tries to add another
UPIO_PORT uart, and that this causes the WARN() to trigger,
if we find any of those, the fix is to no stop registering
broken ports.

     Arnd
