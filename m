Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F54E8821;
	Wed,  6 Aug 2025 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463755; cv=none; b=Oa/OVE4RUlNC9j2ro9+wtN63tWgjHyuH67yBkPKXzLrh1XeQxaF0hgoyei24933CpCmj/5qrXCCXpRF1QYd6DaiSyG79kJUiWlpIq/OfcHH55gtP0FBYM/Xu4K3IA0BjRsjRDm4nBJzuHnVvwabAOkiku7eAk63Rh8CRt0pWwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463755; c=relaxed/simple;
	bh=lRvMfkUTF/iL3sQd9aV66ysujH7eIaME+hHG2kMFQ28=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jc3m6jhHUs1FD0E+/slzPSdWvLaax4lJHUdMibITe0Bp0QzSJLaE1u6mDaFQY76vNW93n7zBsaJUs4Ws/ckp1r5fchzoVxs4rNKigKLyEIpeDsGNwbT75Mkk7PlIxgDfZGWUJ0LN+s3UDWz+zFkqnT2NPtpHPiAedGxjVdxp91A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GmOxT1cx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WAgkFVd3; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GmOxT1cx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WAgkFVd3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 690FA1D00140;
	Wed,  6 Aug 2025 03:02:31 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 06 Aug 2025 03:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754463751;
	 x=1754550151; bh=r+4PwzMnGw4Uw6l+sBKPiWlio2oiOPyjsfxXua3yWu8=; b=
	GmOxT1cxJpTyHHYDUuJQUxCQwJNZnYrE3rBTZZYz+Uhh1UpcLP7Fu5gzleDcN7Kc
	9joF5VEPKt/qSoeJj8f2JcgiUEsU4vXG6vjMCXnaaBA4HsYGkQFZI+VlrlRFLwSP
	O5JYEhZmH1/tGQmFhjO6Vw60miG5zR+x3LUviPz1LKWeE2aImi0w/cqMbWhI3U0v
	K+3OjlMjPr3jGGjlRIudD6vmKUUJ6XEJ1RQnZy069kOm93tqlqjvBXsiyWUn6kWv
	+SiwY92zqfE2nxGpotzEBdlqlBSeLMMQ6eIsU9B+AfB7xyDfLtJvXqdKH63IgZg3
	gnMVYjloLZJVy7w5JCplJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754463751; x=
	1754550151; bh=r+4PwzMnGw4Uw6l+sBKPiWlio2oiOPyjsfxXua3yWu8=; b=W
	AgkFVd3ieSSr6qnsHlrE1puWSODy/bTP5d7cxte4XYpT+q2P0+E6hlKo7+YogAJe
	vPfS0bzkwjxYhZnump6Jx6usxHx0s6xmVHKf6Pn04iQxQMbWIKDVGXOKaxlyN79i
	PYUhdFD1VtfSUdENzxfXJRQ7FoLSURiLXi9wHVbaarsuAimVyR0Xk4Pf0olmPftJ
	lmXRbJjg2BooHLIwKZ/xPwuLzWArz2uX3auHGVZrVb35yTbWmSoprMc8XQWKqcGT
	cU2Un6GFOm89uePIB1VpG4VeSXko9p0PXXPeZZmOSkXwNGDjDjH1HUfPnXAhgNDh
	+SQVUVoM/TOMYxbnbLK5A==
X-ME-Sender: <xms:Bf6SaJeyrOrsR9fxzY42W0fka_hv06HEvA5VGXFcFWicJEU2ogVLtg>
    <xme:Bf6SaHPQJfG8NlMoI-t_x-N5o0MVcgBKnTDCmaskW8edjRqne8AFs1sBCBEpnyGH_
    4hNQd4xxTiKjLRSPkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepuhdrkhhlvghinhgvqdhkohgvnhhighessggrhihlihgsrhgvrdgtoh
    hmpdhrtghpthhtoheprggsihhnrghshhhsihhnghhhlhgrlhhothhrrgesghhmrghilhdr
    tghomhdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgt
    ohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepshhunhhilhhvlhesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Bv6SaA9MVygZHlgPSknmVwyZ4cfLPjQ-Rur4rgEUXSH3gNbHVYJhtQ>
    <xmx:Bv6SaFmxckKembnvtB_5bGLNzQxIoGhkSY9mIvWuDuMdofEC1xQqng>
    <xmx:Bv6SaFwuxA_tI3k82uPUpcKOHHBKGtXGzT4r706NusGJNZXiB8JNig>
    <xmx:Bv6SaP6Ufv5ELt8kaHhKPf9KNJtl36tKNH2Ntsw_BXp6mAVh8iD7vw>
    <xmx:B_6SaGkbtbbHtZQqVhJr9LS5jx_Aed0KNNZrr3nsD0Fjwtg0XJlJWraz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DF429700065; Wed,  6 Aug 2025 03:02:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T1663be770c67d725
Date: Wed, 06 Aug 2025 09:01:46 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Abinash Singh" <abinashsinghlalotra@gmail.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Jiri Slaby" <jirislaby@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Message-Id: <f765eae4-f83e-4c25-9697-2705afd7b9b8@app.fastmail.com>
In-Reply-To: <20250805195155.742004-1-abinashsinghlalotra@gmail.com>
References: <20250805195155.742004-1-abinashsinghlalotra@gmail.com>
Subject: Re: [RFC PATCH 1/2] tty: serial/8250: Fix build warning in
 serial8250_probe_acpi()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025, at 21:51, Abinash Singh wrote:
> The function serial8250_probe_acpi() in 8250_platform.c triggered a
>     frame size warning:
> drivers/tty/serial/8250/8250_platform.c: In function=20
> =E2=80=98serial8250_probe_acpi=E2=80=99:
> drivers/tty/serial/8250/8250_platform.c:152:1: warning: the frame size=20
> of 1160 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]

Hi Abinash,

I've seen this one as well in some configurations, thanks
for helping out addressing it!

> This patch reduces the stack usage by dynamically allocating the
>     `uart` structure using kmalloc(), rather than placing it on
>     the stack. This eliminates the overflow warning and improves kernel
>     robustness.

The same problem does show up in a lot of 8250 driver variants,
plus a couple that have it in theory but don't run into the
1024 byte limit:

drivers/char/mwave/mwavedd.c-static int register_serial_portandirq(unsig=
ned int port, int irq)
drivers/char/mwave/mwavedd.c-{
drivers/char/mwave/mwavedd.c:   struct uart_8250_port uart;

drivers/ptp/ptp_ocp.c-ptp_ocp_serial_line(struct ptp_ocp *bp, struct ocp=
_resource *r)
drivers/ptp/ptp_ocp.c-{
drivers/ptp/ptp_ocp.c-  struct pci_dev *pdev =3D bp->pdev;
drivers/ptp/ptp_ocp.c:  struct uart_8250_port uart;

drivers/tty/serial/8250/8250_acorn.c-serial_card_probe(struct expansion_=
card *ec, const struct ecard_id *id)
drivers/tty/serial/8250/8250_acorn.c-{
drivers/tty/serial/8250/8250_acorn.c:   struct uart_8250_port uart;

drivers/tty/serial/8250/8250_bcm2835aux.c-static int bcm2835aux_serial_p=
robe(struct platform_device *pdev)
drivers/tty/serial/8250/8250_bcm2835aux.c-{
drivers/tty/serial/8250/8250_bcm2835aux.c:      struct uart_8250_port up=
 =3D { };

In total, I see 34 drivers using this exact pattern for=20
their probe function, and ideally we would to to fix them
all to do it some other way.

Note how serial8250_register_8250_port() ands up just copying
individual members of the passed uart_8250_port structure into
the global array of the same type, so one way of addressing
this would be to use a structure for initialization that only
contains a subset of the uart_8250_port members and can still
be allocated on the stack, or possibly be constant.

There is already a 'struct plat_serial8250_port', which some
(mostly ancient) drivers use to register a 8250 compatible
uart through the 8250_platform driver. That driver has
a number of problems, so I don't really want to expand its
usage, but it may be possible to use a single structure
for both purposes.

      Arnd
