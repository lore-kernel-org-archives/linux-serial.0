Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D91D1BE871;
	Mon, 13 Jan 2025 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764594; cv=none; b=QDoqQl0Y9wEPVfXJPvrmpXqdqHMBXas0tSZWOrGRXu8lkpNumOSpc8iQbYNWFl6eDuuXVBGaAlHvx8fmrPPXGRDiuzxMi/NDAV4KOjwp0QYGbE7mITLwhpObhcYXlIBUWUX+F/xX/kpuPnHNFWda9YQhl28rSNYuEQCAahK7UeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764594; c=relaxed/simple;
	bh=eo8FPo9RBhcUGniqMahrR+68nV3B71BKhd6i9lB3e20=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=H8FBYycFmX60fYRljp4JLbfoyjaqlzqKVxxsmF4gBHotjfmRCh8tknHQOOn4hwtPzbfJyRW3wD+fujQ5C5T9tmNTPCHfWIaSuBZTr5Mv5f24ZXg6ajF2gb8zi2ysuFxTSmA3Oe12tYrkdUnE5qp/fXnhpaQEhMzaIRPEiloB3KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ma21ShSn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=um8eX6pB; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ma21ShSn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="um8eX6pB"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 569E813801B9;
	Mon, 13 Jan 2025 05:36:30 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 13 Jan 2025 05:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736764590;
	 x=1736850990; bh=88ddPCGbWB333bn6MExlpHbxtXxUP1vUCe0xR+QOpIs=; b=
	ma21ShSnjGPsx+2D4wbrgGZAFXpa9iiO6II8OXxmxtM7qKNH5xFGHXk/t/+uqjTK
	pNPRzFGe4DpdrpX1XFEtK5AInthS75rWwffL70R/rq7d5ttVPWyirQ7ebwVj1E5j
	iMrNRajv8vk+FAJm2EGGXVUbA5n5/E1pzt9UNfgoxsAMt8B7jNnoc2Vkk286EMAj
	YPNxnKuYNMSdnKeoZ8tVg+gPY0K5kwOxkmI0jWNk3BJhEcqmDE1lm6sFMuFp1VTw
	1rL7+uxVYeQdGACiI+crP8ea5DERL2zOeej5GVrSxaiHrz2fPRt3UimxSgXEX81k
	TBdZpk8Gc2ti33/mg13m3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736764590; x=
	1736850990; bh=88ddPCGbWB333bn6MExlpHbxtXxUP1vUCe0xR+QOpIs=; b=u
	m8eX6pBmZHJVnRp+q6TeRoa4MLIBHG76K1BoFPzlMkAuxpng77t0Z3iDjV2lcvPT
	B43Mx2ykXeVNwfxRhNakBPEl4PV9PKzW0MC5ZAZCyRgcKbU15+AJaMRy1IUCpHfy
	GNh7wRVBpBtZB9BhOcB6wlhg2qKKleGonr8y/hQBgvjsZ2pHm1UNQhVB5WWpyTii
	h+TN4DMt0v9mEUm0BBpWwBQ+/fQkvh6zq1SOI611StEZcco3JnACFzOt3N2EIb2T
	wUb8G6fBSL5XljKeNd/6Cb3zc50LuOZf8CEkpC4N6mc9dW+iaMjlcshlxZDbGdDN
	SBLoF3SSoXXROX1odeZKw==
X-ME-Sender: <xms:reyEZ7ti6EI1CAbHf8mM9f3xFEMUnUicJpwiDBP4iGbON7UERx2MXA>
    <xme:reyEZ8cnALyjaLc35w8yU6Ixmr3nhevsY5f52BwJGjeos5kppDpgEKNIsQlT36RJK
    Pzg1m1kiWAf1ijH5Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpnhgvfihmrghnsegtohhnnhgvtg
    htthgvtghhrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprg
    hulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehstghhnhgvlhhlvgeslhhi
    nhhugidrihgsmhdrtghomhdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkh
    hosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhn
    uhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheptghhvghnghhuohifvghise
    hunhhiohhnthgvtghhrdgtohhmpdhrtghpthhtohepghhurghnfigvnhhtrghosehunhhi
    ohhnthgvtghhrdgtohhm
X-ME-Proxy: <xmx:reyEZ-wRomTbTT9R6928cGIMKVLK7-nkpmnG9Zf4VIUhZbuZfv3kEQ>
    <xmx:reyEZ6MVj-fM929zF12iynHm0GgjzGPEE8fstqffmx8oZGWMZCMxhw>
    <xmx:reyEZ79s5K1lGy_rVLcjsyc07_-Kun5w9ogCSeXv2WmpXqNQsvvGVw>
    <xmx:reyEZ6WD8KZlIDb8QYcj8x2p1ZHGgoIBgARDLBqLpWKfql3BWWecdg>
    <xmx:ruyEZyeTytjSUH4QAinFhyY2Jbzu6t-3ARm-kNs68r1zvYNyMwACocfu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A29AA2220073; Mon, 13 Jan 2025 05:36:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Jan 2025 11:36:08 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: WangYuli <wangyuli@uniontech.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, "Arnd Bergmann" <arnd@kernel.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>, pnewman@connecttech.com,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, zhanjun@uniontech.com,
 guanwentao@uniontech.com, "Zhuozhen He" <hezhuozhen@uniontech.com>,
 "Guowei Chen" <chenguowei@uniontech.com>
Message-Id: <7dd87e6f-6a86-409f-9e1d-4a2d836e399d@app.fastmail.com>
In-Reply-To: <Z4TkDgYSSm7nwUhY@smile.fi.intel.com>
References: <41B1320691916DE6+20250109120808.559950-1-wangyuli@uniontech.com>
 <11805e8c-c97b-4297-9c04-462fa1932ce1@app.fastmail.com>
 <Z4TkDgYSSm7nwUhY@smile.fi.intel.com>
Subject: Re: [PATCH] serial: 8250_it8768e: Create iTE IT8768E specific 8250 driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jan 13, 2025, at 10:59, Andy Shevchenko wrote:
> On Thu, Jan 09, 2025 at 01:40:14PM +0100, Arnd Bergmann wrote:
>> On Thu, Jan 9, 2025, at 13:08, WangYuli wrote:
>> 
>> Can you explain why this isn't done as part of
>> drivers/tty/serial/8250/8250_pnp.c?
>
> I assume you meant 8250_platform.c. PNP is for devices went through legacy PNP
> enumeration, most likely having IOPORT instead of IOMEM.

No, I meant the 8250_pnp.c file.

> Recently 8250_platform.c was expanded to cover ACPI IDs and it seems they have
> proper ID allocated for their device, so that's where it seems best to fit.

I don't think we should expand the use of 8250_platform.c
any more than it is already used for. The ACPI device ID stuff in
there is really only for one specific platform and should probably
get moved out as well, the rest is there for hardwired
"plat_serial8250_port" devices on 25+ year old machines that
predate any type of firmware (pnpbios, acpibios, of) or hardware
(ispnp, pci, ...) autodetection for their uarts.

     Arnd
