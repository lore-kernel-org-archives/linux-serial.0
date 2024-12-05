Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1C1AAE09
	for <linux-serial@vger.kernel.org>; Thu,  5 Dec 2024 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382510; cv=none; b=QKCAOC3hWIITXI+GBKzPdvMsE81idocTY7b+Fli+TFIW8Gzrj3DREa0w0d3LfSYpRF+dgbfEw85jbN/2OuEI+W4KSmRdu7+ctlNIL6E/Ju5hbDOWTI8oRB+YeYmnmNHdJDgqc4CO9YQdMmTgjGykBBg/MFePgdwwL5Bp4XRzeMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382510; c=relaxed/simple;
	bh=KCynoUsJ+cI6b0UzFtz46Acdyhuz8632EjBoea2TAvw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Njj0LwXPCcsgks56Qu3g+bAdYbHQ0/VTL7WqZVcn3ILgmjSiibDYpnCaVQ3/hict5d2JYTaKFzF3roMTByJP92e6iP4jQFCsANBA2hYkg7mwATjUbaT8xEbyJJ48alV7swyNSK4bR3A4zik9nbfOTTYPVSRwRDldnip/0NyPleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvjRxmvo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvjRxmvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FA6C4CEDE;
	Thu,  5 Dec 2024 07:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733382510;
	bh=KCynoUsJ+cI6b0UzFtz46Acdyhuz8632EjBoea2TAvw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MvjRxmvonCmz2L0WHjZ85VIRDLukBDD8PrImb8nvj4jm5Vusd1FJibNhl6poaL+Lg
	 IoRDgcyJRKBtyJ2u4PT3mkkJcR2L3hrkgRcn6OLwjCG4nVn0Ob6blF1sS8iZw/3B/C
	 6cz+u5Ox27vK9p2SjVhUToZ5lr4gJM1A7Xs234nuOnB0EfMZznZg+SqScZe8KGyI5U
	 35evXSgXqyCz6OZRq2Uigyl/gRdqfi5XSy6Wh6XO8B+cThbDMGnqt4GTa7bSkY6Qn3
	 tCcNUM8oRLTeK0Y4aNTmPl3u2cbv2Q8Y8/BAY5Veq1RH6RIHZufYL6wUn/squIC/TE
	 cBfzbTLH8tz8g==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id A11FB1200076;
	Thu,  5 Dec 2024 02:08:28 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 05 Dec 2024 02:08:28 -0500
X-ME-Sender: <xms:bFFRZzoYOG3f4OjejbdlTY4Zmy-Znr2So32kZom3q-OJho-IMkBY1w>
    <xme:bFFRZ9qIFNDCPAJ3MvScwqsXS-AgqUQrZhsIfRO24-8RKJRoOSQjUWu4Wb9a68TxU
    Oae_SNTjP6ItnJeWOs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeigddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlh
    drohhrgheqnecuggftrfgrthhtvghrnhepjeejffetteefteekieejudeguedvgfeffeei
    tdduieekgeegfeekhfduhfelhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrd
    horhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopeihrghnghihihhnghhlihgrnhhgsehhuhgrfigvihdrtghomh
    dprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhtggrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepshgthhhnvghllhgvse
    hlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgv
    nhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrh
    hvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhrvghgkhhh
    sehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugiesrh
    hovggtkhdquhhsrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bFFRZwN5CjgChUFyMCxS_u2y1M30lzZ2vgKQN3FPqDvQ63ez00E5zQ>
    <xmx:bFFRZ26k1bJqeiwGfOexDdJZURJxd2HCucjw-YiCn03vxbroVYhEow>
    <xmx:bFFRZy6bXUwKNKOG0AvjkkE0R8agnAGa2xlyyS0RItXbplxNBZCDqg>
    <xmx:bFFRZ-gClRDpy9UmcmNii3HpfJcUaUZcp5ZS2GM99emVvTWsZ32Qzg>
    <xmx:bFFRZ04-jEDN6PZDOCSrEe6ev4otA7rr43xNTydnQN26Sx-0p4wHXATa>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7573D2220072; Thu,  5 Dec 2024 02:08:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 05 Dec 2024 08:08:08 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Guenter Roeck" <linux@roeck-us.net>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, "Yang Yingliang" <yangyingliang@huawei.com>
Message-Id: <ed8f7230-6eab-4f8e-b607-877e6c8e5a7d@app.fastmail.com>
In-Reply-To: <0e07c26d-5136-44d8-b9a0-96154050ae8e@roeck-us.net>
References: <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
 <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
 <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
 <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com>
 <30a38025-afae-4bdf-a468-21ae2cd5a7b3@app.fastmail.com>
 <4446d7dc-efb0-4395-8fcb-7177d9e07b5c@roeck-us.net>
 <acdab483-05a4-4fa8-ae1c-70ed53402aa2@app.fastmail.com>
 <0e07c26d-5136-44d8-b9a0-96154050ae8e@roeck-us.net>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Dec 4, 2024, at 23:44, Guenter Roeck wrote:
> On 12/4/24 14:17, Arnd Bergmann wrote:
>> On Wed, Dec 4, 2024, at 22:09, Guenter Roeck wrote:
>> 
>> I had considered this at first but didn't really want to do
>> it like this because we should not be registering empty ports
>> on platforms that don't use the setserial style override for
>> the port configuration.
>> 
>> It does of course address the warning, just not the
>> underlying bug.
>> 
>
> I had a look myself, and concluded that a clean fix will likely require
> substantial changes to avoid regressions. Your patch series pretty much
> confirms that. This is why I came up with the hack below. Yes, it doesn't
> get rid of the underlying problem, but IMO it is good enough for 6.13,
> or at least not worse than 6.12, while at the same time avoiding the
> warning backtrace. It seems to me that a clean fix would be 6.14 material,
> and I really don't want those backtraces to clog up test logs until then.

Fair enough, let's use your patch then for 6,13,

Acked-by: Arnd Bergmann <arnd@arndb.de>
