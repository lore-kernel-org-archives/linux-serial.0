Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E688D38F620;
	Mon, 27 Jul 2026 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166008; cv=none; b=CwOucqfD/BW0g8/Z9KTbPKD4ZUbY8TVvXwLlouXvtKz6GMb5D0Y5l09Vk46Gr2ewYMga6cr8UPUMHOIhuZuSHA5bRfoPLpFnGhrmgyMpyBTZ346UWDVboSHcnzfgkRVFkR0isSlox/lN0rnM9oRUpb8EL02guP9eq6FOlsDAeWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166008; c=relaxed/simple;
	bh=8QNWDMa6TjW3Hzw71fZ9VjI0JmzmGmShy98lMbWXiJc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eAcNLFJqKzxMeBD9+NlnwORg1X4FA7MfX1xMeVSJUtvpcZ/s+0TkMvVvnaZHv2fs/IEFkJVy8jefEniQfNrC6064qsn4pVzwEaTJHInKMAm0/a2qmqBXcJXs13VzeVoMWc6afN+UCDo5hF8Nft+2mCfZQbSWAxYwIQ99yZf8Kj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=V/98kMEM; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="V/98kMEM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=xOJ8X2Rmph66Fy3J7+3vzZ/PBG97y1CEuMupiXz5Ouc=; b=V/98kMEMrz+PWttkjWKjXTjoJq
	JP+hF21RhXqqPzn349PCA4jTrfKjPADourIHSdll1bNbwlwH0Vj3J0ltKGx1xGw3AcSc6j4nM5DXL
	2PmgCBEX/vU7S/5IM7+QHGjchtn4oXnuRYvpKegdTAUxWRgL5bZhWQ4v6O30m2Ut/fe8=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1woNE3-000000007qh-2cip;
	Mon, 27 Jul 2026 11:26:43 -0400
Date: Mon, 27 Jul 2026 11:26:43 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
Message-Id: <20260727112643.86b3ab3a725eabc66eb47e39@hugovil.com>
In-Reply-To: <20260727112210.7a0b08d19de0e17fbd995290@hugovil.com>
References: <20260720080812.1223096-2-u.kleine-koenig@baylibre.com>
	<al34uIyOue73MMN0@monoceros>
	<20260720100708.5b9b3ed9f6f42b27adb264d4@hugovil.com>
	<al6PfMCuRiYcOBQV@monoceros>
	<20260720185326.9652faa0df7b02e07eeb7d4b@hugovil.com>
	<amGYgUhPrSdR5srV@monoceros>
	<20260723231359.5d7fa1e8e11990fa00c476f4@hugovil.com>
	<amMZoJ41FKcd2ddG@monoceros>
	<20260727112210.7a0b08d19de0e17fbd995290@hugovil.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam_score: -2.0
X-Spam_bar: --

On Mon, 27 Jul 2026 11:22:10 -0400
Hugo Villeneuve <hugo@hugovil.com> wrote:

> Hi Uwe,
>=20
> On Fri, 24 Jul 2026 09:58:13 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > On Thu, Jul 23, 2026 at 11:13:59PM -0400, Hugo Villeneuve wrote:
> > > > For me the open question remains if the driver works in the
> > > > configuration CONFIG_SERIAL_8250=3Dy (and thus CONFIG_SERIAL_CORE=
=3Dy) +
> > > > CONFIG_SERIAL_8250_HUB6=3Dm. In this case at least commit
> > > > 3d406299d8829747fe2e8692f4c29fe3dc1d101f +
> > > > https://lore.kernel.org/linux-serial/20260715153707.4181828-1-hugo@=
hugovil.com/
> > > > introduces a logical change in uart_match_port() that isn't explain=
ed in
> > > > the commit log.
> > >=20
> > > Not sure what you mean by that logical change?
> >=20
> > With said configuration and before
> > 3d406299d8829747fe2e8692f4c29fe3dc1d101f uart_match_port() returned
> >=20
> > 	port1->iobase =3D=3D port2->iobase && port1->hub6 =3D=3D port2->hub6
> >=20
> > and with 3d406299d8829747fe2e8692f4c29fe3dc1d101f (and your fix on top)
> > it returns false (because when drivers/tty/serial/serial_core.c is
> > compiled IS_REACHABLE(CONFIG_SERIAL_8250_HUB6) evaluates to false).
>=20
> this change was certainly not intended, sorry about that. Looks like
> there are still subtle Kconfig-isms (and 8250-isms) that I still need to
> master...
>=20
> So to be sure i understand this correctly:
> I will submit a patch to replace IS_REACHABLE with IS_ENABLED, which
> means that the configuration CONFIG_SERIAL_8250=3Dy and
> CONFIG_SERIAL_8250_HUB6=3Dm is not supported, as you stated that
> it currently cannot happen?

Or we leave it as is, since this combination is not really valid?

--=20
Hugo Villeneuve
