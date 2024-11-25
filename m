Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1BA1B414F
	for <linux-serial@vger.kernel.org>; Mon, 25 Nov 2024 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557327; cv=none; b=j8fSh4l6TUH2fzWubdw8uYFKxiPfuDbXXdON7NuV1C6pxa+1FffdzygLeb7sHTRw/blUX4FOB25DUwWR8obkn63N1BsW7h+87XwZ+XHTZUnKc66HO6Jv0riJcuNhdtojIjkbvfNVNq6Vahv7BLYMf2khpQDH+f0f44l8dhW2l/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557327; c=relaxed/simple;
	bh=8NAivoIbXu0wIE2Vez6ieEqNsAtS9iMp+FGbamAR+LA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pSiZywY/g1/INQm1ntOzB77rGM0XruE4q8sBu4VBsG2iE8bYNV5TFoZXYTqy4GeuBxoP8Sk6Rxrw8aKylRPsxlTggPxvUcPItm9JI1do2hd68gxeHzNPN7f4IuSut85NpdRsFix4E9vD6lCcD2xfWF7dBl6eOLdQAks7O/NgLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWTMMw8R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWTMMw8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD93C4CECF;
	Mon, 25 Nov 2024 17:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732557326;
	bh=8NAivoIbXu0wIE2Vez6ieEqNsAtS9iMp+FGbamAR+LA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=XWTMMw8RdHoOt+aHMMwU2B5WikFoKRyYkLR1cRjtNJoYPkc57lx5yAa+kd0ZRbTek
	 BYtJ+7sOquk9Nx0UDB9mj+IRarPC69ALf2gTDCJa0Bf6cl8ijos9UtEocIGZriZSGi
	 pJyxuGh8oa7UrviMsLvi2De7/HxqCWFi9lNXhcYc6vFEl/t3V3x1Vbbv3mqRLQABnO
	 5BoNc2moLDLji/ZeP7+dWr5oQjl9Mz88PcLpQV0/zzY8f08JUuu2WJO/qLhAXVxg6O
	 jsshUgrubuT6yEyGft33NtmBffQhrAlIDK+OZ2T82a0Bm1rF6Irvzf2BPANcnMnYDf
	 RQeXS9faEAzww==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 96EA61200043;
	Mon, 25 Nov 2024 12:55:25 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 25 Nov 2024 12:55:25 -0500
X-ME-Sender: <xms:DbpEZ8XbWLkI-jqzqZS9-smUjgtb-gUxhKfVCjkG-9nuFNHGraoQsg>
    <xme:DbpEZwmt2nfwqPMdpiFY7r4UW2LsJOK_mscP6axA9QchpHfNkhQMcpTkVT63WyFMv
    MpcIamAh7O-_scuN6s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlh
    drohhrgheqnecuggftrfgrthhtvghrnhepjeejffetteefteekieejudeguedvgfeffeei
    tdduieekgeegfeekhfduhfelhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrd
    horhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopeihrghnghihihhnghhlihgrnhhgsehhuhgrfigvihdrtghomh
    dprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhtggrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepshgthhhnvghllhgvse
    hlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgv
    nhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrh
    hvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhrvghgkhhh
    sehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepmhgrtghrohesoh
    hrtggrmhdrmhgvrdhukhdprhgtphhtthhopehlihhnuhigsehrohgvtghkqdhushdrnhgv
    th
X-ME-Proxy: <xmx:DbpEZwYbPslYUXN7XMuC4CmFkrZRWZBR8eYZeFywYpb6iZCRyfmCtA>
    <xmx:DbpEZ7VRJN5fDGjsFbD0FOIzyPcy0hXzvVYzSXPOCWI-qJc_zMS9-g>
    <xmx:DbpEZ2ks_7u0OAbCR2PUJfwsiR1k9z2PIC_OgJyMwKjKpQYletdDqA>
    <xmx:DbpEZwfbPs29SpGD8AM5X6pq3fxRiBOomYMr0Cm3RQbX2GEJ3WXOjg>
    <xmx:DbpEZ4EdnUtrt13pXRGdKhCGaRLWkJjneNtDfk3kYuNjD3jxWoMbE5BH>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 620D22220071; Mon, 25 Nov 2024 12:55:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Nov 2024 18:54:55 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Guenter Roeck" <linux@roeck-us.net>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, "Yang Yingliang" <yangyingliang@huawei.com>
Message-Id: <42b1911e-c69b-4f5a-96f2-ab6d4353ea5c@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2411251628320.44939@angie.orcam.me.uk>
References: <20240405152924.252598-2-schnelle@linux.ibm.com>
 <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
 <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
 <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
 <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com>
 <Z0Re61Tk5lN2Xuxi@smile.fi.intel.com>
 <1a7da799-f15b-4714-a3bd-4c0b1f48fc09@app.fastmail.com>
 <alpine.DEB.2.21.2411251628320.44939@angie.orcam.me.uk>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 25, 2024, at 17:54, Maciej W. Rozycki wrote:
> On Mon, 25 Nov 2024, Arnd Bergmann wrote:
>
>> > But the configuration can give less than old_serial_port contains.
>> > See dozens of the explicit settings in the defconfigs.
>> 
>> I don't see any of the upstream defconfigs doing this
>> though, the only ones setting CONFIG_SERIAL_8250_RUNTIME_UARTS
>> are those that have an empty old_serial_port[]. 
>> 
>> Note that SERIAL_PORT_DFNS is only defined on x86, alpha
>> and m68k (for q40), which are the main PC-like platforms.
>
>  May I suggest to call `serial8250_isa_init_ports':
>
> 	if (IS_ENABLED(CONFIG_ISA) || IS_ENABLED(CONFIG_ALPHA) ||
> 	    IS_ENABLED(CONFIG_M68K) || IS_ENABLED(CONFIG_X86))
>
> then (or have an equivalent `select' in the relevant Kconfig files)?

Right, I think that makes sense, but I'm a little worried
about renumbering or incorrectly configuring the uarts on
a non-x86 system that might have ISA slots and also register
a 8250 console.

E.g. on the RM200, two serial ports get registered on
MMIO addresses:

arch/mips/sni/rm200.c:static struct serial8250_platform_data rm200_data[] = {
arch/mips/sni/rm200.c-  MEMPORT(0x160003f8, RM200_I8259A_IRQ_BASE + 4),
arch/mips/sni/rm200.c-  MEMPORT(0x160002f8, RM200_I8259A_IRQ_BASE + 3),
arch/mips/sni/rm200.c-  { },
arch/mips/sni/rm200.c-};

so these would become ports ttyS4 and ttyS5 if the first four
ports get reserved for ISA cards, or disappear when using the
default CONFIG_SERIAL_8250_NR_UARTS=4.

      Arnd
