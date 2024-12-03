Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080241E501B
	for <linux-serial@vger.kernel.org>; Tue,  3 Dec 2024 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234185; cv=none; b=U3kuVEe3Id397BEldWDHcj6xPQLh77G4j1+zz7FK+6VyAnGzv5LlabCnkmXlPlIFTcP1vm88UmOFihgCT1gIj8ztsWW7rw2w5vHKTdwCQ3tFP7Bb004OgN4hkOM/HgN+6G9eKtkjyXHtR/Wy74wUWoKxgXv1bEwX7ekA7sMdOEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234185; c=relaxed/simple;
	bh=0m7rV4LtzWpcBcIpCicq7zBnbPAy+wH9k/1V+zGl0/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yvd3aFwVq+Vq8RkFjUnwgi+iABa+OeKxXJuQ7QFazPZOeik2WfZ+jiam2LIFpFkCses7e5c0eX0MzgjUr44j5jLhoBPvWZFucMdaJGd4ecqCVvOaPHRcSbJWXnEKBO8j6I7+bZfnqFH+Xki9+h3//uD9Wsrjj9H4mH7PkteDHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=rHXo0fJj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2tUcnsHo; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="rHXo0fJj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2tUcnsHo"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 016DC1140170;
	Tue,  3 Dec 2024 08:56:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 03 Dec 2024 08:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733234181; x=1733320581; bh=t5hiGBjd/y
	QSCmdFKrq1E+BRXR/cTuJ8SiDBjPo97q0=; b=rHXo0fJjEsJSHPPkD2NWvdfVjn
	E2g3pcJMCWZ4smK2Kt9thh1lL0rbbb8KsSVw+lheUwKgt4Yjjrh0BYBv08wVn6sx
	SvBBO7GZqNBzzaq6iQ1fYKV1ThNv2JvLYzbU/jL/FWU+NlnTJHZYgVdx6ojTuaFE
	C94sP+nQsX8sGq0/Q0/wMi254h2GGLxWLQVWgY4pwEMddY98TIWkDEnSp+9HHkAH
	CpzI2SZF5j1xUXWjLDrH4tR8ALHBwjYnlornJP5uYLowivv4/CYmb1mO0TGg69H2
	be4vd37i5KgE0fJgXuAxeFeShmgc3ZdZ2x6/lq2YeB/xTVJgJDkNZFwKuU+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733234181; x=1733320581; bh=t5hiGBjd/yQSCmdFKrq1E+BRXR/cTuJ8SiD
	BjPo97q0=; b=2tUcnsHoF1jIbrvnciLZF53nAima+p2ficy1E7pY/hlFRYc4BT6
	vEl+tYh8Zv6s8EHyM3+Mf/qIw5AxbSbIM2nNGsKsqMLWV40g3n5kesXBbD8s/YrD
	TWiVk0ubQKTv8oLYwQoXgG5gwbcT8UznC5aPN2aCpYBzF8szehL0TRB35FU1BYE+
	ECFWGBc09isS2/7USy7cMGfZa7wS4/0RgNZTsqLg2oN2zVpOhE2Yjjg2gJbP/QJd
	8bhOMIcZps/K8rWQwyBslB5Fz1Gbjigb6QidzTvouCRt2uLUc20ypavy/aG5mzf/
	XxfKx6OQzGqmdzeqE42+1ISKwZegUQJc+4A==
X-ME-Sender: <xms:BQ5PZ3fBpQ5fJ82nZDRvguSwqdM80C6ycZn7YdxRpuQ2fT__otMglA>
    <xme:BQ5PZ9NlDvyOsgDbf_SJJ0AzkwQ0dfl0EUb08NWky18MUVoS9ZywOHPRxJ2CZUQu8
    DU5MSAyqtAyTg>
X-ME-Received: <xmr:BQ5PZwhFgRFYD8taWzWg8cZkP57bV_wWf7jpVCpYe437bSwwE_03Lqkj54xl0ohgA-n9XJkOu8w62pJfV_pHphDdg0oo8szXLHV5pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieefgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvghes
    khhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvdevvdeljeeugfdtudduhf
    ekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprh
    gtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmuhhnihhsvghk
    hhgrrhhrmhhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlnhgvfigsih
    gvsheskhgvrhhnvghlnhgvfigsihgvshdrohhrghdprhgtphhtthhopehlihhnuhigqdhs
    vghrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BQ5PZ48AU3BS6WYO00gi2GgQt39DLUiZiSOxcWp9ZW7zC1LkCoq1wA>
    <xmx:BQ5PZzt77ye1GgmY8J7-_LyZ4LtYS3m-UQnN_rqqoukgeh927YRm8w>
    <xmx:BQ5PZ3EW-W7GHYQo30j3fmFOxZFchM3nbvWrCDWLKpnsLIotW60Jug>
    <xmx:BQ5PZ6OlAStd0uPTf5bSxKiVUeDnuFRWW2nyNL4QODRQoAfuNXHYjw>
    <xmx:BQ5PZ3hy8vj-zsCq8ubB-jt5q8XnA96GFAh21jNMJcO-WztdTBEr4seQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 08:56:20 -0500 (EST)
Date: Tue, 3 Dec 2024 14:56:17 +0100
From: Greg KH <greg@kroah.com>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: Query Regarding UART Controller Device Driver in Linux Kernel
Message-ID: <2024120338-atrocious-policy-1ce0@gregkh>
References: <CAHhAz+jqTxsMipLLnBvRAC8cyN=QhTe5sToh45FN=AyrZ9XnNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhAz+jqTxsMipLLnBvRAC8cyN=QhTe5sToh45FN=AyrZ9XnNQ@mail.gmail.com>

On Tue, Dec 03, 2024 at 04:47:31PM +0530, Muni Sekhar wrote:
> Dear Linux Kernel Community,
> 
> I hope this email finds you well. I need to work on the high speed
> UART controller driver in the Linux kernel, and I have a few questions
> that I would appreciate your guidance on:
> 
> I understand that the Linux kernel tree contains multiple source code
> files related to UART controller device drivers. Could you please
> point me to the relevant source code paths for these drivers?

Where have you looked that you did not find them?  (hint,
drivers/tty/serial is where they are located...)

> What is the maximum supported UART baud rate in the current kernel
> driver's supports? For example, if the hardware supports high-speed
> baud rates (e.g., 12 Mbps), are there any specific design strategies
> or modifications needed in the driver to support such high speeds?

Many different uarts support different high-speed rates, it depends on
the hardware.  And yes, there are different ways of going that fast, but
again, it depends on the hardware.

What exact hardware type are you working with?  Does it not already work
properly with Linux?

> Are there any user-space utilities available for testing UART
> interfaces in Linux? If so, could you kindly share details on these
> utilities or provide any resources that would be useful for testing?

There are loads of them, but it depends on what you want to test.  What
exactly are you wishing to test/validate?

thanks,

greg k-h
