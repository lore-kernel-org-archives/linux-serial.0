Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FD31C82E6
	for <linux-serial@vger.kernel.org>; Fri,  4 Oct 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061043; cv=none; b=BDxLwhgNrEJykrSftb/xan4jpjQXieqpNabikiVyYM003GLpRNSxrpM18k+Dpca1Th0UC1Y2tncz1oQN4OGvX3SwOmwSG6K27isVaVrE4Et0TFIjNslY9U+IJHYJhYwPz4yuisWimDlcT1fmpXzwJuKbtpStPWX6jL0ZtiT6YEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061043; c=relaxed/simple;
	bh=mBIgP43hFA332wU/wQG7YLLmCpJoVABP/u7z1pRmDBc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k5b70pyPyJy1QIqQ2UIBtwzaqc46wMBLmKmag0DUSXvejlNC2Q7zVmjiskZzgH9MAxn66O9/Vwyte0jEyJX/nRKbEqOiH89YfPTThpEB6LSKKVGCerfuILr0Yc9Np+etYVmMxIjrqJUmwQ5zCpHjL17S7i3WEHHLC7kXgJ3n6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ5hjuCT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ5hjuCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0884EC4CECD;
	Fri,  4 Oct 2024 16:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728061043;
	bh=mBIgP43hFA332wU/wQG7YLLmCpJoVABP/u7z1pRmDBc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=AQ5hjuCTtjWaEiY0KN0MuiNo0cJoVvRdJATqYT2QiRx4m/X/eVCCA0UnV42qQyVxN
	 hxSAoounLztU0pUmXqf5zhh8/53+lCKRep5QtIWvJzIK0trDhQUPcIoeMU1TBuiKiX
	 guZO7aIJldCjD6yhFrjzeh3xd1y2Ktx3fS/QwLKJR7iXPfwhWrCcUgzGxAI+AZoF6V
	 ChDSsSMZd9HzHygRULkmkX0BnJiq9fsz4qcSWfOF6zBbKGRevVKhJ1uAvPmCk/XfVO
	 p7WgHcd4qtdRTfLgtNmXJSy9/mk8FJ+xYBE8foZ8kuDFxTNt04YL226XeB+mD6KKWC
	 SiIHmS6hRrd2A==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 000931200043;
	Fri,  4 Oct 2024 12:57:21 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 04 Oct 2024 12:57:22 -0400
X-ME-Sender: <xms:cR4AZ8gTM0i9tbbhc_5jErCz7g3sMfFzTbOTejazRXSgeF_KmXfX7g>
    <xme:cR4AZ1A425XkaAu7Luv3qx9utPd187Dbvhlx4MvvsZwOx8y4GeTOO7sa98GL0rONM
    Vazc44gBTAAGvEIh98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedguddtiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:cR4AZ0EyDwR_4kMZSw3G0PRrTj9HGULuUPHmCX-q356OFLmZbmqnpQ>
    <xmx:cR4AZ9Q3blhZPQ7fiSoXfO4JKSCsz315YRyQYDmuzuzkF2ip3pE7IQ>
    <xmx:cR4AZ5wByjji00qWzDAmApNWfZolVcHpaXLiRpewjtUmgIMOhwu3sA>
    <xmx:cR4AZ75zK_An49-mwDyagl1TWjkn21YRRTM_Zl0_KEOmZafWPpbbyw>
    <xmx:cR4AZ2yNQjaqRvSQRmtOD00K9fwtijtHDZbVgNrKaI4W4Zp9xHdzG2bn>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BC6C32220073; Fri,  4 Oct 2024 12:57:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 04 Oct 2024 16:57:01 +0000
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Message-Id: <be4faaed-be22-42e5-bcc2-6a992b4f9b58@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2410041642140.45128@angie.orcam.me.uk>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <alpine.DEB.2.21.2405230244140.1257@angie.orcam.me.uk>
 <ef2912910d006c573324bcf063cb76e843dc8267.camel@linux.ibm.com>
 <alpine.DEB.2.21.2410011707550.45128@angie.orcam.me.uk>
 <7bcec0eb88c3891d23f5c9f224e708e4a9bb8b89.camel@linux.ibm.com>
 <alpine.DEB.2.21.2410021632150.45128@angie.orcam.me.uk>
 <84bbda13-ded1-4ada-a765-9d012d3f4abd@app.fastmail.com>
 <alpine.DEB.2.21.2410022305040.45128@angie.orcam.me.uk>
 <b59d81ee-04af-4557-9d35-ec2c03fbcbe7@app.fastmail.com>
 <alpine.DEB.2.21.2410041642140.45128@angie.orcam.me.uk>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 4, 2024, at 16:24, Maciej W. Rozycki wrote:
> On Fri, 4 Oct 2024, Arnd Bergmann wrote:
>> There are also a lot of Arm systems that have no I/O space support at
>> all, such as the Apple M2 I'm using at the moment.
>
>  Thanks for letting me know.  Is it AArch64 only that has no port I/O 
> support in the PCIe root complex nowadays, or is it 32-bit ARM as well?

I'm fairly sure we have some on 32-bit as well, it's certainly
up to the specific SoC rather than the architecture.

I think I've seen three different cases:

- Apple leaves out every feature from hardware that they don't
  have to do for compliance, this also includes CPU stuff like
  32-bit mode, big-endian or cacheable PCI mappings. I think IBMs
  ppc64 chips are in a similar situation

- Some devices can probably do I/O space in hardware, but this is
  left out from the driver or the DT because it has not been
  validated to work

- Some devices have a limited number of mapping windows that
  are shared between prefetchable-memory, non-prefetchable-memory,
  config and io space. Leaving out I/O space completely is
  easier than runtime remapping of the windows

      Arnd
