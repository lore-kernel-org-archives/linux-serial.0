Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC8D1F4731
	for <linux-serial@vger.kernel.org>; Tue,  3 Dec 2024 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246769; cv=none; b=QEKTzSkM8R7yOWWj4X8dQza5F1RgP8EKyRNJS/bwYNumuYOT02Yp/CVuqtI/pvt86X+wfFhwF0XGXM/Hy+ObWSsKp0U6qNOxqkcGCYmE+kLbeKFL7w1F3yVrYhTq4neSnr+PMjL7s5DMeKRtfd2GaF9nMK6JbFhv2GHJ+klziH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246769; c=relaxed/simple;
	bh=5cqMnt5tSlPEbv4ZRo2BggJ3NHur1JeeNTqPcOMC0bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3okVqqFpqb1APW02ghWXqbd/Io7gou9ClgxdcKewtA8qBgbrOJm0mNtEPnxgOZ0Qd/W2C8UkJGUayXQNFgWM3r6lejlUKE7Be5cDLDFrrRObjdTcRbTmPnDXJTjtx9VLV2Bk6XeSRSVbxQqYmfSEUe+SRAlrV7+mlOoO69f7ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Yzt3g+Ko; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IjnD02jP; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Yzt3g+Ko";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IjnD02jP"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 779EC11401A3;
	Tue,  3 Dec 2024 12:26:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 03 Dec 2024 12:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733246763;
	 x=1733333163; bh=ROJTox0B7eQaiLR3bYiP8xk3zoH7S9KkMLPWuAF/gP4=; b=
	Yzt3g+KopJX0wkffGOGn9Ft+TKaxtBPXqocx6tSXJSk3mxNwNsXKjZi3/0I0BxcH
	x99rtFlKnqCHbKKckgsHDkMdnECKPfEQiXOOPNcsa9u3S+M19RbZPvEfYf93/wUh
	oO8ic4zdR5Lw56U4uVlX8MJ/X0B9/BqPYQEgMiM9eZJkcXhDqdKSfwBrkqkVSHIx
	7vDioAsG1m5YiPb/XptIR0v9n5Q5XQDV06iazRzOAgEwoLzhmQfSwM9mgYgTdqq2
	pBn/KH5VlIcL41he9FJ9a6saJa90zmjEBsyQzoeb8bRQW5qFcCaZOvvqFJYEcG3x
	hFZgDTp6G46O4a5FR9Varg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733246763; x=
	1733333163; bh=ROJTox0B7eQaiLR3bYiP8xk3zoH7S9KkMLPWuAF/gP4=; b=I
	jnD02jPsecjkqdhVYDn+zc9MKQgDkh72WzNC3yQ6Dlh2jIlgEfiajJ5rIXyQ9iZp
	TAAFNG0Uz+nfXN+H3CULgpJQfcBoZfifek1kO2IgeqXcNlkz8B73zHu1rGF9bKwF
	hXsf5MDN2WDMeR8OejtaC2/qVIEOBUC4pFyNjYXGPKXefXb/f7GIXUSVbP/IVPEC
	i6MssYUgzkWmlZ7EAmr/+VxmBxDKQ6+GEGJ9JUVHnnVSIuDRPQELvwmRWZMJ1km7
	WI/5S0PQNq9wlS0uhcygjMYK0OHQKIGfsh08JvHby49kCvWACPY+o3hHhdrMDylH
	s69yz0N5b4tcqmRr7wbdg==
X-ME-Sender: <xms:Kz9PZ4ADpQiiDkoH2WZxQeSm1P8hcge8Hnb4Iw6iGH8T4o-bBM2MuA>
    <xme:Kz9PZ6iZXXEdnk_Diq1OWzYzR9b83zI0chgfxcuZo_u6EORrI2uRnjmX3ITBrSeug
    ivMQLDeOGkQEA>
X-ME-Received: <xmr:Kz9PZ7m0J6sCvk1uGZh1vpPbZa-qlYDutQNN7zcSePvbIf7a5IJ6M2qTDXsJrkbIRLArL4xvLyV2R7uUYHY8jpv7K3ExI4qkxY6OHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieefgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcumffjuceoghhrvghg
    sehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpedugeeuhfdvjeetlefhkeejue
    ekleehieeuhfefieefieefvedvgfdugeekfeefueenucffohhmrghinhepghhithhhuhgs
    rdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmuhhnihhsvghkhhgrrhhrmhhssehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepkhgvrhhnvghlnhgvfigsihgvsheskhgvrhhnvghlnhgvfigsihgv
    shdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:Kz9PZ-yUtdndigc94U6z7B3KZtysXA7EUONP7pTPI0mS-_g-bxnjMg>
    <xmx:Kz9PZ9Q08APUpaYWrHodVrFv_TTDH7sTGm_NUkpH4kX3mhIM5pnkHg>
    <xmx:Kz9PZ5aSE4mayqBe4K0x5ejPOYRgBA5Zze30EzDkS81SeowFUWs7pg>
    <xmx:Kz9PZ2S_7ZvPhCNS9mh_K6MA6eUrREKRuKgkkRbeXfjGxOsvpo2rMg>
    <xmx:Kz9PZ8FIWr3y7o5-UMCcojw0PylgaK4nAxZdYc-bRuI1dMQMZuthWX5b>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 12:26:02 -0500 (EST)
Date: Tue, 3 Dec 2024 18:26:00 +0100
From: Greg KH <greg@kroah.com>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: Query Regarding UART Controller Device Driver in Linux Kernel
Message-ID: <2024120311-omit-camcorder-e8c0@gregkh>
References: <CAHhAz+jqTxsMipLLnBvRAC8cyN=QhTe5sToh45FN=AyrZ9XnNQ@mail.gmail.com>
 <2024120338-atrocious-policy-1ce0@gregkh>
 <CAHhAz+jk5dzBJfEoWYWAf=UKE-43s=qARFX3MkqmMgEAD8zcXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHhAz+jk5dzBJfEoWYWAf=UKE-43s=qARFX3MkqmMgEAD8zcXg@mail.gmail.com>

On Tue, Dec 03, 2024 at 10:38:30PM +0530, Muni Sekhar wrote:
> On Tue, Dec 3, 2024 at 7:26 PM Greg KH <greg@kroah.com> wrote:
> >
> > On Tue, Dec 03, 2024 at 04:47:31PM +0530, Muni Sekhar wrote:
> > > Dear Linux Kernel Community,
> > >
> > > I hope this email finds you well. I need to work on the high speed
> > > UART controller driver in the Linux kernel, and I have a few questions
> > > that I would appreciate your guidance on:
> > >
> > > I understand that the Linux kernel tree contains multiple source code
> > > files related to UART controller device drivers. Could you please
> > > point me to the relevant source code paths for these drivers?
> >
> > Where have you looked that you did not find them?  (hint,
> > drivers/tty/serial is where they are located...)
> >
> > > What is the maximum supported UART baud rate in the current kernel
> > > driver's supports? For example, if the hardware supports high-speed
> > > baud rates (e.g., 12 Mbps), are there any specific design strategies
> > > or modifications needed in the driver to support such high speeds?
> >
> > Many different uarts support different high-speed rates, it depends on
> > the hardware.  And yes, there are different ways of going that fast, but
> > again, it depends on the hardware.
> >
> > What exact hardware type are you working with?  Does it not already work
> > properly with Linux?
> The hardware I am working with is Xilinx based UART controller with
> DMA capability.
> Can you provide examples of hardware platforms or available UART
> controller drivers that support speeds up to 12 Mbps or higher? What
> specific modifications or configurations are required in the driver to
> enable such high baud rates?

I would suggest reading some UART datasheets for this type of
information.  Start with the one that you have now, that's the best way
to test things.

> > > Are there any user-space utilities available for testing UART
> > > interfaces in Linux? If so, could you kindly share details on these
> > > utilities or provide any resources that would be useful for testing?
> >
> > There are loads of them, but it depends on what you want to test.  What
> > exactly are you wishing to test/validate?
> I am looking for test utilities to stress-test high-speed data
> transfers between two systems over UART, checking for correct
> reception of a large data payload. It includes,  transferring data at
> a high baud rate, and verifying its integrity at the receiving end.
> Could you clarify which utilities are commonly used for testing UART
> interfaces at different levels (e.g., performance, stability, data
> integrity, error checking)? Are there any specific utilities or
> resources you would recommend for testing high-speed UARTs?

You can search as well as I can, but here's something that came up
pretty easily:
	https://github.com/cbrake/linux-serial-test

There are many many many other serial port programs, ideally you would
test the hardware with what you expect to use that hardware for, so why
not just use that software instead of something else?

good luck!

greg k-h
