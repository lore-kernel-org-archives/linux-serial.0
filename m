Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5571DEFF0
	for <linux-serial@vger.kernel.org>; Fri, 22 Nov 2024 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303499; cv=none; b=I40LjlDra0BEVLzxysMyl5UGY7u5q6bU/fo8BmEAohIA8ptDqrptiHjo5BkXjE6vcNrY0yJ/9pwL+gi1HIWOma0Limw/NRt3n3r6tm/t5toWxM30Q3psFbIHMy1H9z0kftxRUfwgNlfiBaRYMVJ6161PYSILeyKsbc+jWQmtRhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303499; c=relaxed/simple;
	bh=4A2MsCT60AYKgm9kvhN9yKi/SAeEHaIkmIYrwsN2lWg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pvKw3VrEUSFZ2spNzW002Y9C+vtXgLqmcNysLMaO4v5Ob46itWIl72vcYARpvJo3hukRld7yiaYW+z5ZoUe+3AiFUpKxo5diqJzWay/4o+a2ZPc8PNNrP62a0sZsByEWyytsRWheWTW7V6o48paz9o9Ls21EEQsBbqzrBLkrVQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufNmlCId; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufNmlCId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098FEC4AF0B;
	Fri, 22 Nov 2024 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732303499;
	bh=4A2MsCT60AYKgm9kvhN9yKi/SAeEHaIkmIYrwsN2lWg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ufNmlCIdUDnmI7piZ2yQI2fdPCWwsKtNWGHOxlJLSQDtQvjfcuEc4GMZF3AsEyeZR
	 bsK4KwV9m49fxpNmqi7wnIlaIj6+7XxQPbFaT8wrp7sYKufxBrq3NCP4J6bLp8ilhe
	 AOm9gimxrW4+rT2907TAVrb5w/zxbHs2KvTzq9Qy7k+6hpxGynN1/FOrpnbsiiGJvf
	 ZAabF8S4MibLFy9TRO7Q+pjdfbUk1Zggta993RVeytoaQmiPPBk8TapgoIqZ9U4n45
	 tNeTXM2q+k9kFOOeQJwXjubtHWicX7n8fQbYHKYSkffsptoJ/C+EvAToxBEnbD8iZB
	 rvpKRLO0OX7jQ==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 05FDB120006E;
	Fri, 22 Nov 2024 14:24:58 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 22 Nov 2024 14:24:58 -0500
X-ME-Sender: <xms:idpAZxamo3BG8NVWM_2RBNAJ-tJf-bI48f6YDduU38O--H4tyTAnYw>
    <xme:idpAZ4aXI3XAaEd6af0nWBT1DTajBgCHA3N2RmY520E1mH-fhdsiSKMfFYCT6yO4D
    wYbg67ThTuyjK8jxSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeelgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrd
    horhhgqeenucggtffrrghtthgvrhhnpeejjeffteetfeetkeeijedugeeuvdfgfeefiedt
    udeikeeggeefkefhudfhlefhveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdroh
    hrghesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehhtggrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepshgthhhnvghllhgv
    sehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthh
    gvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehilhhpohdrjhgr
    rhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhrvghgkh
    hhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugies
    rhhovggtkhdquhhsrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:idpAZz9AMrUSg6MRSj-CVbz7JTtI2TRJURQ5tJj4zkRe-URSwjFCww>
    <xmx:idpAZ_pgFW1p9mrA376wUSFeiYkxl65jv_BirK2_ll8H5Nm8Er0kmA>
    <xmx:idpAZ8qq9hXQgOliiYQtK8tNI2vI_ftKWlm-tlp4-khPTOErcTxQJw>
    <xmx:idpAZ1TQlhZMma1k4Ohu1pcT1AIVhgYdaIehwdJSqZtgehbW35MLqg>
    <xmx:idpAZ0q9b3V_Ol5JH1K8EtyPO7HAPjCUHik7xpeANWMsKWCb0vWH-W30>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CDF822220071; Fri, 22 Nov 2024 14:24:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 Nov 2024 20:24:37 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Guenter Roeck" <linux@roeck-us.net>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Message-Id: <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
In-Reply-To: <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 22, 2024, at 18:22, Guenter Roeck wrote:
> On 11/22/24 08:31, Arnd Bergmann wrote:
>> On Fri, Nov 22, 2024, at 16:35, Niklas Schnelle wrote:
>>> On Fri, 2024-11-22 at 07:18 -0800, Guenter Roeck wrote:
>> So in all four cases, the normal uart should keep working,
>> and if something tried to start up an ISA style 8250, I
>> would expect to see the new version produce the WARN()
>> in place of what was a NULL pointer dereference (reading
>> from (u8 *)0x2f8) before.
>> 
>> Since there are so many ways to set up a broken 8250,
>> it is still possible that something tries to add another
>> UPIO_PORT uart, and that this causes the WARN() to trigger,
>> if we find any of those, the fix is to no stop registering
>> broken ports.
>> 
>
> The call chain in all cases is
>
> [    0.013596] Call Trace:
> [    0.013796]  [<d06eb249>] dump_stack+0x9/0xc
> [    0.014115]  [<d000c12c>] __warn+0x94/0xbc
> [    0.014332]  [<d000c29c>] warn_slowpath_fmt+0x148/0x184
> [    0.014560]  [<d04f03d8>] set_io_from_upio+0x70/0x98
> [    0.014781]  [<d04f0459>] serial8250_set_defaults+0x59/0x8c
> [    0.015013]  [<d04efa6a>] serial8250_setup_port+0x6e/0x90
> [    0.015240]  [<d0ae2a12>] serial8250_isa_init_ports+0x32/0x5c
> [    0.015473]  [<d0ae28a1>] univ8250_console_init+0x15/0x24
> [    0.015698]  [<d0ad0684>] console_init+0x18/0x20
> [    0.015926]  [<d0acbf43>] start_kernel+0x3db/0x4cc
> [    0.016145]  [<d06ebc37>] _startup+0x13b/0x13b
>
> That seems unconditional. What is the architecture expected to do to
> prevent this call chain from being executed ?

This looks like a bug in drivers/tty/serial/8250/8250_platform.c
to me, not something the architectures did wrong. My impression
from __serial8250_isa_init_ports() is that this is supposed
to initialize exactly the ports in the old_serial_port[]
array, which is filled only on alpha, m68k and x86 but not
on the other ones.

Andy moved this code in ffd8e8bd26e9 ("serial: 8250: Extract
platform driver"), but I don't think this move by itself
changed anything.

serial8250_setup_port() is where it ends up using the
uninitialized serial8250_ports[index] contents. Since 
port->iotype is not set to anything here, it defaults to
'0', which happens to be UPIO_PORT.

The reason it doesn't immediately crash and burn is that
this is still only setting up the structures for later
use, but I assume that trying to use console=ttyS0, or
opening /dev/ttyS0 on the uninitialized port would
then cause an oops.

The bit I'm less sure about is why the
serial8250_setup_port() function is called here in
the first place. I assume it does something for
/some/ architecture, but it's clearly wrong for
most of them.

       Arnd
