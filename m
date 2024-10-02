Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E4C194AE8;
	Wed,  2 Oct 2024 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906447; cv=none; b=Ikf2yN/Jj4Nr11OQ7eCNQRlG6JcwRhNAiQF23IWM+oEHDZ3iqjPbhF+NSgQijzhCDQmFyCfaS7iM3B3lFt1VtvsYzJHXT82fElygsVXwlP1AwpfLKitVuTiFiudyx/67T6HL5kwBtg7SHL0SerI85SaJOsBb+e2nW07xpJYOfsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906447; c=relaxed/simple;
	bh=fBzz3jOPes2BLCPMA4IAywQAst4FILIw5XqmwFZKG50=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AQG7t5AEVhGRY6n2F/MqFR1TcJprknmqFHrZ6dxIsrJPV8BvZ6UXqK8N7mrVxCTIwReOqb92VbamKElaFQsFhDTmEnHRGsfktjQezEaKGAM4ZMj4VEIkgPX5dItjbBQAxdXzGn2J3zJsC8wEUXwK6LQnMA13UWhZ/7IYm7kl+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMlJMkTt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMlJMkTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727E7C4CED0;
	Wed,  2 Oct 2024 22:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727906446;
	bh=fBzz3jOPes2BLCPMA4IAywQAst4FILIw5XqmwFZKG50=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ZMlJMkTtj8oZbUrJ1jAGItW40J5JFAgRddOHbpTcoBQ+f//KTR12mzvIO+nxgU7wv
	 eiOG3LilBCDW5qXwucDxgT866n9kkz3K3fG/rf5y3dF2LmwSyWdCFtxT/0Cm5Qkpir
	 u4318j9nE10WEHsQ0mUfLI+7ePYlhiEsaIc9mAEjRyCC+XhZB7vY7XbEbOFgVwENJw
	 PFDvQMe/l+Z+hA3NWP6+7c7jgU/airkEMc8lHU7uv7IAD6pX6Y2mq4t2FoH6TeklTL
	 98vnxrAQUL2H3Oo4jslfeiWj8ijxPYt+RdcyGxOpim2nktcbghymtOxH1k0cYc5Sx7
	 e/Jz1r8TG1dNQ==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7B0891200043;
	Wed,  2 Oct 2024 18:00:39 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 18:00:39 -0400
X-ME-Sender: <xms:h8L9ZvUCsZ3I9yGVDywey9pF2jgW_w8_TFUR2tWUHEu8dmAid9_KPg>
    <xme:h8L9Znl82KS6o4PXo2qbRZS22LcxqKrsVa1iEhDZsJpksYAtzHH_qAEzv9LjOW5qT
    BAuBfatZMtcXIZpbF8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvtddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlh
    drohhrgheqnecuggftrfgrthhtvghrnhepjeejffetteefteekieejudeguedvgfeffeei
    tdduieekgeegfeekhfduhfelhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrd
    horhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohephhgtrgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehstghhnhgvlhhl
    vgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvg
    hnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhn
    uhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepmhgrtghrohesohhrtggrmh
    drmhgvrdhukhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:h8L9ZrYN7lTSwsaywRGXIWCxDwxYTApBgUVJ7HZfUKQm2XWdu1Jsvg>
    <xmx:h8L9ZqXGWMaKdsVzxS3oRAXf0hITWsX6aEnezrb3uq8vL3wByFW8CQ>
    <xmx:h8L9ZpmWpKitDdkf1lP9xvks4X5DH8xdCeReLFZJzY4u3LqPuJ2BlA>
    <xmx:h8L9ZncxVLFWndy4LFSl730Wa4n78Nb_z6bSJ_18IoJsODd_lluX3w>
    <xmx:h8L9ZjGLm2O9XlpnwRAB6Ed_pMulZ_2bWX1NBisaRj-JFigWWIR3cyEJ>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4F0322220071; Wed,  2 Oct 2024 18:00:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 22:00:08 +0000
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Message-Id: <84bbda13-ded1-4ada-a765-9d012d3f4abd@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2410021632150.45128@angie.orcam.me.uk>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <alpine.DEB.2.21.2405230244140.1257@angie.orcam.me.uk>
 <ef2912910d006c573324bcf063cb76e843dc8267.camel@linux.ibm.com>
 <alpine.DEB.2.21.2410011707550.45128@angie.orcam.me.uk>
 <7bcec0eb88c3891d23f5c9f224e708e4a9bb8b89.camel@linux.ibm.com>
 <alpine.DEB.2.21.2410021632150.45128@angie.orcam.me.uk>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2024, at 18:12, Maciej W. Rozycki wrote:
> On Wed, 2 Oct 2024, Niklas Schnelle wrote:
>
>> >  Ideally we could come with a slightly user-friendlier change that would 
>> > report the inability to handle port I/O devices as they are discovered 
>> > rather than just silently ignoring them.
>> 
>> I think this would generally get quite ugly as one would have to keep
>> around enough of the drivers which can't possibly work in that
>> !HAS_IOPORT kernel to identify the device and print some error. It's
>> also not what happens when anything else isn't supported by your kernel
>> build. And I don't think we can just look for any I/O ports either
>> because they could be an alternative access method that isn't required.
>
>  There might be corner cases, but offhand I think it's simpler than you 
> outline.  There are two cases to handle here:
>
> 1. Code you've #ifdef'd out that explicitly refers port I/O resources.
>    So rather than having struct entries referring to problematic `*_init' 
>    handlers #ifdef'd out we can keep them and make them call an error 
>    reporting function if (!IS_ENABLED(CONFIG_HAS_IOPORT)).  As a side 
>    effect the structure of code will improve as we don't really like 
>    #ifdefs sprinkled throughout.
>
> 2. Code that infers the access type required from BARs.  It has to handle 
>    the unsupported case anyway, so rather than doing it silently it can 
>    call the same error reporting function.
>
> Yes, there's some work to be done here, but nothing exceedingly tough I 
> believe.

I agree that this shouldn't be hard to finish. The IS_ENABLED()
check is not that easy to do as I think we need to keep calling
inb()/outb() outside of an #ifdef a compile-time error.

However, I think most of the inb/outb usage in 8250_pci.c can
just be converted to either serial_port_in()/serial_port_out(),
using the 8250 specific wrappers, or to ioread8()/iowrite8()
in combination with pci_iomap().

It might help to add a UPIO_IOMAP type to replace UPIO_PORT
for the PCI drivers and just use pci_iomap() exclusively in that
driver.

>  Also I think this case is a bit special, because it's different from a 
> missing driver.  The driver is there and the hardware is there visible in 
> the PCI hierarchy, there's nothing reported and other serial ports work, 
> or a similar serial port works elsewhere, so why doesn't this one?  The 
> user may not necessarily be aware of the peculiarity that the lack of 
> support for port I/O is.

Part of the problem that Niklas is trying to solve with the
CONFIG_HAS_IOPORT annotations is to prevent an invalid inb()/outb()
from turning into a NULL pointer dereference as it currently does
on architectures that have no way to support PIO but get the
default implementation from asm-generic/io.h.

It's not clear if having a silently non-working driver or one
that crashes makes it easier to debug for users. Having a clear
warning message in the PCI probe code is probably the best
we can hope for.

>  I was not and discovered it the hard way in the course of installing my 
> POWER9 system and trying to make the defxx driver work as supplied by the 
> distribution.  It took me a few days to conclude there is no bug anywhere 
> except for the system lacking support for port I/O and the driver having 
> been configured by the packager via a Kconfig option to use that access 
> type.  Also I had PHB4 documentation to hand to refer to and track down 
> the relevant bits.
>
>  I ended up updating the driver to choose the access type automatically 
> (as the board resources are dual-mapped, via both a port I/O and an MMIO 
> BAR), and would have done so long before if I was aware of the existence 
> of such systems.
>
>  Now I consider myself a reasonably seasoned systems software developer, 
> so what can an ordinary user say?  They might be utterly confused and 
> either report it as a system bug (if they were so determined) or just 
> conclude Linux is junk.

I think that anyone using hardware that relies on port I/O on
non-x86 is at this point going to have a reasonable understanding
of the system, so I'm not too worried here. ;-)

>  A message such as:
>
> serial 0001:01:00.0: cannot handle, no port I/O support in the system
>
> would definitely help.

Right.

       Arnd
