Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33891AF0C5
	for <linux-serial@vger.kernel.org>; Mon, 25 Nov 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542689; cv=none; b=e9ccHyVGsVVrpbg73iYV/7sYhq5gNy+FhOqZsWoKtRZX/lwmjy04fBjS8aQYd9qegs+NNiAZV/HKEEXRdqS3FkG/I6NENjp70faHIw+WP2Wzph0G/c6b/5bXvGlu5RlSRIwUQwRRiOdSVYkym3srWlDwONpZZgKPHvQwwM94dsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542689; c=relaxed/simple;
	bh=b/xDcNgHmFl8rKmdpCvpIoRImffNPXL78sWyibQPD7M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eXmLZWTjiXzN4Umm38F+CntkSF8q7zTWimJHIc3UsbN0Bh7eN+FHNj5lSlU6Ftg/SzPaLEs1zqWQ9afy8Bf24z61ydKrLu3vKZWQrvA1dKg7WkO4Ms6NK462EKBOslLwuS9JA/dzbJN0dt9JIJt/EUI/i04b9YKl7Pm902llqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkqjqmqN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkqjqmqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1290C4CED3;
	Mon, 25 Nov 2024 13:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732542688;
	bh=b/xDcNgHmFl8rKmdpCvpIoRImffNPXL78sWyibQPD7M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fkqjqmqNzOXvxFuWxwOXiGjrxhD9X9gIgEjlsFQeE4IGGF19QuzBSMoO8aVed6FTj
	 oBqG2skEbE/wEaQ0kWUj3/QTLX0TMK9otzbfOs/g9vSUI4luJMad2w0vzUK3za4Uy9
	 VMQ8WekPgUHk6j/xF71Uh8+tUGXsEhXOSyz9NwfrPvLAB0tLaWXYSmRYaNAeOh+7T3
	 0QTXpEksyh1xs4B+LgUT5mhaZ93JFPOCc52jeOSw73KY+26Z6saF/q3usjUgi7n4ba
	 Ble9/aBrRYBpe9Z+Fy6dGoXgpFTWwnXwLKgwxbYTl6sCW6el3wmCie4PNNBjDa7MFZ
	 qfDbuTsNts+8A==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id EEF071200066;
	Mon, 25 Nov 2024 08:51:26 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 25 Nov 2024 08:51:26 -0500
X-ME-Sender: <xms:3oBEZ7XtfIa05c4nb-UGxWSNPwaZLHRJhbBkVK6GzHser_Lu2uXH6Q>
    <xme:3oBEZznwk-EQga7xWLhZyKB7w-bdG70WJRxHPTEZaT-DZn-oKBWEqP8zALWXCc9I5
    MubbhBMWaUpyNOEkGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrd
    horhhgqeenucggtffrrghtthgvrhhnpeejjeffteetfeetkeeijedugeeuvdfgfeefiedt
    udeikeeggeefkefhudfhlefhveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdroh
    hrghesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohephigrnhhghihinhhglhhirghngheshhhurgifvghirdgtohhmpd
    hrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgtrgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehstghhnhgvlhhlvgeslh
    hinhhugidrihgsmhdrtghomhdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghn
    khhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepihhlphhordhjrghrvh
    hinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehgrhgvghhkhhes
    lhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigsehroh
    gvtghkqdhushdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3oBEZ3bWvM-OeoNQG3eWTUtm5KAvJUfZBviEZZDAV2H8Eulc07GTDw>
    <xmx:3oBEZ2XAwGkOuI5fJvqVrwYFPRE419D55N5S9O6YZB3QXLurm5H7Qg>
    <xmx:3oBEZ1ltTGPEJmJHLjwMj37acX7iltNoU9Vlu8ET1IH9KMOE0wBYuQ>
    <xmx:3oBEZzchu25dpbazZ_oElvabJKrRS-gaY98kC8jQLv1CUU3KreukTQ>
    <xmx:3oBEZ_Ef1ghYAHc4oRcdXP1BDCh0D-_IUq7nWIa0M7JFagkYqtgVSFdW>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BC0FF2220072; Mon, 25 Nov 2024 08:51:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Nov 2024 14:50:56 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Guenter Roeck" <linux@roeck-us.net>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, "Yang Yingliang" <yangyingliang@huawei.com>
Message-Id: <1a7da799-f15b-4714-a3bd-4c0b1f48fc09@app.fastmail.com>
In-Reply-To: <Z0Re61Tk5lN2Xuxi@smile.fi.intel.com>
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
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 25, 2024, at 12:26, Andy Shevchenko wrote:
> On Mon, Nov 25, 2024 at 12:06:16PM +0100, Arnd Bergmann wrote:
>> What I suspect is going on with the f4c23a140d80 commit
>> is the same bug I mentioned earlier in this thread, where
>> __serial8250_isa_init_ports() just always registers
>> 'nr_uarts' (CONFIG_SERIAL_8250_RUNTIME_UARTS) ports,
>> unlike any other serial driver.
>
> But the configuration can give less than old_serial_port contains.
> See dozens of the explicit settings in the defconfigs.

I don't see any of the upstream defconfigs doing this
though, the only ones setting CONFIG_SERIAL_8250_RUNTIME_UARTS
are those that have an empty old_serial_port[]. 

Note that SERIAL_PORT_DFNS is only defined on x86, alpha
and m68k (for q40), which are the main PC-like platforms.
I see that all three have identical definitions of
SERIAL_PORT_DFNS, so I think these should just be moved
next to the __serial8250_isa_init_ports definition, with
the entire thing moved into a separate ISA driver or
an #ifdef around it. This is of course not the problem
at hand, but it would help separate the x86/isa and
non-x86 platform device cases further.

>> This used to be required before 9d86719f8769 ("serial:
>> 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS"),
>> but I don't see why this is still a thing now, other than
>> for using setserial on i486-class PCs with nonstandard ISA
>> ports.
>> 
>> On non-x86 machines, it only ever seems to create extra
>> ports that are likely to crash the system if opened, either
>> because they lack proper serial_in/serial_out callbacks,
>> or because the default UPIO_PORT callbacks end up poking
>> unmapped memory.
>> 
>> Do you see any reason why we can't just do the version below?
>
> Perhaps we may do this way (it seems better to me than previous 
> suggestions), but it also needs to be carefully checked against
> those configurations that set it explicitly.

Yes, at least to make sure that the numbering of the uarts
does not change. I expect it's actually the same, but don't
know for sure.

> If we go this way, it would be also nice to add a comment explaining that
> this is module parameter (as it's done for those ones above).
>
>> +unsigned int nr_uarts = ARRAY_SIZE(old_serial_port);;

Right.

     Arnd
