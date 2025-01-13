Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3A22A4FE;
	Mon, 13 Jan 2025 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774098; cv=none; b=ZEVVSSYq0q3EdVF1UrFo/VbeirFG2kRnu5nFVmI8SwMPvFjuC6h8wy0swO+cqKR5kC/iBNE1e0Ksvjk6ERe46yJyqX3YSxPNdv5ZAWK9NZNZQ9xZJM15ywMR8wHMZ0IWrAgrHMtggfs2h8ppT9fZe3ZosEIrnsUlGBf5SHcvZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774098; c=relaxed/simple;
	bh=7kHeSjC6cnI42WZDqcgjLwnU7x72rZvlePR+Y3FY8Bg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pe+IjQG3bvPbNUUfuxwBwbk5gQbynwbv0dNNbKtbeSsAE05Dozy7CtV2b9Hsd9myStQ6Y60Us+1sqzQS3Gqw0/jE9zo9GqRlmldJ1QFUSlAm3wYBTr+FpI8FvK9/O3sUDYl06h8S0RDlGEs3sMFEsAssfEAroVkyrB33uLwH/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fGLlfzIw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LPnfYPfu; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fGLlfzIw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LPnfYPfu"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6A85611400AB;
	Mon, 13 Jan 2025 08:14:55 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 13 Jan 2025 08:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736774095;
	 x=1736860495; bh=9vrQJPDydLsCVlCY80CK8S47diJ9mhiwKxRXMyRuN/M=; b=
	fGLlfzIw9HIksI6p1LRmFogZmI89FLYQ2OfWJUsR9BT6kacL7lR0jn0uy+RynwS3
	5b1nQvSCNKC4GAYYGBiNWEP+4xWCpZdvcKXMDqNX3GdOFRDfp33IRM3v83wfR+8C
	t5VlHQSROw9sBjr9VeexbPrHEb3O6ALXsD4+GdtVqnw6xVzAwEKPy88zW/I6yq3g
	yQgNIzq96H8W0LJfUiulIPwJiG+C7OymI+m6+UnQLSWmd9QSAh3ZtrSpS6E7BRQG
	2gNP17GrAx/HregQlWfxLWzABplf+OSaRwFh8E+AvkX/03F03NrUTzzzf2GtP9bM
	dtDxVdPjKVG97vdwzyPelA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736774095; x=
	1736860495; bh=9vrQJPDydLsCVlCY80CK8S47diJ9mhiwKxRXMyRuN/M=; b=L
	PnfYPfuH2SIYHl9dLV51tfGQ0rgQlJp7kBe8VVI2iny9ng4LevIoPrzUUJUjlhri
	SxoLhuITn/VvNA17EfkdCziq8fSuY2sKTaxucqNdaMGX2J5idVM7am8vV+INVnK2
	Q9QZSYmC6TcMmiiLW+P4QKc+4ULbDPw9yXBXOomKPBkD8CGG6t0InONTegdiGSBw
	e+PhXz3LQ3YAnxFyUnrAn7IFgcxbgsP8lW8YtLj/A3/3pix/1KizQ7gQ5Z6bvvI9
	JckBA+/luU8wqK2UxfwGvPf6QkKg2q/1YQdAjrtseESLgixxd3WaLJ8YDBe31IwM
	5WCb3e8BIQYo5+MEBtcNw==
X-ME-Sender: <xms:zhGFZ3gtBcp7n72sT92Pi9vGJTv3aY_5QyD6BQM43d0h_ypWl_WOOA>
    <xme:zhGFZ0BIpO3ligll2NpsMp9-MRvS2mNVs8ZlHzxHucvp_8U1nIMJTG08X692A38dP
    p9UB5Oi9_0vzP_btZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepieeggfdtleeludetgefgheefhfelkeffgeehhefh
    feegfefhfefgteeutdeuhfeinecuffhomhgrihhnpehuvghfihdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgu
    sgdruggvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepphhnvgifmhgrnhestghonhhnvggtthhtvggthhdrtghomhdprhgtphhtthhopegr
    rhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepshgthhhnvghllhgvsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoh
    eprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdp
    rhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopegthhgvnhhguhhofigvihesuhhnihhonhhtvggthhdrtghomhdprhgtphht
    thhopehguhgrnhifvghnthgrohesuhhnihhonhhtvggthhdrtghomh
X-ME-Proxy: <xmx:zhGFZ3GbPNotQBV4hG5O4lmILdjNzW0NzhnFUnYlk2ohNiG-WMU64A>
    <xmx:zhGFZ0Qhhe7GBeSDMqsV0m_sFNhAydrfSOVBpANL69TkhUqVR95zEA>
    <xmx:zhGFZ0wGhgkgsGL-1-H_Vxkw6MOqwPDTePL7fseLIfTzaXVBzx4odQ>
    <xmx:zhGFZ66Sr663_rWtDen6cPWEv76Yi3emJwZ8HfpT4SMJcmH87pnYwA>
    <xmx:zxGFZwDCsfkt93eC9SgJeE7O2-xXBxt2_Suv8o3Wlsfgs4aq4a1cZbgk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 95D982220072; Mon, 13 Jan 2025 08:14:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Jan 2025 14:12:01 +0100
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
Message-Id: <92fa2e1d-2dbb-4d28-a7c5-c0f629f9b05a@app.fastmail.com>
In-Reply-To: <Z4UE995i2OYv-h5E@smile.fi.intel.com>
References: <41B1320691916DE6+20250109120808.559950-1-wangyuli@uniontech.com>
 <11805e8c-c97b-4297-9c04-462fa1932ce1@app.fastmail.com>
 <Z4TkDgYSSm7nwUhY@smile.fi.intel.com>
 <7dd87e6f-6a86-409f-9e1d-4a2d836e399d@app.fastmail.com>
 <Z4UE995i2OYv-h5E@smile.fi.intel.com>
Subject: Re: [PATCH] serial: 8250_it8768e: Create iTE IT8768E specific 8250 driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jan 13, 2025, at 13:20, Andy Shevchenko wrote:
> On Mon, Jan 13, 2025 at 11:36:08AM +0100, Arnd Bergmann wrote:
>> On Mon, Jan 13, 2025, at 10:59, Andy Shevchenko wrote:
>> > On Thu, Jan 09, 2025 at 01:40:14PM +0100, Arnd Bergmann wrote:
>> >> On Thu, Jan 9, 2025, at 13:08, WangYuli wrote:
>> >> 
>> >> Can you explain why this isn't done as part of
>> >> drivers/tty/serial/8250/8250_pnp.c?
>> >
>> > I assume you meant 8250_platform.c. PNP is for devices went through legacy PNP
>> > enumeration, most likely having IOPORT instead of IOMEM.
>> 
>> No, I meant the 8250_pnp.c file.
>
> I am puzzled then. How should it work? PNP ID != ACPI HID that's provided in
> this patch commit message. On top of that, PNP driver uses _legacy_ PMP bus
> and infrastructure.

I guess I don't understand enough about ACPI then, I always
assumed these were the same identifiers. I do see that
CONFIG_ACPI force-enables CONFIG_PNP, and I see the examples in
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/ evice_Configuration.html
refer to _HID values in the form of "PNP####". 

     Arnd
